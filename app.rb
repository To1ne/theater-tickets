require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'i18n'

I18n.load_path += Dir["#{Dir.pwd}/locale/*.yml"]
I18n.default_locale = :nl

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/2014.db")

class Show
  include DataMapper::Resource

  property :id, Serial
  property :date, Date
  property :max, Integer
  property :taken, Integer, :default => 0
end

DataMapper.finalize.auto_upgrade!

if Show.all.empty?
  show = Show.create(:date => Date.new(2014,  3,  8), :max => 170)
  show = Show.create(:date => Date.new(2014,  3,  9), :max => 170)
  show = Show.create(:date => Date.new(2014,  3, 15), :max => 170)
  show = Show.create(:date => Date.new(2014,  3, 16), :max => 170)
  show = Show.create(:date => Date.new(2014,  3, 22), :max => 170)
  show = Show.create(:date => Date.new(2014,  3, 23), :max => 170)
end

get '/' do
  @shows = Show.all
  erb :index
end

get '/edit' do
  @shows = Show.all
  erb :edit
end

# post '/articles' do
#   article = Article.new(params[:article])
  
#   if article.save
#     redirect '/articles'
#   else
#     redirect '/articles/new'
#   end
# end

# put '/articles/:id' do |id|
#   article = Article.get!(id)
#   success = article.update!(params[:article])
  
#   if success
#     redirect "/articles/#{id}"
#   else
#     redirect "/articles/#{id}/edit"
#   end
# end
