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

module.exports = {
createApprovalRequest,
}