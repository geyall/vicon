function getGaugeContainerSize(id) {
	var container = document.getElementById(id)
	return {width:container.clientWidth, height:container.clientHeight}
}

function getGaugeBkLineData(id, index) {
	// var container = document.getElementById(id)
	// var width = container.clientWidth;
	// var height = container.clientHeight;
	var containerSize = getGaugeContainerSize(id)
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

//////////////////////////////////////////////////////////////////////
// var ThermometerMax = 100
// var ThermometerMargin = 30

function getScaleUnit(id, max, margin) {
  var container = document.getElementById(id)
  return {width:container.clientWidth/200,height:container.clientHeight/(max + margin)}
}

function createThermometerScale(id, max, margin) {
  var kd = [];
  var unit = getScaleUnit(id, max, margin)
  var longTick = (35/unit.width)/2 + (5/unit.width)*2
  var shortTick = (35/unit.width)/2 + (5/unit.width)*1

  var len = max + margin
  // 刻度使用柱状图模拟，短设置3，长的设置5；构造一个数据
  for (var i = 0; i <= len; i++) {
      if (i > max || i < margin) {
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

//////////////////////////////////////////////////////////////////////

var echartsTemplate = {
	thermometer:function(id, title, data, max, margin){
		if (max == undefined || max == null)
			max = 100
		if (margin == undefined || margin == null)
			margin = 30

		return {
			    title:{
			      text:title,
			      textStyle:{
			        color:'#868686',
			        fontFamily:'Microsoft YaHei',
			        fontWeight:'bold',
			        fontSize:14 
			      },
			      left:'center',
			          top:4
			    },
			    grid:{
			        top:'16%',
			        right:0,
			        left:0,
			        bottom:'18%'
			    },
			    yAxis: [{
			        show: false,
			        min: 0,
			        max: max + margin
			    }, {
			        show: false,
			        data: [],
			        min: 0,
			        max: max + margin
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
			    series:[
			      {
			        name: '条',
			        type: 'bar',
			        // 对应上面XAxis的第一个对象配置
			        xAxisIndex: 0,
			        data: [data + margin],
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
			                formatter: function(param) {
			                    // 因为柱状初始化为0，温度存在负值，所以，原本的0-100，改为0-130，0-30用于表示负值
			                    return param.value - 30 + '°C';
			                },
			                textStyle: {
			                    color: '#FFFFFF',
			                    fontSize: '10',
			                    fontWeight:'bold'
			                }
			            }
			        },
			        z: 2
			      },
			      {
			        name: '白框',
			        type: 'bar',
			        xAxisIndex: 1,
			        barGap: '-100%',
			        data: [max + margin -2],
			        barWidth: 30,
			        itemStyle: {
			            normal: {
			                color: '#000000',
			                barBorderRadius: 50,
			            }
			        },
			        z: 1
			      },
			      {
			        name: '外框',
			        type: 'bar',
			        xAxisIndex: 2,
			        barGap: '-100%',
			        data: [max + margin],
			        barWidth: 35,
			        itemStyle: {
			            normal: {
			                color: "#868686",
			                barBorderRadius: 50,
			            }
			        },
			        z: 0
			      },
			      {
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
			      },
			      {
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
			     }, 
			     {
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
			      },
			      {
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
			                formatter: function(params) {
			                    // 因为柱状初始化为0，温度存在负值，所以，原本的0-100，改为0-130，0-30用于表示负值
			                    if (params.dataIndex > max || params.dataIndex < margin) {
			                        return '';
			                    } else {
			                        if (params.dataIndex % 10 === 0) {
			                            return params.dataIndex - margin;
			                        } else {
			                            return '';
			                        }
			                    }
			                }
			            }
			        },
			        barGap: -100,
			        data: createThermometerScale(id, max, margin),
			        barWidth: 1,
			        itemStyle: {
			            normal: {
			                color: '#868686',
			                barBorderRadius: 10,
			            }
			        },
			        z: 0
			     }
			    ]
			}
	},
	gauge:function(id, title, max, data, unit) {
		return {
		  title:{
		      text:title,
		      textStyle:{
		        color:'#868686',
		        fontFamily:'Microsoft YaHei',
		        fontWeight:'bold',
		        fontSize:14 
		      },
		      left:'center',
		      top:4
		    },
		grid:{
		    top:0,
		    right:0,
		    left:0,
		    bottom:0
		  },
		xAxis:{
	      show:false,
	      type:'value',
	      min:0,
	      max:getGaugeContainerSize(id).width,
	    },
	  	yAxis:{
	      show:false,
	      min:0,
	      max:getGaugeContainerSize(id).height,
	  	},
	    series : [
	    //////////////////////////////////////////////////
	    {
	      type:'line',
	      animation:false,
	      showSymbol:false,
	      lineStyle:{
	         normal:{
	          color:"#000"
	        }
	      },
	      areaStyle:{
	        normal:{
	          color:"#000",
	          opacity:1
	        }
	      },
	      data:getGaugeBkLineData(id,0)
	    },
	    {
	      type:'line',
	      showSymbol:false,
	      animation:false,
	      lineStyle:{
	         normal:{
	          color:"#212121"
	        }
	      },
	      areaStyle:{
	        normal:{
	          color:"#212121",
	          opacity:1
	        }
	      },
	      data:getGaugeBkLineData(id,1)
	    },
	    {
	      type:'pie',
	      z:1,
	      legendHoverLink:false,
	      hoverAnimation:false,
	      animation:false,
	      startAngle:225,
	      labelLine:{
	        normal:{
	          show:false
	        }
	      },
	      center:['50%','60%'],
	      radius:[0,'90%'],
	      data:[
	        {
	          value:270, 
	          itemStyle:{
	            normal:{
	              color:"#000"
	            }
	          }
	        },
	        {
	          value:90,
	          itemStyle:{
	            normal:{
	              color:"transparent"
	            }
	          }
	        }
	      ]
	    },

	    //////////////////////////////////////////////////
        {
            name: 'outer',
            type: 'gauge',
            min: 0,
            max: max,
            z:2,
            splitNumber: 10,
            radius: '90%',
            center:['50%','60%'],
            axisLine: { 
                lineStyle: {      
                    width: 5,
                    color:[[1,'#868686']]
                }
            },
            axisLabel:{
              show:false,
            },
            axisTick: {            
              length:0
            },
            splitLine: {           
               length:0     
            },
            title : {
              show:false
            },
            detail : {
              show:false
            },
            data:[]
        },
        {
            name: 'inner',
            type: 'gauge',
            z: 3,
            min: 0,
            max: max,
            splitNumber: 10,
            radius: '86%',
            center:['50%','60%'],
            axisLine: { 
                lineStyle: {      
                    width: 5,
                    color:[[1,'#F6A821']]
                }
            },
            axisLabel:{
              show:false
            },
            axisTick: {            
              length:0
            },
            splitLine: {           
              length:0       
            },
            title : {
              show:false
            },
            detail : {
              show:false
            },
            data:[]
        },
        {
            name: 'tick',
            type: 'gauge',
            z: 5,
            min: 0,
            max: max,
            splitNumber: 10,
            radius: '82%',
            center:['50%','60%'],
            axisLine: { 
                show:true,
                lineStyle: {      
                    width: 5,
                    color:[[1,'transparent']]
                }
            },
            axisTick: {            
                length: 12,        
                lineStyle: {  
                    width:1,  
                    color: '#F6A821'
                }
            },
            axisLabel:{
              show:true,
              color:'#868686'
            },
            splitLine: {           
                length: 20,        
                lineStyle: {  
                    width:2,      
                    color: '#F6A821'
                }
            },
            pointer:{
              width:5
            },
            itemStyle:{
              normal:{
                color:"#F6A821",
              }
            },
            title : {
              textStyle: {       
                    fontWeight: 'bolder',
                    fontSize: 14,
                    fontStyle: 'italic',
                    color:'#868686'
                }
            },
            detail : {
               textStyle: {   
                    color:'#FFFFFF',    
                    fontWeight: 'bolder',
                    fontSize:16
                }
            },
            data:[{value: data, name: unit}]
        }
        ]
    }
},
	line : function() {
		return {
		title:{
			text:"",
			textStyle:{
				color:'#868686',
				fontFamily:'Microsoft YaHei',
				fontWeight:'normal',
				fontSize:12 
			},
			left:'center'
		},
		grid:{
			left:'10%',
			right:'3%',
			top:'20%',
			bottom:'13%'
		},
	    xAxis: {
	        type: 'category',
	        axisLine:{
	        	lineStyle:{
	        		color:'#3A3A3A'
	        	}
	        },
	        splitLine:{
	        	show:true,
	        	lineStyle:{
	        		color:'#3A3A3A'
	        	}
	        },
	        axisTick:{
	        	show:false
	        },
	        axisLabel:{
	        	color:'#868686'
	        },
	        data: []
	    },
	    yAxis: {
	        type: 'value',
	        axisLine:{
	        	lineStyle:{
	        		color:'#3A3A3A'
	        	}
	        },
	        splitLine:{
	        	show:true,
	        	lineStyle:{
	        		color:'#3A3A3A'
	        	}
	        },
	        axisTick:{
	        	show:false
	        },
	        axisLabel:{
	        	color:'#868686'
	        },
	    },
	    series: [{
	        data:[],
	        type: 'line',
	        smooth: true,
	        showSymbol:false,
	        lineStyle:{
	        	normal:{
	        		color: '#F6A821'
	        	}	        	
	        }
	    }]
	}}
}