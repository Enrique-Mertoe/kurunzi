from root.manager.general import FollowManager as follow
from root.manager.user import UserManager as uM


class UiUser:
    def __init__(self, uid):
        self.uid = uid

    @property
    def follows(self):
        return follow.is_following(uM.selected_account(), self.uid)

    @property
    def following(self):
        return len(follow.following(self.uid))

    @property
    def followers(self):
        return len(follow.followers(self.uid))
