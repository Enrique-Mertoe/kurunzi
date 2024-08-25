from flask import Blueprint, redirect, url_for
from root.manager.user import UserManager as uM
from root.templates import Template
from root.ui.renderer import Renderer

admin = Blueprint("admin", __name__)


@admin.route("/")
def home():
    if not uM.current_user().is_admin:
        return redirect(url_for("main.index"))
    return redirect(url_for("admin.dashboard"))


@admin.route("/management")
def management():
    user = uM.current_user()
    tag = "management"
    if not user:
        return redirect(url_for("auth.welcome"))
    template = Template(category="dash", admin=True)
    # users = uM.get_users()
    template.add_data(user=user)
    template.page_config(title="Admin management", url="", name=tag)

    return Renderer.from_template(template, load_posts=True)


@admin.route("/dashboard")
def dashboard():
    user = uM.current_user()
    tag = "dashboard"
    if not user:
        return redirect(url_for("auth.welcome"))
    template = Template(category="management", admin=True)
    template.add_data(user=user)
    template.page_config(title="Admin panel | " + Template.TITLE_DEFAULT, url="", name=tag)

    return Renderer.from_template(template, load_posts=True)


@admin.route("/page_management", methods=["POST", "GET"])
def page_management():
    tag = "page_management"
    user = uM.current_user()
    if not user:
        return redirect(url_for("auth.welcome"))
    temp = Template(category=tag)
    temp.page_config(title="Corruption | Main", url=url_for("admin.page_management").lstrip("/"), name=tag)
    return Renderer.from_template(temp, mini_sidebar=True, collapse_endbar=True, load_posts=True)
