
// firebase functions
var functions = require('firebase-functions');

// firebase admin
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

// Stripe
var stripe = require("stripe")(
  "sk_test_UuLNWlSw018RWDleWC536Uat"
);

exports.createApplePayCharge = functions.database.ref('/public/client/{clientID}/payments/{sessionID}/pay').onWrite( event => {
    let token = event.data.val()
    console.log(token)
    // should have variable amount instead
    // two percent fee in stripe
    stripe.charges.create({
      amount: "5085",
      currency: "cad",
      source: token,
      description: "Charge for 1 hour session"
    }, function(err, charge) {

    });
})


// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
