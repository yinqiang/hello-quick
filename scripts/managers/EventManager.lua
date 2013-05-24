if EventManager then return EventManager.instance end

EventManager = class("EventManager")

function EventManager:ctor()
	self.name = "EventManager"

	self.events = {}
end

function EventManager:getName()
	return self.name
end

function EventManager:getEvents()
	return table.keys(self.events)
end

function EventManager:addEventListener(eventType, listener)
	assert(eventType, "EventManager:addEventListener - eventType is nil")
	assert(eventType ~= "", "EventManager:addEventListener - eventType is empty string")
	assert(type(listener) == "function", "EventManager:addEventListener - listener is not a function")
	local group = self.events[eventType]
	if not group then
		self.events[eventType] = {count = 0, listeners = {}}
		group = self.events[eventType]
	end
	group.count = group.count + 1
	group.listeners[listener] = 1
end

function EventManager:removeEventListener(eventType, listener)
	assert(eventType, "EventManager:removeEventListener - eventType is nil")
	assert(eventType ~= "", "EventManager:removeEventListener - eventType is empty string")
	assert(type(listener) == "function", "EventManager:removeEventListener - listener is not a function")
	local group = self.events[eventType]
	if group and group.listeners[listener] then
		group.count = group.count - 1
		group.listeners[listener] = nil
		if group.count == 0 then
			group.count = nil
			group.listeners = nil
			self.events[eventType] = nil
		end
	end
end

function EventManager:dispatchEvent(event)
	assert(type(event) == "table", "EventManager:dispatchEvent - event is not a table")
	assert(event.etype, "EventManager:dispatchEvent - event.etype is nil")
	if not self.events[event.etype] then return end
	for listener, _ in pairs(self.events[event.etype].listeners) do
		listener(event)
	end
end

function EventManager:dump()
	local line_ = string.rep("-", 10)
	print(line_)
	for eventType, v in pairs(self.events) do
		print("etype:" .. eventType .. ", listeners:" .. v.count)
		for listener, _ in pairs(v.listeners) do
			local info = debug.getinfo(listener, "S")
			print(string.format("src:%s, line:%d", info.short_src, info.linedefined))
		end
	end
	print(line_)
end

EventManager.instance = EventManager.new()

return EventManager.instance
