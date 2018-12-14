import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Extras 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Item {
	id:chartControl
	property string title:""
	property real headerHeight:40
	property real margin:0
	property real value:0
	property real maxValue:100
	property real minValue:0
	property real step:10

	property string valueBarColor:"#F6A821"
	property real barWidth: 0.15
	property string backgroundColor:"#000000"
	property string tickmarkColor:"#868686"
	property real tickmarkWidth:18
	property real tickmarkHeight:1
	property real miniorTickmarkWidth:12
	property real miniorTickmarkHeight:1
	property string miniorTickmarkColor:"#868686"
	property string tickmarkLabelColor:"#868686"

	Rectangle {
		anchors.fill: parent
		color:"#212121"
	}

	Rectangle {
		id:header
		height:chartControl.headerHeight
		width:parent.width
		color:"#212121"

		Text {
			text:chartControl.title
			anchors.centerIn: parent
			font.pixelSize: 12
			font.family:"Microsoft YaHei"
			font.bold:true
			color:"#868686"
		}
	}

	Rectangle {
		id:chartContainer
		anchors.top: header.bottom
		height:parent.height - header.height
		anchors.topMargin: chartControl.margin
		width:parent.width
		color:"#212121"

		Gauge {
			id:chart
			height: parent.height*0.9 
			anchors.horizontalCenter: parent.horizontalCenter
			minimumValue: chartControl.minValue
			maximumValue: chartControl.maxValue
		    value: chartControl.value

		    style: GaugeStyle {

		    	foreground:null

		    	valueBar: Rectangle {
		    		id:valueBar
				    color: chartControl.valueBarColor
				    implicitWidth: chartControl.barWidth*chartControl.width
				}

				background:Rectangle {
					color: chartControl.backgroundColor
					implicitWidth:chartControl.barWidth*chartControl.width
				}

				tickmark: Item {
		            implicitWidth: chartControl.tickmarkWidth
		            implicitHeight: chartControl.tickmarkHeight

		            Rectangle {
		                color: chartControl.tickmarkColor
		                anchors.fill: parent
		                anchors.leftMargin: 3
        				anchors.rightMargin: 3
		            }
		        } // tickmark

		        minorTickmark: Item {
				    implicitWidth: chartControl.miniorTickmarkWidth
				    implicitHeight: chartControl.miniorTickmarkHeight

				    Rectangle {
				        color: chartControl.miniorTickmarkColor
				        anchors.fill: parent
				        anchors.leftMargin: 2
       					anchors.rightMargin: 4
				    }
				} // minorTickmark

				tickmarkLabel:Text {
			        font.family: "Microsoft YaHei"
			        font.pixelSize: Math.max(6, chartControl.height/3 * 0.1)
			        text: Math.round(styleData.value)
			        color: chartControl.tickmarkLabelColor
			    } //tickmarkLabel
		    }
		}

	} //chartContainer
}