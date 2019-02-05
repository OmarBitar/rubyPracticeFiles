# Edited 2/2/2019 by Omar Bitar

# the recomended way of creating fxruby app  
require 'fox16'
include Fox

class HelloWorld < FXMainWindow

  def initialize(app, title, w, h)
    super(app, title, :width => w, :height => h) 
  end
  def create
    super
    show(PLACEMENT_SCREEN)
  end

end

# recomended way to start fxRuby app
if __FILE__ == $0
    FXApp.new do |app|
      HelloWorld.new(app, "Simple Text Editor", 600, 400)  
      app.create
      app.run
    end
  end