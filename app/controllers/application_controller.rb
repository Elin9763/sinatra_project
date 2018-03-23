require './config/environment'

class ApplicationController < Sinatra::Base

  get '/' do
    erb :index
  end

end
