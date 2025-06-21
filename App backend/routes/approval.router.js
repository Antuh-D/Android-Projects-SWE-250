const express = require('express');

const {
    createApprovalRequest,
    } = require('../controllers/approval.controller');


const router = express.Router();

router.post("/approval", createApprovalRequest);

module.exports = router;