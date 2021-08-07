# This Python file uses the following encoding: utf-8
import os
from pathlib import Path
import sys

from PySide2.QtCore import QUrl
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    app.setOrganizationName("Marcel Blanck")
    app.setOrganizationDomain("marcel-blanck.de")

    engine = QQmlApplicationEngine()
    engine.load(os.fspath(Path(__file__).resolve().parent / "../qml/main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())