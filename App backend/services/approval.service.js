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

module.exports = {
 createApprovalRequest,

}