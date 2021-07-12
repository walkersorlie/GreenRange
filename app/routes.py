from flask import Blueprint, render_template
from flask import current_app as app


route = Blueprint("route", __name__)

@route.route("/")
def index():
    return render_template('index.html')


@route.errorhandler(404)
def page_not_found(error):
    return render_template('page_not_found.html'), 404