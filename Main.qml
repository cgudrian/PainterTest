import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: window
    width: 1280
    height: 800
    visible: true
    title: qsTr("Hello World")
    color: "#e6e6e6"

    Connections {
        target: Qt.application

        function onAboutToQuit() {
            main.active = false
        }
    }

    BusyIndicator {
        anchors.centerIn: parent
        running: main.status !== Loader.Ready
    }

    Loader {
        id: main
        //active: false
        anchors.fill: parent
        asynchronous: true
        sourceComponent: LazyMain {}
    }
}
