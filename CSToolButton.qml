import QtQuick
import QtQuick.Window
import QtQuick.VirtualKeyboard
import QtQuick.Controls
import QtQuick.Layouts

Column {
    Rectangle {
        width: 48
        height: width
        radius: 7
        color: "#adadad"
    }

    Label {
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Button"
    }
}
