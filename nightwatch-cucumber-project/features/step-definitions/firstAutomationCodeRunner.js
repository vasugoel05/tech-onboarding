const { Given, Then } = require('@cucumber/cucumber');

Given('I open the Ultimate QA automation page', async function () {
    return browser.url('https://ultimateqa.com/automation');
});

Then('the page title should be {string}', async function (expectedTitle) {
    return browser.getTitle().then(function (title) {
        browser.assert.strictEqual(title, expectedTitle);
    });
});

Then('all links should redirect to their proper URLs', async function () {
    await browser.pause(3000);
    const linkElements = await browser.findElements('css selector', 'div[class*="specialty_column"] a');

    for (let i = 0; i < linkElements.length; i++) {
        const linkElement = linkElements[i];
        const href = await browser.getAttribute(linkElement, 'href');

        console.log("href is: " + href);

        if (href) {
            await browser.url(href);
            await browser.waitForElementVisible('body', 3000);
            await browser.pause(3000);
            if (href.includes("pricing")) {
                await browser.assert.urlContains("fake-pricing-page");
            }
            else if (href.includes("courses")) {
                await browser.assert.urlContains("users/sign_in");
            }
            else {
                await browser.assert.urlEquals(href);
            }
            await browser.back();
            await browser.pause(3000);
        }
    }
});

Then('there should be no console errors', async function () {
    return browser.getLog('browser', function (logEntriesArray) {
        logEntriesArray.forEach(function (log) {
            browser.assert.notEqual(log.level, 'SEVERE', `Console error: ${log.message}`);
        });
    });
});