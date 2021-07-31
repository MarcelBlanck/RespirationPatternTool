import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.12
import Qt.labs.qmlmodels 1.0

import "../elements"

Item {
    id: root

    width: 400

    SettingsHeader {
        id: header

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        settingsRef: settings
    }

    ListView {
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        model: settings.phasesModel
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
                        text: "Up"
                        onClicked: {
                            if (index > 0) {
                                settings.phasesModel.move(index, index - 1, 1);
                            }
                        }
                    }
                    Button {
                        text: "Del"
                        onClicked: {
                            deleteYesNoPopup.indexToDelete = index;
                            deleteYesNoPopup.open();
                        }
                    }
                    Button {
                        text: "Down"
                        onClicked: {
                            if (index < settings.phasesModel.count - 2) {
                                settings.phasesModel.move(index, index + 1, 1);
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
            settings.phasesModel.remove(indexToDelete);
        }
    }

    Component {
        id: addPhaseButton
        Pane {
            Material.elevation: 6

            Button {
                text: qsTr("Add")
                onClicked: {
                    // TODO add addPhase function to settings
                    settings.phasesModel.insert(
                        settings.phasesModel.count - 1,
                        settings.defaultPhase
                    );
                }
            }
        }
    }
}
