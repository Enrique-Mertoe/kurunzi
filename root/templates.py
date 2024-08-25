from .ui import BaseTemplate
from .manager.user import UserManager as uM


class Template(BaseTemplate):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.add_tag(current_user=uM.current_user())
