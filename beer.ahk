; First, let's start with some AHK boilerplate that's recommended for all scripts.
; ----------
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; ----------

; Alright, now we can get to the good stuff.
; Make a variable to hold the script's title. (This can be different than A_ScriptName, 
; which is just a built-in variable for the script's filename.)
; Use ":=" to assign a value to a variable.

Script_Title := "Beer Script"


; Change the hover text ("tool tip") of the tray icon.
; Make it the title of the script we set earlier when we made the Script_Title variable.
; When we wrap a variable in %percent_signs%, we are telling AHK to replace it with literal value that we assigned to the variable.

Menu, Tray, Tip, %Script_Title%


; Make the script icon a beer mug. 
; A_ScriptDir is a built-in variable for the current script's directory (folder), 
; so we'll use it look for the icon filepath relative to the script's folder.
; It is always better to use a relative filepath. 
; If you type out ("hard code") the whole filepath (C:\Users\UserName\Desktop\ahk\ico\beer.ico), 
; then you can't move the script to a different folder or computer without having to re-edit the script and change the filepath.

Menu, Tray, Icon, %A_ScriptDir%\beer.ico


; Add an option to the tray icon right-click menu ("context menu") so the user can select whether the script should run at startup.
; Later in the script we'll create a function and call it "Startup_Options", which will run when the user clicks this option.

Menu, Tray, Add, Startup Options, Startup_Options


; Set ":beer" as the text for the beer mug emoji.
; "Return" tells AHK to stop processing this part of the script.

:::beer::🍺
Return


; Side note: The AHK format for expanding/replacing text is "::original text::replacement text". 
; You can use this for anything, and you can have an unlimited amount of text replacements/expansions. Here's an example
; ::did you::Did you get that thing I sent you?
; This would automatically change "did you" to "Did you get that thing I sent you?" so you don't have to type the whole thing.
; Side note over. Let's move on.


; Now let's create a custom function (technically a soubroutine) with the name "Startup_Options".
; This will start when the user calls it by clicking Startup Options in the tray icon right-click menu.
; It will let the user choose whether to run the script when Windows starts.

Startup_Options:

     ; Show the user a Message Box asking for their input.
     MsgBox, 4, %Script_Title%, Would you like %Script_Title% to start with Windows? (click Yes or No)

     ; Take action based on whether the user said Yes or No.
     IfMsgBox Yes
          {
          ; User wants the script to start automatically. Create a shortcut in the Windows startup folder.
          ; The variables that start with "A_" are built-in AHK variables.

          FileCreateShortcut, %A_ScriptFullPath%, %A_Startup%\%A_ScriptName%.lnk, %A_ScriptDir%


          ; Give the user confirmation with another Message Box. 
          ; The "`n" is used to represent a line break in AHK.

          MsgBox, 0, %Script_Title%, You said Yes. `n %Script_Title% will start automatically, 2
          }
     Else
          {
          ; User said No. Delete the shortcut from the Windows startup folder.
          
          Filedelete, %A_Startup%\%A_ScriptName%.lnk
          MsgBox, 0, %Script_Title%, You said No. `n %Script_Title% will not start automatically, 2
          }
Return
