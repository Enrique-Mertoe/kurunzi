import time
from flask import session, request as req
from werkzeug.datastructures import FileStorage

from .fn import gen_key, PasswordManager as pM
from .db import PDO
from ..core.const import T_USERS, SESSION_TAG
from ..models import User
from .base_manager import BaseManager
from .file_manager import FileManager


class UserManager(BaseManager):
    USER = None
    _FORM_REGISTER = "register"
    _FORM_LOGIN = "login"
    __FORM_PAGE = "page"
    __START_1 = "start-up"

    def __init__(self):
        super().__init__(T_USERS)

    @classmethod
    def _start_session(cls, key):
        session[SESSION_TAG] = key

    @classmethod
    def end_session(cls):
        session.pop(SESSION_TAG, None)

    @classmethod
    def selected_account(cls) -> None | dict:
        return session.get(SESSION_TAG)

    @classmethod
    def current_user(cls) -> User:
        return cls.get_user_by_id(cls.selected_account())

    @classmethod
    def get_user_by_email(cls, email) -> User:
        return User(PDO.get_instance(T_USERS).get({"email": email}).single)

    @classmethod
    def get_user_by_key(cls, keys: dict, **alternatives) -> User:
        return User(PDO.get_instance(T_USERS).get(keys, **alternatives).single)

    @classmethod
    def get_users(cls, keys: dict = {}, **alternatives) -> list[User]:
        return [User(user) for user in PDO.get_instance(T_USERS).get(keys, **alternatives).all]

    @classmethod
    def get_user_by_name(cls, uname) -> User:
        return User(PDO.get_instance(T_USERS).get({"uname": uname}).single)

    @classmethod
    def get_user_by_id(cls, uid) -> User:
        return User(PDO.get_instance(T_USERS).get({"uid": uid}).single)

    @classmethod
    def _create_user(cls, data) -> str | None | int:
        if cls.get_user_by_key({"email": data["email"]}, uname=data["email"]).is_not_empty:
            return 100

        uid = gen_key()
        data["uid"] = uid
        data["joined"] = time.time()
        data["uname"] = data["fullname"].replace(" ", "")
        create = PDO.get_instance(T_USERS).push(data=data)
        return uid if create else None

    @classmethod
    def _login_user(cls, email, password) -> tuple | int:
        user = cls.get_user_by_key({"email": email}, uname=email)
        if user.is_empty:
            return 404
        pw = user.get("password", "")
        if pM.verify(pw, password):
            return user.get("uid"), "Login successful"
        else:
            return False, "Wrong password"

    @classmethod
    def user_form(cls, form, form_data) -> tuple:
        if form == cls._FORM_REGISTER:
            res = cls._create_user(cls._prepare_f_data(form_data))
            if res == 100:
                return False, "Email already used."
            if res:
                cls._start_session(res)
                return True, "Account created successfully."
            return False, "Unable to create user."
        if form == cls._FORM_LOGIN:
            res = cls._login_user(*cls._prepare_l_data(form_data))
            if res == 404:
                return False, "Account not found."
            if res[0]:
                cls._start_session(res[0])
            return res
        if form == cls.__FORM_PAGE:
            file = [req.files.get("profile_pic")]
            s = cls._create_user(cls._prepare_p_data(form_data))
            if s and file and file[0]:
                cls.handle_avatar(file, s)
            return True if s else False, "sss"
        if form == cls.__START_1:

            file = req.files.get("profile_pic"),
            data = {"uname": form_data.get("uname")}
            if file and file[0]:
                cls.handle_avatar(file, cls.selected_account())
            res = cls.make_update(T_USERS, **data, _key_content=("uid", cls.selected_account()))
            return True if res else False, None
        return False, "Invalid form."

    @classmethod
    def handle_avatar(cls, file, uid):
        file = FileManager(file, "avatar").files()[0]
        res = cls.make_update(T_USERS, profile_pic=file.filename, _key_content=("uid", uid))
        if res:
            file.upload("avatars")

        return True if res else False

    @staticmethod
    def _prepare_f_data(data: dict):
        return {
            "fullname": f"{data.get('f-name')} {data.get('l-name')}",
            "password": pM.hash(data.get("u-password", "")),
            "email": data.get("u-email"),
            "gender": data.get("u-gender"),
            "county": data.get("u-county"),
            "constituency": data.get("u-s-county")
        }

    @staticmethod
    def _prepare_p_data(data: dict):
        return {
            "fullname": f"{data.get('p-name')}",
            "password": pM.hash("12345"),
            "email": f"{data.get('p-mail')}",
            "gender": "other",
            "county": "",
            "constituency": "",
            "account_category": data.get("category"),
            "account_type": "p",
            "bio": data.get("p-desc")
        }

    @staticmethod
    def _prepare_l_data(data: dict) -> list:
        return [data.get("u-email"), data.get("u-password", "")]
