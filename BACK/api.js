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
    origin: 'http://localhost:64372',
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    credentials: true
}));

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'app_raices'
});

// Middleware para leer JSON
app.use(express.json());

// Ruta para registrar un nuevo usuario
app.post('/api/register', (req, res) => {
    console.log(req.body);
    const { username, password, email } = req.body;

    const hashedPassword = bcrypt.hashSync(password, saltRounds);
    db.query('INSERT INTO users ( password, mail) VALUES (?, ?)', [ hashedPassword, email], (err, results) => {
        if (err) {
            console.error(err);
            res.status(500).json({ message: 'Error al registrar el usuario' });
        } else {
            const idUser= results.insertId;
            db.query('INSERT INTO people(name,idUser) VALUES (?,?)',[username,idUser],(err,results)=>{
                if(err){
                    console.error(err);
                    res.status(500).json({ message: 'Error al registrar el usuario' });
                }else{
                    res.status(201).json({ message: 'usuario registrado' });
                }
            })

        }
    });
});

// Ruta para obtener datos (mensaje de ejemplo)
app.get('/api/data', (req, res) => {
    res.json({ message: 'Hola desde el backend' });
});

// Ruta para recibir datos (ejemplo)
app.post('/api/data', (req, res) => {
    const data = req.body;
    res.json({ message: 'Datos recibidos', data: data });
});

// Iniciar el servidor
app.listen(port, () => {
    console.log(`Servidor backend corriendo en http://localhost:${port}`);
});
