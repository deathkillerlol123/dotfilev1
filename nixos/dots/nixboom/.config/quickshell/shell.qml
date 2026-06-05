import Quickshell
import Quickshell.Io
import Quickshell.Services.SystemTray
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland

PanelWindow {
    property bool hasBattery: true
    anchors {
	top: false
	bottom: true
	left: true
	right: true
    }
    implicitHeight: 30
    color: "#888FFF"

    Rectangle {
	width: 65
	height: 30
	color: "red"
	border {
	    color: "black"
	    width: 5
	}
	radius: 7
	anchors.right: parent.right
	anchors.rightMargin: 120
	Text {
	    id: clock
	    anchors.centerIn: parent
	    Process {
		id: dateProc
		command: ["date","+%H:%M:%S"]
		running: true
		stdout: StdioCollector {
		    onStreamFinished: clock.text = this.text
		}
	    }
	    Timer {
		interval: 1000
  		running: true
		repeat: true
		onTriggered: dateProc.running = true
	    }
	}
    }
    Rectangle {
	id:left
	width: 45
	height: 30
	color: "red"
	border.color: "black"
	border.width: 5
	radius: 7
	anchors.right: parent.right
	anchors.rightMargin: 75
	Text {
	    id: battery
	    anchors.centerIn: parent
	    Process {
		id: batteryProc
		command: ["sh", "-c", "echo $(cat /sys/class/power_supply/BAT*/capacity),$(cat /sys/class/power_supply/BAT*/status)"]
		running: hasBattery		
		stdout: SplitParser {
		    onRead: function(data) {
			const [capacityStr, status] = data.trim().split(',')
			const capacity = parseInt(capacityStr)
			let batteryIcon = "󰂂"
			if (capacity <= 20) batteryIcon = "󰁺"
			else if (capacity <= 40) batteryIcon = "󰁽"
			else if (capacity <= 60) batteryIcon = "󰁿"
			else if (capacity <= 80) batteryIcon = "󰂁"
			else batteryIcon = "󰂂"
			
			const symbol = status === "Charging" ? "${capacity}" : "Full"
			battery.text = `${symbol}`
		    }
		}
	    }      
	    Timer {
		interval: 1000
		running: hasBattery
		repeat: true
		onTriggered: batteryProc.running = true		
	    }
	}
    }
    Rectangle {
	id:tray
	width: 75
	height: 30
	border.width: 5
	radius: 7
	color: "#8888ff"
	anchors.right:parent.right
	anchors.rightMargin: 0

	Row {
	    id: trayRow
	    spacing:0
	    Repeater {
		model: SystemTray.items
		delegate: Rectangle {
		    height: 23
		    width: 23
		    color: "transparent"
		    Image {
			source: modelData.icon
			anchors.fill: parent
			anchors.topMargin: 3
			anchors.bottomMargin: -3
			anchors.leftMargin:2
		    }
		    MouseArea {
			anchors.fill: parent
			onClicked: {
			    modelData.activate()
			}
		    }
		}
	    }
	}
    }
}
