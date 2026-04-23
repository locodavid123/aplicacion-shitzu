const mongoose = require('mongoose');

const AppointmentSchema = new mongoose.Schema({
    pet: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Pet',
        required: true
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    date: {
        type: Date,
        required: [true, 'La fecha de la cita es obligatoria']
    },
    service: {
        type: String,
        enum: ['Peluquería', 'Veterinaria', 'Paseo', 'Baño'],
        default: 'Peluquería'
    },
    status: {
        type: String,
        enum: ['Pendiente', 'Completada', 'Cancelada'],
        default: 'Pendiente'
    },
    notes: {
        type: String,
        trim: true
    },
    createdAt: {
        type: Date,
        default: Date.now
    }
});

module.exports = mongoose.model('Appointment', AppointmentSchema);
