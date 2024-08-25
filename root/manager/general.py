import time
from enum import Enum
import typing as t
from . import UserManager as uM
from ..models import Note, User, NoteType
from .db import PDO
from .fn import gen_key
from ..core.const import T_NOTES, T_FOLLOW, T_USERS, NOTE_FOLLOW
from root.templates import Template


class FollowManager:
    def __init__(self):
        ...

    @classmethod
    def follow_suggest(cls, uid) -> list[User]:
        ex = PDO.carrier(uid=uid)
        return [User(user) for user in
                PDO.get_instance(T_USERS)
                .get(limit=3,
                     order=PDO.ORDER_RANDOM,
                     exclude=ex).all]

    @classmethod
    def follow(cls, me, user) -> tuple:
        f = PDO.get_instance(T_FOLLOW).push(data={
            "uid": me,
            "follows": user,
            "date": time.time()
        })
        if f:
            NoteManager.create(note_type=NoteType.FOLLOW,
                               note_to=user, note_from=me, target=user)
        return True if f else False, 1

    @classmethod
    def unfollow(cls, me, user) -> tuple:
        f = PDO.get_instance(T_FOLLOW).delete(uid=me, follows=user)
        if f:
            NoteManager.remove(note_type=NoteType.FOLLOW,
                               note_to=user, note_from=me, target=user)

        return True if f else False, -1

    @classmethod
    def is_following(cls, me, user):
        return len(PDO.get_instance(T_FOLLOW).get({"uid": me, "follows": user}).all)

    @classmethod
    def followers(cls, uid):
        return PDO.get_instance(T_FOLLOW).get({"follows": uid}).all

    @classmethod
    def following(cls, uid):
        return PDO.get_instance(T_FOLLOW).get({"uid": uid}).all


class NoteManager:
    t = t.Optional[str]

    @classmethod
    def create(cls,
               *,
               note_type: NoteType,
               target: t = None,
               note_from: t,
               note_to: t) -> bool:
        d = cls._get_data(note_type=note_type.value,
                          note_from=note_from,
                          note_to=note_to,
                          target=target)
        return PDO.get_instance(T_NOTES).push(data=d)

    @classmethod
    def remove(cls, *,
               target: t = None,
               note_from: t,
               note_to: t,
               note_type: NoteType
               ):
        return PDO.get_instance(T_NOTES).delete(target=target,
                                                note_from=note_from,
                                                note_to=note_to,
                                                note_type=note_type.value)

    @classmethod
    def remove_by_key(cls, **keys):
        return PDO.get_instance(T_NOTES).delete(**keys)

    @classmethod
    def get_for(cls, user_id):
        return PDO.get_instance(T_NOTES).get({"note_to": user_id}).all

    @classmethod
    def get_notifications(cls) -> list:
        temp = Template(category="notifications", name="item", render_type=Template.RENDER_CONTENT_ONLY)
        return [temp.add_data(note=cls.prep_note(note)).render()
                for note in cls.get_for(uM.selected_account())
                ]

    @classmethod
    def prep_note(cls, item) -> Note:
        n = Note(item)
        n.note_to = uM.get_user_by_id(n.note_to)
        n.note_from = uM.get_user_by_id(n.note_from)
        n["text"] = cls.compose_text(n)
        return n

    @staticmethod
    def compose_text(note: Note) -> dict:
        txt = ""
        link = ""
        if note.note_type == NoteType.FOLLOW:
            txt = NOTE_FOLLOW
            link = note.note_from.username

        return {
            "header": note.note_from.fullname,
            "content": txt,
            "link": link
        }

    @staticmethod
    def _get_data(**kwargs) -> dict:
        d = {
            "note_id": gen_key(),
            "note_time": time.time()
        }
        d.update(kwargs)
        return d
