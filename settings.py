from pathlib import Path
import os


BASE_PATH = Path(os.path.dirname(os.path.abspath(__file__))).resolve()
TEMPLATES_FOLDER = BASE_PATH.joinpath("resources", "layout")
STATIC_FOLDER = BASE_PATH.joinpath("resources", "files")

PORT = 8000
HOST = "192.168.1.101"
# HOST = "localhost"

DEBUG = True
#
SITE_URL = f"http://{HOST}:{PORT}/"

DATABASE_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "db_name": "kenya_today",

}

# SITE_URL = "https://kenyatoday.pythonanywhere.com/"
#
# DATABASE_CONFIG = {
#     "host": "kenyatoday.mysql.pythonanywhere-services.com",
#     "user": "kenyatoday",
#     "password": "123456_-",
#     "db_name": "kenyatoday$default",
#
# }

APP_CONFIG = {
    "config": {
        "site_url": SITE_URL,
        "app_name": "Tuiseme",
        "title": "Kenya Today",
        "logo": SITE_URL + "/file_manager/images/logo.svg",
        "fav": SITE_URL + "/file_manager/images/fav.png"
    },
    "files": {
        "images": SITE_URL + "/file_manager/images",
        "uploads": SITE_URL + "/file_manager/app_files",
        "videos": SITE_URL + "/file_manager/videos",
        "docs": SITE_URL + "/file_manager/docs"
    },
    "css": {
        "theme": SITE_URL + "/file_manager/stylesheet/theme.css",
        "main": SITE_URL + "/file_manager/stylesheet/style.css",
        "admin": SITE_URL + "/file_manager/stylesheet/admin.css",
    },
    "js": {
        "jquery": SITE_URL + "/file_manager/scripts/jq.min.js",
        "main": SITE_URL + "/file_manager/scripts/main.js",
        "smv": SITE_URL + "/file_manager/scripts/smallville.js",
        "general": SITE_URL + "/file_manager/scripts/general.js",
        "admin": SITE_URL + "/file_manager/scripts/admin.js",
        "bootstrap": SITE_URL + "/file_manager/scripts/bootstrap.min.js",
        "appjs": SITE_URL + "/file_manager/scripts/appjs.js"
    },
}
