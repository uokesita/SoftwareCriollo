require 'rubygems'
require 'sinatra/base'
require 'haml'
require 'sass'
require 'mongoid'

Mongoid.load!("mongoid.yml")


module EncodeString
  def encode_string
    self.nombre = self.nombre.encode('utf-8', 'iso-8859-1')
  end
end

class Person
  include Mongoid::Document
  include EncodeString
  field :nombre
  field :email

  before_create :encode_string
end

class Suggestion
  include Mongoid::Document
  include EncodeString
  field :nombre

  before_create :encode_string
end

class App < Sinatra::Base

  set :public, File.join(File.dirname(__FILE__), 'public')  
  set :views, File.join(File.dirname(__FILE__), 'views')

  helpers do
    def partial(page, options={})
      haml page, options.merge!(:layout => false)
    end
  end

  set :haml, :format => :html5

  get '/styles.css' do 
    content_type 'text/css', :charset => 'utf-8'
    sass :styles
  end

  get '/' do
    haml :index
  end

  get '/thanks' do
    haml :thanks
  end

  get '/suggestion' do
    haml :suggestion
  end

  get '/home' do
    haml :home
  end

  post '/thanks' do 
    suggestion = Suggestion.create(params)
    if suggestion.save
      haml :thanks
    else
      haml :index
    end
  end

  post '/suggestion' do 
    person = Person.create(params)
    if person.save
      haml :suggestion
    else
      haml :index
    end
  end
end
