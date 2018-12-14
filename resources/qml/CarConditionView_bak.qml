import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtWebEngine 1.7
import QtWebChannel 1.0
import Rand 1.0

Page {
	id:carConditionView
	anchors.fill: parent
	property int margin:10

	Item {
		anchors.fill: parent
		anchors.margins: margin

		WebEngineView {
			anchors.fill: parent
			url:"qrc:///web/carConditionView.html"
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
		WebChannel.id: "carConditionViewController"
	}

}