import QtQuick 2.0

Item {
    id: root

    property real breathInFactor: 0.4
    property real breathCyclePosition: 0.0

    readonly property real circleRadius: 16
    readonly property real circleOrbitRadius: (width / 2) - circleRadius / 2

    onBreathInFactorChanged: {
        circleGuide.requestPaint();
    }

    Canvas {
        id: circleGuide
        anchors.fill: parent
        onPaint: {
            var context = getContext("2d");
            context.clearRect(0, 0, width, height);

            var breathGradient = context.createLinearGradient(
                width / 2,
                root.circleRadius / 2,
                width/2 + root.circleOrbitRadius * Math.cos(root.breathInFactor * 2 * Math.PI - Math.PI / 2),
                height/2 + root.circleOrbitRadius * Math.sin(root.breathInFactor * 2 * Math.PI - Math.PI / 2)
            );
            breathGradient.addColorStop("0.0", "#11CCFFFF");
            breathGradient.addColorStop("1.0", "#FF00FFFF");

            context.lineWidth = 8;
            context.strokeStyle = breathGradient;

            context.beginPath();
            context.arc(
                width / 2,
                height / 2,
                root.circleOrbitRadius,
                - Math.PI / 2,
                2 * Math.PI * root.breathInFactor - Math.PI / 2
            );
            context.stroke();

            context.beginPath();
            context.arc(
                width / 2,
                height / 2,
                root.circleOrbitRadius,
                2 * Math.PI * root.breathInFactor - Math.PI / 2,
                2 * Math.PI - Math.PI / 2
            );
            context.stroke();
        }

        Component.onCompleted: requestPaint();
    }

    Rectangle {
        id: circle
        width: (radius - border.width) * 2
        height: width
        radius: root.circleRadius
        color: "#FF00FFFF"
        border.color: "grey"
        border.width: 2
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -root.circleOrbitRadius * Math.cos(root.breathCyclePosition * 2 * Math.PI)
        anchors.horizontalCenterOffset: root.circleOrbitRadius * Math.sin(root.breathCyclePosition * 2 * Math.PI)
    }
}
