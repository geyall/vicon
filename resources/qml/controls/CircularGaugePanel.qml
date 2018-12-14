import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Extras 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras.Private 1.0

Item {
	id:chartControl
	property string title:""
	property real headerHeight:40
	property real margin:0
	property real startAngle: 0.75 * Math.PI
	property real endAngle: 0.25 * Math.PI
	property string borderColor:"#F6A821"
	property string tickmarkColor:"#F6A821"
	property string backgroundColor:"#000000"
	property string needleColor:"#868686"
	property string tickmarkLabelColor:"#868686"
	property string valueColor:"#ffffff"
	property string titleColor:"#868686"
	property string unit:""
	property real value:0
	property real maxValue:100
	property real minValue:0
	property real step:10

	function getTickLabel(value, fixNum) {
		return value < 1 ? value.toFixed(fixNum) : value
	}

	Rectangle {
		anchors.fill: parent
		color:"#212121"
	}

	Rectangle {
		id:header
		height:chartControl.headerHeight
		width:parent.width
		color:"#00000000"

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
		width:parent.width
		color:"#212121"
		// anchors.margins: chartControl.margin


		CircularGauge {
			id:chart
			anchors.fill: parent
			anchors.centerIn: parent
			value:chartControl.value
			maximumValue:chartControl.maxValue
    		minimumValue:chartControl.minValue

			style: CircularGaugeStyle {
				id:chartStyle
				minimumValueAngle:-135
				maximumValueAngle:135
				tickmarkInset: outerRadius * 0.04
				minorTickmarkInset:outerRadius * 0.04
				labelInset:outerRadius * 0.25
				tickmarkStepSize:chartControl.step
				labelStepSize:chartControl.step

				background: Canvas {
					onPaint:{
						var ctx = getContext("2d");
						ctx.reset();

						//outer
						ctx.beginPath();
						ctx.strokeStyle = chartControl.borderColor;
						ctx.lineWidth = outerRadius * 0.04;
						ctx.fillStyle= chartControl.backgroundColor

						ctx.arc(outerRadius,
								outerRadius,
								outerRadius - ctx.lineWidth/2,
								chartControl.startAngle,
								chartControl.endAngle,
								false);
						ctx.closePath();
						ctx.fill()
						ctx.stroke();
					}
				} //background

				tickmark: Rectangle {
			        implicitWidth: outerRadius * 0.02
			        antialiasing: true
			        implicitHeight: outerRadius * 0.08
			        color: chartControl.tickmarkColor
			    }

			    minorTickmark: Rectangle {
			        implicitWidth: outerRadius * 0.01
			        antialiasing: true
			        implicitHeight: outerRadius * 0.04
			        color: chartControl.tickmarkColor
			    }

			    tickmarkLabel: Text {
			        font.family: "Microsoft YaHei"
			        font.pixelSize: Math.max(6, outerRadius * 0.09)
			        text: chartControl.getTickLabel(styleData.value, 1)
			        color: chartControl.tickmarkLabelColor
			    }

			    needle: Rectangle {
		            y: outerRadius * 0.15
		            implicitWidth: outerRadius * 0.03
		            implicitHeight: outerRadius * 0.8
		            antialiasing: true
		            color: chartControl.tickmarkColor
		        }

		        foreground:Item {
			    	Text {
			    		anchors.centerIn: parent
			    		// anchors.verticalCenter
			    		anchors.verticalCenterOffset: -outerRadius/2

			    		text:chartControl.unit
			    		font.pixelSize: Math.max(6, outerRadius * 0.1)
						font.family:"Microsoft YaHei"
						font.bold:true
						font.italic:true
						color:chartControl.titleColor
			    	}

			    	Text {
			    		anchors.centerIn: parent
			    		// anchors.verticalCenter
			    		anchors.verticalCenterOffset: outerRadius/2 

			    		text:chart.value
			    		font.pixelSize: Math.max(6, outerRadius * 0.15)
						font.family:"Microsoft YaHei"
						font.bold:true
						color:chartControl.valueColor
			    	}

				    Rectangle {
				        width: outerRadius * 0.2
				        height: width
				        radius: width / 2
				        color: chartControl.needleColor
				        anchors.centerIn: parent
				    }
				} //foreground
			} // style
		} // chart
	} //chartContainer
}