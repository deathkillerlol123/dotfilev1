import QtQuick
import Quickshell
import Quickshell.Services.Notifications
PanelWindow {
    id: window
    visible: false
    anchors {
        top: false
        bottom: true
        right: true
    }
    implicitWidth: 350
    implicitHeight: 330
    color: "#1e1e2e"
    property var notificationList: []
    NotificationServer {
        id: server
        keepOnReload: true
        persistenceSupported: true
        onNotification: function(notification) {
            notification.tracked = true
            notificationList = [notification].concat(notificationList)
            Qt.callLater(function() {
                listView.positionViewAtBeginning()
            })
        }
    }
    Rectangle {
        anchors.fill: parent
        color: "#313244"
        radius: 12
        Text {
            anchors {
                top: parent.top
                left: parent.left
                topMargin: 15
                leftMargin: 15
            }
            text: "Notifications: " + notificationList.length
            color: "white"
            font.pixelSize: 20
        }
        Rectangle {
            anchors {
                top: parent.top
                right: parent.right
                topMargin: 10
                rightMargin: 15
            }
            width: 80
            height: 30
            color: "#45475a"
            radius: 6
            Text {
                anchors.centerIn: parent
                text: "Clear"
                color: "white"
                font.pixelSize: 14
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    for (var i = 0; i < notificationList.length; i++) {
                        notificationList[i].tracked = false
                    }
                    notificationList = []
                }
            }
        }
        ListView {
            id: listView
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                topMargin: 60
                margins: 15
            }
            clip: true
            spacing: 10
            model: window.notificationList
            delegate: Rectangle {
                width: listView.width
                height: 75
                color: "#45475a"
                radius: 8
                Column {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 4
                    Text {
                        width: parent.width
                        text: modelData.appName + ": " + modelData.summary
                        color: "white"
                        font.bold: true
                        elide: Text.ElideRight
                    }
                    Text {
                        width: parent.width
                        text: modelData.body
                        color: "#cdd6f4"
                        elide: Text.ElideRight
                    }
                }
            }
        }
    }
}
