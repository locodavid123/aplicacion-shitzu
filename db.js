const mongoose = require('mongoose');
require('dotenv').config();

const connectDB = async () => {
    try {
        // Se recomienda usar variables de entorno para la URL de conexión
        const url = process.env.MONGODB_URI || 'mongodb://localhost:27017/shitzu_db';
        
        if (!process.env.MONGODB_URI) {
            console.warn('⚠️ Advertencia: MONGODB_URI no está definida en .env, usando base de datos local.');
        }

        await mongoose.connect(url);
        console.log('✅ MongoDB conectado exitosamente');
    } catch (error) {
        console.error('❌ Error al conectar a MongoDB:', error.message);
        process.exit(1);
    }
};

module.exports = connectDB;
