require 'sinatra'
require 'data_mapper'
require_relative 'pig_latin'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/app.db")

class Exercise
  include DataMapper::Resource
  property :id, Serial
  property :name, Text
  property :prompt, Text
  property :method_name, Text
  property :test, Text
end

DataMapper.finalize.auto_upgrade!

get '/' do
  @exercises = Exercise.all order: :name.asc
  erb :index
end

get '/:id' do
  @exercise = Exercise.get params[:id]
  erb :view   
end

post '/' do
  exercise = Exercise.new
  exercise.name        = params[:name]
  exercise.prompt      = params[:prompt]
  exercise.method_name = params[:method_name]
  exercise.save
  redirect '/'  
end