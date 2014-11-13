require 'yaml'
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

# stores results, returns values that were 'not' already store
def stash(files)
  yml_file = 'results_store.yml'
  store = YAML.load_file(yml_file)

  unless store
    new_store = store = files
  else
    new_store = {
      offroad: [],
      onroad: [],
      oval: []
    }

    files[:offroad].each do |f|
      unless store[:offroad].include? f
        new_store[:offroad].push f 
        store[:offroad].push f
      end
    end

    files[:onroad].each do |f|
      unless store[:onroad].include? f
        new_store[:onroad].push f
        store[:onroad].push f
      end
    end

    files[:oval].each do |f|
      unless store[:oval].include? f
        new_store[:oval].push f 
        store[:oval].push f 
      end
    end    
    store
  end

  File.open(yml_file, "w") do |file|
    file.write store.to_yaml
  end

  new_store
end

def view_stash
  yml_file = 'results_store.yml'
  store = YAML.load_file(yml_file)
  puts store.to_s
end

