require 'mongo'
require 'bson'
require 'pry'

db = Mongo::Connection.new("localhost").db("mydb") 
col = db.collection("testCollection")
binding.pry