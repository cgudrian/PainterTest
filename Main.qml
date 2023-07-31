import QtQuick
import QtQuick.Window
import QtQuick.VirtualKeyboard
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

Window {
    id: window

    width: 1024
    height: 600
    visible: true
    title: qsTr("Hello World")
    color: "#e6e6e6"

    Rectangle {
        id: topDrawer

        anchors.horizontalCenter: parent.horizontalCenter
        width: 780
        height: topHandle.y + 10
        visible: opacity > 0
        opacity: Math.min(1, Math.max(0, (height - 15) / 50))
        color: "#e6e6e6"
        clip: true
        border.color: "#7f7f7f"
        border.width: (opacity >= 1) ? 2 : 0
        radius: 8

        Rectangle {
            id: toolbar
            width: parent.width
            color: "#e6e6e6"
            height: 79

            RowLayout {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 3
                anchors.rightMargin: 3
                anchors.topMargin: 9

                CSToolButton {}

                Item { Layout.fillWidth: true }

                CSToolButton {}

                Item { Layout.fillWidth: true }

                CSToolButton {}

                CSToolButton {}

                Item { Layout.fillWidth: true }

                CSToolButton {}

                Item { Layout.fillWidth: true }

                CSToolButton {}

                Item { Layout.fillWidth: true; width: 2 }

                CSToolButton {}

                Item { Layout.fillWidth: true; width: 2 }

                CSToolButton {}

                Item { Layout.fillWidth: true; width: 2 }

                CSToolButton {}
            }
        }

        Rectangle {
            id: divider
            anchors.top: toolbar.bottom
            height: 2
            width: parent.width
            color: "white"
        }

        GridLayout {
            columnSpacing: 5
            rowSpacing: 5
            rows: 1

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: divider.bottom
            anchors.topMargin: 5

            Repeater {
                model: 26

                Rectangle {
                    width: 70
                    height: 100
                    radius: 8
                    color: "white"
                }
            }
        }
    }

    Rectangle {
        id: topHandle

        property bool pressed: false
        property int oldY: 5

        y: 5

        anchors.horizontalCenter: parent.horizontalCenter
        width: 52
        height: 20
        color: "#2ea938"
        border.color: "#e6e6e6"
        border.width: 2
        radius: height / 2

        Rectangle {
            visible: parent.pressed
            anchors.centerIn: parent
            width: parent.width + 30
            height: parent.height + 30
            color: "transparent"
            border.width: 15
            border.color: "#336dc7"
            radius: height / 2
        }

        MouseArea {
            property real speedY: 0
            property int lastY: 0

            anchors.fill: parent

            drag.target: parent
            drag.axis: Drag.YAxis
            drag.minimumY: 5
            drag.threshold: 0

            onClicked: {
                if (parent.y > 5) {
                    parent.oldY = parent.y
                    parent.y = 5
                } else {
                    if (parent.oldY > 5) {
                        parent.y = parent.oldY
                    } else {
                        parent.y = 89
                    }
                }
            }

            onPressed: {
                parent.pressed = true
            }

            onReleased: (mouse) => {
                            parent.pressed = false
                            if (speedY < -5) {
                                parent.y = 5
                            }
                            if (parent.y > 40 && parent.y < 89){
                                parent.y = 89
                            }
                            if (parent.y < 40) {
                                parent.y = 5
                            }
                        }

            onPositionChanged: (mouse) => {
                                   mouse = window.contentItem.mapFromItem(this, mouse)
                                   speedY = mouse.y - lastY
                                   lastY = mouse.y
                               }
        }
    }

    PanelView {
        visible: false
        anchors.centerIn: parent
        width: 400
        height: 300
        x: 10
        y: 10
    }

    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: window.height
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }

        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }

    Slider {
        id: slider
        from: 1
        to: 20
        value: 5
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: 10
        color: "lightblue"
        z: -1

        Label {
            anchors.centerIn: parent
            text: "HALLO"
        }

        Canvas {
            property int radius: slider.value

            anchors.fill: parent
            anchors.margins: 10
            contextType: "2d"

            onRadiusChanged: requestPaint()

            onPaint: {
                //context.fillStyle = Qt.rgba(1, 0, 0, 1)
                context.clearRect(0, 0, width, height)

                context.beginPath()
                context.lineWidth = 2
                context.moveTo(2 * radius, radius)
                context.lineTo(width - 2 * radius, radius)
                context.arcTo(width - radius, radius, width - radius, 2 * radius, radius)
                context.lineTo(width - radius, height - (50 + radius))
                context.arcTo(width - radius, height - 50, width - 2 * radius, height - 50, radius)
                context.fill()
            }
        }
    }
}
