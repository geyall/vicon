(function(){

var controller;
var bmap;

window.onload = function() {
    new QWebChannel(qt.webChannelTransport, function(channel) {
	    controller = channel.objects.carRecordViewController;
	    createMap()

	    controller.getPath(function(data){
	    	drawPath(data)
	    })

	    controller.get7dayOilWearData(function(data){
	    	create7OilWearChart(data)
	    })

	    controller.get30dayOilWearData(function(data){
	    	create30OilWearChart(data)
	    })

	    controller.get7daysMilesData(function(data){
	    	create7daysMilesChart(data)
	    })

	    controller.get30daysMilesData(function(data){
	    	create30daysMilesChart(data)
	    })
	});			
}

function create30OilWearChart(data) {
	var chart = echarts.init(document.getElementById('30dayOilWear'));
	var option = echartsTemplate.line()
	option.title.text = '30日油耗统计(升)'
	option.series[0].data = data.dataset
	option.xAxis.data = data.x

	chart.setOption(option);
}

function create7OilWearChart(data) {
	var chart = echarts.init(document.getElementById('7dayOilWear'));
	var option = echartsTemplate.line()
	option.title.text = '7日油耗统计(升)'
	option.series[0].data = data.dataset
	option.xAxis.data = data.x
	chart.setOption(option);
}

function create30daysMilesChart(data) {
	var chart = echarts.init(document.getElementById('30dayMiles'));
	var option = echartsTemplate.line()
	option.title.text = '30日里程统计(公里)'
	option.series[0].data = data.dataset
	option.xAxis.data = data.x

	chart.setOption(option);
}

function create7daysMilesChart(data) {
	var chart = echarts.init(document.getElementById('7dayMiles'));
	var option = echartsTemplate.line()
	option.title.text = '7日里程统计(公里)'
	option.series[0].data = data.dataset
	option.xAxis.data = data.x
	chart.setOption(option);
}

function addMarker(point,name){
	var marker = new BMap.Marker(point);
	var label = new BMap.Label(name, {
		offset : new BMap.Size(20, -10)
	});
	marker.setLabel(label);
	bmap.addOverlay(marker);
}

function createMap() {
	bmap = new BMap.Map('map_canvas');
	bmap.setMapStyle({style:'dark'});
	bmap.enableScrollWheelZoom();
}

function drawPath(data) {
	var p = Math.ceil(data.length / 2);
	bmap.centerAndZoom(new BMap.Point(data[p].x, data[p].y), 13);
	var driving;
	for(var i in data){
		if(i == 0 ){
			addMarker(new BMap.Point(data[i].x, data[i].y),"起点");
			continue;
		}
		driving = new BMap.DrivingRoute(bmap, {renderOptions:{map: bmap, autoViewport: false}, 
        onMarkersSet:function(routes) {
            bmap.removeOverlay(routes[0].marker); //删除API自带起点
            bmap.removeOverlay(routes[1].marker); //删除API自带终点
        }});
        driving.search(new BMap.Point(data[i-1].x, data[i-1].y), 
				new BMap.Point(data[i].x, data[i].y));
        if(i == data.length -1){
			addMarker(new BMap.Point(data[i].x, data[i].y),"终点");
        }
	}
}

})()

