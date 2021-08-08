import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "./data"
import "./views"

ApplicationWindow {
    id: window

    readonly property string gearIconUnicode: "\u2699"
    readonly property string backIconUnicode: "\u25C0"
    readonly property string infoIconUnicode: "\uD83D\uDEC8"
    readonly property real iconPixelSize: Qt.application.font.pixelSize * 1.6

    width: 800
    height: 600
    minimumWidth: 500
    minimumHeight: 500

    visible: true

    header: ToolBar {
        contentWidth: window.width
        contentHeight: settingsButton.implicitHeight

        RowLayout {
            width: parent.width
            ToolButton {
                id: settingsButton
                text: stackView.depth > 1 ? backIconUnicode : gearIconUnicode
                font.pixelSize: iconPixelSize
                onClicked: {
                    if (stackView.depth > 1) {
                        stackView.pop();
                    } else {
                        drawer.open();
                    }
                }
            }

            Label {
                Layout.fillWidth: true
                verticalAlignment: Label.AlignVCenter
                text: qsTr("Respiration Pattern Tool")
            }

            ToolButton {
                id: infoButton

                text: infoIconUnicode
                font.pixelSize: iconPixelSize
                onClicked: {
                    stackView.push("views/InfoView.qml");
                    drawer.close();
                }
            }
        }
    }

    Settings {
        id: globalSettings
    }

    Drawer {
        id: drawer

        width: scenarioCreationView.width + 2 * scenarioCreationView.anchors.margins
        height: window.height

        onAboutToShow: {
            stackView.currentItem.stop();
        }

        ScenarioCreationView {
            id: scenarioCreationView
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.margins: 10
            settings: globalSettings
        }
    }

    StackView {
        id: stackView

        anchors.fill: parent

        Component.onCompleted: {
            stackView.push(
                Qt.resolvedUrl("views/BreathingFacilitatorView.qml"),
                {
                    settings: globalSettings
                }
            );
        }
    }
}
