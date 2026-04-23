const mongoose = require('mongoose');

const PetSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, 'El nombre es obligatorio'],
        trim: true
    },
    age: Number,
    breed: {
        type: String,
        default: 'Shih Tzu'
    },
    ownerEmail: {
        type: String,
        required: true // Para vincularlo con el usuario de Firebase
    },
    createdAt: {
        type: Date,
        default: Date.now
    }
});

module.exports = mongoose.model('Pet', PetSchema);