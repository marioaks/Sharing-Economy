$.ajax({
   type: "GET",
   contentType: "application/json; charset=utf-8",
   url: 'countries',
   dataType: 'json',
   success: function (Worlddata) {
       worldMap(Worlddata);
       
       $.ajax({
            type: "GET",
            contentType: "application/json; charset=utf-8",
            url: 'services',
            dataType: 'json',
            success: function (serviceData) {

              citiesMap(serviceData);
            },
            error: function (result) {
              error();
            }
    });   
   },
   error: function (result) {
       error();
   }
});

var countryById = {};

function worldMap(data) {
  var countryByService = {},
      max = 0;
      worldID_to_id = {}

  data.forEach(function(d) {
      worldID_to_id[d.world110_id] = parseInt(d.id, 10);
      countryById[d.world110_id] = d.name;
      countryByService[d.world110_id] = d.service_ids.length
      if (d.service_ids.length > max) {
        max = d.service_ids.length;
      }
    }); 

  var color = d3.scaleThreshold() 
    .domain([0, 1, 2, 4, 8, 15, 30, 60, max])
    .range(d3.schemePuBu[9]);

  var width = 1400,
    height = 933;

  var projection = d3.geoMercator()
    .scale(220)
    .translate([width / 2,height / 2 + 100]);

  var path = d3.geoPath()
    .projection(projection);

  var svg = d3.select("#worldMap")
    .attr("perserveAspectRatio", "xMinYMin meet")
    .attr("viewBox", "0 0 1400 933")
    .classed("svg-content", true);


  var tooltip = d3.select('body').append('div')
            .attr('class', 'tooltip');

  d3.json("https://d3js.org/world-110m.v1.json", function(error, world) {
  if (error) return console.error(error);

  var countries = topojson.feature(world, world.objects.countries).features,
      neighbors = topojson.neighbors(world.objects.countries.geometries);

    svg.selectAll(".country")
    .data(countries)
    .enter().append("a")
      .attr("xlink:href", function(d) {
          return "/countries/" +  worldID_to_id[parseInt(d.id, 10)] })
    .append("path")
      .attr("class", "country")
      .attr("d", path)
      
      .style("stroke", 'gray')
      .style("stroke-width", 1)
      .style("fill", function(d) { 
        //d.color = ((Math.random() * 6) + 3);
        c = countryByService[parseInt(d.id, 10)];
        if (c != null) {
          return color(c);
        } else {
          return color(0);
        }
      
      })
      
      .on('mouseout', function(d) {
        var i = parseInt(d.id, 10);
        c = countryByService[i];
          d3.select(this)
            .style('stroke', 'gray')
            .style('stroke-width', 1)
            .transition()
            .duration(800)
            .style("fill", function(d_1) { 
              c = countryByService[i];
              if (c != null) {
                return color(c);
              } else {
                return color(0);
              }
            })
          tooltip.style("opacity", 0)
          .style("display", "none")
      })

      .on('mouseover', function(d) {
          d3.select(this)
            .transition()
            .duration(0)
            .style('fill', '#63CB84');
      })

      .on('mousemove', function(d) {
          var i = parseInt(d.id, 10);
          tooltip.text(countryById[i] + ' - Services: ' + countryByService[i])
            .style("left", (d3.event.pageX + 7) + "px")
            .style("top", (d3.event.pageY - 15) + "px")
            .style("display", "block")
            .style("opacity", 1);
      });
  });


  var legend = svg.selectAll('g.legendEntry')
    .data(color.range().reverse())
    .enter()
    .append('g').attr('class', 'legendEntry');

  legend
    .append('rect')
    .attr("x", width - 100)
    .attr("y", function(d, i) {
       return i * 20 + 375;
    })
   .attr("width", 10)
   .attr("height", 10)
   .style("stroke", "black")
   .style("stroke-width", 1)
   .style("fill", function(d){return d;}); 

  legend
    .append('text')
    .attr("x", width - 85) //leave 5 pixel space after the <rect>
    .attr("y", function(d, i) {
       return i * 20 + 375;
    })
    .attr("dy", "0.8em") //place text one line *below* the x,y point
    .text(function(d,i) {
        var extent = color.invertExtent(d);
        //extent will be a two-element array, format it however you want:
        var first = parseInt(+extent[0]);
        var second = parseInt(+extent[1]);

        var toPrint = "";
        if (!Number.isInteger(first)) {
          toPrint = (0 + " - " + second);
        } else if (!Number.isInteger(second)) { 
          toPrint = (first + "+");
        } else {
          toPrint = first + " - " + second
        }
        return toPrint;
    });   
}



function citiesMap(data) {
    var cityNumbers = {},
        max = 0;

  data.forEach(function(d) {
    if (d.city != null) {

      if (cityNumbers[d.city.id] == null) {
        cityNumbers[d.city.id] = {name: d.city.name, coordinates: [d.city.lng, d.city.lat], serviceNum: 1};
      } else {
        cityNumbers[d.city.id].serviceNum += 1;
        if (cityNumbers[d.city.id].serviceNum > max) {
          max = cityNumbers[d.city.id].serviceNum
        }
      }
    }
  }); 

  var width = 1400,
      height = 933;

  var projection = d3.geoMercator()
    .scale(220)
    .translate([width / 2,height / 2 + 100]);

  var path = d3.geoPath()
    .projection(projection);

  var radius = d3.scaleSqrt()
    .domain([0, max])
    .range([0, 33]);

  var svg = d3.select("#citiesMap")
    .attr("perserveAspectRatio", "xMinYMin meet")
    .attr("viewBox", "0 0 1400 933")
    .classed("svg-content", true);

  var tooltip = d3.select('body').append('div')
      .attr('class', 'tooltip');

  d3.json("https://d3js.org/world-110m.v1.json", function(error, world) {
  if (error) return console.error(error);

  var countries = topojson.feature(world, world.objects.countries).features,
      neighbors = topojson.neighbors(world.objects.countries.geometries);

  svg.selectAll(".country")
    .data(countries)
    .enter().append("path")
      .attr("class", "country")
      .attr("d", path)
      .style("fill", "#131313")
      .style("stroke", '#666666')
      .style("stroke-width", 1)
      
      .on('mouseout', function(d) {
          d3.select(this)
            .transition()
            .duration(800)
            .style('stroke', '#666');
      })

      .on('mouseover', function(d) {
          d3.select(this)
            .transition()
            .duration(0)
            .style('stroke', '#AAA');
      });

      var circles = svg.append("g")
        .attr("class", "bubble");

      svg.selectAll("circles")
        .data(Object.values(cityNumbers)).enter()
        .append("circle")
        .attr("cx", function(d) { 
          console.log(d);
          return projection(d.coordinates)[0]; })
        .attr("cy", function(d) { return projection(d.coordinates)[1]; })
        //.attr("transform", function(d) { return "translate(" + path.centroid(d) + ")"; })
        .attr("r", function(d) {
            return radius(d.serviceNum);   
        })
        .attr("fill-opacity", '.4')
        .attr("fill", '#27BB68')
        .attr("stroke", '#fff')
        .attr("stroke-width", '.5px')

        .on('mouseout', function(d) {
          d3.select(this)
          .transition()
          .duration(800)
          .style('fill', '#27bb68');
          tooltip.style("opacity", 0)
          .style("display", "none");
      })

      .on('mouseover', function(d) {
          d3.select(this)
            .transition()
            .duration(0)
            .style('fill', '#BE4646');
      })

      .on('mousemove', function(d) {
          tooltip.text(d.name + ' - Services: ' + d.serviceNum)
            .style("left", (d3.event.pageX + 7) + "px")
            .style("top", (d3.event.pageY - 15) + "px")
            .style("display", "block")
            .style("opacity", 1);
      });
    });
}
function error() {
    console.log("error")
}
