import random
import re
import typing as t
from flask import Flask
from jinja2 import Environment, nodes
from jinja2.ext import Extension
from jinja2.parser import Parser

from .admin import admin
from .files import file
from .main_bp import main, ajax
from .auth import auth
from .error import error

from datetime import datetime as dt

from settings import APP_CONFIG
from root.ui.jinja import UiUser
from random import randint


def register_urls(app: Flask):
    app.register_blueprint(main)
    app.register_blueprint(file, url_prefix='/file_manager')
    app.register_blueprint(auth, url_prefix="/auth")
    app.register_blueprint(error)
    app.register_blueprint(ajax, url_prefix="/_xhr")
    app.register_blueprint(admin, url_prefix="/admin")


def extend_env(app: Flask):
    env: Environment = app.jinja_env
    env.add_extension(_RequireExt)
    env.add_extension(GetFile)
    env.add_extension(MeldTag)

    for f_name, fn in vars(_JinjaFilters).items():
        if callable(fn):
            env.filters[f_name] = fn


class _RequireExt(Extension):
    tags = {'require'}

    def parse(self, parser: "Parser") -> t.Union[nodes.Node, t.List[nodes.Node]]:
        lineno = parser.stream.expect("name:require").lineno
        component = parser.parse_expression()
        call = self.call_method("_require", [component], lineno=lineno)
        return nodes.Output([nodes.MarkSafe(call)]).set_lineno(lineno)

    def _require(self, component):
        component = component + ".html"
        print(self.identifier)
        return self.environment.get_template(component).render()


class GetFile(Extension):
    # This will be the name of our tag
    tags = {'get_file'}

    def parse(self, parser):
        # Parse the arguments of the tag
        lineno = next(parser.stream).lineno
        args = [parser.parse_expression()]

        # Call our custom_include function
        return nodes.CallBlock(
            self.call_method('_get_file', args),
            [], [], []
        ).set_lineno(lineno)

    def _get_file(self, template_name):
        template_name = template_name + ".html"
        # Get the environment
        env = self.environment
        return "template.render(context)"


class MeldTag(Extension):
    tags = {"meld"}

    def parse(self, parser):
        lineno = parser.stream.expect("name:meld").lineno
        component = parser.parse_expression()
        call = self.call_method("_render", [component], lineno=lineno)
        return nodes.Output([nodes.MarkSafe(call)]).set_lineno(lineno)

    def _render(self, component):
        return self.environment.get_template(component)


class _JinjaFilters:
    @staticmethod
    def file_image(file_name: str):
        if file_name.startswith("placeholder"):
            return APP_CONFIG["files"]["images"] + "/" + file_name
        return APP_CONFIG["files"]["uploads"] + "/ket_images/avatars/h/" + file_name

    @staticmethod
    def joined(date):
        d = dt.fromtimestamp(date).strftime("%Y-%d-%b").split("-")
        return f"{d[2]} {d[1]} {d[0]}"

    @staticmethod
    def to_date(date):
        d = dt.fromtimestamp(date).strftime("%Y-%d-%b").split("-")
        return f"{d[1]} {d[2]} {d[0]}"

    @staticmethod
    def feed_image_upload(file_name):
        b = APP_CONFIG["files"]["uploads"] + "/ket_images/feeds"
        return {
            "high": b + "/h/" + file_name,
            "low": b + "/l/" + file_name,
        }

    @staticmethod
    def render_main(name):
        return f"admin/{name}/content.html"

    @staticmethod
    def get_file(obj):
        obj = FileProp(obj)
        return APP_CONFIG["files"]["uploads"] + f"/{obj.f_type}/{obj.category}/{obj.quality}/{obj.name}"

    @staticmethod
    def file_size(txt):
        return txt.split("/") or "2/1".split("/")

    @staticmethod
    def usermanager(uid):
        return UiUser(uid)

    @staticmethod
    def value_filter(value):
        return "" if not value else value

    @staticmethod
    def filter_html(text: str):
        def mt(s: str):
            c = ""
            if s.startswith("__link__"):
                c = "hs-link"
                s = s.replace("__link__", "")
                c = f"""<a href="{s}" target=_blank class="{c}">{s}</a>"""
            if s.startswith("__hash__"):
                c = "hash-tag"
                s = s.replace("__hash__", "")
                if s.startswith("@"):
                    c = f"""<span data-url="{re.sub("@+", "", s)}" class="{c}">{s}</span>"""
                else:
                    c = f"""<span class="{c}">{s}</span>"""

            return c

        match = re.sub(r"(__link__|__hash__)\S+", lambda match1: mt(match1.group()), text)
        print(match)
        return match

    @staticmethod
    def filter_doc_category(text: str):
        return text.lower().replace("/", "_") if text else ""


def generate_username():
    random_number = randint(10000, 99999)
    username = f'user{random_number}'
    return username


class FileProp:
    def __init__(self, items: list):
        f: str = items[1]
        items.pop()
        items.extend(f.split("-"))
        self._l = items

    @property
    def name(self) -> str:
        return self._l[0]

    @property
    def category(self) -> str:
        return self._l[1]

    @property
    def f_type(self) -> str:
        c = {"img": "ket_images", "vid": "ket_videos", 'file': "ket_docs"}
        return c.get(self._l[2])

    @property
    def quality(self) -> str:
        if len(self._l) > 3:
            return self._l[3]
        return "h"
