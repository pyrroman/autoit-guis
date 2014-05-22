#include <GUIConstantsEx.au3>

Opt("GUIOnEventMode", 1)
$mainwindow = GUICreate("Add Codigo letters",  200, 100, 0, 600)
GUISetOnEvent($GUI_EVENT_CLOSE, "CLOSEClicked")
;;$mylabel = GUICtrlCreateLabel("Hello, nice to sweet you", 30, 10)
$loadbutton = GUICtrlCreateButton("Load", 38, 10, 60)
$nextbutton = GUICtrlCreateButton("next", 38, 57, 60)
$savebutton = GUICtrlCreateButton("Save", 110, 10, 60)
$readbutton = GUICtrlCreateButton("Read out", 110, 57, 60)
GUICtrlSetOnEvent($loadbutton, "LoadButton")
GUICtrlSetOnEvent($nextbutton, "NextLine")
GUICtrlSetOnEvent($savebutton, "SaveFile")
GUICtrlSetOnEvent($readbutton, "ReadOut")
GUISetState(@SW_SHOW)

Global $infile = ""
Global $outvalue = ""

While 1
   Sleep(1000)
WEnd

Func LoadButton()
   ;; MsgBox(0, "GUI Event", "You pressed ok")
   $in = FileOpenDialog("Choose file with plain codigos", "c:\Python32\Scripts\cardex", "All (*.*)")
   ;; MsgBox(0, "File chosen", $in)
   $infile = FileOpen($in, 0)
EndFunc

Func NextLine()
   Local $line = FileReadLine($infile)
   If StringLen($line) > 5 Then
	  ;; MsgBox(0, "filename", $line)
	  WinActivate("Produto")
	  Sleep(200)
	  Send("{F3}")
	  Sleep(200)
	  Send($line)
	  Send("{ENTER}")
	  Sleep(300)
   
	  Local $letters = InputBox("Enter letters (or none)", $line, "", "", -1, -1, 10, 536)
	  If StringLen($letters) == 0 Then
		 $letters = " "
	  EndIf	
	  For $index = 1 To StringLen($letters)
		 $outvalue = $outvalue & $line & StringUpper(StringMid($letters, $index, 1)) & @CRLF
	  Next
   EndIf
EndFunc

Func SaveFile()
   $savetofilename = FileSaveDialog("Save to...", "c:\Python32\Scripts\cardex", "All (*.*)", 16)
   FileWrite($savetofilename, $outvalue)
EndFunc

Func ReadOut()
   MsgBox(0, "output", $outvalue)
EndFunc

Func CLOSEClicked()
   ;; MsgBox(0, "GUI Event", "You clicked close")
   Exit
EndFunc