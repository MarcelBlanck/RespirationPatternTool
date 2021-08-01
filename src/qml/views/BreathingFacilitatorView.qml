import QtQuick 2.12
import QtQml 2.12
import QtGraphicalEffects 1.5
import QtQuick.Controls 2.12
import QtMultimedia 5.12

import "../elements"

Item {
    id: root

    property var settings

    BreathingSimulation {
        id: breathingSimulation
    }

    BreathSonification {
        automaticSonificationActive: breathingSimulation.animationRunning && settings.soundOn
        breathInFactor: breathingSimulation.breathInFactor
        breathCyclePosition: breathingSimulation.breathCyclePosition
    }

    BreathVolumeVisualization {
        id: breathVolumeVisualization
        width: Math.min(parent.width, parent.height) - 10
        height: width
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
