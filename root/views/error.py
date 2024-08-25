from flask import Blueprint, request, jsonify

error = Blueprint("error", __name__)


# @error.app_errorhandler(404)
# def _404():
#     if request.accept_mimetypes.accept_json and \
#             not request.accept_mimetypes.accept_html:
#         response = jsonify({'error': 'not found'})
#         response.status_code = 404
#         return response
#     return "890"


@error.route("/page_not_found")
def error_404():
    return "90"
