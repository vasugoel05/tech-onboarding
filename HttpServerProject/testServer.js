const http = require('http');

const server = http.createServer((req, res) => {
    res.end('Hello from test server!');
});

server.listen(3000, () => {
    console.log('Test server running at http://localhost:3000');
});
