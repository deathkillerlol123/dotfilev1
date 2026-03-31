import Quickshell
import Quickshell.Io // for Process
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland


PanelWindow {
  anchors {
      top: false
      bottom: true
      left: true
      right: true
  }
  implicitHeight: 30
  color: "#888FFF"    

  Text {
    id: clock

    anchors.centerIn: parent

    Process {
	id: dateProc
	command: ["date","+%m-%d %H:%M:%S"]
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
    RowLayout {
	anchors.fill: parent
	anchors.margins: 8
	spacing: 1
	Repeater {
	    model:3
	    Rectangle {
		width:5
		height: 16
	    }
	}
    }
    
}
