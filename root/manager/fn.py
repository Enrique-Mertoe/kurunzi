from random import uniform
import json
import bcrypt
import time
import math
from settings import BASE_PATH


class PasswordManager:
    @classmethod
    def hash(cls, password: str) -> str:
        salt = bcrypt.gensalt()
        return bytes(bcrypt.hashpw(password.encode("utf-8"), salt)).decode("utf-8")

    @classmethod
    def verify(cls, hashed: str, password: str) -> bool:
        return bcrypt.checkpw(password.encode("utf-8"), hashed.encode("utf-8"))


def gen_key():
    push_chars = '-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz'
    now = int(time.time() * 1000)
    last_push_time = 0
    last_rand_chars = []
    duplicate_time = now == last_push_time
    time_stamp_chars = [0] * 8
    for i in reversed(range(0, 8)):
        time_stamp_chars[i] = push_chars[now % 64]
        now = int(math.floor(now / 64))
    new_id = "".join(time_stamp_chars)
    if not duplicate_time:
        for i in range(0, 12):
            last_rand_chars.append(int(math.floor(uniform(0, 1) * 64)))
    else:
        for i in range(0, 11):
            if last_rand_chars[i] == 63:
                last_rand_chars[i] = 0
            last_rand_chars[i] += 1
    for i in range(0, 12):
        new_id += push_chars[last_rand_chars[i]]
    return new_id


class Serializer:
    def __init__(self):
        self.level = 0

    def _dic_s(self, data: dict):
        d = "{\n"
        for k, v in data.items():
            d += f"{self._intent}\"{k}\": " + self._tcheck(v) + ",\n"
        d = d.rstrip(",\n")
        d += "\n" + "\t" * (self.level - 1) + "}"
        return d

    def _ls_s(self, data: list | set | tuple):
        s = "["
        for item in data:
            s += self._tcheck(item) + ","
        s = s.rstrip(",")
        s += "]"
        return s

    @property
    def _intent(self):
        return "\t" * self.level

    def _tcheck(self, v):
        self.level += 1
        val = self._primitiv(v)
        if type(v) is dict:
            val = self._dic_s(v)
        if type(v) in [set, tuple, list]:
            val = self._ls_s(v)
        self.level -= 1

        return val

    @classmethod
    def _primitiv(cls, v):
        if type(v) is str:
            v = f"\"{v}\""
        if type(v) is bool:
            v = v.__str__().lower()
        return f"{v}"

    @classmethod
    def serialise(cls, data):
        return Serializer()._tcheck(data)


def load_ke_json():
    ke_json = BASE_PATH.joinpath("resources", "ke.json")
    res = []
    if ke_json.exists():
        with ke_json.open("r") as file:
            res = json.loads(file.read())
    return res
