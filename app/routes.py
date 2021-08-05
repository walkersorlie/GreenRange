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
            return make_response(jsonify({'message': 'Successfully submitted'}), 200)
        else:
            print(f'errors: {form.errors}')
        return make_response(jsonify({'message': form.errors}), 200)


@route.route("/submitContactForm", methods=['POST'])
def submit_contact_form():
    form = ContactForm()

    if form.validate_on_submit():
        return jsonify(data={'message': 'Successfully submitted'})

    return jsonify(data=form.errors)

@route.app_errorhandler(404)
def page_not_found(error):
    return render_template('404.html'), 404