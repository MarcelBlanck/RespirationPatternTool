import QtQuick 2.12
import QtQuick.Controls 2.5

import "./data"

ApplicationWindow {

    id: window
    width: 800
    height: 600
    minimumHeight: 600
    minimumWidth: 800

    visible: true
    title: qsTr("Stack")

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: qsTr("Respiration Pattern Tool")
            anchors.centerIn: parent
        }
    }

    Settings {
        id: settings
    }

    Drawer {
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Setup")
                width: parent.width
                onClicked: {
                    stackView.push("views/SettingsView.qml")
                    drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: "views/BreathingFacilitatorView.qml"
        anchors.fill: parent
    }
}
