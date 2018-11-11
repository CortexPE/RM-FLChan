#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         CortexPE

 Script Function:
	Split Fruity Dance spritesheet to multiple spritesheets for use with RainMeter

#ce ----------------------------------------------------------------------------

#cs
Copyright 2018 (c) CortexPE

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
#ce

; Script Start - Add your code below here
#include <Date.au3>
#include <GDIPlus.au3>

_GDIPlus_Startup()
$file = FileOpenDialog("Choose Spritesheet", @ScriptDir, "PNG files (*.png)|JPG files (*.jpg)|GIF files (*.gif)|All files (*.*)", BitOR(1, 2))
If $file <> "" Then
   $hImage = _GDIPlus_ImageLoadFromFile($file)

   $imageWidth = _GDIPlus_ImageGetWidth($hImage)
   $imageHeight = _GDIPlus_ImageGetHeight($hImage)
   $offset = Int(Ceiling($imageHeight / 10))

   $path = @ScriptDir & "\output_" & StringReplace(StringReplace(StringReplace(_Now(), "/", "-"), ":", "_"), " ", "_")
   DirCreate($path)

   _GDIPlus_ImageSaveToFile(_ImageCut($hImage, 0, 0, $imageWidth, $offset), $path & "\waiting.png")
   _GDIPlus_ImageSaveToFile(_ImageCut($hImage, 0, $offset, $imageWidth, $offset), $path & "\stepping.png")
   _GDIPlus_ImageSaveToFile(_ImageCut($hImage, 0, $offset * 2, $imageWidth, $offset), $path & "\jumping.png")
   _GDIPlus_ImageSaveToFile(_ImageCut($hImage, 0, $offset * 3, $imageWidth, $offset), $path & "\zombie.png")
   _GDIPlus_ImageSaveToFile(_ImageCut($hImage, 0, $offset * 4, $imageWidth, $offset), $path & "\waving.png")
   _GDIPlus_ImageSaveToFile(_ImageCut($hImage, 0, $offset * 5, $imageWidth, $offset), $path & "\hula.png")
   _GDIPlus_ImageSaveToFile(_ImageCut($hImage, 0, $offset * 6, $imageWidth, $offset), $path & "\freestyle.png")
   _GDIPlus_ImageSaveToFile(_ImageCut($hImage, 0, $offset * 7, $imageWidth, $offset), $path & "\zitabata.png")
   _GDIPlus_ImageSaveToFile(_ImageCut($hImage, 0, $offset * 8, $imageWidth, $offset), $path & "\dervish.png")
   _GDIPlus_ImageSaveToFile(_ImageCut($hImage, 0, $offset * 9, $imageWidth, $offset), $path & "\picked_up.png")

   _GDIPlus_ImageDispose($hImage)
   MsgBox(0, "Spritesheet has been split!", "Spritesheets saved to: " & $path)
EndIf
_GDIPlus_Shutdown()

Func _ImageCut($hImage, $iX, $iY, $iWidth, $iHeight)
   $imageHeight = _GDIPlus_ImageGetHeight($hImage)
   If ($iY + $iHeight) > $imageHeight Then ; fix last sprite not split
	  $iY = $imageHeight - $iHeight
   EndIf
   $hNewBmp = _GDIPlus_BitmapCloneArea($hImage, $iX, $iY, $iWidth, $iHeight, $GDIP_PXF32ARGB)
   $hNewGC = _GDIPlus_ImageGetGraphicsContext($hNewBmp)
   _GDIPlus_GraphicsDispose($hNewGC)
   Return $hNewBmp
EndFunc