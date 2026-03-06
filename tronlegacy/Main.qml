import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
    id: root
    width: Screen.width
    height: Screen.height
    color: "#000000"

    Image {
        anchors.fill: parent
        source: "background.jpg"
        fillMode: Image.PreserveAspectCrop
        smooth: true
    }

    Rectangle {
        anchors.fill: parent
        color: "#000a0f"
        opacity: 0.5
    }

    Canvas {
        anchors.fill: parent
        opacity: 0.06
        onPaint: {
            var ctx = getContext("2d")
            ctx.strokeStyle = "#00e5ff"
            ctx.lineWidth = 1
            for (var y = 0; y < height; y += 3) {
                ctx.beginPath()
                ctx.moveTo(0, y)
                ctx.lineTo(width, y)
                ctx.stroke()
            }
        }
    }

    Canvas {
        id: gridCanvas
        anchors.fill: parent
        opacity: 0.15
        property real offset: 0

        NumberAnimation on offset {
            from: 0; to: 80
            duration: 2400
            loops: Animation.Infinite
        }

        onOffsetChanged: requestPaint()

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)
            ctx.strokeStyle = "#00e5ff"
            ctx.lineWidth = 0.8
            var startY = height * 0.60
            var vpx = width / 2
            var vpy = startY - 80
            for (var i = 0; i < 20; i++) {
                var t = ((i * 80 + offset) % (20 * 80)) / (20 * 80)
                var y = startY + t * (height - startY)
                var spread = (y - vpy) / (height - vpy)
                ctx.globalAlpha = 0.3 + spread * 0.7
                ctx.beginPath()
                ctx.moveTo(vpx - spread * width * 0.95, y)
                ctx.lineTo(vpx + spread * width * 0.95, y)
                ctx.stroke()
            }
            ctx.globalAlpha = 1.0
            for (var j = -14; j <= 14; j++) {
                ctx.beginPath()
                ctx.moveTo(vpx + j * 70, startY)
                ctx.lineTo(vpx + j * (width / 14), height)
                ctx.stroke()
            }
        }
    }

    Column {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: 60
        anchors.bottomMargin: 52
        spacing: 6

        Text {
            id: timeText
            text: Qt.formatTime(new Date(), "HH:mm")
            font.family: "monospace"
            font.pixelSize: 80
            font.weight: Font.Thin
            font.letterSpacing: 10
            color: "#e0f7fa"
            style: Text.Outline
            styleColor: "#00e5ff"

            Timer {
                interval: 1000
                repeat: true
                running: true
                onTriggered: timeText.text = Qt.formatTime(new Date(), "HH:mm")
            }
        }

        Text {
            text: Qt.formatDate(new Date(), "dddd, MMMM d yyyy").toUpperCase()
            font.family: "monospace"
            font.pixelSize: 13
            font.letterSpacing: 7
            color: "#4dd0e1"
            opacity: 0.8
        }
    }

    Item {
        width: 320
        height: loginCol.height + 60
        anchors.right: parent.right
        anchors.rightMargin: 140
        anchors.verticalCenter: parent.verticalCenter

        Rectangle {
            anchors.fill: parent
            color: "#010d12"
            opacity: 0.85
            border.color: "#003d4d"
            border.width: 1
        }

        Rectangle {
            width: 2
            height: parent.height
            color: "#00e5ff"
            anchors.left: parent.left
            SequentialAnimation on opacity {
                loops: Animation.Infinite
                NumberAnimation { to: 0.3; duration: 1400 }
                NumberAnimation { to: 1.0; duration: 1400 }
            }
        }

        Rectangle { width: parent.width; height: 1; color: "#00e5ff"; anchors.top: parent.top; opacity: 0.4 }
        Rectangle { width: 24; height: 2; color: "#00e5ff"; anchors.top: parent.top; anchors.right: parent.right; opacity: 0.9 }
        Rectangle { width: 2; height: 24; color: "#00e5ff"; anchors.top: parent.top; anchors.right: parent.right; opacity: 0.9 }
        Rectangle { width: 24; height: 2; color: "#00e5ff"; anchors.bottom: parent.bottom; anchors.left: parent.left; opacity: 0.9 }
        Rectangle { width: 2; height: 24; color: "#00e5ff"; anchors.bottom: parent.bottom; anchors.left: parent.left; opacity: 0.9 }

        Column {
            id: loginCol
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 28
            spacing: 14

            Text {
                text: "SYSTEM ACCESS"
                font.family: "monospace"
                font.pixelSize: 10
                font.letterSpacing: 8
                color: "#00e5ff"
                opacity: 0.7
            }

            Rectangle { width: parent.width; height: 1; color: "#00e5ff"; opacity: 0.15 }

            Rectangle {
                width: 52; height: 52; radius: 26
                color: "#001a22"
                border.color: "#00e5ff"; border.width: 1
                anchors.horizontalCenter: parent.horizontalCenter

                Text { anchors.centerIn: parent; text: "◈"; font.pixelSize: 20; color: "#00e5ff" }

                Rectangle {
                    width: 66; height: 66; radius: 33
                    color: "transparent"
                    border.color: "#00e5ff"; border.width: 1
                    anchors.centerIn: parent
                    SequentialAnimation on opacity {
                        loops: Animation.Infinite
                        NumberAnimation { to: 0.05; duration: 1600 }
                        NumberAnimation { to: 0.3; duration: 1600 }
                    }
                }
            }

            Text {
                text: userModel.lastUser ? userModel.lastUser.toUpperCase() : "USER"
                font.family: "monospace"
                font.pixelSize: 16
                font.letterSpacing: 6
                color: "#e0f7fa"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                width: parent.width; height: 40
                color: "#000d12"
                border.color: passField.activeFocus ? "#00e5ff" : "#1a3a42"
                border.width: 1

                Rectangle {
                    anchors.fill: parent
                    color: "#00e5ff"
                    opacity: passField.activeFocus ? 0.05 : 0
                    Behavior on opacity { NumberAnimation { duration: 200 } }
                }

                Row {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    spacing: 8

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "▸"; color: "#00e5ff"; font.pixelSize: 11
                        opacity: passField.activeFocus ? 1.0 : 0.3
                    }

                    TextInput {
                        id: passField
                        width: parent.width - 28
                        anchors.verticalCenter: parent.verticalCenter
                        echoMode: TextInput.Password
                        passwordCharacter: "◆"
                        color: "#00e5ff"
                        font.family: "monospace"
                        font.pixelSize: 13
                        font.letterSpacing: 4
                        focus: true
                        Keys.onReturnPressed: sddm.login(userModel.lastUser, passField.text, sessionModel.lastIndex)
                        Keys.onEnterPressed: sddm.login(userModel.lastUser, passField.text, sessionModel.lastIndex)
                    }
                }
            }

            Rectangle {
                width: parent.width; height: 40
                color: loginMouse.containsMouse ? "#003d4d" : "#001520"
                border.color: "#00e5ff"; border.width: 1
                Behavior on color { ColorAnimation { duration: 150 } }

                Text {
                    anchors.centerIn: parent
                    text: "INITIALIZE"
                    font.family: "monospace"
                    font.pixelSize: 11
                    font.letterSpacing: 8
                    color: "#00e5ff"
                }

                Rectangle {
                    anchors.fill: parent
                    clip: true
                    color: "transparent"

                    Rectangle {
                        width: 2; height: parent.height
                        color: "#00e5ff"; opacity: 0.5
                        NumberAnimation on x { from: -10; to: 290; duration: 2200; loops: Animation.Infinite }
                    }
                }

                MouseArea {
                    id: loginMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: sddm.login(userModel.lastUser, passField.text, sessionModel.lastIndex)
                }
            }

            Text {
                id: errorMsg
                text: ""
                font.family: "monospace"
                font.pixelSize: 10
                font.letterSpacing: 3
                color: "#ff5252"
                visible: text !== ""
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle { width: parent.width; height: 1; color: "#00e5ff"; opacity: 0.1 }

            Row {
                spacing: 8
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "SESSION"; font.family: "monospace"; font.pixelSize: 9
                    font.letterSpacing: 4; color: "#4dd0e1"; opacity: 0.5
                }
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "HYPRLAND"; font.family: "monospace"; font.pixelSize: 9
                    font.letterSpacing: 4; color: "#00e5ff"; opacity: 0.8
                }
            }
        }
    }

    Row {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 40
        anchors.bottomMargin: 32
        spacing: 16

        Rectangle {
            width: 34; height: 34; radius: 17
            color: "transparent"; border.color: "#00e5ff"; border.width: 1
            opacity: shutMouse.containsMouse ? 1.0 : 0.5
            Text { anchors.centerIn: parent; text: "⏻"; font.pixelSize: 15; color: "#00e5ff" }
            MouseArea { id: shutMouse; anchors.fill: parent; hoverEnabled: true; onClicked: sddm.powerOff() }
        }

        Rectangle {
            width: 34; height: 34; radius: 17
            color: "transparent"; border.color: "#00e5ff"; border.width: 1
            opacity: rebootMouse.containsMouse ? 1.0 : 0.5
            Text { anchors.centerIn: parent; text: "↺"; font.pixelSize: 15; color: "#00e5ff" }
            MouseArea { id: rebootMouse; anchors.fill: parent; hoverEnabled: true; onClicked: sddm.reboot() }
        }
    }

    Connections {
        target: sddm
        onLoginFailed: {
            errorMsg.text = "ACCESS DENIED"
            passField.text = ""
            passField.focus = true
        }
    }

    Component.onCompleted: passField.forceActiveFocus()
}
