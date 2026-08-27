import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
PanelWindow {
    id: bar
    color: "transparent"
    anchors {
        top: false
        bottom: true
        left: true
        right: true
    }
    implicitHeight: 40
    property string boxColor: "#313244"
    property string textColor: "#ffffff"
    property string accentColor: "#556D94"
    property int memoryUsage: 0
    property int cpuUsage: 0
    property double previousTotal: 0
    property double previousIdle: 0
    Process {
        id: walProcess
        command: [
            "cat",
            "/home/nixboom/.cache/wal/colors.json"
        ]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    var wal = JSON.parse(text)
                    bar.textColor = wal.special.foreground
                    bar.boxColor = wal.colors.color0
                    bar.accentColor = wal.colors.color4
                } catch (e) {
                    console.log("Pywal:", e)
                }
            }
        }
    }
    Rectangle {
        anchors.centerIn: parent
        width: clock.width + 20
        height: clock.height + 10
        color: bar.boxColor
        radius: 8
        Text {
            id: clock
            anchors.centerIn: parent
            color: bar.textColor
            font.pixelSize: 16
            function updateTime() {
                text = Qt.formatTime(new Date(), "HH:mm:ss")
            }
            Component.onCompleted: updateTime()
        }
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clock.updateTime()
    }
    Rectangle {
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            leftMargin: 15
        }
        width: Math.min(music.implicitWidth + 30, 300)
        height: music.height + 10
        color: bar.boxColor
        radius: 8
        Text {
            id: music
            anchors.centerIn: parent
            color: bar.textColor
            font.pixelSize: 15
            width: parent.width - 30
            elide: Text.ElideRight
            text: {
                if (Mpris.players.values.length === 0)
                    return "Nothing playing"
                var player = Mpris.players.values[0]
                if (player.trackTitle === "")
                    return "Nothing playing"
                return player.trackTitle
            }
        }
    }
    Rectangle {
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: 50
        }
        width: stats.width + 20
        height: stats.height + 10
        color: bar.boxColor
        radius: 8
        Text {
            id: stats
            anchors.centerIn: parent
            color: bar.textColor
            font.pixelSize: 15
            text: "CPU: " + cpuUsage + "%  RAM: " + memoryUsage + "%"
        }
    }
    Process {
        id: memoryProcess
        command: [
            "sh",
            "-c",
            "free | awk '/Mem:/ {printf \"%.0f\", ($3/$2)*100}'"
        ]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                memoryUsage = parseInt(text.trim())
            }
        }
    }
    Process {
        id: cpuProcess
        command: [
            "sh",
            "-c",
            "awk '/^cpu / {print $2+$3+$4+$5+$6+$7+$8, $5+$6}' /proc/stat"
        ]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                var values = text.trim().split(/\s+/)
                var total = parseFloat(values[0])
                var idle = parseFloat(values[1])
                if (previousTotal > 0) {
                    var totalDiff = total - previousTotal
                    var idleDiff = idle - previousIdle
                    if (totalDiff > 0) {
                        cpuUsage = Math.round(
                            (1 - idleDiff / totalDiff) * 100
                        )
                    }
                }
                previousTotal = total
                previousIdle = idle
            }
        }
    }
    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            memoryProcess.running = false
            memoryProcess.running = true
            cpuProcess.running = false
            cpuProcess.running = true
        }
    }
    Rectangle {
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: 225
        }
        width: 40
        height: 30
        color: bar.accentColor
        radius: 8
        Text {
            anchors.centerIn: parent
            text: "🔔"
            color: bar.textColor
            font.pixelSize: 18
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                notificationCenter.visible = !notificationCenter.visible
            }
        }
    }
    NotificationCenter {
        id: notificationCenter
    }
    Rectangle {
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: 5
        }
        width: 40
        height: 30
        color: bar.accentColor
        radius: 8
        Text {
            anchors.centerIn: parent
            text: "󰸉"
            color: bar.textColor
            font.pixelSize: 16
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                scriptProcess.running = false
                scriptProcess.running = true
            }
        }
    }
    Process {
        id: scriptProcess
        command: [
            "bash",
            "/home/nixboom/dotfiles/nixos/modules/hosts/users/nixboom/home/.config/waybar/random_wallpaper.sh"
        ]
        onExited: function(exitCode) {
            if (exitCode === 0) {
                walProcess.running = false
                walProcess.running = true
            }
        }
    }
}
