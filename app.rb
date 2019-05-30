require 'rf_rgb'
require 'sinatra'

post '/api' do
  data = JSON.parse request.body.read
  colordata = {}
  data.each {|key,value|
    colordata[key.to_sym] = value
  }
  RfRgb::Keyboard.run_and_release do |keyboard|
    keyboard.colors = colordata
    keyboard.save
  end
end

