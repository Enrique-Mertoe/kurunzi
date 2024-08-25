import time

from .fn import gen_key
from .db import PDO
from .util import sanitize_input
from ..core.const import T_POSTS, T_POSTS_INFO, T_LIKES, T_COMMENTS
from .user import UserManager as uM
from .file_manager import File
from ..models import Post, PostInfo, Comment
from ..templates import Template
from .db_manager import Modifier


class FeedManager:
    REACTION_LIKE = "rpl"

    def __init__(self):
        ...

    @classmethod
    def create_feed(cls, post_data, files: list[File]) -> tuple:
        key = gen_key()
        instance = PDO.get_instance(T_POSTS)
        u = uM.current_user()

        data = cls._data_main(post_data, p_id=key, uid=u.uid)
        if instance.push(data=data):
            er = 0
            pd = post_data
            for file in files:
                instance = PDO.get_instance(T_POSTS_INFO)
                data = cls._data_info(pd, p_id=key,
                                      filename=file.filename,
                                      filetype=file.meme_type,
                                      file_size=file.ratio)
                pd = {}
                if instance.push(data=data):
                    if not file.upload("feeds"):
                        er += 1
                else:
                    er += 1

            if er == 0:
                return True, key
            instance.delete(p_id=key)

        return False, "something went wrong."

    @staticmethod
    def _data_main(data, **kwargs) -> dict:
        d = {
            "p_date": time.time(),
            "p_type": "normal",
            "commenting": data.get("commenting", 0),
            "sharing": data.get("sharing", 0),
            "on_camera": data.get("on-camera", 0),
        }
        d.update(kwargs)
        return d

    @staticmethod
    def _data_info(data, **kwargs) -> dict:
        d = {
            "status": sanitize_input(data.get("status", "")),
            "category": data.get("category", ""),
            "location": data.get("location", ""),

        }
        d.update(kwargs)
        return d

    @classmethod
    def get_post_by_id(cls, post_id) -> Post:
        p = cls.f_post(Post(PDO.get_instance(T_POSTS).get({"p_id": post_id}).single))
        return p

    @classmethod
    def f_post(cls, p: Post) -> Post:
        p.user = uM.get_user_by_id(p.user_id)
        p.related_info = cls.get_post_info(p.post_id)
        return p

    @classmethod
    def get_post_info(cls, post_id) -> list[PostInfo]:
        return [PostInfo(info) for info in PDO.get_instance(T_POSTS_INFO).get({"p_id": post_id}).all]

    @classmethod
    def studio_recently_posted(cls, key) -> Template:
        p = cls.get_post_by_id(key)
        return cls._prepare_post(p)

    @classmethod
    def _prepare_post(cls, post: Post) -> Template:
        like = {
            "liked": LikeManager.is_liked(uM.selected_account(), post.post_id),
            "likes": LikeManager.get_likes(post.post_id)
        }
        temp = Template(category="xhr/post", name="item", render_type=Template.RENDER_CONTENT_ONLY)
        temp.add_data(post=post, like=like)
        return temp

    @classmethod
    def get_posts(cls, start: int = 0, end: int = 2) -> list:
        r = []
        for p in PDO.get_instance(T_POSTS).get(limit=(start, 100)).all:
            p = cls.f_post(Post(p))
            temp = cls._prepare_post(p)
            r.append(temp.render())
        return r

    @classmethod
    def handle_likes(cls, post_id) -> tuple:
        uid = uM.selected_account()
        liked = LikeManager.is_liked(uid, post_id)
        if liked:
            return LikeManager.unlike(uid, post_id)
        else:
            return LikeManager.add_like(uid, post_id)

    @classmethod
    def get_comments(cls, target, limit=2, **options) -> list[Comment]:
        cs = []
        modifier = (Modifier(Modifier.MODE_GET).data(target=target)
                    .limits(limit).order(Modifier.ORDER_ASC, "date"))
        for cmt in PDO.get_instance(T_COMMENTS).from_modifier(modifier).all:
            c = Comment(cmt)
            c.user = uM.get_user_by_id(c.uid)
            cs.append(c)
        return cs

    @classmethod
    def add_comment(cls, *, target, status):
        return PDO.get_instance(T_COMMENTS).push(data={
            "target": target,
            "status": status,
            "uid": uM.selected_account(),
            "c_id": gen_key(),
            "date": time.time()
        })


class LikeManager:
    def __init__(self):
        ...

    @classmethod
    def is_liked(cls, uid, target):
        return PDO.get_instance(T_LIKES).get({"uid": uid, "target": target}, selector="id").all

    @classmethod
    def unlike(cls, user, target) -> tuple:
        res = PDO.get_instance(T_LIKES).delete(uid=user, target=target)
        return True if res else False, None

    @classmethod
    def add_like(cls, uid, target) -> tuple:
        lk = PDO.get_instance(T_LIKES).push(data={
            "l_date": time.time(),
            "uid": uid,
            "target": target
        })
        return True if lk else False, None

    @classmethod
    def get_likes(cls, target, **options):
        d = {"target": target}
        d.update(options)
        res = PDO.get_instance(T_LIKES).get(d)
        return res.all
