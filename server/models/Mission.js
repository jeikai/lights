const mongoose = require('mongoose');

const missionSchema = new mongoose.Schema({
  description: { type: String },
});

const Mission = mongoose.model('Mission', missionSchema);
