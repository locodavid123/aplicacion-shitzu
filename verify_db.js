const mongoose = require('mongoose');
const connectDB = require('./db');
const User = require('./User');

const verify = async () => {
    // Intentar conectar a la base de datos
    await connectDB();
    
    try {
        console.log('Intentando inicializar la colección de usuarios...');
        
        const testUser = new User({
            email: "verificacion@shitzu.com",
            password: "password_de_prueba_123"
        });

        await testUser.save();
        console.log('✨ Usuario de prueba creado con éxito. ¡La colección de usuarios ya está operativa!');
    } catch (error) {
        if (error.code === 11000) {
            console.log('ℹ️ La colección ya existe y el usuario de prueba también. Todo está en orden.');
        } else {
            console.error('❌ Error al verificar/crear la colección:', error.message);
        }
    } finally {
        mongoose.connection.close();
    }
};

verify();