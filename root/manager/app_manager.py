from .fn import load_ke_json
from flask import Flask


class SmvApp:
    KE_JSON = []

    @classmethod
    def initialize_app(cls, app: Flask):
        cls._load_files()

    @classmethod
    def _load_files(cls):
        cls.KE_JSON = load_ke_json()
