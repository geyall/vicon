import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4

Item {
	id:control
	width:100
	height:75
	focus: true
	property string icon
	property string text:"button"
	property string color:"default"
	property int iconSize:36
	property int fontSize:32
	signal clicked

	Rectangle {
		id:background
		anchors.fill: parent
		color:getColor()

		RowLayout {
			anchors.centerIn: parent
			spacing:15
			Image {
				sourceSize.width:control.iconSize
				sourceSize.height:control.iconSize
				source:control.icon
			}
			Label {
				text:control.text
				font.pixelSize: control.fontSize
				font.family:"Microsoft YaHei"
			}
			StatusIndicator {
				id:buttonIndicator
				active:false
		        color: "#1BBF89"
		    }
		}
	}

	states: [
		State {
			name:"TURN_ON"
			PropertyChanges {target:buttonIndicator; active:true}
		},
		State {
			name:"TURN_OFF"
			PropertyChanges {target:buttonIndicator; active:false}
		}
	]

	MouseArea {
		id:mouse
		anchors.fill: parent
		onPressed:{
			background.color = Qt.lighter(background.color)
			if (control.state == "TURN_ON")
				control.state = "TURN_OFF"
			else
				control.state = "TURN_ON"
		}

		onReleased:{
			background.color = getColor()
		}

		onClicked:control.clicked()
	}

	function getColor() {
		switch(control.color) {
			case "red":
				return "#DB524B"
			case "green":
				return "#008A00"
			case "yellow":
				return "#F6A821"
			default:
				return "#616779"
		}
	}

	Component.onCompleted: {
        state:"TURN_OFF"
    }

	
}