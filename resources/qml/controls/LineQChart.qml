import QtQuick 2.6
import QtQuick.Controls 2.1
import QtCharts 2.2

Item {
	id: control
	property string title:"line"
	property string format:"yyyy-MM-dd"
	property int min:0
	property int max:0
	property var dataset:[]

	onDatasetChanged:function() {

		for (var i in control.dataset) {
			var item =  control.dataset[i]
			series.append(item.x, item.y)
		}

		if (control.dataset.length > 0) {
			var axisXrange = control.getAxisXRange()
			axisX.min = new Date(axisXrange.min)
			axisX.max = new Date(axisXrange.max)

			var axisYmax = control.getAxisYMax()
			axisY.max = Math.round(axisYmax * 1.2)
		}
	}

	Rectangle {
        id: background
        anchors.fill: parent
        color: "#212121"
    }

	ChartView {
		id:chart
		anchors.fill: parent
	    title: control.title
	    legend.visible: false
	    antialiasing: true
	    backgroundColor:"#212121"
	    titleColor:"#868686"
	    titleFont:Qt.font({family: "Microsoft YaHei"})

	    backgroundRoundness: 0
	    theme:ChartView.ChartThemeDark
	    margins.top: 0
	    margins.bottom: 0
	    margins.left: 0
	    margins.right: 0

	    DateTimeAxis {
	    	id: axisX
	    	format: control.format
	    	color:"#3A3A3A"
	    	labelsColor:"#868686"
	    	gridLineColor:"#3A3A3A"
	    	shadesVisible:false
	    	labelsFont : Qt.font({ family:"Microsoft YaHei"})
	    }

	    ValueAxis {
	    	id: axisY
	    	min:0
	    	color:"#3A3A3A"
	    	labelsColor:"#868686"
	    	gridLineColor:"#3A3A3A"
	    	shadesVisible:false
	    	labelsFont:Qt.font({family:"Microsoft YaHei"})
	    }

	    LineSeries {
	    	id:series
	        name: "LineSeries"
	        axisX: axisX
    		axisY: axisY
    		color:"#F6A821"
    		width:2
	    }
	}

	function getAxisYMax() {
		var max = control.dataset[0].y;
		for (var i in control.dataset) {
			var val = control.dataset[i].y
			if ( val > max)
				max = val
		}
		return max
	}

	function getAxisXRange() {
		var min=control.dataset[0].x, max=control.dataset[0].x;
		for (var i in control.dataset) {
			var val = control.dataset[i].x
			if ( val > max)
				max = val
			if ( val < min)
				min = val
		}
		return {min:min, max:max}
	}
}