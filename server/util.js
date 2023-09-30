const { DateTime } = require('luxon');

const desiredTimezone = 'Asia/Ho_Chi_Minh';

// Create a DateTime object for the current time in the desired timezone
const currentTimeInDesiredTimezone = DateTime.now().setZone(desiredTimezone).toString();

module.exports = currentTimeInDesiredTimezone;