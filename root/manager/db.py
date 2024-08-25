__version__ = "1.0.0"

import pymysql
from pymysql.cursors import DictCursor

from settings import DATABASE_CONFIG
from .db_manager import Modifier


class PDOCarrier:
    def __init__(self, **items):
        self._items = items

    def __getitem__(self, item):
        return self._items.get(item)

    @property
    def is_empty(self):
        return len(self._items) == 0

    @property
    def get(self):
        return self._items.items()


class PDO:
    ORDER_RANDOM = 1
    ORDER_ASC = 2
    ORDER_DESC = 4

    @staticmethod
    def get_instance(ref):
        return _Reference(ref)

    @staticmethod
    def carrier(**items):
        return PDOCarrier(**items)

    @staticmethod
    def modifier(**kwargs):
        return


class DataBaseException(Exception):
    """"""


class FetchType:
    def __init__(self, data):
        self._data = data

    @property
    def single(self) -> dict | None:
        return self._data[0] if self._data else None

    @property
    def all(self) -> list:
        return self._data


class _Reference:
    _CONDITION_AND = 0
    _CONDITION_OR = 1

    def __init__(self, ref: str):
        self.ref = ref
        host = DATABASE_CONFIG.get("host")
        passw = DATABASE_CONFIG.get("password")
        dbname = DATABASE_CONFIG.get("db_name")
        user = DATABASE_CONFIG.get("user")
        try:
            self._conn = pymysql.connect(host=host, password=passw, database=dbname, user=user)
        except:
            self._conn = None

    @classmethod
    def _gen_cols(cls, **values) -> tuple:
        cols = " ("
        vals = []
        val_ref = " VALUES ("
        for key, value in values.items():
            cols += f" `{key}`,"
            vals.append(value)
            val_ref += "%s,"
        cols = cols.rstrip(",")
        cols += ")"
        val_ref = val_ref.rstrip(",")
        val_ref += ")"
        cols += val_ref
        return cols, vals

    @classmethod
    def _conditions(cls, _type: int = _CONDITION_AND, **cond):
        if not len(cond):
            return "", []
        where = ""
        if _type == cls._CONDITION_OR:
            where += " OR "
        op = "AND" if _type == cls._CONDITION_AND else "OR"
        where_vals = []
        for key, value in cond.items():
            where += f"{key} = %s {op} "
            where_vals.append(value)
        where = where.rstrip(f" {op} ")
        return where, where_vals

    def _exec_and_commit(self, sql, *data) -> bool | None:
        if not self._conn:
            return
        self._conn.ping()
        with self._conn as con:
            cs = con.cursor()
            try:
                cs.execute(sql, data)
                con.commit()
                return True
            except Exception as e:
                print(f"\033[91m{e}\033[0m")
                return False

    def push(self, *, data: dict):
        cols, vals = self._gen_cols(**data)
        sql = f"INSERT INTO " + self.ref + cols
        return self._exec_and_commit(sql, *vals)

    def from_modifier(self, modifier: Modifier):
        sql, vals = modifier.serialize(self.ref)
        self._conn.ping()
        with self._conn.cursor(DictCursor) as cs:
            cs.execute(sql, [*vals])
            return FetchType(cs.fetchall())

    def get(self, data: dict | None = None, **alternatives) -> FetchType | None:
        """
        :param data:
        :param alternatives:
            :key selector: str | tuple
            :key limit:int | tuple
        :return:
        """

        # force dictionary
        if not data:
            data = {}
        selector = self._selector(alternatives.get("selector"))
        alternatives.pop("selector", None)

        limit = self._prep_limits(alternatives.get("limit"))
        alternatives.pop("limit", None)

        order = self._prep_order(alternatives.get("order"))
        alternatives.pop("order", None)

        exclude = self._prep_exclude(alternatives.get("exclude"))
        alternatives.pop("exclude", None)

        where, vals = self._conditions(**data)
        alter, vals1 = self._conditions(_type=self._CONDITION_OR, **alternatives)

        vals.extend(vals1)
        sql = f"SELECT {selector} FROM " + self.ref
        if where:
            sql += " WHERE " + where + alter
        if exclude:
            if where:
                sql += f" AND {exclude[0]}"
            else:
                sql += f" WHERE {exclude[0]}"

            vals.extend(exclude[1])

        if order:
            sql += order
        if limit:
            sql += limit

        if not self._conn:
            return FetchType({})

        self._conn.ping()
        with self._conn.cursor(DictCursor) as cs:
            cs.execute(sql, vals) if vals else cs.execute(sql)
            return FetchType(cs.fetchall())

    @staticmethod
    def _selector(selector) -> str:
        if not selector:
            return "*"
        if type(selector) is str:
            selector = [selector]
        if len(selector):
            selector = ",".join(selector)
        else:
            selector = "*"
        return selector

    @classmethod
    def _prep_order(cls, order):
        if order == PDO.ORDER_RANDOM:
            return " ORDER BY RAND() "
        if order == PDO.ORDER_ASC:
            return "ORDER BY "
        return ""

    @classmethod
    def _prep_exclude(cls, items) -> tuple | None:
        if not isinstance(items, PDOCarrier):
            return
        res = ""
        vals = []
        for key, val in items.get:
            res += f"{key} <> %s AND "
            vals.append(val)
        res = res.rstrip("AND ")
        return res, vals

    @staticmethod
    def _prep_limits(limit) -> str | None:
        t = type(limit)
        lim = " LIMIT "
        if t is int:
            return lim + str(limit)
        if limit and len(limit) and t is not str:
            return lim + f"{limit[0]},{limit[1]}"

    def delete(self, **options):
        sql = f"DELETE FROM " + self.ref + " WHERE "
        vals = []
        for key, value in options.items():
            sql += f"{key} = %s AND "
            vals.append(value)
        sql = sql.rstrip(" AND ")
        return self._exec_and_commit(sql, *vals)

    def update(self, key, key_value, **data):
        sql = f"UPDATE {self.ref} SET "
        vals = []
        for k, v in data.items():
            sql += f"{k} = %s , "
            vals.append(v)
        sql = sql.rstrip(" , ")
        sql += f" WHERE {key} = %s "
        vals.append(key_value)
        return self._exec_and_commit(sql, *vals)

    def test(self, sql):
        self._conn.ping()
        with self._conn.cursor() as cs:
            cs.execute(sql)
            return FetchType(cs.fetchall())
