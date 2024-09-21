from flask import request as req
from root.templates import Template
from .db import PDO
from .user import UserManager
from ..core.const import T_USERS


class Admin:
    @staticmethod
    def init() -> tuple:
        target = req.form.get("target")
        if not target:
            return None, None
        if hasattr(Admin, target):
            return getattr(Admin, target)()
        return None, None

    @classmethod
    def user_management(cls):
        temp = Template(category="admin/management", name="users", render_type=Template.RENDER_CONTENT_ONLY)
        users = UserManager.get_users()
        temp.add_data(users=users)
        return True, temp.render()

    @classmethod
    def single_user(cls):
        uid = req.form.get("user")
        temp = Template(category="admin/management", name="user_single", render_type=Template.RENDER_CONTENT_ONLY)
        users = UserManager.get_user_by_id(uid)
        temp.add_data(user_data=users)
        return True, temp.render()

    @classmethod
    def rmv_user(cls):
        uid = req.form.get("user")
        print(uid)
        if UserManager.delete(uid):
            return True, "user deleted"
        return False, None

    @classmethod
    def privileges(cls):
        uid = req.form.get("user")
        if req.form.get("set"):
            s = PDO.get_instance(T_USERS).update(
                "uid", uid, account_type="p"
            )
            return True if s else False, None

        temp = Template(category="admin/management", name="privileges", render_type=Template.RENDER_CONTENT_ONLY)

        user = UserManager.get_user_by_id(uid)
        temp.add_data(user_data=user)
        return True, temp.render()
