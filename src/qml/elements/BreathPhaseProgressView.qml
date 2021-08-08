import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

Rectangle {
    id: root

    property var settings

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

   PathView {
       anchors.fill: parent
       model: settings.phasesModel
       delegate: phaseCard
       pathItemCount: 3
       cacheItemCount: 3
       interactive: true
       path: Path {
           startX: width / 2
           startY: 0
           PathLine {
               x: width / 2
               y: 200}
       }
   }
}
