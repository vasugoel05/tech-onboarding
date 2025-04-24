const fs = require('fs');
const filePath = 'todos.json';


function loadTodos() {
    try {
        const data = fs.readFileSync(filePath, 'utf-8');
        return JSON.parse(data);
    } catch (err) {
        return [];
    }
}


function saveTodos(todos) {
    fs.writeFileSync(filePath, JSON.stringify(todos, null, 2), 'utf-8');
}


function addTodo(task) {
    if (!task) {
        console.log('Please provide a todo task !!');
        return;
    }
    const todos = loadTodos();
    todos.push(task);
    saveTodos(todos);
    console.log(`Added:- "${task}"`);
}


function listTodos() {
    const todos = loadTodos();
    if (todos.length === 0) {
        console.log('No todos found !!');
    } else {
        console.log('Your Todos:- ');
        todos.forEach((todo, index) => {
            console.log(` ${index + 1}. ${todo}`);
        });
    }
}


function deleteTodo(index) {
    const todos = loadTodos();
    if (!index || isNaN(index) || index < 1 || index > todos.length) {
        console.log('Invalid index !!');
        return;
    }
    const removed = todos.splice(index - 1, 1);
    saveTodos(todos);
    console.log(`Deleted:- "${removed[0]}"`);
}


const [,, command, ...args] = process.argv;

switch (command) {
    case 'add':
        addTodo(args.join(' '));
        break;
    case 'list':
        listTodos();
        break;
    case 'delete':
        deleteTodo(parseInt(args[0]));
        break;
    default:
        console.log('Usage:-');
        console.log(' node todo.js add "Your task here"');
        console.log(' node todo.js list');
        console.log(' node todo.js delete <index>');
}
