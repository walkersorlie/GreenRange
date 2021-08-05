import os
from flask import Flask
from flask_wtf.csrf import CSRFProtect
from flask_mail import Mail
from app import config


csrf = CSRFProtect()
mail = Mail()

def create_app(testing=False):
    app = Flask(__name__)

    # load secret key
    app.config['SECRET_KEY'] = os.getenv('SECRET_KEY', None)

    # init CSRF protection
    csrf.init_app(app)

    # Dynamically load config based on the testing argument or FLASK_ENV environment variable
    flask_env = os.getenv("FLASK_ENV", None)
    if testing:
        app.config.from_object(config.TestingConfig)
    elif flask_env == "development":
        app.config.from_object(config.DevelopmentConfig)
    elif flask_env == "testing":
        app.config.from_object(config.TestingConfig)
    else:
        app.config.from_object(config.ProductionConfig)

    # init mail backend
    mail.init_app(app)

    # Import and register blueprints
    from app.routes import route
    app.register_blueprint(route)

    return app
