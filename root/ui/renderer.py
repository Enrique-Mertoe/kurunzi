from root.templates import Template
from flask import request as req
from root.views.view_util import method
from root.manager.xhr import Xhr


class Renderer:
    def __init__(self):
        pass

    @staticmethod
    def from_template(temp: Template, **options):
        if options.get("collapse_endbar") == None:
            options.update({
                "collapse_endbar": True
            })
        return Renderer()._builder(temp, **options)

    @staticmethod
    def config_init(*, sidebar: bool = True, end_bar: bool = True, main: bool = True):
        return [sidebar, main, end_bar]

    @staticmethod
    def flags(**flags):
        return flags

    @property
    def _is_init(self) -> bool:
        return req.form.get("xhr_init") and method("post")

    @property
    def _is_xhr(self) -> bool:
        return req.args.get("xhr") and method("POST")

    def _init_renderer(self):
        self.temp.name = "layout"
        self.temp.render_mode = Template.RENDER_CONTENT_ONLY
        return Xhr.init_doc(self.temp, **self.options)

    def _xhr_renderer(self):
        return self.temp.ui_data(Xhr, **self.options)

    def _builder(self, temp: Template, **kwargs):
        self.temp = temp
        self.options = kwargs
        if self._is_init:
            return self._init_renderer()
        if self._is_xhr:
            return self._xhr_renderer()
        return self.temp.render()
