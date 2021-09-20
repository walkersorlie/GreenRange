import os
from flask import Flask
from flask_wtf.csrf import CSRFProtect


def access_secrets():
    from google.cloud import secretmanager

    client = secretmanager.SecretManagerServiceClient()

    secrets = {
        'secret_key': 'projects/123181321826/secrets/SECRET_KEY/versions/latest',
        'sendgrid_api_key': 'projects/123181321826/secrets/SENDGRID_API_KEY/versions/latest'
    }

    ret = {}
    for key, value in secrets.items():
        response = client.access_secret_version(request={"name": value})
        payload = response.payload.data.decode("UTF-8")
        ret[key] = payload

    return ret


csrf = CSRFProtect()

def create_app(testing=False):
    app = Flask(__name__)

    flask_env = os.getenv("FLASK_ENV", 'production')

    from app import config

    if flask_env == 'production':
        secrets = access_secrets()
        app.config.from_object(config.ProductionConfig)

        app.config['SECRET_KEY'] = secrets['secret_key']
        app.config['SENDGRID_API_KEY'] = secrets['sendgrid_api_key']

    else:
        app.config['SECRET_KEY'] = os.getenv('SECRET_KEY', None)
        app.config['SENDGRID_API_KEY'] = os.getenv('SENDGRID_API_KEY')

        if testing or flask_env == 'testing':
            app.config.from_object(config.TestingConfig)
        elif flask_env == 'development':
            app.config.from_object(config.DevelopmentConfig)

    # init CSRF protection
    csrf.init_app(app)

    # Import and register blueprints
    from app.routes import route
    app.register_blueprint(route)

    return app
