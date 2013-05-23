local StartScene = class("StartScene", function()
	return display.newScene("StartScene")
end)

function StartScene:ctor()
	local lab = ui.newBMFontLabel({
		text = "Let's ROCK!",
		font = "UIFont.fnt",
		x = display.cx,
		y = display.cy,
	})
	self:addChild(lab)

	for i = 1, 3 do
		local cls = require("ui.label.TLabel")
		local tlab = cls.new({
			name = 'lab_' .. i,
			text = 'lab_' .. i,
			x = 200 * i,
			y = display.top - 100
		})
		tlab:setTag(i)
		self:addChild(tlab)
	end

	self.btSend = ui.newTTFLabelMenuItem({
		text = "Send",
		size = 64,
		x = display.cx,
		y = display.bottom + 100,
		listener = function()
			game.eventManager:dump()
			game.eventManager:dispatchEvent({
				etype = "time"
			})
			self.btSend.count = self.btSend.count + 1
			if self.btSend.count > 3 then
				game.enterFreshScene()
				return
			end
			local tlab = self:getChildByTag(self.btSend.count)
			if tlab then
				tlab:destory()
				self:removeChild(tlab, true)
				tlab = nil
			end
		end
	})
	self.btSend.count = -1
	local menu = ui.newMenu({ self.btSend })
	self:addChild(menu)

	-- keypad layer, for android
    self.layer = display.newLayer()
    self.layer:addKeypadEventListener(function(event)
        if event == "back" then
            audio.playSound(GAME_SFX.backButton)
            self.layer:setKeypadEnabled(false)
            game.enterFreshScene()
        end
    end)
    self:addChild(self.layer)
end

return StartScene
