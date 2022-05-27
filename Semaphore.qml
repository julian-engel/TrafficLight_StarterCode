import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: _root
    readonly property real lightHeight: height/3.5
    readonly property real dimLightOpacity: 0.2
    property color currentLightColor
    property bool simulating: false

// PUBLIC: the user is supposed to set these properties as they like
    /* The user needs to be able to drive the behavior of the semaphore from the code so you'll
       need to define some properties. When they are set from the outside the semaphore should
       react accordingly
    */

    /* The semaphore should also be able to notify the application about particular user's
       interactions. For instance when the user clicks in the lights or in the background. The
       corresponding behavior on user input should not be tied to the semaphore itself. When the
       user clicked somewhere in the semaphore just emit a signal and then everyone interested in
       the event will be able to react accordingly.
    */
    function changeLight(color) {
        if(Qt.colorEqual(color, "green")) {
            greenLight.opacity = 1;
            yellowLight.opacity = redLight.opacity = _root.dimLightOpacity;
            _root.currentLightColor = color;
        }
        else if(Qt.colorEqual(color, "yellow")) {
            yellowLight.opacity = 1;
            greenLight.opacity = redLight.opacity = _root.dimLightOpacity;
            _root.currentLightColor = color;
        }
        else if(Qt.colorEqual(color, "red")) {
            redLight.opacity = 1;
            greenLight.opacity = yellowLight.opacity = _root.dimLightOpacity;
            _root.currentLightColor = color;
        }
        else {
            console.log("Got invalid light color: " + color);
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        Light{
            id: greenLight
            height: _root.lightHeight
            width: height
            color: "green"
            onLightClicked: {
                _root.simulating = false;
                changeLight(color);
            }
        }
        Light{
            id: yellowLight
            height: _root.lightHeight
            width: height
            color: "yellow"
            onLightClicked: {
                _root.simulating = false;
                changeLight(color)
            }
        }
        Light{
            id: redLight
            height: _root.lightHeight
            width: height
            color: "red"
            onLightClicked: {
                _root.simulating = false;
                changeLight(color)
            }
        }
    }
    Component.onCompleted: {
        changeLight("green")
    }

    Timer {
        interval: 2000
        running: _root.simulating
        repeat: true
        onTriggered: {
            if(Qt.colorEqual(_root.currentLightColor, "green")) {
                changeLight(yellowLight.color)
            }
            else if(Qt.colorEqual(_root.currentLightColor, "yellow")) {
                changeLight(redLight.color)
            }
            else if(Qt.colorEqual(_root.currentLightColor, "red")) {
                changeLight(greenLight.color)
            }
        }
    }

// PRIVATE: the user should not set these properties. They are for component self-organization

    width: 100
    height: 300
    color: "black"
}
