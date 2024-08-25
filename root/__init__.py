from flask import Flask
from pathlib import Path
from .views import register_urls, extend_env
from settings import STATIC_FOLDER, TEMPLATES_FOLDER
from root.manager.app_manager import SmvApp


def create_app() -> Flask:
    app = Flask(__name__)
    app.secret_key = "kind87keys98kind988kids9"
    app.template_folder = TEMPLATES_FOLDER
    app.static_folder = STATIC_FOLDER
    register_urls(app)
    extend_env(app)
    SmvApp.initialize_app(app)
    return app
