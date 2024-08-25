import re
from typing import Any


class Modifier:
    MODE_GET = 0
    MODE_SET = 1
    MODE_DELETE = 2
    MODE_UPDATE = 3

    ORDER_ASC = 0
    ORDER_DESC = 1
    ORDER_RAND = 2

    SELECT_ALL = 0

    def __init__(self, mode):
        self._mode = mode
        self._data: dict | None = None
        self._alternatives = None
        self._order: tuple | None = None
        self._limits = None
        self._exclude = None
        self._sel = None
        self._vals = []

    def selection(self, *, selection_type: int = SELECT_ALL, selection_keys: list | None = None):
        self._sel = (selection_type, selection_keys)
        return self

    def data(self, **kwargs):
        self._data = kwargs
        return self

    def alternatives(self, **kwargs):
        self._alternatives = kwargs
        return self

    def order(self, order_type: int, key: str | None = None):
        self._order = (order_type, key)
        return self

    def limits(self, *args):
        self._limits = args
        return self

    def exclude(self, **data):
        self._exclude = data
        return self

    def _sync_mode(self):
        if type(self._mode) is not int or self._mode > 3:
            raise Exception("Incorrect mode. Mode should be one of Modifier.MODE_GET,Modifier.MODE_SET,"
                            "Modifier.MODE_DELETE,Modifier.MODE_UPDATE")
        return {
            0: "SELECT",
            1: "INSERT",
            2: "DELETE",
            3: "UPDATE",
        }.get(self._mode)

    def _sync_selection(self):
        if not self._sel:
            return "*" if self._mode == self.MODE_GET else ""
        s_type, s_keys = self._sel
        if s_keys:
            return ",".join(s_keys) if s_keys else ""
        if s_type == self.SELECT_ALL:
            return "*"
        else:
            raise Exception(f"Invalid selection type -> {s_type}")

    @property
    def _condition(self) -> bool:
        return (self._data or self._alternatives or self._exclude) is not None

    def _sync_data(self):
        if not self._data:
            return ""
        data = ""
        for key, val in self._data.items():
            data += f"{key}=%s AND "
            self._vals.append(val)
        data = data.rstrip(" AND ")
        return data

    def _sync_alternatives(self):
        if not self._alternatives:
            return ""
        data = "OR " if self._data else ""
        for key, val in self._alternatives.items():
            data += f"{key}=%s OR "
            self._vals.append(val)
        data = data.rstrip(" OR ")
        return data

    def _sync_exclude(self):
        if not self._exclude:
            return ""
        data = "AND " if self._data or self._alternatives else ""
        for key, val in self._exclude.items():
            data += f"{key}<>%s AND"
            self._vals.append(val)
        data = data.rstrip(" AND ")
        return data

    def _sync_limits(self):
        if not self._limits:
            return ""
        limit = "LIMIT "
        if len(self._limits) > 1:
            a, b = self._limits
            if not (a and b):
                return ""

            limit += f"%s,%s"
            self._vals.extend([a, b])
        else:
            if not self._limits[0]:
                return ""
            limit += f"%s"
            self._vals.append(self._limits[0])
        return limit

    def _sync_order(self):
        if not self._order:
            return ""
        order = "ORDER BY "
        o_type, key = self._order
        if o_type == self.ORDER_RAND:
            order += "RAND()"
        elif o_type in [self.ORDER_DESC, self.ORDER_ASC]:
            if not key:
                raise Exception("Order Type (ORDER_DESC,ORDER_ASC) requires a key value.")
            d = ["ASC", "DESC"]
            order += f"{self._order[1]} {d[self._order[0]]}"
        else:
            raise Exception(f"Invalid Order {self._order[0]}")
        return order

    def _mode_sel(self, target):
        sql = self._sync_mode()
        sql += f" {self._sync_selection()} FROM {target}"
        if self._condition:
            data = self._sync_data()
            sql += f" WHERE {data} {self._sync_alternatives()} {self._sync_exclude()}"
        sql += f" {self._sync_order()}"
        sql += f" {self._sync_limits()}"
        sql = re.sub("\s+", " ", sql)
        # print(sql)
        return sql

    def _mode_update(self, target):
        sql = self._sync_mode()
        sql += f" {target} SET "
        if self._condition:
            data = self._sync_data()
            sql += f" WHERE {data} {self._sync_alternatives()} {self._sync_exclude()}"
        sql += f" {self._sync_order()}"
        sql += f" {self._sync_limits()}"
        sql = re.sub("\s+", " ", sql)
        # print(sql)
        return sql

    def serialize(self, target) -> tuple[str | None, list[Any]]:
        if self._mode == self.MODE_GET:
            return self._mode_sel(target), self._vals
        if self._mode == self.MODE_UPDATE:
            return self._mode_update(target), self._vals

        return "sql", self._vals
