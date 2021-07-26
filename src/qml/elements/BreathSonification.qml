import QtQuick 2.12
import QtMultimedia 5.12

Item {
    id: root

    property bool automaticSonificationActive: false
    property real breathInFactor: 0.5
    property real breathCyclePosition: 0.0
    property string breathInStartSound: "qrc:/sounds/4390__noisecollector__pongblipf-4.wav"
    property string breathOutStartSound: "qrc:/sounds/4391__noisecollector__pongblipf-5.wav"

    function playBreathStartSound() {
        breathInStartSoundEffect.play();
    }

    function playBreathStopSound() {
        breathOutStartSoundEffect.play();
    }

    onAutomaticSonificationActiveChanged: {
        internal.breathInStartPlayed = false;
        internal.breathOutStartPlayed = false;
    }

    onBreathCyclePositionChanged: {
        if (!automaticSonificationActive) return;

        if (!internal.breathInStartPlayed && breathCyclePosition <= breathInFactor) {
            playBreathStartSound();
            internal.breathInStartPlayed = true;
            internal.breathOutStartPlayed = false;
        } else if (!internal.breathOutStartPlayed && breathCyclePosition > breathInFactor) {
            playBreathStopSound()
            internal.breathOutStartPlayed = true;
            internal.breathInStartPlayed = false;
        }
    }

    QtObject {
        id: internal
        property bool breathInStartPlayed: false
        property bool breathOutStartPlayed: false
    }

    MediaPlayer {
        id: breathInStartSoundEffect
        source: root.breathInStartSound
    }

    MediaPlayer {
        id: breathOutStartSoundEffect
        source: root.breathOutStartSound
    }
}
