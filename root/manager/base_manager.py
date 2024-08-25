from .db import PDO


class BaseManager:
    def __init__(self, target):
        self.__target = target

    @classmethod
    def make_update(cls, target, **options):
        key_content: tuple = options.get("_key_content")
        if not key_content or len(key_content) < 2:
            return
        options.pop("_key_content", None)
        key, value = key_content
        return PDO.get_instance(target).update(key, value, **options)
