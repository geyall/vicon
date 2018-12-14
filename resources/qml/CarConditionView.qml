import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import "controls" as CustomControl
import "qrc:///js/test.js" as TestJs

Page {
	id:controlView
	anchors.fill: parent
	property int margin:10

	GridLayout {
		id : grid
		anchors.fill: parent
		anchors.margins: margin
		columns:8
		rows:2
		columnSpacing:10
		rowSpacing:10
		property double colMulti : (grid.width - controlView.margin*2 - grid.columnSpacing*2) / grid.columns
	    property double rowMulti : (grid.height - controlView.margin) / grid.rows

	   	function prefWidth(item){
	        return colMulti * item.Layout.columnSpan
	    }
	    function prefHeight(item){
	        return rowMulti * item.Layout.rowSpan
	    }

	    CustomControl.ThermometerPanel {
	    	id:coolantTemp
	    	title:"冷却液温度"
	    	value:50
	    	maxValue:100
	    	Layout.rowSpan   : 1
            Layout.columnSpan: 1
		    Layout.preferredWidth  : grid.prefWidth(this)
       	    Layout.preferredHeight : grid.prefHeight(this)
	    }

	    CustomControl.CircularGaugePanel {
	    	id:rotationlSpeed
	    	title:"发送机转速"
	    	unit:"转/分钟"
	    	maxValue:5000
	    	value:3200
	    	step:500
	    	Layout.rowSpan   : 1
            Layout.columnSpan: 2
		    Layout.preferredWidth  : grid.prefWidth(this)
       	    Layout.preferredHeight : grid.prefHeight(this)
	    }

	    CustomControl.CircularGaugePanel {
	    	id:carSpeed
	    	title:"当前车速"
	    	unit:"公里/小时"
	    	maxValue:200
	    	value:45
	    	step:20
	    	Layout.rowSpan   : 1
            Layout.columnSpan: 2
		    Layout.preferredWidth  : grid.prefWidth(this)
       	    Layout.preferredHeight : grid.prefHeight(this)
	    }

	    CustomControl.CircularGaugePanel {
	    	id:oilMass
	    	title:"剩余油量"
	    	unit:"百分比"
	    	value:60
	    	Layout.rowSpan   : 1
            Layout.columnSpan: 2
		    Layout.preferredWidth  : grid.prefWidth(this)
       	    Layout.preferredHeight : grid.prefHeight(this)
	    }

	    CustomControl.ThermometerPanel {
	    	id:transTemp
	    	title:"变速箱温度"
	    	value:80
	    	maxValue:120
	    	Layout.rowSpan   : 1
            Layout.columnSpan: 1
		    Layout.preferredWidth  : grid.prefWidth(this)
       	    Layout.preferredHeight : grid.prefHeight(this)
	    }

	    CustomControl.ThermometerPanel {
	    	id:intakeTemp
	    	title:"进气温度"
	    	value:50
	    	Layout.rowSpan   : 1
            Layout.columnSpan: 1
		    Layout.preferredWidth  : grid.prefWidth(this)
       	    Layout.preferredHeight : grid.prefHeight(this)
	    }

	    CustomControl.CircularGaugePanel {
	    	id:betteryVoltage
	    	title:"蓄电池电压"
	    	unit:"伏特"
	    	maxValue:20
	    	value:12
	    	step:2
	    	Layout.rowSpan   : 1
            Layout.columnSpan: 2
		    Layout.preferredWidth  : grid.prefWidth(this)
       	    Layout.preferredHeight : grid.prefHeight(this)
	    }

	     CustomControl.CircularGaugePanel {
	    	id:o2sVoltage
	    	title:"后氧传感器电压"
	    	unit:"伏特"
	    	maxValue:1
	    	value:0.5
	    	step:0.1
	    	Layout.rowSpan   : 1
            Layout.columnSpan: 2
		    Layout.preferredWidth  : grid.prefWidth(this)
       	    Layout.preferredHeight : grid.prefHeight(this)
	    }

	    CustomControl.CircularGaugePanel {
	    	id:throttleAngle
	    	title:"节气门开度"
	    	unit:"百分比"
	    	value:5
	    	Layout.rowSpan   : 1
            Layout.columnSpan: 2
		    Layout.preferredWidth  : grid.prefWidth(this)
       	    Layout.preferredHeight : grid.prefHeight(this)
	    }

	    CustomControl.ThermometerPanel {
	    	id:oilTemp
	    	title:"机油温度"
	    	value:70
	    	maxValue:120
	    	Layout.rowSpan   : 1
            Layout.columnSpan: 1
		    Layout.preferredWidth  : grid.prefWidth(this)
       	    Layout.preferredHeight : grid.prefHeight(this)
	    }

	}


	Timer {
        interval: 500; running: true; repeat: true
        onTriggered: {
        	coolantTemp.value = TestJs.randomNum(50, 70)
        	rotationlSpeed.value = TestJs.randomNum(3200, 3500)
        	carSpeed.value = TestJs.randomNum(45, 60)
        	oilMass.value = TestJs.randomNum(58, 60)
        	transTemp.value = TestJs.randomNum(80, 95)
        	intakeTemp.value = TestJs.randomNum(25, 35)
        	betteryVoltage.value = TestJs.randomNum(10, 13)
        	o2sVoltage.value = TestJs.randomNum(0.5, 0.8,1)
        	throttleAngle.value = TestJs.randomNum(3,8)
        	oilTemp.value = TestJs.randomNum(60,85)
        }
    }
}