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
}
