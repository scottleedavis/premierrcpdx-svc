require 'mongo'
require 'bson'
include Mongo

# uploads results to mongodb at mongodblab
def upload(files)
  #db = Mongo::Connection.new("localhost").db("mydb") 
  client = MongoClient.from_uri(ENV['MONGOLAB_URI'])
  db = client.db("mydb")
  
  offroad_coll = db.collection("offroad")
  files[:offroad].each do |d|
    if 0 == offroad_coll.find("date" => d.keys[0], "link" => d.values[0]).to_a.length
      offroad_coll.insert( { date: d.keys[0], link: d.values[0] } )
    end
  end

  onroad_coll = db.collection("onroad")
  files[:onroad].each do |d|
    if 0 == onroad_coll.find("date" => d.keys[0], "link" => d.values[0]).to_a.length
      onroad_coll.insert( { date: d.keys[0], link: d.values[0] } )
    end
  end

  oval_coll = db.collection("oval")
  files[:oval].each do |d|
    if 0 == oval_coll.find("date" => d.keys[0], "link" => d.values[0]).to_a.length
      oval_coll.insert( { date: d.keys[0], link: d.values[0] } )
    end
  end
end

