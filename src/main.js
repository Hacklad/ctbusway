(function(){
    var baseUrl = 'http://{s}.tiles.mapbox.com/v3/civicworks.map-akuytyon/{z}/{x}/{y}.png',
      routesUrl = 'http://a.tiles.mapbox.com/v3/civicworks.ctbusway_routes.jsonp',
      stopsUrl = 'http://a.tiles.mapbox.com/v3/civicworks.ctbusway_stops.jsonp',
      map = new L.Map('map', {
        minZoom: 12,
        maxZoom: 12,
        maxBounds: new L.LatLngBounds(
          new L.LatLng(41.2,-74.2),
          new L.LatLng(42.3,-71.0)
        ),
        zoomControl: false
      }),
      baseLayer = new L.TileLayer(baseUrl, {
        attribution: 'Map data &copy; OpenStreetMap contributors, CC-BY-SA <a href="http://mapbox.com/about/maps" target="_blank">Terms &amp; Feedback</a>'
      });

  map.attributionControl.setPrefix('');
  map.addLayer(baseLayer).setView(new L.LatLng(41.7159, -72.7319), 12);

  var initMapboxLayer = function(url, callback) {
    wax.tilejson(url, function(tilejson) {
      map.addLayer(new wax.leaf.connector(tilejson));

      wax.leaf.interaction()
        .map(map)
        .tilejson(tilejson)
        .on(wax.tooltip().animate(true).parent(map._container).events());

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
  };

  initLocation();

  initMapboxLayer(routesUrl, function(){
    initMapboxLayer(stopsUrl);
  });

  bindEvents();
})();