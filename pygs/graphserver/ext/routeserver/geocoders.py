from graphserver.ext.osm.osmdb import OSMDB

class OSMReverseGeocoder:
    def __init__(self, osmdb_filename):
        self.osmdb = OSMDB( osmdb_filename )
        
    def __call__(self, lat, lon):
        nearby_vertex = list(self.osmdb.nearest_node(lat, lon))
        return "osm-%s"%(nearby_vertex[0])