--[[
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
]]

frozen = false
dancing = false
RMS = 0
freestyle = false
freestyle_img = "freestyle"
freestyle_spritesheets = {
	'dervish',
	'freestyle',
	'hula',
	'jumping',
	'stepping',
	'waving',
	'zitabata',
	'zombie',
}
freestyle_counter = 2
filename = ""

function Initialize()
	filename = SKIN:GetMeasure('GetFilename'):GetStringValue()
	freestyle = (filename == "freestyle.ini")
end

function Update()
	RMS = SKIN:GetMeasure('GetRMS'):GetValue()
	if not frozen then
		if ((100 * RMS) >= 1) then
			if freestyle then
				if freestyle_counter <= 0 then
					freestyle_img = freestyle_spritesheets[math.random(#freestyle_spritesheets)]
					freestyle_counter = math.random(1, 3)
				elseif (SKIN:GetMeasure('FrameCounter'):GetValue() == 0) then
					freestyle_counter = freestyle_counter - 1
				end
				SetSpritesheet(freestyle_img)
			else
				SetSpritesheet(GetSkinName())
			end
			dancing = true
		else
			SetSpritesheet('waiting')
			dancing = false
			freestyle_counter = 2
		end
	end
end

function MouseOver()
	frozen = true
	SetSpritesheet('picked_up')
end

function MouseLeave()
	if dancing then
		SetSpritesheet(GetSkinName())
	end
	frozen = false
end

function GetSkinName()
	return filename:sub(1, -5)
end

function SetSpritesheet(name)
	SKIN:Bang('!SetOption', 'SpritesheetAnimator', 'BitmapImage', "img\\" .. name .. ".png")
end