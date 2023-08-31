const functions = require ('firebade-functions');
exports.sendEmail = functions.database.ref('/emailSubscribers/{email}').
onWrite(event => {
    const email = event.data.email;
    const message = 'Hi ${email},'
    'This is an automated email for me.'

    'Thanks',
    'Mobisa Kwamboka'

});