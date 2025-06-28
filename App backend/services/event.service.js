const Event = require('../models/event.model');

const createEventService = async (data) => {
  const newEvent = new Event(data);
  return await newEvent.save();
};

const getAllEventsService = async () => {
  return await Event.find().sort({ createdAt: -1 });
};

module.exports = {
            createEventService,
            getAllEventsService,
            };
