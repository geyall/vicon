//Chart基类定义 开始
//构造函数参数：id
function Chart(props) {
	this.id = props.id
	this.container = document.getElementById(this.id)
	this.echart = null
    if (this.container)
        this.echart = echarts.init(this.container)
    this.option = {}
}

Chart.prototype.render = function(){
	this.echart.setOption(this.option)
}
//Chart基类定义 结束


//Gauge 图表定义 开始
//构造函数：id, title, max, data, unit
function Gauge(props) {
	 Chart.call(this, props)
	 this.title = props.title
	 this.data = props.data
	 this.max = props.max || 100
	 this.unit = props.unit || '百分比'
	 this.option = {
	    title: {
	        text: this.title,
	        textStyle: {
	            color: '#868686',
	            fontFamily: 'Microsoft YaHei',
	            fontWeight: 'bold',
	            fontSize: 14
	        },
	        left: 'center',
	        top: 4
	    },
	    grid: {
	        top: 0,
	        right: 0,
	        left: 0,
	        bottom: 0
	    },
	    xAxis: {
	        show: false,
	        type: 'value',
	        min: 0,
	        max: this.getGaugeContainerSize().width,
	    },
	    yAxis: {
	        show: false,
	        min: 0,
	        max: this.getGaugeContainerSize().height,
	    },
	    series: [
	        //////////////////////////////////////////////////
	        {
	            type: 'line',
	            animation: false,
	            showSymbol: false,
	            lineStyle: {
	                normal: {
	                    color: "#000"
	                }
	            },
	            areaStyle: {
	                normal: {
	                    color: "#000",
	                    opacity: 1
	                }
	            },
	            data: this.getGaugeBkLineData(0)
	        }, {
	            type: 'line',
	            showSymbol: false,
	            animation: false,
	            lineStyle: {
	                normal: {
	                    color: "#212121"
	                }
	            },
	            areaStyle: {
	                normal: {
	                    color: "#212121",
	                    opacity: 1
	                }
	            },
	            data: this.getGaugeBkLineData(1)
	        }, {
	            type: 'pie',
	            z: 1,
	            legendHoverLink: false,
	            hoverAnimation: false,
	            animation: false,
	            startAngle: 225,
	            labelLine: {
	                normal: {
	                    show: false
	                }
	            },
	            center: ['50%', '60%'],
	            radius: [0, '90%'],
	            data: [{
	                value: 270,
	                itemStyle: {
	                    normal: {
	                        color: "#000"
	                    }
	                }
	            }, {
	                value: 90,
	                itemStyle: {
	                    normal: {
	                        color: "transparent"
	                    }
	                }
	            }]
	        },

	        //////////////////////////////////////////////////
	        {
	            name: 'outer',
	            type: 'gauge',
	            min: 0,
	            max: this.max,
	            z: 2,
	            splitNumber: 10,
	            radius: '90%',
	            center: ['50%', '60%'],
	            axisLine: {
	                lineStyle: {
	                    width: 5,
	                    color: [
	                        [1, '#868686']
	                    ]
	                }
	            },
	            axisLabel: {
	                show: false,
	            },
	            axisTick: {
	                length: 0
	            },
	            splitLine: {
	                length: 0
	            },
	            title: {
	                show: false
	            },
	            detail: {
	                show: false
	            },
	            data: []
	        }, {
	            name: 'inner',
	            type: 'gauge',
	            z: 3,
	            min: 0,
	            max: this.max,
	            splitNumber: 10,
	            radius: '86%',
	            center: ['50%', '60%'],
	            axisLine: {
	                lineStyle: {
	                    width: 5,
	                    color: [
	                        [1, '#F6A821']
	                    ]
	                }
	            },
	            axisLabel: {
	                show: false
	            },
	            axisTick: {
	                length: 0
	            },
	            splitLine: {
	                length: 0
	            },
	            title: {
	                show: false
	            },
	            detail: {
	                show: false
	            },
	            data: []
	        }, {
	            name: 'tick',
	            type: 'gauge',
	            z: 5,
	            min: 0,
	            max: this.max,
	            splitNumber: 10,
	            radius: '82%',
	            center: ['50%', '60%'],
	            axisLine: {
	                show: true,
	                lineStyle: {
	                    width: 5,
	                    color: [
	                        [1, 'transparent']
	                    ]
	                }
	            },
	            axisTick: {
	                length: 12,
	                lineStyle: {
	                    width: 1,
	                    color: '#F6A821'
	                }
	            },
	            axisLabel: {
	                show: true,
	                color: '#868686'
	            },
	            splitLine: {
	                length: 20,
	                lineStyle: {
	                    width: 2,
	                    color: '#F6A821'
	                }
	            },
	            pointer: {
	                width: 5
	            },
	            itemStyle: {
	                normal: {
	                    color: "#F6A821",
	                }
	            },
	            title: {
	                textStyle: {
	                    fontWeight: 'bolder',
	                    fontSize: 14,
	                    fontStyle: 'italic',
	                    color: '#868686'
	                }
	            },
	            detail: {
	                textStyle: {
	                    color: '#FFFFFF',
	                    fontWeight: 'bolder',
	                    fontSize: 16
	                }
	            },
	            data: [{
	                value: this.data,
	                name: this.unit
	            }]
	        }
	    ]
	}
}

Gauge.prototype = new Chart({id:null})
Gauge.prototype.constructor = Gauge

Gauge.prototype.setData = function(data) {
	var opt = this.echart.getOption()
	this.data = data
	opt.series[5].data[0].value = this.data
	this.option = opt
	this.render()
}

Gauge.prototype.getGaugeContainerSize = function() {
	return {width:this.container.clientWidth, height:this.container.clientHeight}
}

Gauge.prototype.getGaugeBkLineData = function (index) {
	var containerSize = this.getGaugeContainerSize()
	var width = containerSize.width
	var height = containerSize.height
	var outerGaugeRadius = 0.9
	var gaugeCenterY = 0.6
	var gaugeCenterX = 0.5

	var radius = (width > height) ? (height/2)*outerGaugeRadius : (width*outerGaugeRadius)/2
	var centerY = height*(1-gaugeCenterY)
	var centerX = width*gaugeCenterX
	var sideLength = Math.sqrt((radius*radius)/2)

	var startX = width/2 - sideLength
	var startY = centerY - sideLength

	if (index == 0) 
		return [[startX,startY],[centerX,centerY],[startX+sideLength*2,startY]]
	else
		return [[startX-1,startY],[startX+sideLength*2+1,startY]]
}
//Gauge 图表定义 结束

//Thermometer 图表定义 开始
//构造函数：id, title, data, max, margin
function Thermometer(props) {
	 Chart.call(this, props)
	 this.title = props.title
	 this.data = props.data
	 this.max = props.max || 100
	 this.margin = props.margin || 30
	 var that = this
	 this.option = {
		    title: {
		        text: this.title,
		        textStyle: {
		            color: '#868686',
		            fontFamily: 'Microsoft YaHei',
		            fontWeight: 'bold',
		            fontSize: 14
		        },
		        left: 'center',
		        top: 4
		    },
		    grid: {
		        top: '16%',
		        right: 0,
		        left: 0,
		        bottom: '18%'
		    },
		    yAxis: [{
		        show: false,
		        min: 0,
		        max: this.max + this.margin
		    }, {
		        show: false,
		        data: [],
		        min: 0,
		        max: this.max + this.margin
		    }],
		    xAxis: [{
		        show: false,
		        data: []
		    }, {
		        show: false,
		        data: []
		    }, {
		        show: false,
		        data: []
		    }, {
		        show: false,
		        min: -100,
		        max: 100,
		    }],
		    series: [{
		        name: '条',
		        type: 'bar',
		        // 对应上面XAxis的第一个对象配置
		        xAxisIndex: 0,
		        data: [this.data + this.margin],
		        barWidth: 12,
		        itemStyle: {
		            normal: {
		                color: "#F6A821",
		                barBorderRadius: 0,
		            }
		        },
		        label: {
		            normal: {
		                show: true,
		                position: 'top',
		                formatter: function (param) {
		                        return param.value - 30 + '°C';
		                    },
		                    textStyle: {
		                        color: '#FFFFFF',
		                        fontSize: '10',
		                        fontWeight: 'bold'
		                    }
		            }
		        },
		        z: 2
		    }, {
		        name: '白框',
		        type: 'bar',
		        xAxisIndex: 1,
		        barGap: '-100%',
		        data: [this.max + this.margin - 2],
		        barWidth: 30,
		        itemStyle: {
		            normal: {
		                color: '#000000',
		                barBorderRadius: 50,
		            }
		        },
		        z: 1
		    }, {
		        name: '外框',
		        type: 'bar',
		        xAxisIndex: 2,
		        barGap: '-100%',
		        data: [this.max + this.margin],
		        barWidth: 35,
		        itemStyle: {
		            normal: {
		                color: "#868686",
		                barBorderRadius: 50,
		            }
		        },
		        z: 0
		    }, {
		        name: '圆',
		        type: 'scatter',
		        hoverAnimation: false,
		        data: [0],
		        xAxisIndex: 0,
		        symbolSize: 35,
		        itemStyle: {
		            normal: {
		                color: '#F6A821',
		                opacity: 1,
		            }
		        },
		        z: 2
		    }, {
		        name: '白圆',
		        type: 'scatter',
		        hoverAnimation: false,
		        data: [0],
		        xAxisIndex: 1,
		        symbolSize: 55,
		        itemStyle: {
		            normal: {
		                color: '#000000',
		                opacity: 1,
		            }
		        },
		        z: 1
		    }, {
		        name: '外圆',
		        type: 'scatter',
		        hoverAnimation: false,
		        data: [0],
		        xAxisIndex: 2,
		        symbolSize: 60,
		        itemStyle: {
		            normal: {
		                color: "#868686",
		                opacity: 1,
		            }
		        },
		        z: 0
		    }, {
		        name: '刻度',
		        type: 'bar',
		        yAxisIndex: 1,
		        xAxisIndex: 3,
		        label: {
		            normal: {
		                show: true,
		                position: 'right',
		                distance: 10,
		                color: '#868686 ',
		                fontSize: 10,
		                formatter: function (params) {
		                    // 因为柱状初始化为0，温度存在负值，所以，原本的0-100，改为0-130，0-30用于表示负值
		                    if (params.dataIndex > that.max || params.dataIndex < that.margin) {
		                        return '';
		                    } else {
		                        if (params.dataIndex % 10 === 0) {
		                            return params.dataIndex - that.margin;
		                        } else {
		                            return '';
		                        }
		                    }
		                }
		            }
		        },
		        barGap: -100,
		        data: this.createThermometerScale(),
		        barWidth: 1,
		        itemStyle: {
		            normal: {
		                color: '#868686',
		                barBorderRadius: 10,
		            }
		        },
		        z: 0
		    }]
		}
}

Thermometer.prototype = new Chart({id:null})
Thermometer.prototype.constructor = Thermometer

Thermometer.prototype.setData = function(data) {
	var opt = this.echart.getOption()
	this.data = data
	opt.series[0].data[0] = this.data + this.margin
	this.option = opt
	this.render()
}

Thermometer.prototype.getScaleUnit = function() {
  return {width:this.container.clientWidth/200,height:this.container.clientHeight/(this.max + this.margin)}
}

Thermometer.prototype.createThermometerScale = function() {
  var kd = [];
  var unit = this.getScaleUnit()

  var longTick = (35/unit.width)/2 + (5/unit.width)*2
  var shortTick = (35/unit.width)/2 + (5/unit.width)*1

  var len = this.max + this.margin
  for (var i = 0; i <= len; i++) {
      if (i > this.max || i < this.margin) {
          kd.push(0)
      } else {
          if (i % 10 === 0) {
              kd.push(longTick)
          } else {
              if (unit.height>2)
                kd.push(shortTick)
              else
                kd.push(0)
          }
      }
  }

  return kd
}
//Thermometer 图表定义 结束
