from flask import Flask
from app.routes import routes
from dotenv import load_dotenv
import os

def create_app():
    # Load the environment variables from .env file
    load_dotenv()

    # Create the Flask app
    app = Flask(__name__, template_folder='app/templates')

    # Set the secret key using an environment variable
    app.config['SECRET_KEY'] = '1234'

    # Register the routes blueprint
    app.register_blueprint(routes)

    return app

if __name__ == '__main__':
    app = create_app()
    app.run(debug=True)
