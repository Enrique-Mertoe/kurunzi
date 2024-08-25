from flask import request


def method(name: str):
    return request.method == name.upper()


def req_data(name=None):
    form = request.form
    return form.get(name) if name else form
