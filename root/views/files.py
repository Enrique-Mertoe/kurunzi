from pathlib import Path
from settings import STATIC_FOLDER
from flask import Blueprint, send_from_directory

file = Blueprint("files", __name__)


@file.route("/<path:name>")
def files(name):
    # path = Path().resolve().joinpath("as
    return send_from_directory(STATIC_FOLDER, name)
