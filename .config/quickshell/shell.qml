import Quickshell
import Quickshell.Io
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
	width: 95
	height: 30
	color: "red"
	border {
	    color: "black"
	    width: 5
	}
	radius: 7
	anchors.right: parent.right
	anchors.rightMargin: 170
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
	width: 80
	height: 30
	color: "red"
	border.color: "black"
	border.width: 5
	radius: 7
	anchors.right: parent.right
	anchors.rightMargin: 90
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
			
			const symbol = status === "Charging" ? "🔌" : batteryIcon
			battery.text = `${symbol} ${capacity}%`
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
}
