const Approval = require('../models/approval.model');

const createApprovalRequest = async (data) =>{
   const {clubname, contract,applicationText, category, president} = data;

   if(!clubname || !contract || !applicationText || !category || !president){
   return{
     status:400,
     data: {message: "All fields are required"},
   }
   }

   const exists = await Approval.findOne({ clubname });
   if(exists){
    return{
     status:409,
     data:{message: "Club name already submitted."}
    }
   }
   const approval = new Approval({clubname, contract,applicationText, category, president});
   await approval.save();

   return {
        status: 201,
        data: { message: "Approval request submitted", approval },
   };
}

const getAllApprovalRequests = async () => {
  const requests = await Approval.find().sort({ createdAt: -1 });
  return {
    status: 200,
    data: requests,
  };
};

const updateApprovalStatus = async (id, status) => {
  const validStatuses = ["approved", "rejected"];

  if (!validStatuses.includes(status)) {
    return {
      status: 400,
      data: { message: "Invalid status" },
    };
  }

  const updated = await Approval.findByIdAndUpdate(id, { status }, { new: true });
  if (!updated) {
    return {
      status: 404,
      data: { message: "Approval request not found" },
    };
  }

  return {
    status: 200,
    data: { message: `Approval ${status}`, approval: updated },
  };
};

module.exports = {
 createApprovalRequest,
 getAllApprovalRequests,
 updateApprovalStatus
}