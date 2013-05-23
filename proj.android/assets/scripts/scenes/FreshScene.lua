local FreshScene = class("FreshScene", function()
	return display.newScene("FreshScene")
end)

function FreshScene:ctor()
	local logo = display.newSprite("logo.png", display.cx, display.cy)
	self:addChild(logo)

	self:runAction(transition.sequence({
		CCDelayTime:create(2.0),
		CCCallFunc:create(game.enterStartScene),
	}))
end

return FreshScene
