import QtQuick 2.12

Item {
    id: root

    property bool automaticVisualizationActive: false
    property real breathInFactor: 0.5
    property real breathCyclePosition: 0.0

    property string breathInText: qsTr("Breath\nIN")
    property string breathOutText: qsTr("Breath\nOUT")

    function showText(text) {
        if (automaticVisualizationActive) return;
        setupAndStart(text);
    }

    onAutomaticVisualizationActiveChanged: {
        showTextAnimation.setupAndStart("")
        internal.breathInTextDisplayed = false;
        internal.breathOutTextDisplayed = false;
    }

    onBreathCyclePositionChanged: {
        if (!automaticVisualizationActive) return;

        if (!internal.breathInTextDisplayed && breathCyclePosition <= breathInFactor) {
            showTextAnimation.setupAndStart(root.breathInText)
            internal.breathInTextDisplayed = true;
            internal.breathOutTextDisplayed = false;
        } else if (!internal.breathOutTextDisplayed && breathCyclePosition > breathInFactor) {
            showTextAnimation.setupAndStart(root.breathOutText)
            internal.breathInTextDisplayed = false;
            internal.breathOutTextDisplayed = true;
        }
    }

    QtObject {
        id: internal
        readonly property real fadeTimeMs: 0
        property bool breathInTextDisplayed: false
        property bool breathOutTextDisplayed: false
    }

    Text {
        id: textDisplay
        color: "white"
        anchors.centerIn: parent
        font.bold: true
        font.pointSize: 12
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    SequentialAnimation {
        id: showTextAnimation

        property string textToShow: ""

        function setupAndStart(text) {
            if (internal.fadeTimeMs === 0.0) {
                textDisplay.text = text;
            } else {
                textToShow = text;
                textFadeOutAnimator.from = textDisplay.opacity;
                start();
            }
        }

        OpacityAnimator {
            id: textFadeOutAnimator
            target: textDisplay
            to: 0
            duration: internal.fadeTimeMs
        }

        ScriptAction {
            script: {
                textDisplay.text = showTextAnimation.textToShow;
            }
        }

        OpacityAnimator {
            target: textDisplay
            from: 0
            to: 1
            duration: internal.fadeTimeMs
        }
    }
}
