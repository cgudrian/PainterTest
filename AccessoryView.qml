import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

GridView {
    id: view

    readonly property int minCellWidth: 80
    property int numColumns: Math.floor(parent.width / minCellWidth)

    width: numColumns * cellWidth
    height: parent.height
    anchors.horizontalCenter: parent.horizontalCenter

    cellWidth: Math.floor(parent.width / numColumns)
    cellHeight: 110
    snapMode: GridView.SnapToRow

    clip: true

    model: 200

    delegate: Item {
        width: view.cellWidth
        height: view.cellHeight

        Rectangle {
            anchors.centerIn: parent
            width: 70
            height: 100
            color: "red"
            radius: 7

            Label {
                anchors.centerIn: parent
                text: modelData
            }
        }
    }

    ScrollIndicator.vertical: ScrollIndicator {}
}
