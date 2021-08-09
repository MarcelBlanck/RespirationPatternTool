import QtQuick 2.0

Rectangle {
    id: root

    property bool isTop: true
    property var content

    width: parent.width
    height: 80
    state: isTop ? "top" : ""
    color: "red"
    border.color: "black"
    states: [
        State {
            name: ""
            PropertyChanges { target: root; y: root.height / 2; z: 0}
        },
        State {
            name: "top"
            PropertyChanges { target: root; y: 0; z: 1}
        }
    ]
    transitions: [
        Transition {
            from: ""
            to: "top"
            SequentialAnimation {
                PropertyAnimation {
                    property: "y"
                    to: root.height / 4
                    duration: animationDurationMs / 2
                }
                PropertyAction { property: "z"; value: 1 }
                PropertyAnimation {
                    property: "y"
                    to: 0
                    duration: animationDurationMs / 2
                }
            }
        },
        Transition {
            from: "top"
            to: ""

            SequentialAnimation {
                ParallelAnimation {
                    PropertyAnimation {
                        property: "opacity"
                        to: 0
                        duration: animationDurationMs / 2
                    }
                    PropertyAnimation {
                        property: "y"
                        to: -root.height
                        duration: animationDurationMs / 2
                    }
                }
                PropertyAction { property: "y"; value: root.height * 2 }
                PropertyAction { property: "z"; value: 0 }
                PropertyAction { property: "opacity"; value: 1 }
                PropertyAnimation {
                    property: "y"
                    to: root.height / 2
                    duration: animationDurationMs / 2
                }
            }
        }
    ]

    Component.onCompleted: {
        if (isTop) {
            z = 1;
            y = 0;
        } else {
            z = 0;
            y = height / 2;
        }
    }
}


