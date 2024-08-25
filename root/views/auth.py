from flask import Blueprint, redirect, url_for, request as req, render_template
from ..templates import Template
from ..ui.renderer import Renderer
from ..manager.user import UserManager as uM
from ..manager.xhr import Xhr as xhr
from .view_util import method
from settings import BASE_PATH
from root.manager.fn import Serializer
import subprocess
import sys

auth = Blueprint("auth", __name__)


@auth.route("authorization", methods=["POST", "GET"])
def welcome():
    user = uM.selected_account()
    if user:
        return redirect(url_for("main.index"))
    if req.form.get("xhr_init") and method("post"):
        return xhr.init_doc("auth")
    temp = Template(category="auth")
    temp.page_config(title="Auth")
    temp.add_data(step=1)
    return temp.render()


@auth.route("/logout", methods=["POST"])
def logout():
    if req.args.get("xhr"):
        return xhr.terminate()
    uM.end_session()
    return redirect(url_for("main.index"))


@auth.route("/start-up", methods=["POST", "GET"])
def start_up():
    user = uM.selected_account()
    tags = [1, 2, 3]
    if not user or not req.args:
        return redirect(url_for("main.index"))
    step = req.args.get("step")
    temp = Template(category="auth", name="start-up")
    temp.page_config(title="Let`s Go !").add_data(step=step)

    return Renderer.from_template(temp, collapse_endbar=True, flags=Renderer.flags(lock=True))


@auth.route("/install", methods=["POST", "GET"])
def install():
    ini_file = BASE_PATH.joinpath("install.py")
    if not ini_file.exists():
        return redirect(url_for("main.index"))
    if req.method == "POST":
        import pymysql
        from settings import DATABASE_CONFIG as db
        with BASE_PATH.joinpath("sql.sql").open("r") as file:
            conn = pymysql.connect(host=db["host"], password=db["password"], user=db["user"], database=db["db_name"])
            c = conn.cursor()

            for stmt in file.read().split(";"):
                if stmt:
                    c.execute(stmt)
            conn.commit()

        # subprocess.check_call([sys.executable, '-m', 'pip', 'install', '-r', 'requirements.txt'])

    config = {
        "css1": url_for("static", filename="stylesheet/theme.css"),
        "css2": url_for("static", filename="stylesheet/style.css"),
    }
    return render_template("install.html", config=config)



