from enum import Enum


class BaseModel:
    TAG = None

    def __init__(self, model):
        self.__model = model or {}

    @property
    def is_empty(self) -> bool:
        return False if self.__model else True

    @property
    def is_not_empty(self) -> bool:
        return True if self.__model else False

    def __getitem__(self, item):
        return self.__model.get(item)

    def get(self, item, default=None):
        return self[item] or default

    def __str__(self):
        if self.TAG:
            items = "".join([f"\t{key}:{val}\n"
                             for key, val in self.__model.items()
                             ])
            return f"""<{self.TAG}>(\n{items})"""
        return super().__str__()

    def __setitem__(self, key, value):
        self.__model[key] = value


class User(BaseModel):
    """
    User model
    """

    def __init__(self, *args, **kwargs):
        # force dictionary
        if args:
            self._props = args[0] if isinstance(args[0], dict) else {}
        if kwargs:
            self._props.update(kwargs)
        super().__init__(self._props)
        self.TAG = "User Model"

    @property
    def uid(self):
        return self._props.get("uid")

    @property
    def username(self):
        return self._props.get("uname")

    @property
    def fullname(self):
        return self._props.get("fullname")

    @property
    def email(self):
        return self._props.get("email")

    @property
    def password(self):
        return self._props.get("password")

    @property
    def is_admin(self):
        return self._props.get("admin")

    @property
    def is_page(self):
        return self._props.get("account_type", "") == "p"

    @property
    def joined(self):
        return self._props.get("joined")

    @property
    def bio(self):
        return self._props.get("bio")

    @property
    def gender(self):
        return self._props.get("gender")

    @property
    def profile_pic(self):
        return self._props.get("profile_pic")

    @property
    def county(self):
        return self._props.get("county")

    @property
    def sub_county(self):
        return self._props.get("constituency")


class PostInfo(BaseModel):
    def __init__(self, *args, **kwargs):
        # force dictionary
        if args:
            self._props = args[0] if isinstance(args[0], dict) else {}
        if kwargs:
            self._props.update(kwargs)
        super().__init__(self._props)
        self.TAG = "PostInfo Model"

    @property
    def status(self):
        return self._props.get("status")


class Post(BaseModel):
    def __init__(self, *args, **kwargs):
        # force dictionary
        if args:
            self._props = args[0] if isinstance(args[0], dict) else {}
        if kwargs:
            self._props.update(kwargs)
        super().__init__(self._props)
        self.TAG = "Post Model"

        self._related_info = None
        self._user = None

    @property
    def post_id(self):
        return self._props.get("p_id")

    @property
    def user_id(self):
        return self._props.get("uid")

    @property
    def views(self):
        return self._props.get("views")

    @property
    def user(self) -> User:
        return self._user

    @user.setter
    def user(self, user: User) -> None:
        self._user = user

    @property
    def posted_on(self):
        return self._props.get("p_date")

    @property
    def related_info(self) -> list[PostInfo]:
        return self._related_info

    @related_info.setter
    def related_info(self, info: list[PostInfo]) -> None:
        self._related_info = info


class Comment(BaseModel):
    def __init__(self, *args, **kwargs):
        # force dictionary
        if args:
            self._props = args[0] if isinstance(args[0], dict) else {}
        if kwargs:
            self._props.update(kwargs)
        super().__init__(self._props)
        self.TAG = "Comment Model"
        self._user = None

    @property
    def id(self):
        return self._props.get("c_id")

    @property
    def status(self):
        return self._props.get("status")

    @property
    def target(self):
        return self._props.get("target")

    @property
    def date(self):
        return self._props.get("date")

    @property
    def uid(self):
        return self._props.get("uid")

    @property
    def user(self) -> User:
        return self._user

    @user.setter
    def user(self, user: User):
        self._user = user


class NoteType(Enum):
    FOLLOW = "follow"
    LIKE = "like"
    UNDEFINED = ""

    @staticmethod
    def instance(note_ype: str | None):
        if note_ype == NoteType.FOLLOW.value:
            return NoteType.FOLLOW
        if note_ype == NoteType.LIKE.value:
            return NoteType.LIKE
        return NoteType.UNDEFINED


class Note(BaseModel):
    """
    Notification model
    """

    def __init__(self, *args, **kwargs):
        # force dictionary
        if args:
            self._props = args[0] if isinstance(args[0], dict) else {}
        if kwargs:
            self._props.update(kwargs)
        super().__init__(self._props)
        self.TAG = "Note Model"
        self._from: User | None = None
        self._to: User | None = None

    @property
    def id(self):
        return self._props.get("note_id")

    @property
    def note_from(self) -> str | User:
        return self._from or self._props.get("note_from")

    @note_from.setter
    def note_from(self, user: User):
        self._from = user

    @property
    def note_to(self):
        return self._to or self._props.get("note_to")

    @note_to.setter
    def note_to(self, user: User):
        self._to = user

    @property
    def target(self):
        return self._props.get("target")

    @property
    def date(self):
        return self._props.get("note_time")

    @property
    def note_type(self) -> NoteType:
        return NoteType.instance(self._props.get("note_type"))

    @property
    def note_status(self):
        return self._props.get("note_status")
