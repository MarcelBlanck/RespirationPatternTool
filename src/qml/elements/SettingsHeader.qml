import QtQuick 2.12
import QtQuick.Controls 2.12

Column {
    id: root


    property var settings

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

    Label {
        text: qsTr("Settings")
    }

    LabeledSwitch {
        width: parent.width
        text: qsTr("Sound")
        checked: settings.soundOn
        onCheckedChanged: {
            settings.soundOn = checked;
        }
    }

    LabeledSwitch {
        width: parent.width
        text: qsTr("Loop forever")
        checked: settings.loopForever
        onCheckedChanged: {
            settings.loopForever = checked;
        }
    }

    SettingsStorageControl {
        width: parent.width
        settings: root.settings
    }
}
