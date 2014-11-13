require 'mongo'
require 'bson'
require 'yaml'

#mongod --dbpath ~/mongo-data/
db = Mongo::Connection.new("localhost").db("mydb") 

yml_file = 'results_store.yml'
store = YAML.load_file(yml_file)

offroad_coll = db.collection("offroad")
offroad_coll.remove
store[:offroad].each do |d|
  offroad_coll.insert( { date: d.keys[0], link: d.values[0] } )
end

onroad_coll = db.collection("onroad")
onroad_coll.remove
store[:onroad].each do |d|
  onroad_coll.insert( { date: d.keys[0], link: d.values[0] } )
end

oval_coll = db.collection("oval")
oval_coll.remove
store[:oval].each do |d|
  oval_coll.insert( { date: d.keys[0], link: d.values[0] } )
end

puts 'migrated!'
puts 'offroad:'
puts offroad_coll.find.to_a
puts 'onroad:'
puts onroad_coll.find.to_a
puts 'oval:'
puts oval_coll.find.to_a

