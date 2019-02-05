# Edited 2/2/2019 by Omar Bitar
# tutorial: https://www.sitepoint.com/an-introduction-to-fxruby/

require 'fox16'
include Fox

class PasswordGenerator < FXMainWindow

  def initialize(app)
    super(app, "Hello, World!" , :width => 400, :height => 200)

    #create box effect
    packer = FXPacker.new(self, :opts => LAYOUT_FILL) #put this as param when not using group box (packes everything together)
    groupBox = FXGroupBox.new(packer, nil, :opts => FRAME_RIDGE | LAYOUT_FILL_X)

    hFrame1 = FXHorizontalFrame.new(groupBox)

    chrLabel = FXLabel.new(hFrame1, "Number of characters in password:")
    
    chrTextField = FXTextField.new(hFrame1, 4)
    
    hFrame2 = FXHorizontalFrame.new(groupBox)
    
    specialChrsCheck = FXCheckButton.new(hFrame2, "Include special characters in password")
    
    vFrame1 = FXVerticalFrame.new(packer , :opts => LAYOUT_FILL)

    textArea = FXText.new(vFrame1, :opts => LAYOUT_FILL | TEXT_READONLY | TEXT_WORDWRAP)

    hFrame3 = FXHorizontalFrame.new(vFrame1, :opts => PACK_UNIFORM_WIDTH)

    generateButton = FXButton.new(hFrame3, "Generate")

    copyButton = FXButton.new(hFrame3, "Copy to clipboard")

    # connecting button to a function
    generateButton.connect(SEL_COMMAND) do 
      textArea.removeText(0, textArea.length) 
      textArea.appendText(generatePassword(chrTextField.text.to_i))
    end

  end
  def create
    super
    show(PLACEMENT_SCREEN)
  end

end

def generatePassword(num)

  finalNum = ''

  if num == 0
    return finalNum
  end
  
  (1..num).each do |i|
    finalNum += "#{i.to_s}"
  end

  return finalNum

end

if __FILE__ == $0

  FXApp.new do |app|
    PasswordGenerator.new(app)
    app.create
    app.run
  end
  
end