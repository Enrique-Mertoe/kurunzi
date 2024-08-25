from root import create_app
from settings import HOST, PORT

create_app().run(port=PORT, debug=True, host=HOST)
