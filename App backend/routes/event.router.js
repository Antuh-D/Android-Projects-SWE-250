const express = require('express');
const {
      createEventController,
      getAllEventsController
      } = require('../controllers/event.controller');

const router = express.Router();

router.post('/events', createEventController);
router.get('/events', getAllEventsController);

module.exports = router;
