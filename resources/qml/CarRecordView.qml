import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtCharts 2.2
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
		columns:6
		rows:10
		columnSpacing:10
		rowSpacing:10
		property double colMulti : (grid.width - controlView.margin*2) / grid.columns
	    property double rowMulti : (grid.height - controlView.margin*2 - grid.rowSpacing) / grid.rows

	    function prefWidth(item){
	        return colMulti * item.Layout.columnSpan
	    }
	    function prefHeight(item){
	        return rowMulti * item.Layout.rowSpan
	    }

	    CustomControl.TextDash {
	    	value:"12"
	    	desc:"今日里程"
	    	unit:"公里"
	    	icon:"qrc:///img/path2.png"
	    	Layout.rowSpan   : 2
            Layout.columnSpan: 2
		    Layout.preferredWidth  : grid.prefWidth(this)
       	    Layout.preferredHeight : grid.prefHeight(this)
       	    //Layout.alignment:Qt.AlignTop
	    }

	    CustomControl.TextDash {
	    	value:"3.1k"
	    	desc:"总里程"
	    	unit:"公里"
	    	icon:"qrc:///img/path.png"
	    	Layout.rowSpan   : 2
            Layout.columnSpan: 2
		    Layout.preferredWidth  : grid.prefWidth(this)
       	    Layout.preferredHeight : grid.prefHeight(this)
       	    //Layout.alignment:Qt.AlignTop
	    }

	    CustomControl.TextDash {
	    	value:"36"
	    	desc:"平均时速"
	    	unit:"公里/小时"
	    	icon:"qrc:///img/avgspeed.png"
	    	Layout.rowSpan   : 2
            Layout.columnSpan: 2
		    Layout.preferredWidth  : grid.prefWidth(this)
       	    Layout.preferredHeight : grid.prefHeight(this)
       	    //Layout.alignment:Qt.AlignTop
	    }

	    CustomControl.TextDash {
	    	value:"60"
	    	desc:"最高时速"
	    	unit:"公里/小时"
	    	icon:"qrc:///img/maxspeed.png"
	    	Layout.rowSpan   : 2
            Layout.columnSpan: 2
		    Layout.preferredWidth  : grid.prefWidth(this)
       	    Layout.preferredHeight : grid.prefHeight(this)
       	    //Layout.alignment:Qt.AlignTop
	    }

	    CustomControl.TextDash {
	    	value:"1.2"
	    	desc:"今日油耗"
	    	unit:"升"
	    	icon:"qrc:///img/oil2.png"
	    	Layout.rowSpan   : 2
            Layout.columnSpan: 2
		    Layout.preferredWidth  : grid.prefWidth(this)
       	    Layout.preferredHeight : grid.prefHeight(this)
       	    //Layout.alignment:Qt.AlignTop
	    }

	    CustomControl.TextDash {
	    	value:"9.1"
	    	desc:"平均油耗"
	    	unit:"升/百公里"
	    	icon:"qrc:///img/oils.png"
	    	Layout.rowSpan   : 2
            Layout.columnSpan: 2
		    Layout.preferredWidth  : grid.prefWidth(this)
       	    Layout.preferredHeight : grid.prefHeight(this)
       	    //Layout.alignment:Qt.AlignTop
	    }

	    CustomControl.LineQChart {
	    	id: sevenDayMiles
	    	title:"7日里程统计(公里)"
	    	format:"yyyy-MM-dd"
	    	Layout.rowSpan   : 3
            Layout.columnSpan: 3
		    Layout.preferredWidth  : grid.prefWidth(this) + grid.columnSpacing/2
       	    Layout.preferredHeight : grid.prefHeight(this)
       	    //Layout.alignment:Qt.AlignTop
	    }

	    CustomControl.LineQChart {
	    	id: thirtyDayMiles
	    	title:"30日里程统计(公里)"
	    	format:"yyyy-MM-dd"
	    	Layout.rowSpan   : 3
            Layout.columnSpan: 3
		    Layout.preferredWidth  : grid.prefWidth(this) + grid.columnSpacing/2
       	    Layout.preferredHeight : grid.prefHeight(this)
       	    //Layout.alignment:Qt.AlignTop
	    }

	    CustomControl.LineQChart {
	    	id: sevenDayOilWear
	    	title:"7日油耗统计(升)"
	    	format:"yyyy-MM-dd"
	    	Layout.rowSpan   : 3
            Layout.columnSpan: 3
		    Layout.preferredWidth  : grid.prefWidth(this) + grid.columnSpacing/2
       	    Layout.preferredHeight : grid.prefHeight(this)
       	    //Layout.alignment:Qt.AlignTop
	    }

	    CustomControl.LineQChart {
	    	id: thirtyDayOilWear
	    	title:"30日油耗统计(升)"
	    	format:"yyyy-MM-dd"
	    	Layout.rowSpan   : 3
            Layout.columnSpan: 3
		    Layout.preferredWidth  : grid.prefWidth(this) + grid.columnSpacing/2
       	    Layout.preferredHeight : grid.prefHeight(this)
       	    //Layout.alignment:Qt.AlignTop
	    }
	}

	Component.onCompleted:{
		sevenDayMiles.dataset = TestJs.get7daysMilesData()
		thirtyDayMiles.dataset = TestJs.get30daysMilesData()
		sevenDayOilWear.dataset = TestJs.get7dayOilWearData()
		thirtyDayOilWear.dataset = TestJs.get30dayOilWearData()
	}
}