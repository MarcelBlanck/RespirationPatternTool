import QtQuick 2.0

Item {
    id: root
    property real breathTaken: 0.0
    readonly property real innerMargin: 30
    readonly property real centerScale: 0.4

    smooth: true
    antialiasing: true

    Item {
        anchors.fill: parent
        anchors.margins: root.innerMargin
        Rectangle {
            color: "#33CCFFFF"
            anchors.fill: parent
            radius: width / 2
            scale: root.centerScale + 0.6 * (root.breathTaken + 0.1)
        }
        Rectangle {
            color: "#6699FFFF"
            anchors.fill: parent
            radius: width / 2
            scale: root.centerScale + 0.45 * (root.breathTaken + 0.1)
        }
        Rectangle {
            color: "#9966FFFF"
            anchors.fill: parent
            radius: width / 2
            scale: root.centerScale + 0.3 * (root.breathTaken + 0.1)
        }
        Rectangle {
            color: "#CC33FFFF"
            anchors.fill: parent
            radius: width / 2
            scale: root.centerScale + 0.15 * (root.breathTaken + 0.1)
        }
        Rectangle {
            color: "#FF00FFFF"
            anchors.fill: parent
            radius: width / 2
            scale: root.centerScale
        }

    }

}
