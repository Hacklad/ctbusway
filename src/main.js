(function(routeDetails){
    var baseUrl = 'http://{s}.tiles.mapbox.com/v3/civicworks.map-akuytyon/{z}/{x}/{y}.png',
      routesUrl = 'http://a.tiles.mapbox.com/v3/civicworks.ctbusway_routes.jsonp',
      stopsUrl = 'http://a.tiles.mapbox.com/v3/civicworks.ctbusway_stops.jsonp',
      map = new L.Map('map', {
        minZoom: 11,
        maxZoom: 13,
        maxBounds: new L.LatLngBounds(
          new L.LatLng(41.2,-74.2),
          new L.LatLng(42.3,-71.0)
        )
      }),
      baseLayer = new L.TileLayer(baseUrl, {
        attribution: 'Map data &copy; OpenStreetMap contributors, CC-BY-SA <a href="http://mapbox.com/about/maps" target="_blank">Terms &amp; Feedback</a>'
      }),
      $tooltip = $('.tooltip');

  map.attributionControl.setPrefix('');
  map.addLayer(baseLayer).setView(new L.LatLng(41.7159, -72.7319), 12);

  var initMapboxLayer = function(url, type, formatter, callback) {
    wax.tilejson(url, function(tilejson) {
      map.addLayer(new wax.leaf.connector(tilejson));

      wax.leaf.interaction()
        .map(map)
        .tilejson(tilejson)
        .on({
          on: function(evt) {
            var html = formatter ? formatter(evt.data) : evt.data.name;

            $('.' + type + '-tooltip').html(html).show();
            $tooltip.show();
          },
          off: function(evt) {
            $('.' + type + '-tooltip').hide();

            if($tooltip.children().is(':visible') === false) {
              $tooltip.hide();
            }
          }
        });

      if (callback) { callback(); }
    });
  };

  var initLocation = function() {
    map.on('locationfound', onLocationFound);
    map.on('locationerror', onLocationError);

    function onLocationFound(e) {
      // Debugging
      // e.latlng = new L.LatLng(41.73414116441006, -72.68258571624756);

      var radius = e.accuracy / 2,
          marker = new L.CircleMarker(e.latlng, {
            radius: 2,
            opacity: 1,
            fillOpacity: 0.7,
            clickable: false
          }),
          circle = new L.Circle(e.latlng, 400, {
            weight: 1,
            opacity: 0.8
          });

      if (map.options.maxBounds.contains(e.latlng)) {
        map.addLayer(marker);
        map.addLayer(circle);
      } else {
        alert('Unable to locate you within the map area.');
      }
    }

    function onLocationError(e) {
      alert(e.message);
    }
  };

  var bindEvents = function() {
    $('.geolocation a').click(function() {
      map.locate();
    });

    $('#nav-bttn').click(function(e){
      $('#main-menu').toggleClass('expose');
      e.preventDefault();
    });

    $('.close-bttn').click(function(e){
      $('.dialog').hide();
      e.preventDefault();
    });

    $('.about a').click(function(e) {
      $('#about').show();
      $('#main-menu').removeClass('expose');
      e.preventDefault();
    });

    $('#legend-bttn').click(function(e) {
      $('#legend').toggleClass('open');
      e.preventDefault();
    });
  };

  var formatStops = function(data) {
    return '<h3>' + data.name + '</h3>';
  };

  var formatRoutes = function(data) {

    // Turn the route data into an array of minutes integers
    var getMinutes = function(keys, routeData) {
      var i, m, mins = [];
      // For each key
      for(i=0; i<keys.length; i++) {
        // Get the number
        m = parseInt(routeData[keys[i]], 10);
        // Add if it's really a number
        if (isNaN(m) === false) {
          mins.push(m);
        }
      }
      return mins;
    };

    var routeData = routeDetails[data.name],
        // Keys for the minute values. Go see route-details.js.
        rushKeys = [
          'Weekday AM Peak',
          'Weekday PM Peak'
        ],
        otherKeys = [
          'Weekday Midday',
          'Weekday Evening',
          'Saturday AM Peak',
          'Saturday Midday',
          'Saturday PM Peak',
          'Saturday Evening',
          'Sunday AM Peak',
          'Sunday Midday',
          'Sunday PM Peak',
          'Sunday Evening'
        ],
        rushHour, minuteArray, other, min, max, headway,
        // Default display html
        html = '<h3>' + data.name + '</h3>';

    // Not everything has additional route data
    if (routeData) {
      // Get the rush hours, assuming AM and PM are the samefor simplicity
      rushHour = parseInt(routeData['Weekday AM Peak'], 10),
      // Get the min and max for non rush hour headways
      minuteArray = getMinutes(otherKeys, routeData),
      min = Math.min.apply(null, minuteArray);
      max = Math.max.apply(null, minuteArray);

      if (min === -Infinity || min === Infinity) {
          // Not all busways have off-peak times.
          other = '';
      }
      else {
          // Support ranges for non-peak headways
          if (min === max) {
              other = 'every ' + max;
          } else  {
              other = 'between ' + min + ' and ' + max;
          }
      };
      // Tailor the output string to several combinations of times:
      if (min === max && max === rushHour) {
         // Peak and nonpeak times are the same.
         html += 'Runs every ' + rushHour + ' minutes.';
      } else if (isNaN(rushHour)) {
         // There are no peak times.
         if (min === max) {
            html += 'Runs every ' + min + ' minutes at off-peak times.';
	 } else {
            html += 'Runs between ' + min + ' and ' + max + ' minutes at off-peak times.';
         };
      } else {
         // There are peak times...
         html += 'Runs every ' + rushHour + ' minutes during rush hour';
         if (other === '') {
             // ... but no offpeak.
             html += '.';
         } else {
             // ... with off-peak times also.
             html += ' and ' + other + ' minutes at other times.';
	 }
      }
    }

    return html;
  };

  initLocation();

  initMapboxLayer(routesUrl, 'routes', formatRoutes, function(){
    initMapboxLayer(stopsUrl, 'stops', formatStops);
  });

  bindEvents();
})(routeDetails);
