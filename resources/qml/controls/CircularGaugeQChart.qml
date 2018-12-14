import QtQuick 2.6
import QtQuick.Controls 2.1
// import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras.Private 1.0


Rectangle {
	id:chartControl
	property real value:0
	property string title:""
	property real outerDiameter:300
	property real startAngle: 0.75 * Math.PI
	property real endAngle: 0.25 * Math.PI
	property string outerColor:"#868686"
	property string innerColor:"#F6A821"
	property string backgroundColor:"#000000"
	property real _outerRadius:outerDiameter/2
	property real voffset:(_outerRadius - Math.sqrt((_outerRadius*_outerRadius)/2))/2
	property real vcenter: _outerRadius + voffset
	property real outerWidth: _outerRadius * 0.05
	property real innerWidth: _outerRadius * 0.05
	property string titleColor:"#868686"
	property string needleColor:"#868686"
	property string tickmarkLabelColor:"#868686"
	property string valueColor:"#ffffff"
	property real max:100
	property real min:0
	property real step:10

	color: "#21212100"

	height:chartControl.outerDiameter
	width:chartControl.outerDiameter
	// radius:360

	function getTickLabel(value, fixNum) {
		return value < 1 ? value.toFixed(fixNum) : value
	}

    Canvas {
    	anchors.fill: parent
    	anchors.centerIn: parent
    	// anchors.verticalCenterOffset:chartControl.voffset
    	onPaint:{
    		var ctx = getContext("2d");
			ctx.reset();

			//outer
			ctx.beginPath();
			ctx.strokeStyle = chartControl.outerColor;
			ctx.lineWidth = chartControl.outerWidth;

			ctx.arc(chartControl._outerRadius,
					chartControl.vcenter,
					chartControl._outerRadius - chartControl.outerWidth/2,
					chartControl.startAngle,
					chartControl.endAngle,
					false);
			ctx.closePath();
			ctx.stroke();

			//inner
			ctx.beginPath();
			ctx.strokeStyle = chartControl.innerColor;
			ctx.lineWidth = chartControl.innerWidth;
			ctx.arc(chartControl._outerRadius,
					chartControl.vcenter,
					chartControl._outerRadius - chartControl.outerWidth*1.5,
					chartControl.startAngle,
					chartControl.endAngle,
					false);
			ctx.closePath();
			ctx.stroke();

			//background
			ctx.beginPath();
			// ctx.strokeStyle = chartControl.backgroundColor;
			ctx.arc(chartControl._outerRadius,
					chartControl.vcenter,
					chartControl._outerRadius - chartControl.outerWidth*1.5 - chartControl.innerWidth/2 ,
					chartControl.startAngle,
					chartControl.endAngle,
					false);
			ctx.fillStyle=chartControl.backgroundColor;
			ctx.fill()

    	} // canvas onpaint
    } // Canvas

    CircularGauge {
    	id: chart
    	anchors.centerIn: parent
    	maximumValue:chartControl.max
    	minimumValue:chartControl.min
    	anchors.verticalCenterOffset:chartControl.voffset
    	width:chartControl.width - chartControl.outerWidth*2 - chartControl.innerWidth*2
    	height:chartControl.height - chartControl.outerWidth*2 - chartControl.innerWidth*2
    	property string tickmarkColor:chartControl.innerColor
    	// property string tickmarkLabelColor:chartControl.fontColor
    	value:chartControl.value

		style: CircularGaugeStyle {
			minimumValueAngle:-135
    		maximumValueAngle:135
    		tickmarkStepSize:chartControl.step
    		labelStepSize:chartControl.step
    		// tickmarkStepSize:0.01

    		// background: Rectangle {
    		// 	anchors.fill: parent
    		// }

    		tickmark: Rectangle {
		        implicitWidth: outerRadius * 0.02
		        antialiasing: true
		        implicitHeight: outerRadius * 0.08
		        color: chart.tickmarkColor
		    }

		    minorTickmark: Rectangle {
		        implicitWidth: outerRadius * 0.01
		        antialiasing: true
		        implicitHeight: outerRadius * 0.04
		        color: chart.tickmarkColor
		    }

		    tickmarkLabel: Text {
		        font.family: "Microsoft YaHei"
		        font.pixelSize: Math.max(6, outerRadius * 0.1)
		        text: chartControl.getTickLabel(styleData.value, 1)
		        color: chartControl.tickmarkLabelColor
		    }

		    needle: Rectangle {
	            y: outerRadius * 0.15
	            implicitWidth: outerRadius * 0.03
	            implicitHeight: outerRadius * 0.9
	            antialiasing: true
	            color: chart.tickmarkColor
	        }

		    foreground:Item {
		    	Text {
		    		anchors.centerIn: parent
		    		// anchors.verticalCenter
		    		anchors.verticalCenterOffset: -outerRadius/2

		    		text:chartControl.title
		    		font.pixelSize: Math.max(6, outerRadius * 0.1)
					font.family:"Microsoft YaHei"
					font.bold:true
					font.italic:true
					color:chartControl.titleColor
		    	}

		    	Text {
		    		anchors.centerIn: parent
		    		// anchors.verticalCenter
		    		anchors.verticalCenterOffset: outerRadius/2 - chartControl.voffset/2

		    		text:chartControl.value
		    		font.pixelSize: Math.max(6, outerRadius * 0.2)
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
			}
		} // CircularGaugeStyle
	} // CircularGauge
}