local TLabel = class("TLabel", function()
	return ui.newBMFontLabel({
		text = "",
		font = "UIFont.fnt"
	})
end)

function TLabel:ctor(params)
	self.name = params.name or '<unnamed>'

	if params.text then self.setString(params.text) end
	local x, y = params.x, params.y
	if x and y then self:setPosition(x, y) end

	function self.onRecvTime(event)
		self:setString(self.name .. "," .. tostring(os.date("*t")["sec"]))
		print(string.format("[%d] %s", self:getTag(), self:getString()))
	end
	game.eventManager:addEventListener("time", self.onRecvTime)
end

function TLabel:destory()
	print(self.name .. " destory")
	game.eventManager:removeEventListener("time", self.onRecvTime)
end

return TLabel
