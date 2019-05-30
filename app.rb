require 'rf_rgb'
require 'sinatra'

def parse_body(request)
  data = JSON.parse request.body.read
  colordata = {}
  data.each {|key,value|
    colordata[key.to_sym] = value
  }
  colordata
end

post '/api' do
  begin 
    colordata = parse_body(request)
  rescue => error
    halt error.message
  end
  kernel_base = File.read('/etc/udev/rules.d/topre_keyboard_kernel').gsub(":1.0","")
  puts kernel_base
  for num in 0..2 do
    kernel = kernel_base + ":1." + num.to_s
    system('echo -n "' + kernel + "" + '" | sudo tee /sys/bus/usb/drivers/usbhid/unbind')
  end
  system('echo -n "' + kernel + '" | sudo tee /sys/bus/usb/drivers/usbhid/unbind')
  RfRgb::Keyboard.run_and_release do |keyboard|
    keyboard.colors = colordata
    keyboard.save
    for num in 1..3 do
      kernel = kernel_base + ":1." + num.to_s
      system('echo -n "' + "#{kernel}" + '" | sudo tee /sys/bus/usb/drivers/usbhid/unbind')
    end
  end
end

