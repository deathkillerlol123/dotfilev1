import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick

ShellRoot {
    id: root
    Process {
        id: cpu
        command: ["sh","-c","head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data =>{
                var parts = data.trim().split(/\s+/)
                var user = parseInt(parts[1]) || 0
                var nice = parseInt(parts[2]) || 0
                var system = parseInt(parts[3]) || 0
                var idle = parseInt(parts[4]) || 0
                var iowait = parseInt(parts[5]) || 0
                var irq = parseInt(parts[6]) || 0
                var softirq = parseInt(parts[7]) || 0
                
                var total = user+nice+system+idle+iowait+irq+softirq
                var idleTime = idle +iowait
                
            }
        }
        Component.onCompleted: running = true
    }
    
    Variants {
        model: Quickshell.screens
        PanelWindow {
            property var modelData
            screen: modelData
            anchors {
                top:true
                left:true
                right:true
            }
            implicitHeigh: 30
            margins {
                top:0
                bottom:
                
            }
        }
        
    }
}
