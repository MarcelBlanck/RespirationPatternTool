import QtQuick 2.12

Item {
    id: root
    property real breathsPerMinute: settings.breathsPerMinute
    property real breathInFactor: settings.breathInFactor

    readonly property alias animationRunning: breathingAnimation.running
    readonly property alias softStopRunning: softStopAnimation.running

    readonly property alias breathCyclePosition: internal.breathCyclePosition
    readonly property alias breathTaken: internal.breathTaken

    function start() {
        hardStop();
        breathingAnimation.start();
    }

    function hardStop() {
        breathingAnimation.stop();
        softStopAnimation.stop();
        internal.breathCyclePosition = 0.0;
    }

    function softStop() {
        breathingAnimation.stop();
        softStopAnimation.setupAndStart();
    }

    QtObject {
        id: internal

        readonly property real breathCycleTimeMs: 60000 / breathsPerMinute
        readonly property real breathInDurationMs: breathInFactor * breathCycleTimeMs
        readonly property real breathOutDurationMs: (1 - breathInFactor) * breathCycleTimeMs
        readonly property real softStopTimeMs: 500

        property real breathCyclePosition: 0.0
        property real breathTaken:  breathCyclePosition <= breathInFactor
                                    ? breathCyclePosition / breathInFactor
                                    : 1 - (breathCyclePosition - breathInFactor) / (1 - breathInFactor);
    }

    SequentialAnimation {
        id: breathingAnimation
        loops: Animation.Infinite

        NumberAnimation {
            target: internal
            property: "breathCyclePosition"
            from: 0
            to: root.breathInFactor
            duration: internal.breathInDurationMs
            easing.type: Easing.Linear
        }

        NumberAnimation {
            target: internal
            property: "breathCyclePosition"
            from: root.breathInFactor
            to: 1
            duration: internal.breathOutDurationMs
            easing.type: Easing.Linear
        }
    }

    SequentialAnimation {
        id: softStopAnimation

        function setupAndStart() {
            softStopNumberAnimation.from = internal.breathCyclePosition;
            softStopNumberAnimation.to = internal.breathCyclePosition <= root.breathInFactor ? 0 : 1;
            softStopNumberAnimation.duration = internal.softStopTimeMs * internal.breathCyclePosition;
            start();
        }

        loops: 1
        running: false

        NumberAnimation {
            id: softStopNumberAnimation
            target: internal
            property: "breathCyclePosition"
            easing.type: Easing.OutSine
        }

        ScriptAction {
            script: internal.breathCyclePosition = 0;
        }
    }
}
