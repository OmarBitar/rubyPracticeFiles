require 'fox16'
#All of FXRuby’s classes are defined within the Fox module, so including Fox in our program’s 
#global namespace removes the need to precede these classes with a Fox:: prefix.
include Fox

app = FXApp.new
main = FXMainWindow.new(app, "PIE - paint image editor" , :width => 720, :height => 480)

app.create
#Windows are however invisible by default in FXRuby, so we need to call FXMainWindow#show for 
#it to be displayed. The argument PLACEMENT_SCREEN ensures that it is centred on the screen.
main.show(PLACEMENT_SCREEN)
app.run # program’s main loop 
