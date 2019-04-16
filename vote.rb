require 'yaml/store'
require 'sinatra'

get '/' do
    @title = 'Welcome to the voting app!'
    erb :index
end

get '/' do
    @votes = { 'HAM' => 7, 'PIZ' => 5, 'CUR' => 3 }
    erb :results
end

post '/cast' do
    @title = 'Thanks for casting your vote!'
    @vote = params['vote']
    @store = YAML::Store.new 'votes.yml'
    @store.transaction do
        @store['votes'] ||={}
        @store['votes'][@vote] ||= 0
        @store['votes'][@vote] += 1
    end
    erb :cast
end

get '/results' do
    @title = 'Results so far:'
    @store = YAML::Store.new 'votes.yml'
    @votes = @store.transaction { @store['votes']}
    erb :results
end


Choices = {
    'HAM' => 'Hamburger',
    'PIZ' => 'Pizza',
    'CUR' => 'Curry',
    'NOO' => 'Noodles'
}