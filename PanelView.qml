import QtQuick
import QtQuick.Window
import QtQuick.VirtualKeyboard
import QtQuick.Controls
import PainterTest

Rectangle {
    id: root

    property bool dragging: false
    property point originStart
    property point mouseStart

    border.width: 2
    clip: true

    ControlPanel {
        id: panel

        anchors.fill: parent
    }

    PinchArea {
        property real startZoom: 0

        anchors.fill: parent

        onPinchStarted: startZoom = panel.zoom

        onPinchUpdated: (event) => {
                            panel.setZoom(event.startCenter, startZoom * event.scale)
                        }
    }

    MouseArea {
        scrollGestureEnabled: false

        anchors.fill: parent

        onPositionChanged: (mouse) => {
                               if (!dragging) {
                                   return;
                               }

                               panel.origin = {
                                   x: originStart.x - (mouseStart.x - mouse.x),
                                   y: originStart.y - (mouseStart.y - mouse.y),
                               }
                           }

        onPressed: (mouse) => {
                       dragging = true
                       mouseStart.x = mouse.x
                       mouseStart.y = mouse.y
                       originStart = panel.origin
                   }

        onReleased: (mouse) => {
                        dragging = false
                    }

        onWheel: (wheel) => {
                     panel.zoomByFactor(Qt.point(wheel.x, wheel.y), 2 ** (wheel.angleDelta.y / 240))
                 }
    }

    Rectangle {
        anchors.fill: parent

        MultiPointTouchArea {
            anchors.fill: parent
            touchPoints: [
                TouchPoint { id: point1 },
                TouchPoint { id: point2 },
                TouchPoint { id: point3 },
                TouchPoint { id: point4 },
                TouchPoint { id: point5 }
            ]
        }

        Rectangle {
            width: 30; height: 30
            color: "green"
            x: point1.x
            y: point1.y
        }

        Rectangle {
            width: 30; height: 30
            color: "yellow"
            x: point2.x
            y: point2.y
        }

        Rectangle {
            width: 30; height: 30
            color: "yellow"
            x: point3.x
            y: point3.y
        }

        Rectangle {
            width: 30; height: 30
            color: "yellow"
            x: point4.x
            y: point4.y
        }

        Rectangle {
            width: 30; height: 30
            color: "yellow"
            x: point5.x
            y: point5.y
        }
    }
}
