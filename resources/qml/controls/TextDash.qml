import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

Item {
	id:control
	width:150
	height:90
	property string desc:""
	property string value:""
	property string unit:""
	property string icon:""
	property int leftWidth : outerRow.width * 0.4
	property int rightWidth : outerRow.width * 0.6
	property int containerHeight: outerRow.height

	Rectangle {
		anchors.fill: parent
        color: "#212121"
    }

    Row {
    	id:outerRow
    	anchors.fill: parent

  		Item {
  			width:control.leftWidth
  			height:control.containerHeight
  			Image {
	    		anchors.centerIn:parent
	    		source:control.icon
	    	}
  		}

  		Item {
  			width:control.rightWidth
  			height:control.containerHeight

  			Column {
		    	// anchors.centerIn: parent
		    	anchors.verticalCenter: parent.verticalCenter
		    	Row {
		    		// anchors.centerIn: parent
		    		spacing:15
		    		Text {
		    			id:valueText
		    			text:control.value
		    			font.pixelSize: 40
						font.family:"Microsoft YaHei"
						font.bold:true
						color:"#ffffff"
		    		}

		    		Text {
		    			anchors.bottom:valueText.baseline
		    			text:control.unit
		    			font.family:"Microsoft YaHei"
		    			font.pixelSize: 14
						font.bold:false
						color:"#868686"
		    		}
		    	}

	    	   Text {
			   		// anchors.right:control.right
			   		// anchors.bottom:control.bottom
					text:control.desc
					font.family:"Microsoft YaHei"
					font.pixelSize: 14
					font.bold:false
					color:"#868686"
					// color:"#F6A821"
				}
		    }
  		} // item2
    }
}