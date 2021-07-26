import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import "../data"

Flickable
{
    anchors.fill: parent
    ColumnLayout {
        width: parent.width
        Row {
            width: parent.width
            height: soundSwitch.height
            Label {
                id: soundLabel
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 15
                text: qsTr("Sound")
            }
            Switch {
                id: soundSwitch
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                checked: settings.soundOn
                onCheckedChanged: {
                    settings.soundOn = checked;
                }
            }
        }

        Row {
            width: parent.width
            height: breathsPerMinuteSlider.height
            Label {
                id: breathsPerMinuteLabel
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 15
                text: qsTr("Breaths per minute")
            }
            Slider {
                id: breathsPerMinuteSlider
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.left: breathsPerMinuteLabel.right
                from: 0
                to: 40
                onValueChanged: settings.breathsPerMinute = value
                Component.onCompleted: {
                    value = settings.breathsPerMinute
                }
            }
        }

    }
}
