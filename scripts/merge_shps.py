from geoscript.workspace import Directory, Memory
from geoscript.layer import Layer
from geoscript.geom import *
from geoscript.feature import Schema
from geoscript.proj import Projection
from sys import argv
import simplejson as json

# Get the arguments, naively
script, shp_dir, config_file_name, out_file = argv

# Read the json config file
f = open(config_file_name, 'r')
config = json.load(f)

# Create the workspaces
in_ws = Directory(shp_dir)
out_ws = Directory('out')
mem_ws = Memory()

# Show the layers are about to merge
print in_ws.layers()

# Init the output layer
epsg4326 = Projection('epsg:4326')
schema = Schema(out_file, [
    ('geom', locals()[config['geomtype']], epsg4326),
    ('type', str), ('name', str), ('agency', str)
])
out_layer = Layer(schema=schema)

# Iterate over each configured shape
for shp_name, shp_config in config['shps'].iteritems():
    # Copy it to memory so the reprojected layer will also be in memory
    mem_ws.add(in_ws[shp_name], name=shp_name)
    shp4326 = mem_ws[shp_name].reproject(epsg4326)

    # Iterate over the reprojected features
    for f in shp4326.features():
        # Construct the normalized attributes
        attrs = {'geom': f.geom}
        for k, v in shp_config.iteritems():
            attrs[k] = v % dict(f)

        print attrs['name']

        # Save it to memory
        new_feature = schema.feature(attrs)
        out_layer.add(new_feature)

# Write it to the shape file
out_ws.add(out_layer)
