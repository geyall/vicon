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

function get7daysMilesData() {
	var result = []
	for (var i=1; i < 8; i++) {
		var date = new Date(2018,11,i)
		result.push({x:date.getTime(),y:parseFloat(randomNum(11.0,15.0,1))})
	}
	return result
}

function get30daysMilesData() {
	var result = []
	for (var i=1; i < 31; i++) {
		var date = new Date(2018,11,i)
		result.push({x:date.getTime(),y:parseFloat(randomNum(11.0,15.0,1))})
	}
	return result
}

function get7dayOilWearData() {
	var result = []
	for (var i=1; i < 8; i++) {
		var date = new Date(2018,11,i)
		result.push({x:date.getTime(),y:parseFloat(randomNum(1.0,2.5,1))})
	}
	return result
}

function get30dayOilWearData() {
	var result = []
	for (var i=1; i < 31; i++) {
		var date = new Date(2018,11,i)
		result.push({x:date.getTime(),y:parseFloat(randomNum(1.0,2.5,1))})
	}
	return result
}