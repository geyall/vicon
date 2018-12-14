import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import "controls" as CustomControl

ApplicationWindow {
	id:autoCenterApp
    visible: true
    title: qsTr("AutoCenter")

    Loader { 
    	id: viewLoader
    	anchors.fill: parent
    	asynchronous:true
    	visible: status == Loader.Ready
    }

    CustomControl.BusyIndicator {
        id: indicator
        height:64
        width:64
        anchors.centerIn:parent
        running: viewLoader.status == Loader.Loading
    }

    header: ToolBar {

        RowLayout {
        	spacing:15

            Image {
			    source: "qrc:///img/logo.png"
			}

			ToolButton {
            	text:qsTr("主控")
            	icon.name:"control"
            	icon.color:"#F6A821"
            	onClicked:viewLoader.source = "qrc:///qml/ControlView.qml"
            }

            ToolButton {
            	text:qsTr("故障诊断")
            	icon.name:"diagnostic"
            	icon.color:"#F6A821"
            }

            ToolButton {
            	text:qsTr("行车记录")
            	icon.name:"gps"
            	icon.color:"#F6A821"
            	onClicked:viewLoader.source = "qrc:///qml/CarRecordView.qml"
            }

            ToolButton {
            	text:qsTr("实时车况")
            	icon.name:"dashboard"
            	icon.color:"#F6A821"
                onClicked:viewLoader.source = "qrc:///qml/CarConditionView.qml"
            }

            ToolButton {
            	text:qsTr("系统设置")
            	icon.name:"settings"
            	icon.color:"#F6A821"
                // onClicked:viewLoader.source = "qrc:///qml/Dashboard.qml"
            }
        }
    }

    Component.onCompleted: {
        // autoCenterApp.showFullScreen();
        autoCenterApp.showMaximized();
        viewLoader.source = "qrc:///qml/ControlView.qml"
    }
}