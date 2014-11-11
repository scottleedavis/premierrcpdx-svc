require 'mongo'
require 'bson'
require 'pry'

#mongod --dbpath ~/mongo-data/

db = Mongo::Connection.new("localhost").db("mydb") 
col = db.collection("testCollection")
binding.pry