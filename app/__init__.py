import os
from flask import Flask
from app import config


def create_app(testing=False):
    app = Flask(__name__)

    # Dynamically load config based on the testing argument or FLASK_ENV environment variable
    flask_env = os.getenv("FLASK_ENV", None)
    if testing:
        app.config.from_object(config.TestingConfig)
    elif flask_env == "development":
        app.config.from_object(config.ProductionConfig)
    elif flask_env == "testing":
        app.config.from_object(config.TestingConfig)
    else:
        app.config.from_object(config.ProductionConfig)

    # Import and register blueprints
    from app.routes import route
    app.register_blueprint(route)

    return app
