from geoscript.workspace import Directory, Memory
from geoscript.layer import Layer
from geoscript.feature import Schema
from geoscript.proj import Projection
from sys import argv
import geoscript.geom
import simplejson as json


def merge_shapefiles(config, out_layer):
    # Iterate over each configured shape
    for shp_name, shp_config in config['shps'].iteritems():
        # Copy it to memory so the reprojected layer will also be in memory
        mem_ws.add(in_ws[shp_name], name=shp_name)
        shp4326 = mem_ws[shp_name].reproject(epsg4326)

        # Iterate over the reprojected features.
        for f in shp4326.features():
            attrs = get_attrs_from_feature(f, shp_config)
            if attrs is None:
                # Skip this feature.
                continue

            # Save it to memory
            new_feature = schema.feature(attrs)
            out_layer.add(new_feature)
    return out_layer

def get_attrs_from_feature(f, shp_config):
    # Construct the normalized attributes.

    # Possibly skip this feature.
    whitelist_map = shp_config.pop('whitelist', {})

    attrs = {'geom': f.geom}
    for k, v in shp_config.iteritems():
        if whitelist_map:
            for whitelist_field, whitelist_values in whitelist_map.items():
                if f[whitelist_field] not in whitelist_values:
                    return None

        attrs[k] = v % dict(f)

    print attrs['name']
    return attrs

if __name__ == '__main__':

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
        ('geom', getattr(geoscript.geom, config['geomtype']), epsg4326),
        ('type', str), ('name', str), ('agency', str)
    ])
    out_layer = Layer(schema=schema)
    out_layer = merge_shapefiles(config, out_layer)
    # Write it to the shape file
    out_ws.add(out_layer)
