from geoscript.workspace import Directory, Memory
from geoscript.layer import Layer
from geoscript.geom import Point
from geoscript.feature import Schema
from geoscript.proj import Projection
from sys import argv
import simplejson as json

script, shp_dir, config_file_name, out_file = argv

f = open(config_file_name, 'r')
config = json.load(f)
in_ws = Directory(shp_dir)
out_ws = Directory('out')
mem_ws = Memory()

print in_ws.layers()

epsg4326 = Projection('epsg:4326')
schema = Schema(out_file, [
    ('geom', Point, epsg4326), ('type', str), ('name', str)
])
out_layer = Layer(schema=schema)

for shp in in_ws.values():
    mem_ws.add(shp, name=shp.name)
    shp4326 = mem_ws[shp.name].reproject(epsg4326)
    cfg = config['shps'][shp.name]

    for f in shp4326.features():
        # print dict(f)
        attrs = {'geom': f.geom}
        for k, v in cfg.iteritems():
            attrs[k] = v % dict(f)
        # print attrs
        new_feature = schema.feature(attrs)
        out_layer.add(new_feature)

out_ws.add(out_layer)
