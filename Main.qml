import QtQuick
import QtQuick.Window
import QtQuick.VirtualKeyboard
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

Window {
    id: window

    width: 1280
    height: 800
    visible: true
    title: qsTr("Hello World")
    color: "#e6e6e6"

    BusyIndicator {
        anchors.centerIn: parent
        running: main.status !== Loader.Ready
    }

    Loader {
        id: main
        anchors.fill: parent
        asynchronous: true
        sourceComponent: LazyMain {}
    }
}
