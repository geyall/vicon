(function(){

var controller;

window.onload = function() {
    new QWebChannel(qt.webChannelTransport, function(channel) {
	    controller = channel.objects.carConditionViewController;

	    var rsChart = createRotationlSpeed(1400)
		var csChart = createCarSpeed(40)
		var ctChart = createCoolantTemp(60)
		var itChart = createIntakeTemp(29)
		var ttChart = createTransTemp(90)
		var otChart = createOilTemp(65)
		var omChart = createOilMass(33)
		var bvChart = createBetteryVoltage(10)
		var ovChart = createO2sVoltage(0.6)
		var taChart = createThrottleAngle(4)


		setInterval(function(){
			csChart.setData(randomNum(45,55))
			omChart.setData(randomNum(30,35))
			bvChart.setData(randomNum(9,12))
			ovChart.setData(randomNum(4,7)/10)
			taChart.setData(randomNum(2,5))
			rsChart.setData(randomNum(1000,1500))

			ctChart.setData(randomNum(50,70))
			itChart.setData(randomNum(25,35))
			ttChart.setData(randomNum(78,100))
			otChart.setData(randomNum(60,80))
		},1000)
	});			
}

function randomNum(maxNum, minNum, decimalNum) {
    var max = 0, min = 0;
    minNum <= maxNum ? (min = minNum, max = maxNum) : (min = maxNum, max = minNum);
    switch (arguments.length) {
        case 1:
            return Math.floor(Math.random() * (max + 1));
            break;
        case 2:
            return Math.floor(Math.random() * (max - min + 1) + min);
            break;
        case 3:
            return (Math.random() * (max - min) + min).toFixed(decimalNum);
            break;
        default:
            return Math.random();
            break;
    }
}

function createOilTemp(data) {
	var chart = new Thermometer({id:'oilTemp',title:'机油温度',data:data, max:120})
	chart.render()
	return chart
}

function createTransTemp(data) {
	var chart = new Thermometer({id:'transTemp',title:'变速箱温度',data:data, max:120})
	chart.render()
	return chart
}

function createIntakeTemp(data) {
	var chart = new Thermometer({id:'intakeTemp',title:'进气温度',data:data})
	chart.render()
	return chart
}


function createCoolantTemp(data) {
	var chart = new Thermometer({id:'coolantTemp',title:'冷却液温度',data:data})
	chart.render()
	return chart
}

function createCarSpeed(data) {
	var chart = new Gauge({id:'carSpeed',title:"当前车速", max:200, data:data, unit:"公里/小时"})
	chart.render()
	return chart
}

function createOilMass(data) {
	var chart = new Gauge({id:'oilMass',title:"剩余油量", max:100, data:data, unit:"百分比"})
	chart.render()
	return chart
}


function createBetteryVoltage(data) {
	var chart = new Gauge({id:'betteryVoltage',title:"蓄电池电压", max:20, data:data, unit:"伏特"})
	chart.render()
	return chart
}

function createO2sVoltage(data) {
	var chart = new Gauge({id:'o2sVoltage',title:"后氧传感器电压", max:1, data:data, unit:"伏特"})
	chart.render()
	return chart
}

function createThrottleAngle(data) {
	var chart = new Gauge({id:'throttleAngle',title:"节气门开度", max:100, data:data, unit:"百分比"})
	chart.render()
	return chart
}

function createRotationlSpeed(data) {
	// var chart = echarts.init(document.getElementById('rotationlSpeed'));
	// var option = echartsTemplate.gauge('rotationlSpeed',"发送机转速", 5000, data, "转/分钟")
	// chart.setOption(option)
	var chart = new Gauge({id:'rotationlSpeed',title:"发送机转速", max:5000, data:data, unit:"转/分钟"})
	chart.render()
	return chart
}

})()

