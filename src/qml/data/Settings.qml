import QtQuick 2.12

Item {
    id: root

    property bool soundOn: true
    property bool loopForever: true
    property alias phasesModel: phasesModel

    readonly property string settingsVersion: "1.0.0"
    readonly property int maxBpm: 60
    readonly property int maxBreatingTimesPerPhase: 1000
    readonly property var defaultPhase: {
        "type": "phase",
        "rpm": 14,
        "times": 14,
        "breathInQuota": 50
    }


    property real breathsPerMinute: 14
    property real breathInFactor: 0.5

    function setToDefault() {
        soundOn = true;
        loopForever = true;
        phasesModel.clear();
        phasesModel.append(defaultPhase);
        phasesModel.append({ type: "add" });
    }

    function loadFromJson(json) {
        var settings = JSON.parse(json);

        soundOn = settings.soundOn;
        loopForever = settings.loopForever;

        // TODO phasesModelList order, data validation, sanification and correction

        phasesModel.clear();
        const phasesModelListCount = settings.phasesModelList.length;
        settings.phasesModelList.forEach(listEntry => {
            if (listEntry.type === "phase") {
                phasesModel.append({
                    type: "phase",
                    rpm: listEntry.rpm,
                    times: listEntry.times,
                    breathInQuota: listEntry.breathInQuota
                });
            }
        });
        phasesModel.append({ type: "add" });
    }

    function convertToJson() {
        var settings = {
            soundOn: root.soundOn,
            loopForever: root.loopForever,
            phasesModelList: []
        };

        const phasesModelList = [];
        const phaseModelCount = phasesModel.count;
        for (let i = 0; i < phaseModelCount; i++) {
            const modelEntry = phasesModel.get(i);
            console.log("checking ", JSON.stringify(modelEntry))
            if (modelEntry.type === "phase") {
                phasesModelList.push({
                    order: i,
                    type: "phase",
                    rpm: modelEntry.rpm,
                    times: modelEntry.times,
                    breathInQuota: modelEntry.breathInQuota
                });
            };
        };
        settings.phasesModelList = phasesModelList;

        return JSON.stringify(settings);
    }

    ListModel {
        id: phasesModel
        ListElement {
            type: "phase"
            rpm: 12
            times: 12
            breathInQuota: 50
        }
        ListElement {
            type: "add"
        }
    }

    Component.onCompleted: setToDefault();
}
