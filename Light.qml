import QtQuick 2.0

Rectangle {
    radius: width/2
    color: "white"

    signal lightClicked()

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            lightClicked()
        }
    }

    function toggleLight() {
        if(opacity !== 1) {
            opacity = 0.2;
        }
        else {
            opacity = 1;
        }
    }
}
