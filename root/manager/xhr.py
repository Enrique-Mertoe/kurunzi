from flask import jsonify, request as req, url_for
from .user import UserManager as uM
from .general import FollowManager as followManager, NoteManager
from ..templates import Template
from .file_manager import FileManager as fM
from .feed_manager import FeedManager as Feed
from root.ui.fn import component_loader
from root.manager.admin_manager import Admin
from root.manager.app_manager import SmvApp


class Xhr:
    _HIDDEN_ACTIONS = {
        "fl_sg": "follow_suggest",
        "rc_c": "recent_comments",
        "fl_o": "follow"

    }

    @staticmethod
    def _xhr_response(*, success=False, data=None, message=None, **kwargs):
        d = {
            "success": success,
            "data": data,
            "message": message
        }
        d.update(kwargs)
        return jsonify(d)

    @staticmethod
    def filter_actions(action: str) -> str:
        return Xhr._HIDDEN_ACTIONS.get(action, action)

    @classmethod
    def init_doc(cls, page: str | Template, **options):
        user = uM.selected_account()
        side, main, end = options.get("init", [1, 1, 1])
        options.pop("init", None)
        if user:
            auth = False

            temp1 = Template(category="header", render_type=Template.RENDER_CONTENT_ONLY)
            temp2 = Template(category="sidebar", render_type=Template.RENDER_CONTENT_ONLY)
            temp3 = page if type(page) is Template else Template(category=page, name="layout",
                                                                 render_type=Template.RENDER_CONTENT_ONLY)
            temp4 = Template(category="endbar", render_type=Template.RENDER_CONTENT_ONLY)

            for t in [temp1, temp2, temp3, temp4]:
                t.add_data(user=uM.current_user())
            temp = {
                "header": temp1.render(),
                "aside": temp2.render(),
                "main": temp3.render(),
                "end": temp4.render() if end else ""
            }
        else:
            auth = True
            temp = Template(category="auth", render_type=Template.RENDER_CONTENT_ONLY).add_data(step=1)
            temp = temp.render()

        options.update(fl_sg=True)
        return cls._xhr_response(
            success=True, data={
                "content": temp,
                "parent": ".main-layout"
            },
            auth=auth,
            **options
        )

    @classmethod
    def auth(cls):
        tag = req.args.get("tag")
        rdr = req.args.get("rdr")
        if not tag:
            return cls._xhr_response()
        a = {}
        if rdr:
            a["rdr"] = url_for("main.auth_begin") if rdr == 1 else rdr
        if tag == "register":
            a["redirect"] = url_for("auth.start_up", step="start")

        suc, res = uM.user_form(tag, req.form)
        return cls._xhr_response(data=res, success=suc, message=res if type(res) is str else None, **a)

    @classmethod
    def form_register(cls):
        step = req.args.get("step")
        temp = Template(category="auth", name="register", render_type=Template.RENDER_CONTENT_ONLY)

        options = {}
        suc = True
        if step == "1":
            temp.add_data(step=2)
        if step == "2":
            temp.add_data(step=3)
            email = req.form.get("u-email")
            if uM.get_user_by_email(email).is_not_empty:
                options["error"] = "Email already exists"
                suc = False
        if step == "3":
            temp.add_data(step=4, ke=SmvApp.KE_JSON)
        if step == "4":
            temp.add_data(step=5)
            options["can_send"] = True

        return cls._xhr_response(success=suc, data=temp.render(), **options)

    @classmethod
    def terminate(cls):
        uM.end_session()
        return cls._xhr_response(data="success", success=True, redirect=url_for("auth.welcome", rdr=1))

    @classmethod
    def page(cls, page_data, **kwargs):
        return cls._xhr_response(data=page_data, success=True, **kwargs)

    @classmethod
    def studio(cls):
        files = req.files.getlist("m-files")
        if not len(files):
            return cls._xhr_response(data="No file selected")
        files = fM(files, "feed").files()

        try:
            res, mes = Feed.create_feed(req.form, files)
            if res:
                mes = Feed.studio_recently_posted(mes).render()
        except Exception as e:
            print(e)
            res = False
            mes = "Something went wrong!"

        return cls._xhr_response(success=res, data=mes)

    @classmethod
    def posts(cls):
        p = Feed.get_posts(start=req.form.get("from", 0))

        d = {
            "content": p
        }
        if not len(p):
            d["content"] = "Empty"
            d["empty"] = True
        return cls._xhr_response(success=True, data=d)

    @classmethod
    def post_reaction(cls):
        d = req.form
        ty = d.get("type")
        tar = d.get("target")
        suc = None
        res = None
        if ty == Feed.REACTION_LIKE:
            suc, res = Feed.handle_likes(tar)

        return cls._xhr_response(success=suc, data=res)

    @classmethod
    def post_actions(cls):
        d = req.form
        ty = d.get("type")
        tar = d.get("target")
        suc = None
        res = None
        if ty == Feed.ACTION_DELETE:
            suc = Feed.delete_post(tar)

        return cls._xhr_response(success=suc, data=res)

    @classmethod
    def follow_suggest(cls):
        f = followManager.follow_suggest(uM.selected_account())
        temp = Template(category="xhr/follow", render_type=Template.RENDER_CONTENT_ONLY)
        d = [
            temp.add_data(sug=user).render()
            for user in f
        ]
        return cls._xhr_response(success=True, data=d)

    @classmethod
    def recent_comments(cls):
        t = req.form.get("target")
        cmt = Feed.get_comments(t)
        d = {
            "empty": not len(cmt),
            "content": '<span class="py-2 comment-item">Be first to comment</span>'
        }
        temp = Template(category="xhr/post", name="comment", render_type=Template.RENDER_CONTENT_ONLY)
        c = [temp.add_data(comment=item).render() for item in cmt]
        if c:
            d["content"] = c
        return cls._xhr_response(success=True, data=d)

    @classmethod
    def new_comment(cls):
        d = req.form
        add = Feed.add_comment(target=d.get("target"), status=d.get("status"))
        return cls._xhr_response(success=add, data=add)

    @classmethod
    def follow(cls):
        t = req.form.get("target")
        fm = followManager
        d = (uM.selected_account(), t)
        if fm.is_following(*d):
            s, d = fm.unfollow(*d)
        else:
            s, d = followManager.follow(*d)
        d = "follow" if d == -1 else "unfollow"

        return cls._xhr_response(success=s, data=d)

    @classmethod
    def notifications(cls):
        n = NoteManager.get_notifications()
        d = {
            "content": n,
            "empty": False if n else True
        }
        if not n:
            d["content"] = "<span>nothing to view</span>"
        return cls._xhr_response(success=True, data=d)

    @classmethod
    def ui_components(cls):
        ui = component_loader()

        dialogs = Template(category="utils", name="modals")
        feed_plant = Template(category="home", name="feed-plant-input")
        up = Template(category="updates", name="component")
        ui.add_feature(dialogs=dialogs, fp=feed_plant, updateTag=up)
        return cls._xhr_response(success=True, data=ui.serialize())

    @classmethod
    def load_comments(cls):
        target = req.form.get("target")
        if target:
            comments = Feed.get_comments(target, limit="")
            temp = Template(category="comment", render_type=Template.RENDER_CONTENT_ONLY)
            temp.add_data(comments=comments)
            return cls._xhr_response(success=True, data=temp.render())
        return cls._xhr_response()

    @classmethod
    def new_page(cls):
        suc, res = uM.user_form("page", req.form)
        return cls._xhr_response(data=res, success=suc, message=res if type(res) is str else None)

    @classmethod
    def admin(cls):
        suc, res = Admin.init()
        return cls._xhr_response(success=suc, data=res)

    @classmethod
    def up_manager(cls):
        t = Template(category="updates", name="departs", render_type=Template.RENDER_CONTENT_ONLY)
        users = uM.get_users({"account_type": "p"})
        t.add_data(users=users)
        return cls._xhr_response(success=True, data=t.render())

    @classmethod
    def update_link(cls):
        target = req.form.get("target")
        if target:
            temp = Template(category="updates", name="update-item", render_type=Template.RENDER_CONTENT_ONLY)
            config = {"page": target}
            if target == "president":
                config.update({
                    "title": "The President."
                })
            if target == "d_president":
                config.update({
                    "title": "The Deputy President."
                })
            if target.startswith("c_"):
                config["counties"] = SmvApp.KE_JSON
            temp.add_data(config=config)
            return cls._xhr_response(success=True, data=temp.render())
        return cls._xhr_response()

    @staticmethod
    def invalid_action():
        return Xhr._xhr_response()

    @classmethod
    def update_item_content(cls):
        target = req.form.get("target")
        if not target:
            return cls._xhr_response()
        temp = Template(category="updates", name="update_item_content", render_type=Template.RENDER_CONTENT_ONLY)
        temp.add_data(target=cls._formart_uic(target))
        return cls._xhr_response(success=True, data=temp.render())

    @staticmethod
    def _formart_uic(text):
        return {
            "rac": "Received /Allocations",
            "plb": "plans/Budget",
            "ext": "Expense/Tenders",
            "mca": "MCA office",
            "cecm": "CECM Office",
            "governor": "Governor Office"
        }.get(text, text)
