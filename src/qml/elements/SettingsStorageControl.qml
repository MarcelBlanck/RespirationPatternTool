import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.2

import "../data"

Item {
    id: root

    property var settings

    height: buttonRow.height

    RowLayout {
        id: buttonRow

        width: parent.width

        Button {
            Layout.fillWidth: true
            text: qsTr("Load")
            onClicked: openFileDialog.open();
        }

        Button {
            Layout.fillWidth: true
            text: qsTr("Save")
            onClicked: saveFileDialog.open();
        }

        Button {
            Layout.fillWidth: true
            text: qsTr("Default")
            onClicked: settings.setToDefault();
        }
    }

    FileDialog {
        id: openFileDialog

        nameFilters: ["Respiration Pattern Tool Data files (*.rptd)"]
        selectExisting: true
        onAccepted: {
            // TODO error popups for request.status
            var request = new XMLHttpRequest();
            request.open("GET", openFileDialog.fileUrl, false);
            request.send(null);
            root.settings.loadFromJson(request.responseText);
        }
    }

    FileDialog {
        id: saveFileDialog

        nameFilters: ["Respiration Pattern Tool Data (*.rptd), All files (*)"]
        selectExisting: false
        onAccepted: {
            // TODO error popups for request.status
            var request = new XMLHttpRequest();
            request.open("PUT", saveFileDialog.fileUrl, true);
            request.send(root.settings.convertToJson());
        }
    }
}
