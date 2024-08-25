from root.templates import Template


class ComponentBuilder:
    def __init__(self):
        self._features = None

    @staticmethod
    def get_instance(templates: dict):
        return ComponentBuilder()._with(templates)

    def _with(self, t):
        self.temp = t
        return self

    def add_feature(self, **features):
        if not self._features:
            # force dictionary
            self._features = {}
        for key, value in features.items():
            if isinstance(value, Template):
                value.render_mode = Template.RENDER_CONTENT_ONLY
                value = value.render()
            self._features[key] = value

    def serialize(self):
        return self._features
