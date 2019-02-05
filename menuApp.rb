# Edited 2/2/2019 by Omar Bitar
#toturial: http://rubylearning.com/satishtalim/fxruby.html

require 'fox16'
include Fox

class TextEditor < FXMainWindow

  def initialize(app, title, w, h)
    super(app, title, :width => w, :height => h) 
    addMenuBar
    add_text_area
  end
  def create
    super
    show(PLACEMENT_SCREEN)
  end

  # text area
  def add_text_area  
    @txt = FXText.new(self, :opts => TEXT_WORDWRAP|LAYOUT_FILL)  
    @txt.text = "hello world"  
  end  

  # menu system (with pull-down menus)
  def addMenuBar  
    # set up menu layout properties
    menuBar = FXMenuBar.new(self, LAYOUT_SIDE_TOP | LAYOUT_FILL_X)  
        # create pointers (to link new 'FXMenuPane' wutg a new 'FXMenuTitle')
    fileMenu = FXMenuPane.new(self)  #self refers to the TextEditor window
    about = FXMenuPane.new(self)  #self refers to the TextEditor window

    #create main menu Items
    FXMenuTitle.new(menuBar, "File", :popupMenu => fileMenu)  
    FXMenuTitle.new(menuBar, "About", :popupMenu => about) 

    #create sub menue Items
        #under 'File' tab 
    newCmd = FXMenuCommand.new(fileMenu, "new")
    loadCmd = FXMenuCommand.new(fileMenu, "Load")
    saveCmd = FXMenuCommand.new(fileMenu, "save") 
    exitCmd = FXMenuCommand.new(fileMenu, "Exit")
        #under 'About' tab
    aboutCmd = FXMenuCommand.new(about, "contact us") 
    
    #connect sub menue Items to functions
    newCmd.connect(SEL_COMMAND) do
        @txt.text = ""
    end

    loadCmd.connect(SEL_COMMAND) do  
        dialog = FXFileDialog.new(self, "Load a File") 
        dialog.selectMode = SELECTFILE_EXISTING 
        dialog.patternList = ["All Files (*)"]  
        if dialog.execute != 0  
         load_file(dialog.filename)  
        end   
    end  

    saveCmd.connect(SEL_COMMAND) do
        dialog = FXFileDialog.new(self, "Save a File")  
        dialog.selectMode = SELECTFILE_EXISTING  
        dialog.patternList = ["All Files (*)"]  
        if dialog.execute != 0  
          save_file(dialog.filename)  
        end
    end

    exitCmd.connect(SEL_COMMAND) do
        exit
    end

    aboutCmd.connect(SEL_COMMAND) do
        # ...
    end
    
  end 

end

def load_file(filename)  
    contents = ""  
    File.open(filename, 'r') do |f1|  
      while line = f1.gets  
        contents += line  
      end  
    end  
    @txt.text = contents  
  end  

# recomended way to start fxRuby app
if __FILE__ == $0
    FXApp.new do |app|
      TextEditor.new(app, "Simple Text Editor", 600, 400)  
      app.create
      app.run
    end
  end