import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    property alias text: switchLabel.text
    property alias checked: switchControl.checked

    height: switchControl.height

    Label {
        id: switchLabel
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: switchControl.left
        anchors.leftMargin: 15
    }

    Switch {
        id: switchControl
        anchors.right: parent.right
    }
}
