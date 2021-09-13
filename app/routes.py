from flask import Blueprint, render_template, request, jsonify, make_response, current_app as app
from flask_mail import Message
from app import mail
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

            company = company if company else 'NO_COMPANY_PROVIDED'
            body = question if question else 'NO_QUESTION_PROVIDED'
            msg = Message(
                subject=f"'{name}' from '{company}' has requested information",
                sender='contact-me@greenrangeproducts.com',
                recipients=['walker@greenrangeproducts.com'],
                body = body
            )
            mail.send(msg)

            return make_response(jsonify({'message': 'Successfully submitted'}), 200)
        else:
            print(f'errors: {form.errors}')

        return make_response(jsonify({'message': form.errors}), 200)

@route.app_errorhandler(404)
def page_not_found(error):
    return render_template('404.html'), 404