import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
    anchors.top: false
    anchors.bottom: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 30
    color: "#1a1b26"

    Text {
        anchors.centerIn: parent
        text: "My First Bar"
        color: "#a9b1d6"
        font.pixelSize: 14
    }
    Item {
	property real margin: 5
	implicitWidth: child.implicitWidth + margin * 10
	implicitHeight: child.implicitHeight + margin *10

	Rectangle {
	    id: child

	    x: parent.margin
	    y: parent.margin
	    width: parent.width - parent.margin * 10
	    height: parent.height - parent.margin * 10

	    anchors.fill: parent
	    anchors.margins: parent.margin

	    implicitWidth: 50
	    implicitHeight: 50

	}
    }
}
