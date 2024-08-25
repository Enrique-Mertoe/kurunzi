import html
import typing as t

dt = t.Optional[dict]


class JsonObject:
    def __init__(self, data: dt):
        self.__dict__ = data
        self._d = data

    def __getitem__(self, item):
        return self._d.get(item)


def sanitize_input(data):
    return html.escape(data)
