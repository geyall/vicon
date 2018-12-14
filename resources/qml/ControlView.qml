import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Window 2.11
import "controls" as CustomControl

Page {
	id:controlView
	anchors.fill: parent
	property int margin:15


	RowLayout {
		id:rowlayout
		anchors.fill: parent
		anchors.margins: margin
		spacing:10

        CameraPlayer {
        	id:videoPlayer
        	Layout.fillHeight: true	
        	width:Screen.desktopAvailableWidth*0.8
        }

		CustomControl.ControlBox {
			id:buttonPane
			Layout.fillWidth: true
			Layout.fillHeight: true	

			ColumnLayout {
				spacing:20
				width: (parent.width - 30)
				anchors.margins:15
				anchors.left: parent.left
            	anchors.top: parent.top
				
				CustomControl.ControlButton {
	                text: "停止"
	                color:"red"
	                icon:"qrc:///img/stop.png"
	                Layout.fillWidth: true
	                onClicked:console.log(123)
	            }

	            CustomControl.ControlButton {
	                text: "升起"
	                icon:"qrc:///img/up-arrow.png"
	                Layout.fillWidth: true
	            }

	            CustomControl.ControlButton {
	                text: "下落"
	                icon:"qrc:///img/down-arrow.png"
	                Layout.fillWidth: true
	            }

	            CustomControl.ControlButton {
	                text: "打开"
	                icon:"qrc:///img/open-box.png"
	                Layout.fillWidth: true
	            }

	            CustomControl.ControlButton {
	                text: "关闭"
	                icon:"qrc:///img/closed-box.png"
	                Layout.fillWidth: true
	            }

	            CustomControl.ControlButton {
	                text: "灯光"
	                icon:"qrc:///img/spotlight.png"
	                Layout.fillWidth: true
	            }
	        }
		} //control box
	}
}