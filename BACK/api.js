const express = require('express');
const app = express();
const mysql = require('mysql2');
const cors = require('cors');
const bcrypt = require('bcrypt');
const saltRounds = 13;
const port = 5000; // Puerto del servidor

// Configuración de CORS
app.use(cors({
    origin: 'http://localhost:55978', // Ajustar según el frontend
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    credentials: true
}));

// Configuración de conexión a la base de datos
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'app_raices'
});

// Middleware para parsear JSON
app.use(express.json());

// Ruta para registrar un nuevo usuario
app.post('/api/register', (req, res) => {
    const { username, password, email } = req.body;

    console.log("Datos recibidos para registro:", req.body);

    // Verificar si el correo ya está registrado
    db.query('SELECT * FROM users WHERE mail = ?', [email], (err, results) => {
        if (err) {
            console.error("Error al consultar la base de datos:", err);
            return res.status(500).json({ message: 'Error en el servidor' });
        }

        if (results.length > 0) {
            return res.status(409).json({ message: 'El correo ya está registrado' });
        }

        // Generar hash de la contraseña de manera asíncrona
        bcrypt.hash(password, saltRounds, (hashErr, hashedPassword) => {
            if (hashErr) {
                console.error("Error al hashear la contraseña:", hashErr);
                return res.status(500).json({ message: 'Error al procesar la contraseña' });
            }

            // Insertar en la tabla `users`
            db.query('INSERT INTO users (password, mail) VALUES (?, ?)', [hashedPassword, email], (err, results) => {
                if (err) {
                    console.error("Error al insertar en users:", err);
                    return res.status(500).json({ message: 'Error al registrar el usuario' });
                }

                const idUser = results.insertId;

                // Insertar el nombre en la tabla `people`
                db.query('INSERT INTO people (name, idUser) VALUES (?, ?)', [username, idUser], (err) => {
                    if (err) {
                        console.error("Error al insertar en people:", err);
                        return res.status(500).json({ message: 'Error al registrar el usuario' });
                    }

                    res.status(201).json({ message: 'usuario registrado' });
                });
            });
        });
    });
});

// Ruta para iniciar sesión
app.post('/api/login', (req, res) => {
    const { email, password } = req.body;

    console.log("Datos recibidos para login:", req.body);

    db.query('SELECT * FROM users WHERE mail = ?', [email], (err, result) => {
        if (err) {
            console.error("Error al consultar la base de datos:", err);
            return res.status(500).json({ success: false, message: 'Error de logueo' });
        }

        if (result.length === 0) {
            return res.status(401).json({ success: false, message: 'Usuario no encontrado' });
        }

        const user = result[0];
        const passwordAlmacenado = user.password;

        bcrypt.compare(password, passwordAlmacenado, (err1, result1) => {
            if (err1) {
                console.error("Error al verificar la contraseña:", err1);
                return res.status(500).json({ success: false, message: 'Error al verificar la contraseña' });
            }

            if (result1) {
                return res.status(200).json({
                    success: true,
                    message: 'Inicio de sesión exitoso',
                    user: { dataToken: user.idUser, email: user.mail }
                });
            } else {
                console.log(passwordAlmacenado);
                console.log("Contraseña incorrecta para:", email);
                return res.status(401).json({ success: false, message: 'Contraseña incorrecta' });
            }
        });
    });
});

app.get('/api/getUser',(req,res)=>{
    console.log('usuario encontrado');
    console.log(req.query);

    db.query('SELECT * FROM users WHERE idUser = ? AND mail = ?', [req.query.id, req.query.email], (err, result) => {
       if(err){
           console.log("Error al consultar la base de datos:", err);
           res.status(500).json({message:'Error al consultar la base de datos', });
       }else{
           if(result.length > 0 && result.length<2){
               console.log(result[0]);
               db.query('SELECT * FROM people WHERE idUser = ?', [req.query.id], (err1, result1) => {
                   if(err1){
                       console.log("Error al consultar la base de datos:", err1);
                       res.status(500).json({message:'Error al consultar la base de datos people', });
                   }else{
                       if(result1.length > 0 && result1.length<2){
                           console.log(result1[0]);
                           result[0].name = result1[0].name;
                           res.status(200).json({message:'Usuario encontrado', user: result[0], data:result1[0]});
                       }else{
                           res.status(404).json({message:'Usuario no encontrado'});
                       }
                   }
               })


           }else{
               res.status(404).json({message:'Usuario no encontrado'});
           }
       }
    });
})

// Ruta de prueba para obtener datos
app.get('/api/data', (req, res) => {
    res.json({ message: 'Hola desde el backend' });
});

// Ruta de prueba para recibir datos
app.post('/api/data', (req, res) => {
    const data = req.body;
    console.log("Datos recibidos:", data);
    res.json({ message: 'Datos recibidos', data });


});

// Iniciar el servidor
app.listen(port, () => {
    console.log(`Servidor backend corriendo en http://localhost:${port}`);
});
