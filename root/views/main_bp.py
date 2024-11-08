from flask import Blueprint, redirect, url_for, request as req, session

from root.ui.renderer import Renderer
from ..manager import UserManager as uM
from ..manager.xhr import Xhr as xhr
from ..templates import Template

main = Blueprint("main", __name__)
ajax = Blueprint("xhr", __name__)


@main.route("/", methods=["POST", "GET"])
def index():
    user = uM.current_user()
    tag = "home"
    if not user:
        return redirect(url_for("auth.welcome"))

    template = Template(category="home")
    template.add_data(user=user)

    template.page_config(title=Template.TITLE_DEFAULT, url="", name=tag)

    return Renderer.from_template(template, load_posts=True, collapse_endbar=False)


@main.route("/chat")
def chat():
    temp = Template(category="chat", name="splash")
    temp.page_config(title="Chat", url="url")
    return temp.render()


@main.route("/updates", methods=["POST", "GET"])
def updates():
    user = uM.current_user()
    if not user:
        return redirect(url_for("auth.welcome"))
    temp = Template(category="updates")
    temp.page_config(title="Updates", url="updates")
    departments = uM.get_users({"account_type": "p"})
    users = uM.get_users({
        "account_category": 1
    })
    temp.add_data(departments=departments, users=users)
    return Renderer.from_template(temp, mini_sidebar=True, collapse_endbar=True)


@main.route("/doc_repo", methods=["POST", "GET"])
def doc_repo():
    user = uM.current_user()
    tag = "doc_repo"
    if not user:
        return redirect(url_for("auth.welcome"))
    temp = Template(category="doc_repo")
    temp.page_config(title="", url=tag)
    return Renderer.from_template(temp, mini_sidebar=True, collapse_endbar=True)


@main.route("/feedback-&-response", methods=["POST", "GET"])
def feed_response():
    user = uM.current_user()
    tag = "feedback-&-response"
    if not user:
        return redirect(url_for("auth.welcome"))
    temp = Template(category="doc_repo")
    temp.page_config(title="", url=tag)
    return Renderer.from_template(temp, mini_sidebar=True, collapse_endbar=True)


@main.route("/corruption", methods=["POST", "GET"])
def corruption():
    tag = "corruption"
    user = uM.current_user()
    if not user:
        return redirect(url_for("auth.welcome"))
    temp = Template(category=tag)
    temp.page_config(title="AngukaNayo", url=tag)
    return Renderer.from_template(temp, load_posts=True)


@main.route("/explore", methods=["POST", "GET"])
def explore():
    tag = "explore"
    user = uM.current_user()
    if not user:
        return redirect(url_for("auth.welcome"))
    temp = Template(category=tag)
    temp.page_config(title="Corruption | Main", url=tag, name=tag)
    return Renderer.from_template(temp, load_posts={"post_type": 2, "f_type": "doc_commented"})


@main.route("/settings", methods=["POST", "GET"])
def settings():
    tag = "settings"
    url = tag
    pages = "account,security".split(",")
    page = req.args.get("st")
    user = uM.current_user()
    if not user:
        return redirect(url_for("auth.welcome"))
    temp = Template(category=tag, name=page if page else Template.MAIN)
    if page:
        page = page if page in pages else pages[0]
        url = url + "?st=" + page
        temp.add_tag(sPage=page)
    temp.page_config(title=f"@{user.username} | settings", url=url, name=tag)

    return Renderer.from_template(temp)


@main.route("/<uname>", methods=["POST", "GET"])
def timeline(uname):
    tag = "timeline"
    user = uM.current_user()
    t_user = uM.get_user_by_name(uname)
    if not user:
        return redirect(url_for("auth.welcome"))

    temp = Template(category=tag)
    temp.page_config(title=f"@{uname} | Timeline", url=uname, name=tag)
    temp.add_data(tUser=t_user, user=user)
    temp.properties = {
        "user": t_user
    }
    return Renderer.from_template(temp, load_posts={
        "uid": t_user.uid
    }, collapse_endbar=False)


@main.route("/notifications", methods=["POST", "GET"])
def notifications():
    tag = "notifications"
    user = uM.selected_account()
    if not user:
        return redirect(url_for("auth.welcome"))

    temp = Template(category=tag)
    temp.page_config(title=f"Notifications", url=tag, name=tag)
    return Renderer.from_template(temp, load_notes=True, collapse_endbar=False)


@main.route("/feedbacks", methods=["POST", "GET"])
def feedbacks():
    tag = "feedbacks"
    user = uM.selected_account()
    if not user:
        return redirect(url_for("auth.welcome"))
    temp = Template(category=tag)
    temp.page_config(title=tag, url=tag, name=tag)
    return Renderer.from_template(temp)


@main.route("/premium", methods=["GET", "POST"])
def premium():
    tag = "premium"
    user = uM.selected_account()
    if not user:
        return redirect(url_for("auth.welcome"))

    temp = Template(category=tag)
    temp.page_config(title=f"Premium", url=tag, name=tag)
    return Renderer.from_template(temp, load_notes=True)


@main.route("/_empty", methods=["POST", "GET"])
def empty():
    tag = "empty"
    user = uM.selected_account()
    if not user:
        return redirect(url_for("auth.welcome"))

    temp = Template(category=tag)
    temp.page_config(title=req.args.get("tr", f"Nothing"), url="_empty", name=tag)
    return Renderer.from_template(temp, load_notes=True)


@ajax.route("/<action>", methods=["POST"])
def _xhr(action):
    action = xhr.filter_actions(action)
    if hasattr(xhr, action):
        return getattr(xhr, action)()
    return xhr.invalid_action()


@main.route("/auth_begin")
def auth_begin():
    tag = "auth_begin"
    user = uM.selected_account()
    if not user:
        return redirect(url_for("auth.welcome"))
    temp = Template(name=tag, category="home")
    temp.page_config(title=f"Premium", url=tag, name=tag)
    return Renderer.from_template(temp)


@main.route("/start_a", methods=["POST", "GET"])
def start_a():
    rdr = req.args.get("rdr")
    session.pop("start_a", None)
    return redirect(rdr)
