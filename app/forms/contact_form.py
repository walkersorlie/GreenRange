from flask_wtf import FlaskForm
from wtforms import StringField, TextAreaField
from wtforms.fields.html5 import EmailField
from wtforms.validators import required, optional, Email


class ContactForm(FlaskForm):
    name = StringField(label='Name', validators=[required()])
    company = StringField(label='Company', validators=[optional()])
    email = EmailField(label='Email address', validators=[required(), Email(message='Email address is not valid')], id='formEmail', render_kw={'placeholder': 'name@emailaddress.com'})
    question = TextAreaField(label='Question?', validators=[optional()], render_kw={'rows': 4})
