const mongoose = require('mongoose');

const connectDB = async () => {
    try {
        // Si usas MongoDB Atlas, cambia esta URL por tu cadena de conexión
        // Hemos quitado los símbolos < > y añadido 'shitzu_db' como nombre de la base de datos
        const url = 'mongodb+srv://produccion364_db_user:M1s3i4TCUPJVqLu0@beban32.ssf4cq2.mongodb.net/shitzu_db?retryWrites=true&w=majority&appName=beban32';
        await mongoose.connect(url);
        console.log('✅ MongoDB conectado exitosamente');
    } catch (error) {
        console.error('❌ Error al conectar a MongoDB:', error.message);
        process.exit(1);
    }
};

module.exports = connectDB;
