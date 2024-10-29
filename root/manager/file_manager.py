import os
from enum import Enum
from io import BytesIO

from PIL import Image
import random
import string
from datetime import datetime
from settings import STATIC_FOLDER
from werkzeug.utils import secure_filename

from .util import JsonObject


class FileItem(JsonObject):
    def __init__(self, file):
        super().__init__(file)

    @property
    def filename(self):
        return self["filename"]

    @property
    def content(self):
        return self["content"]


class FileType(Enum):
    IMAGE = "img"
    VIDEO = "vid"
    DOC = 'file'


class File:
    def __init__(self, file, name_prefix):
        img = FileItem(file)
        self.ext = None
        self.e = None
        self._name = img.filename
        self.content = img.content
        self.extn()
        self._new_name = self._name
        self._f_type = self._type()
        self.process()

        # self.get_ratio()
        if self._is("vid") or self._is("img"):
            prefix = "Img" if self._is("img") else "Vid"
            self._new_name = f"{name_prefix}{prefix}-{self._key()}-{self._stamp()}.{self.ext}"

    @property
    def filename(self):
        return self._new_name

    @property
    def meme_type(self):
        return self._f_type.value

    def extn(self):
        ext = os.path.splitext(self._name)[1][1:]
        self.ext = self.e = ext.lower() if ext else ext

    @property
    def ratio(self):
        ratio = "200/800"
        if self._is("img"):
            image = self.content
            width, height = image.size
            ratio = f"{width}/{height}"
        return ratio

    def upload(self, _dir):
        d = _dir
        # ext = self.ext
        dirs = "ket_docs"

        if self._is("img"):
            dirs = "ket_images"
        if self._is("vid"):
            dirs = "ket_videos"

        directory = STATIC_FOLDER.joinpath("app_files", dirs, _dir, "h")
        os.makedirs(directory, exist_ok=True)
        path = os.path.join(directory, self._new_name)
        try:
            if self._is("img"):
                self.content.save(path)
                self._low_quality(d, os.path.join(directory, self._new_name))
            else:
                with open(path, "wb") as file:
                    file.write(self.content)
            return True
        except Exception:
            raise

    def _is(self, type_):
        refs = {
            "vid": {"r": ["mkv", "mp4"], "a": "vid"},
            "img": {"r": ["jpg", "png", "jpeg", "webp", "svg"], "a": "vid"},
        }
        if type_ in refs:
            return self.ext in refs[type_]["r"]
        return False

    def _low_quality(self, _dir, high_quality_image_path):
        ext = os.path.splitext(self._name)[1][1:]
        videos = ["mkv", "mp4"]
        images = ["jpg", "png", "jpeg", "webp", "svg"]
        dirs = "ket_docs"

        if ext in images:
            dirs = "ket_images"
        if ext in videos:
            dirs = "ket_videos"

        directory = STATIC_FOLDER.joinpath("app_files", dirs, _dir, "l")
        os.makedirs(directory, exist_ok=True)

        target_path = os.path.join(directory, self._new_name)
        high_quality_image = Image.open(high_quality_image_path)
        width, height = high_quality_image.size
        new_width = 40
        new_height = (new_width / width) * height
        low_quality_image = high_quality_image.resize((int(new_width), int(new_height)))
        low_quality_image.save(target_path, quality=50)
        return target_path

    @staticmethod
    def _key():
        return "".join(random.choices(string.ascii_lowercase + string.digits, k=8))

    @staticmethod
    def _stamp():
        return datetime.now().strftime("%Y-%m-%d")

    def _type(self):
        if self._is("img"):
            return FileType.IMAGE
        elif self._is("vid"):
            return FileType.VIDEO
        return FileType.DOC

    def process(self):
        if self._f_type == FileType.IMAGE:
            self.content = self._resize_img(self.content)

    def _resize_img(self, target_path):
        try:
            high_quality_image = Image.open(BytesIO(target_path))
            width, height = high_quality_image.size
            new_width = self._get_new_width(width)
            new_height = (new_width / width) * height
            return high_quality_image.resize((int(new_width), int(new_height)))
        except Exception:
            raise

    @staticmethod
    def _get_new_width(width):
        return 700 if width > 700 else width


class FileManager:
    def __init__(self, files, name_prefix):
        self.__files = files
        self.__ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}
        self.__f1 = []
        self._name_prefix = name_prefix
        pass

    def allowed_file(self, filename):
        return '.' in filename and filename.rsplit('.', 1)[1].lower() in self.__ALLOWED_EXTENSIONS

    def files(self):
        for file in self.__files:
            file_fmt = {
                "filename": secure_filename(file.filename),
                "content": file.read(),
                "ratio": "1 / 2"
            }
            if self.allowed_file(file.filename):
                width, height = self._get_image_size(file)
                aspect_ratio = f"{width} / {height}"
                file_fmt["ratio"] = aspect_ratio

            self.__f1.append(File(file_fmt, self._name_prefix))
        return self.__f1

    @staticmethod
    def _get_image_size(file):
        with Image.open(file) as img:
            return img.size
