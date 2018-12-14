import QtQuick 2.6
import QtQuick.Controls 2.1

Item {
	id:control
	width:150
	height:50
	property string icon
	property string text
	property int fontSize:24

	Rectangle {
		id:background
		height:100
		width:150
		anchors.left: parent.left
        anchors.top: parent.top
		anchors.fill:parent
		color:"#F6A821"
	}

	Text {
		anchors.centerIn:parent
		text:control.text
		color:"#FFFFFF"
		font.pixelSize: control.fontSize
		font.family:"Microsoft YaHei"
		font.bold:true
	}
}