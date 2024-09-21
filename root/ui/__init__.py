from flask import render_template, jsonify
import typing as t
from settings import APP_CONFIG

Temp = t.Optional[str]


class _BProp:
    def __init__(self, d: t.Optional[dict]):
        self._d = d

    def __getitem__(self, item):
        return self._d.get(item)

    def __setitem__(self, key, value):
        self._d[key] = value


class BaseTemplate:
    """This class carries the configuration of a given view and how the view renders a given template."""

    RENDER_DEFAULT = 1
    """This render type returns a view wrapped in a container view."""

    RENDER_CONTENT_ONLY = 2
    """The view is rendered as it is without parent container."""
    RENDER_MODULE = 3

    TITLE_DEFAULT = APP_CONFIG["config"]["title"]

    ROOT = "container"
    MAIN = "content"

    def __init__(self, *, name: str = MAIN,
                 category: str | None = None,
                 render_type: int = RENDER_DEFAULT, **options):
        self._name: str = name
        self._category: str | None = category
        self._render_type: int = render_type
        self._options = options
        self._t_api: dict = APP_CONFIG
        self._temp: Temp = None
        self._layout: Temp = None
        self._page_config: dict = {}
        self._page_data = {}
        self._tags = {}
        self._props = {}
        self._init_config()
        pass

    def _init_config(self):
        ...

    @property
    def _is_admin(self):
        return self._options.get("admin")

    @property
    def render_mode(self):
        return self._render_type

    @render_mode.setter
    def render_mode(self, r_type: int):
        self._render_type = r_type

    @property
    def name(self) -> str:
        return self._name

    @name.setter
    def name(self, name: str) -> None:
        self._name = name

    @property
    def category(self):
        return self._category

    @category.setter
    def category(self, category):
        self._category = category

    @property
    def properties(self):
        return self._props

    @properties.setter
    def properties(self, props: dict, **kwargs):
        props.update(kwargs)
        self._props = props

    def add_tag(self, **tags):
        self._tags.update(tags)

    def page_config(self, *, title, url=None, name=None):
        self._page_config = {
            "title": title,
            "url": APP_CONFIG["config"]["site_url"] + (url or ""),
            "name": name
        }
        return self

    def add_data(self, **data):
        self._page_data.update(data)
        return self

    def __get_layout(self):
        if self._category:
            return self._category + "/" + self._name + ".html"
        return self._name + ".html"

    def _check_to_render(self):
        self._page_config["property"] = _BProp(self.properties)
        self._t_api["page"] = self._page_config

    def render(self):
        """Renders the template to the browser."""
        self._check_to_render()
        self._layout = self.__get_layout()
        layout: Temp = None
        if self._is_admin:
            self.ROOT = "admin/" + self.ROOT
            self._layout = "admin/" + self._layout
        if self._render_type == self.RENDER_DEFAULT:
            layout = render_template(self.ROOT + ".html", app=self._t_api, view=self._layout, data=self._page_data,
                                     **self._tags)
        elif self._render_type == self.RENDER_CONTENT_ONLY:
            layout = render_template(self._layout, app=self._t_api, data=self._page_data, **self._tags)
        return layout

    def ui_data(self, xhr, **options):
        self._render_type = self.RENDER_CONTENT_ONLY
        conf = self._page_config
        # print("self._page_data")
        data = {
            "title": conf["title"],
            "content": self.render(),
            "url": conf["url"]
        }
        options.update(fl_sg=True)
        return xhr.page(data, **options)
