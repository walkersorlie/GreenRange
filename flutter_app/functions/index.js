const functions = require("firebase-functions");
const sgMail = require("@sendgrid/mail");
sgMail.setApiKey(functions.config().sendgrid.key);

exports.contactMeEmailEndpoint = functions.https.onCall((data, context) => {
  const name = data.name;
  const email = data.email;
  const company = data.company;
  const question = data.question;

  const fromCompany = (company) ? company : "NO_COMPANY_PROVIDED";
  const body = (question) ? question : "NO_QUESTION_PROVIDED";
  const subject = "'" + name + "'" + " from '" +
    fromCompany + "' has requested information";
  const msg = {
    to: "contact-me@greenrangeproducts.com",
    from: "contact-me@greenrangeproducts.com",
    subject: subject,
    text: "Email address: " + email + "\n\n" + body,
  };
  return sgMail.send(msg).then(() => {
    return true;
  }).catch((error) => {
    return null;
  });
});
