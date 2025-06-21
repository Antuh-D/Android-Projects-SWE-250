const express = require('express');

const {
    createApprovalRequest,
    getAllApprovalRequests,
    updateApprovalStatus,
    } = require('../controllers/approval.controller');


const router = express.Router();

router.post("/approval", createApprovalRequest);
router.get("/approval", getAllApprovalRequests);
router.patch("/approval/:id", updateApprovalStatus);

module.exports = router;