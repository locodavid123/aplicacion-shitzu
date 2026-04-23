const mongoose = require('mongoose');
const connectDB = require('./db');
const User = require('./User');

const addUser = async () => {
    await connectDB();

    try {
        const newUser = new User({
            email: "admin@shitzuapp.com",
            password: "AdminPassword123",
            fullName: "Administrador del Sistema",
            username: "admin_shitzu",
            country: "Colombia",
            city: "Bogotá",
            phone: "3001234567",
            age: 28,
            role: "admin" // Aquí asignamos el rol de administrador
        });

        const savedUser = await newUser.save();
        console.log('✅ Usuario agregado exitosamente:');
        console.log(`📧 Email: ${savedUser.email}`);
        console.log(`👤 Username: ${savedUser.username}`);
        console.log(`🛡️ Rol: ${savedUser.role}`);

    } catch (error) {
        if (error.code === 11000) {
            console.error('❌ Error: El correo electrónico o el nombre de usuario ya están en uso.');
        } else {
            console.error('❌ Error al agregar usuario:', error.message);
        }
    } finally {
        await mongoose.disconnect();
        console.log('🔌 Conexión cerrada.');
    }
};

addUser();