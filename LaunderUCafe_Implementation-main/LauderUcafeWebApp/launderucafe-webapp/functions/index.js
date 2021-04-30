const functions = require("firebase-functions");

const admin = require("firebase-admin");

admin.initializeApp();

exports.addAdminRole = functions.https.onCall((data, context) => {
  //get user and add custom claim (admin)
  return admin.auth().getUserByEmail(data.email).then(user => {
    return admin.auth().setCustomUserClaims(user.uid, {
      admin:true
    });
  }).then(()=> {
    return {
      message:'Success! User has been made an admin'
    }
  }).catch(err => {
    return err;
  });
});

exports.addEmployeeRole = functions.https.onCall((data, context) => {
  //get user and add custom claim (admin)
  return admin.auth().getUserByEmail(data.email).then(user => {
    return admin.auth().setCustomUserClaims(user.uid, {
      employee:true
    });
  }).then(()=> {
    return {
      message:'Success! User has been made an employee'
    }
  }).catch(err => {
    return err;
  });
});
