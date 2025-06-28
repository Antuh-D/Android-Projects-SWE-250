const { createEventService, getAllEventsService } = require('../services/event.service');

const createEventController = async (req, res) => {
  try {
    const eventData = req.body;

    const createdEvent = await createEventService(eventData);
    res.status(201).json({ message: "Event created", data: createdEvent });
  } catch (error) {
    console.error("Event creation error:", error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

const getAllEventsController = async (req, res) => {
  try {
    const events = await getAllEventsService();
    res.status(200).json(events);
  } catch (error) {
    console.error("Error fetching events:", error);
    res.status(500).json({ error: 'Failed to fetch events' });
  }
};

module.exports = { createEventController ,getAllEventsController};
