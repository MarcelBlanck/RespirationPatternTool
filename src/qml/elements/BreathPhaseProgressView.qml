import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

Item {
    id: root

    property var settings
    property bool running: false
    property int countDown: 3
    property int phaseIndex: 0

    property int phase: 0

    readonly property real animationDurationMs: 500

    clip: true
    onPhaseChanged: {
        progressCard1.isTop = !progressCard1.isTop;
        progressCard2.isTop = !progressCard2.isTop;
    }

    Timer {
        interval: animationDurationMs * 2
        repeat: true
        running: true
        onTriggered: {
            root.phase++;
        }
    }

    BreathProgressCard {
        id: progressCard1
        isTop: true
    }

    BreathProgressCard {
        id: progressCard2
        isTop: false
        color: "green"
    }

    Component {
        id: phaseCard
        Pane {
            Material.elevation: 4
            width: root.width

            Column {
                id: phaseData
                width: parent.width
                height: 200
                Label {
                    text: rpm + " " + qsTr("rpm")
                }
                Label {
                    text: times + " " + qsTr("times")
                }
                Label {
                    readonly property real durationInTwoDigitS: {
                        return Math.round(times * 60 / rpm * 100) / 100;
                    }
                    text: durationInTwoDigitS + " " + qsTr("s")
                }
                Label {
                    text: breathInQuota + "/" + (100 - breathInQuota) + " " + qsTr("IN/OUT")
                }
            }
        }
    }

    Component {
        id: startCard
        Pane {
            Material.elevation: 4
            width: root.width

            Item {
                id: phaseData
                width: parent.width
                height: 200
                Label {
                    text: rpm + " " + qsTr("rpm")
                }
                Label {
                    text: times + " " + qsTr("times")
                }
                Label {
                    readonly property real durationInTwoDigitS: {
                        return Math.round(times * 60 / rpm * 100) / 100;
                    }
                    text: durationInTwoDigitS + " " + qsTr("s")
                }
                Label {
                    text: breathInQuota + "/" + (100 - breathInQuota) + " " + qsTr("IN/OUT")
                }
            }
        }
    }

//    Component {
//        id: endCard
//    }
}
