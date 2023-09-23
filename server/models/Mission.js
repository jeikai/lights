const mongoose = require('mongoose');

const missionSchema = new mongoose.Schema({
  emotion: { type: Number, enum: [0, 1, 2, 3, 4] },
  description: { type: String },
});

const Mission = mongoose.model('Mission', missionSchema);
