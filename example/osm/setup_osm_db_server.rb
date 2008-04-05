$: << "../../extension/osm"

require 'graphserver.rb'
require 'osm_extend2.rb'

# At least one parameter (the osm file)
if ARGV.size < 1 then
  print "usage: ruby setup_osm_server.rb [create_tables] [file [file ...] ]\n"
  print "       create_tables: clear and create new osm tables in the database\n"
  print "       DEBUG_LEVEL: 0 (no), 1(medium) or 2(verbose)\n"
  print "       file: osm data file name\n"
  exit
end

DB_PARAMS = { :host => nil,
              :port => nil,
              :options => nil,
              :tty => nil,
              :dbname => 'graphserver',
              :login => 'postgres', #database username
              :password => 'postgres' }

gs = Graphserver.new
gs.database_params = DB_PARAMS

if ix = ARGV.index("create_tables") then
  gs.remove_osm_table! #clean up first
  gs.create_osm_table!

  ARGV.delete_at( ix )
end

ARGV.each do |file|
  gs.import_osm_to_db! file, debug_level=1
end
