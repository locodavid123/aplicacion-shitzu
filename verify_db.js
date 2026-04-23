const mongoose = require('mongoose');
const connectDB = require('./db');
const User = require('./User');

const verify = async () => {
    // Intentar conectar a la base de datos
    await connectDB();
    
    try {
        console.log('🔍 Verificando conexión e intentando crear un usuario de prueba...');
        
        const testUser = new User({
            email: "verificacion@shitzu.com",
            password: "password_de_prueba_123",
            fullName: "Usuario de Verificación",
            username: "verify_user",
            age: 25,
            role: "cliente" // Por defecto es cliente, pero aquí lo confirmamos
        });

        await testUser.save();
        console.log('✨ Usuario de prueba creado con éxito. Rol asignado:', testUser.role);
    } catch (error) {
        if (error.code === 11000) {
            console.log('ℹ️ El usuario de prueba ya existe en la base de datos. La conexión es correcta.');
        } else {
            console.error('❌ Error al verificar/crear la colección:', error.message);
        }
    } finally {
        await mongoose.disconnect();
        console.log('🔌 Conexión cerrada.');
    }
};

verify();