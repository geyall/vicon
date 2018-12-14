import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtMultimedia 5.8

Item {
	id: videoPlayer
	// state: "PAUSE"

	VideoOutput {
		anchors.fill: parent
		source: camera
	}

	Camera {
		id: camera
	}

	Timer {
		id:timer
		repeat:false
	}

	function setTimeout(callback,delayTime) {
	   timer.interval = delayTime;
	   timer.triggered.connect(callback);
	   timer.start();
	}

	MouseArea {
		anchors.fill: parent

		onClicked: {
			if (camera.cameraStatus == Camera.ActiveStatus){
				coverLayer.visible = true
				setTimeout(function(){
					coverLayer.visible = false
				},4000)
			}
		}
	}

	Rectangle {
		id:coverLayer
		anchors.fill: parent
		color: Qt.rgba(0.7,0.7,0.7,0.2)
		property int imgWidth :coverLayer.width*0.1

		Rectangle {
			id:playerButton
			anchors.horizontalCenter:parent.horizontalCenter
			anchors.verticalCenter:parent.verticalCenter
			width:parent.imgWidth
			height:parent.imgWidth
			radius:parent.imgWidth/2
			color: Qt.rgba(0,0,0,0.3)
			Image {
				id:buttonImage
				sourceSize.width: parent.width/2
				sourceSize.height: parent.height/2
				anchors.horizontalCenter:parent.horizontalCenter
				anchors.verticalCenter:parent.verticalCenter
				source:"qrc:///img/play-button.png"
			}

			MouseArea {
				anchors.fill: parent
				onClicked: {
					if (camera.cameraStatus == Camera.ActiveStatus){
						camera.stop()
						timer.stop()
						videoPlayer.state = "PAUSE"
						// coverLayer.visible = true
						// buttonImage.source = "qrc:///img/play-button.png"
					}
					else {
						camera.start()
						videoPlayer.state = "PLAY"
						// coverLayer.visible = false
						// buttonImage.source = "qrc:///img/pause-button.png"
					}
				}
			}
		}
	}

	states: [
		State {
			name: "PLAY"
			PropertyChanges { target: buttonImage; source: "qrc:///img/pause-button.png" }
			PropertyChanges { target: coverLayer; visible: false }
		},

		State {
			name: "PAUSE"
			PropertyChanges { target: buttonImage; source: "qrc:///img/play-button.png" }
			PropertyChanges { target: coverLayer; visible: true }
		}
	]
	
	Component.onCompleted: {
        camera.stop()
    }
}



