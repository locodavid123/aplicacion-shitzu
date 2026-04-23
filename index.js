const express = require('express');
const cors = require('cors');
const connectDB = require('./db');
const Pet = require('./Pet');
const User = require('./User');

const app = express();

// Middlewares
app.use(cors()); // Permitir peticiones desde Flutter
app.use(express.json());

// Conectar a la base de datos
connectDB().then(() => {
    console.log('📦 Base de datos lista para operaciones');
}).catch(err => {
    console.error('❌ Fallo crítico al iniciar BD:', err);
});

// Ruta para registrar un usuario desde Flutter/Firebase
app.post('/api/users', async (req, res) => {
    console.log('📩 Intentando guardar usuario:', req.body);
    try {
        const { email, password } = req.body;
        if (!email || !password) throw new Error('Faltan datos obligatorios (email/password)');
        
        const newUser = new User({ email, password });
        await newUser.save();
        res.status(201).json({ message: 'Usuario guardado en MongoDB', user: newUser });
    } catch (error) {
        console.error('❌ Error al guardar:', error.message);
        res.status(400).json({ error: error.message });
    }
});

// Ruta para inicio de sesión
app.post('/api/login', async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.findOne({ email });

        if (!user) {
            return res.status(401).json({ error: 'Credenciales inválidas' });
        }

        // Nota: En producción, usa bcrypt.compare
        if (user.password !== password) {
            return res.status(401).json({ error: 'Credenciales inválidas' });
        }

        res.status(200).json({ message: 'Login exitoso', user: { email: user.email } });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Ruta para recuperación de contraseña (Simulación)
app.post('/api/forgot-password', async (req, res) => {
    try {
        const { email } = req.body;
        // Aquí iría la lógica para enviar un correo real
        res.json({ message: 'Enlace enviado a ' + email });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Ruta de prueba para guardar un perrito
app.post('/api/pets', async (req, res) => {
    try {
        const newPet = new Pet(req.body);
        const savedPet = await newPet.save();
        res.status(201).json(savedPet);
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
});

// Ruta para obtener todos los perritos
app.get('/api/pets', async (req, res) => {
    try {
        const pets = await Pet.find();
        res.json(pets);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, '0.0.0.0', () => {
    console.log(`🚀 Servidor corriendo en el puerto ${PORT}`);
});