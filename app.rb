require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'i18n'

I18n.load_path += Dir[File.join(settings.root, 'locales', '*.yml')]
I18n.default_locale = :nl

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/2014.db")

class Show
  include DataMapper::Resource

  property :id, Serial
  property :date, DateTime
  property :max, Integer
  property :taken, Integer, :default => 0
end

DataMapper.finalize.auto_upgrade!

if Show.all.empty?
  show = Show.create(:date => DateTime.new(2014, 3,  8, 19, 30), :max => 170)
  show = Show.create(:date => DateTime.new(2014, 3,  9, 13, 30), :max => 170)
  show = Show.create(:date => DateTime.new(2014, 3, 15, 19, 30), :max => 170)
  show = Show.create(:date => DateTime.new(2014, 3, 16, 13, 30), :max => 170)
  show = Show.create(:date => DateTime.new(2014, 3, 22, 19, 30), :max => 170)
  show = Show.create(:date => DateTime.new(2014, 3, 23, 13, 30), :max => 170)
end

get '/' do
  @shows = Show.all
  erb :index
end

get '/edit' do
  @shows = Show.all
  erb :edit
end

put '/update/' do
  params[:show].each do |param|
    id = param[0]
    show = Show.get!(id)
    success = show.update!(param[1])
  end
  redirect "/"
end
