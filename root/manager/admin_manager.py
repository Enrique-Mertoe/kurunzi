from flask import request as req
from root.templates import Template
from .user import UserManager


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
        print(users)
        temp.add_data(users=users)
        return True, temp.render()
