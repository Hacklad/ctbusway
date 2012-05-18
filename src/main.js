(function(routeDetails){
    var baseUrl = 'http://{s}.tile.cloudmade.com/d253021886024e50adec434f02cbf0b5/62952/256/{z}/{x}/{y}.png',
      routesUrl = 'http://a.tiles.mapbox.com/v3/civicworks.ctbusway_routes.jsonp',
      stopsUrl = 'http://a.tiles.mapbox.com/v3/civicworks.ctbusway_stops.jsonp',
      map = new L.Map('map', {
        minZoom: 11,
        maxZoom: 13,
        maxBounds: new L.LatLngBounds(
          new L.LatLng(41.5,-73.2),
          new L.LatLng(42.0,-72.1)
        )
      }),
      baseLayer = new L.TileLayer(baseUrl, {
        attribution: 'Map data <a target="_blank" href="http://creativecommons.org/licenses/by-sa/2.0/">CCBYSA</a> 2012 <a target="_blank" href="http://openstreetmap.org">OpenStreetMap.org</a> contributors - <a target="_blank" href="http://cloudmade.com/terms_conditions">Terms of Use</a>'
      }),
      $tooltip = $('.tooltip');

  map.attributionControl.setPrefix('');
  map.addLayer(baseLayer).setView(new L.LatLng(41.7159, -72.7319), 12);

  var initMapboxLayer = function(url, type, formatter, callback) {
    wax.tilejson(url, function(tilejson) {
      var tid;
      map.addLayer(new wax.leaf.connector(tilejson));

      wax.leaf.interaction()
        .map(map)
        .tilejson(tilejson)
        .on({
          on: function(evt) {
            var html = formatter ? formatter(evt.data) : evt.data.name;

            if (tid) {
              clearTimeout(tid);
            }

            $('.' + type + '-tooltip').html(html).show();
            $tooltip.show();
          },
          off: function(evt) {
            if (tid) {
              clearTimeout(tid);
            }

            tid = setTimeout(function(){
              $('.' + type + '-tooltip').hide();
              if($tooltip.children().is(':visible') === false) {

                $tooltip.hide();
              }
            }, 300);
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
  };

  var formatStops = function(data) {
    // What stops here?
    var routes = [];
    $.each(routeDetails, function(key, route) {
      if (route['stops'] !== undefined ) {
        $.each(route['stops'], function(i, busstop) {
          if (busstop === data.name) {
            routes.push(key);
          };
        });
      };
    });

    // TODO: template updates.
    // TODO: handle no routes.
    return ich.stopsTooltip({
      'title': data.name + '(... FORMAT ME routes: ' +  routes.join(', ') + ')'
    });
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
        desc = '';

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
      } else {
        // Support ranges for non-peak headways
        if (min === max) {
          other = 'every ' + max;
        } else  {
          other = 'between ' + min + ' and ' + max;
        }
      }
      // Tailor the output string to several combinations of times:
      if (min === max && max === rushHour) {
        // Peak and nonpeak times are the same.
        desc += 'Runs every ' + rushHour + ' minutes.';
      } else if (isNaN(rushHour)) {
        // There are no peak times.
        if (min === max) {
          desc += 'Runs every ' + min + ' minutes at off-peak times.';
        } else {
          desc += 'Runs between ' + min + ' and ' + max + ' minutes at off-peak times.';
        }
      } else {
        // There are peak times...
        desc += 'Runs every ' + rushHour + ' minutes during rush hour';
        if (other === '') {
          // ... but no offpeak.
          desc += '.';
        } else {
          // ... with off-peak times also.
          desc += ' and ' + other + ' minutes at other times.';
        }
      }
    }

    return ich.routesTooltip({
      'title': data.name,
      'description': desc
    });
  };

  initLocation();

  initMapboxLayer(routesUrl, 'routes', formatRoutes, function(){
    initMapboxLayer(stopsUrl, 'stops', formatStops);
  });

  bindEvents();
})(routeDetails);
