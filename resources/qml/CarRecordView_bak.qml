import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtWebEngine 1.7
import QtWebChannel 1.0
import Rand 1.0

Page {
	id:carRecordView
	anchors.fill: parent
	property int margin:10

	Item {
		anchors.fill: parent
		anchors.margins: margin

		WebEngineView {
			anchors.fill: parent
			url:"qrc:///web/carRecordView.html"
			webChannel:channel
		}
	}

	WebChannel {
	    id: channel
	    registeredObjects: [controller]
	}

	Rand {
		id:random
	}

	QtObject {
		id:controller
		WebChannel.id: "carRecordViewController"

		function getPath() {
			return  [{"x":106.6621950000,"y":26.6271700000},
					 {"x":106.6622350000,"y":26.6271700000},
					 {"x":106.7329920000,"y":26.6110190000},
					 {"x":106.7739370000,"y":26.6371410000},
					 {"x":106.7786660000,"y":26.6372330000}]
		}

		function get7daysMilesData() {
			var result = {x:[],dataset:[]}
			for (var i=1; i < 8; i++) {
				result.x.push('11-' + i)
				result.dataset.push(random.uniform(11.0,15.0))
			}
			return result
		}

		function get30daysMilesData() {
			var result = {x:[],dataset:[]}
			for (var i=1; i < 31; i++) {
				result.x.push('11-' + i)
				result.dataset.push(random.uniform(11.0,15.0))
			}
			return result
		}

		function get7dayOilWearData() {
			var result = {x:[],dataset:[]}
			for (var i=1; i < 8; i++) {
				result.x.push('11-' + i)
				result.dataset.push(random.uniform(1.0,2.5))
			}
			return result
		}

		function get30dayOilWearData() {
			var result = {x:[],dataset:[]}
			for (var i=1; i < 31; i++) {
				result.x.push('11-' + i)
				result.dataset.push(random.uniform(1.0,2.5))
			}
			return result
		}
	}
}