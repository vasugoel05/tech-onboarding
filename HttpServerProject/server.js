const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 3000;

const server = http.createServer((req, res) => {
    const url = req.url;

    // Serve static files from /public
    if (url.startsWith('/public/')) {
        const filePath = path.join(__dirname, url);
        const ext = path.extname(filePath).toLowerCase();

        const mimeTypes = {
            '.png': 'image/png',
            '.jpg': 'image/jpeg',
            '.jpeg': 'image/jpeg',
            '.gif': 'image/gif',
            '.css': 'text/css',
            '.js': 'application/javascript',
        };

        fs.readFile(filePath, (err, data) => {
            if (err) {
                res.writeHead(404);
                res.end('File not found');
                return;
            }
            res.writeHead(200, { 'Content-Type': mimeTypes[ext] || 'application/octet-stream' });
            res.end(data);
        });
        return;
    }

    if (url === '/') {
        res.writeHead(200, { 'Content-Type': 'text/plain' });
        res.end('Welcome to my Node.js server!');
    } else if (url === '/about') {
        res.writeHead(200, { 'Content-Type': 'text/plain' });
        res.end('I am a Node.js developer building simple and scalable backend systems.');
    } else if (url === '/contact') {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(`
            <!DOCTYPE html>
            <html>
            <head>
                <title>Contact</title>
            </head>
            <body>
                <h1>Contact Me</h1>
                <form>
                    <label>Name:</label><br>
                    <input type="text" name="name" /><br><br>
                    <label>Email:</label><br>
                    <input type="email" name="email" /><br><br>
                    <input type="submit" value="Submit" />
                </form>
                <img src="/public/logo.png" alt="Logo" width="150"/>
            </body>
            </html>
        `);
    } else {
        res.writeHead(404, { 'Content-Type': 'text/plain' });
        res.end('404 - Page Not Found');
    }
});

server.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});
