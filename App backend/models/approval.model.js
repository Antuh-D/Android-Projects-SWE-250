const mongoose = require("mongoose");

const approvalSchema = new mongoose.Schema({
    clubname: {type: String, required:true, unique:true},
    contract: {type:String, required:true,},
    applicationText:{type:String, required:true} ,
    category:{type:String, required:true} ,
    president:{type:String, required:true},
    status: { type: String, default: "pending" },
    createdAt: { type: Date, default: Date.now },
});

module.exports = mongoose.model("Approval", approvalSchema);