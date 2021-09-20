import sendgrid
from sendgrid.helpers.mail import Mail, Email, To, Content
from flask import Blueprint, render_template, request, jsonify, make_response, current_app as app
from app.forms.contact_form import ContactForm


route = Blueprint("route", __name__)

@route.route("/", methods=['GET', 'POST'])
def index():
    form = ContactForm()

    if request.method == 'GET':
        return render_template('index.html', form=form)

    elif request.method == 'POST':
        if form.validate_on_submit():
            name = form.name.data
            company = form.company.data
            email = form.email.data
            question = request.form['question']

            sg = sendgrid.SendGridAPIClient(api_key=app.config['SENDGRID_API_KEY'])
            from_email = Email('contact-me@greenrangeproducts.com')
            to_email = To('walker@greenrangeproducts.com')
            company = company if company else 'NO_COMPANY_PROVIDED'
            body = question if question else 'NO_QUESTION_PROVIDED'
            subject = f"'{name}' from '{company}' has requested information"
            content = Content("text/plain", body)
            mail = Mail(from_email, to_email, subject, content)

            mail_json = mail.get()
            response = sg.client.mail.send.post(request_body=mail_json)


            return make_response(jsonify({'message': 'Successfully submitted'}), 200)
        else:
            print(f'errors: {form.errors}')

        return make_response(jsonify({'message': form.errors}), 200)

@route.app_errorhandler(404)
def page_not_found(error):
    return render_template('404.html'), 404