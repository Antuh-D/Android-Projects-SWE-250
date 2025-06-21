const approvalService = require("../services/approval.service");

const createApprovalRequest = async(req, res) =>{
 try{
   const result = await approvalService.createApprovalRequest(req.body);
   res.status(result.status).json(result.data)
 }catch(err){
   console.error("Create Approval Error:", err);
   res.status(500).json({ message: "Server error" });
 }
}

const getAllApprovalRequests = async (req, res) => {
  try {
    const result = await approvalService.getAllApprovalRequests();
    res.status(result.status).json(result.data);
  } catch (err) {
    console.error("Get Approvals Error:", err);
    res.status(500).json({ message: "Server error" });
  }
};

const updateApprovalStatus = async (req, res) => {
  try {
    const id = req.params.id.trim();
    const { status } = req.body;
    const result = await approvalService.updateApprovalStatus(id, status);
    res.status(result.status).json(result.data);
  } catch (err) {
    console.error("Update Approval Error:", err);
    res.status(500).json({ message: "Server error" });
  }
};

module.exports = {
    createApprovalRequest,
    getAllApprovalRequests,
    updateApprovalStatus,
}