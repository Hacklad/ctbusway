ctbusway
========

Map for CT Transit Busway corridor

Overview
------------

Purely client-side (so far) plus hosted map tiles.

Uses Tilemill for map generation, Mapbox.com for tile hosting.


Development Server
----------------------

Static files go on
http://ctbusway.s3.amazonaws.com/

and shapefile zips go in
http://ctbusway.s3.amazonaws.com/shp/

TODO: We are missing the AWS account info to upload to this. Aaron
should have it.


Editing and Generating the Map Tiles
-------------------------------------

### Edit shapefiles ###

... then upload them to our s3 server (see above).

### Tilemill ###

First install tilemill locally.

Start TileMill.

The project files are in the source checkout in
tilemill/ctbusway_routes/project.mml and
tilemill/ctbusway_stops/project.mml.
Open the one you want to edit.

Edit styles as needed.

click Save at upper right.

click Export -> MBTiles at upper right.

When that finishes, it should give you a link to "download" the export
(Even though running locally... yep it's odd.)

Save that file.


Deployment
==========

## Updating Mapbox tiles  ##

On mapbox.com: Go to "My account".

http://tiles.mapbox.com/login

Click "Upload map" at top right.

Browse to exported mbtiles file and upload.

Choose "New Map" and enter a new ID. Include a date/time stamp in
the name to avoid caching issues. eg. we've been naming them like
"ctbusway_routes_6291607"

Next screen is a preview; make sure tiles look OK.


## Update javascript to use new tiles ##

Edit src/main.js, fix the mapbox tile URL to use the name you created
when uploading the tiles.

#### Mapbox cleanup ####

After JS code is deployed, go back to
http://tiles.mapbox.com/login
and delete previous version of map tiles, once you're sure it's not
needed for production.

(We pay for these, so this is important!)




