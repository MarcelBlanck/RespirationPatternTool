import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.12
import Qt.labs.qmlmodels 1.0

Item {
    id: root

    readonly property alias scenarioName: scenarioNameEntry.text
    readonly property alias scenarioLoopingForever: scenarioLoopForeverSwitch.checked

    width: 400

    Column {
        id: scenarioHeader
        Text {
            id: title
            anchors.left: parent.left
            anchors.right: parent.right
            text: qsTr("Create a Scenario")
            color: "white"
        }

        TextEdit {
            id: scenarioNameEntry
            anchors.left: parent.left
            anchors.right: parent.right
            text: "Scenario Name"
            color: "white"
        }

        Switch {
            id: scenarioLoopForeverSwitch
            anchors.left: parent.left
            text: qsTr("Loop forever")
            checked: false
        }
    }

    ListView {
        anchors.top: scenarioHeader.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        model: phasesModel
        spacing: 6
        clip: true
        delegate: DelegateChooser {
            role: "type"
            DelegateChoice {
                roleValue: "phase"
                delegate: phaseCard
            }
            DelegateChoice {
                roleValue: "add"
                delegate: addPhaseButton
            }
        }
    }

    ListModel {
        id: phasesModel
        ListElement {
            type: "phase"
            rpm: 12
            times: 12
            breathInQuota: 0.5
        }
        ListElement {
            type: "phase"
            rpm: 15
            times: 60
            breathInQuota: 0.3
        }
        ListElement {
            type: "phase"
            rpm: 18
            times: 36
            breathInQuota: 0.5
        }
        ListElement {
            type: "add"
        }
    }

    Component {
        id: phaseCard
        Pane {
            Material.elevation: 4

            RowLayout {
                height: valueBoxColumn.height
                spacing: 5

                ColumnLayout {
                    id: valueBoxColumn
                    height: rpmBox.height + respirationCountBox.height
                    Layout.fillWidth: true

                    SpinBox {
                        id: rpmBox
                        from: 0
                        to: 60
                        stepSize: 1
                        value: rpm
                    }

                    SpinBox {
                        id: respirationCountBox
                        from: 0
                        to: 1000
                        value: times
                    }

                    Slider {
                        id: breathInQuotaSlider
                        width: parent.width
                        from: 5
                        to: 95
                        stepSize: 5
                        value: breathInQuota
                        onValueChanged: breathInQuota = value;
                    }
                }

                Column {
                    Label {
                        text: rpmBox.value + " " + qsTr("rpm")
                    }
                    Label {
                        text: respirationCountBox.value + " " + qsTr("times")
                    }
                    Label {
                        readonly property real durationInTwoDigitS: {
                            return Math.round(respirationCountBox.value * 60 / rpmBox.value * 100) / 100;
                        }
                        text: durationInTwoDigitS + " " + qsTr("s")
                    }
                    Label {
                        text: breathInQuota + "/" + (100 - breathInQuota) + " " + qsTr("IN/OUT")
                    }
                }

                Column {
                    Button {
                        text: "Del"
                        onClicked: {
                            deleteYesNoPopup.indexToDelete = index;
                            deleteYesNoPopup.open();
                        }
                    }
                    Button {
                        text: "Up"
                        onClicked: {
                            if (index > 0) {
                                phasesModel.move(index, index - 1, 1);
                            }
                        }
                    }
                    Button {
                        text: "Down"
                        onClicked: {
                            if (index < phasesModel.count - 2) {
                                phasesModel.move(index, index + 1, 1);
                            }
                        }
                    }
                }
            }
        }
    }

    MessageDialog {
        id: deleteYesNoPopup
        property int indexToDelete: 0
        informativeText: qsTr("Do you want to delete this item?")
        standardButtons: StandardButton.No | StandardButton.Yes
        onYes: {
            phasesModel.remove(indexToDelete);
        }
    }

    Component {
        id: addPhaseButton
        Pane {
            Material.elevation: 6

            Button {
                text: qsTr("Add")
                onClicked: {
                    phasesModel.insert(
                        phasesModel.count - 2,
                        {
                            type: "phase",
                            rpm: 14,
                            times: 14,
                            breathInQuota: 0.5
                        }
                    );
                }
            }
        }
    }
}
