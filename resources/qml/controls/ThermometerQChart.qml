import QtQuick 2.6
import QtQuick.Controls 2.1

Rectangle {
	id:control
	height:250
	width:height*0.4

	property real max:100
	property real min:0
	property real tickmarkStep:10
	property real minortickmarkStep:2
	property real value:0
	property real borderWidth:Math.round(control.width*0.04)
	property string borderColor:"#868686"
	property real trackPadding:Math.round(control.width*0.05)
	property string backgroundColor:"#212121"
	property real barWidth:control.width*0.25
	property string valueBarColor:"#F6A821"
	property string trackColor:"#000000"
	property string tickmarkColor:"#868686"
	property string minortickmarkColor:"#868686"
	property string tickmarkLabelColor:"#868686"
	property real tickmarkLabelSize:10
	property real tickmarkWidth:8
	property real tickmarkHeight:1
	property real minortickmarkWidth:4
	property real minortickmarkHeight:1
	property real tickmarkLabelRightMargin:2


	color:control.backgroundColor
	// onValueChanged: valueBar.height = getValueBarHeight()

	function getMinorTickmarkSpacing() {
		var height = (trackBar.height - trackCircle.width/2) 
						- getMinortickmarkCount()*control.minortickmarkHeight
		return height/(control.max - control.min)*control.minortickmarkStep
	}

	function getTickmarkSpacing() {
		var height = (trackBar.height - trackCircle.width/2) 
						- getTickmarkCount()*control.tickmarkHeight
		return height/(control.max - control.min)*control.tickmarkStep
	}

	function getTickmarkLabelSpacing() {
		var height = (trackBar.height - trackCircle.width/2) 
					- ((getTickmarkCount() - 1)*control.tickmarkLabelSize)

		return height/(control.max - control.min)*control.tickmarkStep
	}

	function unitHeight() {
		return (trackBar.height - trackCircle.width/2)/(control.max - control.min)
	}

	function getTickmarkCount() {
		return (control.max - control.min)/control.tickmarkStep + 1
	}

	function getMinortickmarkCount() {
		return (control.max - control.min)/control.minortickmarkStep + 1
	}

	function getTickmarkLabelModel() {
		var result = []
		var start = control.min/control.tickmarkStep
		for (var i=start; i < control.getTickmarkCount(); i++) {
			result.unshift(i*control.tickmarkStep)
		}
		return result
	}

	function getValueBarHeight() {
		return control.value*control.unitHeight() 
				+ control.borderWidth 
				+ control.trackPadding
				+ valueCircle.width/2
	}

	//border circle
	Rectangle {
		id:borderCircle
		radius:360
		width:parent.barWidth*2
		height:width
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		color:parent.borderColor
	}

	//border bar
	Rectangle {
		id:borderBar
		width:parent.barWidth
		height:parent.height - borderCircle.height + parent.borderWidth
		anchors.horizontalCenter: parent.horizontalCenter
		color:parent.borderColor
	}

	//track circle
	Rectangle {
		id:trackCircle
		radius:360
		width:borderCircle.width - parent.borderWidth*2
		height:width
		anchors.horizontalCenter: borderCircle.horizontalCenter
		anchors.verticalCenter: borderCircle.verticalCenter
		color:parent.trackColor
	}

	//track bar
	Rectangle {
		id:trackBar
		width:borderBar.width - parent.borderWidth*2
		height:parent.height 
				- parent.borderWidth*2 
				- trackCircle.height
				+ trackCircle.width/2
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: trackCircle.top
		anchors.bottomMargin: -trackCircle.width/2
		color:parent.trackColor
	}

	//value circle
	Rectangle {
		id:valueCircle
		radius:360
		width:trackCircle.width - parent.trackPadding*2
		height:width
		anchors.horizontalCenter: trackCircle.horizontalCenter
		anchors.verticalCenter: trackCircle.verticalCenter
		color:parent.valueBarColor
	}

	//value bar
	Rectangle {
		id:valueBar
		width:trackBar.width - parent.trackPadding*2
		height:control.getValueBarHeight()
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: valueCircle.top
		anchors.bottomMargin: -valueCircle.width/2
		color:parent.valueBarColor
	}

	Rectangle {
		id:minortickmark
		anchors.right: borderBar.left
		height:trackBar.height - trackCircle.width/2
		width:parent.barWidth
		color:"#00000000"

		Column {
			anchors.fill: parent
			// spacing:control.unitMinorTickmarkSpacing()*control.minortickmarkStep
			spacing:control.getMinorTickmarkSpacing()
			Repeater {
		        model: control.getMinortickmarkCount()
		        Rectangle {
		        	anchors.right: parent.right
		            width: control.minortickmarkWidth
		            height: control.minortickmarkHeight
		            color: control.minortickmarkColor
		        }
		    } // repeater
		}
	} // minortickmark

	//tickmark
	Rectangle {
		id:tickmark
		anchors.right: borderBar.left
		height:trackBar.height - trackCircle.width/2
		width:parent.barWidth
		color:"#00000000"

		Column {
			id:tickmarkContainer
			anchors.fill: parent
			// spacing:control.unitTickmarkSpacing()*control.tickmarkStep
			spacing:control.getTickmarkSpacing()

			Repeater {
				id:tickmarkList
		        model: control.getTickmarkCount()

		        Rectangle {
		        	anchors.right: parent.right
		            width: control.tickmarkWidth
		            height: control.tickmarkHeight
		            color: control.minortickmarkColor
		        }
		    } // repeater
		}
	} // tickmark

	//tickmarkLabel
	Rectangle {
		id:tickmarkLabel
		anchors.right: tickmark.horizontalCenter
		// height:trackBar.height - trackCircle.width/2
		width:parent.barWidth
		y: -control.tickmarkLabelSize

		Column {
			anchors.fill: parent
			spacing:control.getTickmarkLabelSpacing()
			// spacing:2
				Repeater {
					id:tickmarkLabelList
			        model: control.getTickmarkLabelModel()
			        Text {
			        	height:control.tickmarkLabelSize
			        	anchors.right: parent.right
			        	anchors.rightMargin: control.tickmarkLabelRightMargin
			            font.family:"Microsoft YaHei"
			            font.pixelSize:control.tickmarkLabelSize
			            text:modelData
			            color: control.tickmarkLabelColor
			        }
			    } // repeater
		} //Column
	} //tickmarkLabel
}