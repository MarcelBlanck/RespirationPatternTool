import QtQuick 2.12
import QtQml 2.12
import QtGraphicalEffects 1.5
import QtQuick.Controls 2.12
import QtMultimedia 5.12

import "../elements"

Item {
    id: root

    property var settings

    function stop() {
        breathingSimulation.softStop();
    }

    BreathingSimulation {
        id: breathingSimulation
    }

    BreathSonification {
        automaticSonificationActive: breathingSimulation.animationRunning && settings.soundOn
        breathInFactor: breathingSimulation.breathInFactor
        breathCyclePosition: breathingSimulation.breathCyclePosition
    }

    Item {
        id: breathVolumeVisualizationArea

        anchors.left: parent.left
        anchors.right: breathPhaseProgressView.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        BreathVolumeVisualization {
            id: breathVolumeVisualization

            height: Math.min(parent.width-40, parent.height - 40)
            width: height
            anchors.centerIn: parent
            breathTaken: breathingSimulation.breathTaken

            BreathTextVisualization {
                id: breathTextVisualization

                anchors.centerIn: parent
                automaticVisualizationActive: breathingSimulation.animationRunning
                breathInFactor: breathingSimulation.breathInFactor
                breathCyclePosition: breathingSimulation.breathCyclePosition
            }

            BreathProgressCircle {
                anchors.fill: parent
                breathInFactor: breathingSimulation.breathInFactor
                breathCyclePosition: breathingSimulation.breathCyclePosition
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (breathingSimulation.animationRunning) {
                        breathingSimulation.softStop();
                    } else {
                        breathingSimulation.start();
                    }
                }
            }
        }
    }

    BreathPhaseProgressView {
        id: breathPhaseProgressView

        width: 200
        height: 150
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 20
        settings: root.settings
    }

    state: width >= height ? "" : "phaseProgressBelow"

    states: [
        State {
            name: "phaseProgressBelow"
            AnchorChanges {
                target: breathPhaseProgressView
                anchors.right: undefined
                anchors.verticalCenter: undefined
                anchors.bottom: root.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }
            AnchorChanges {
                target: breathVolumeVisualizationArea
                anchors.left: root.left
                anchors.right: root.right
                anchors.top: parent.top
                anchors.bottom: breathPhaseProgressView.top
            }
        }
    ]
}
