%W( 
	sinatra/base 
	sinatra/config_file 
	mustache/sinatra
).each {|e| require e}

get '/' do
	@title = "Mustache + Sinatra = Wonder"
	mustache :index
end

get '/other' do
	mustache :other
end

get '/nolayout' do
	content_type 'text/plain'
	mustache :nolayout, :layout => false
end