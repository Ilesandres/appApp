const express = require('express');
const app = express();
const mysql = require('mysql2');
const cors = require('cors');
const http = require('http');
const moment = require('moment');
const bcrypt = require('bcrypt');
const saltRounds = 13;
const port = 5000; // Puerto del servidor


app.use(cors({
    origin: 'http://localhost:64780',
    methods:['GET', 'POST','PUT', 'DELETE'],
    credentials: true
}))

const db=mysql.createConnection(({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'app_raices'
}))

// Middleware para leer JSON
app.use(express.json());


app.post('api/register', (req, res) => {
    const { username, password } = req.body;
    const hashedPassword = bcrypt.hashSync(password, saltRounds);
    db.query('INSERT INTO users (username, password_hash) VALUES (?, ?)', [username, hashedPassword], (err, results) => {
        if (err) {
            console.error(err);
            res.status(500).json({ message: 'Error al registrar el usuario' });
        } else {
            res.status(201).json({ message: 'Usuario registrado correctamente' });
        }
    });
})

// Rutas
app.get('/api/data', (req, res) => {
    res.json({ message: 'Hola desde el backend' });
});

app.post('/api/data', (req, res) => {
    const data = req.body;
    res.json({ message: 'Datos recibidos', data: data });
});

// Iniciar el servidor
app.listen(port, () => {
    console.log(`Servidor backend corriendo en http://localhost:${port}`);
});
