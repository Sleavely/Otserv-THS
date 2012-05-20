
do
	local revDir = {NORTH=SOUTH,
					EAST=WEST,
					SOUTH=NORTH,
					WEST=EAST}
	function reverseDirection(dir)
		return revDir[dir]
	end
end

QueueClass = {}

function QueueClass:New(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.items = {}
	o.firstindex = 0
	o.lastindex = 0
	return o
end

function QueueClass:Count()
	return self.lastindex - self.firstindex
end

function QueueClass:Push(item)
	self.lastindex = self.lastindex + 1
	self.items[self.lastindex] = item
	
end

function QueueClass:Pop()
	if self:Count() == 0 then
		return nil
	end
	self.firstindex = self.firstindex + 1
	local result = self.items[self.firstindex]
	self.items[self.firstindex] = nil
	
	return result
end

StackClass = {}

function StackClass:New(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.items = {}
	o.count = 0
	return o
end

function StackClass:Count()
	return self.count
end

function StackClass:Push(item)
	self.items[self.count] = item
	self.count = self.count + 1
end

function StackClass:Pop()
	if self:Count() == 0 then
		return nil
	end
	self.count = self.count - 1
	local result = self.items[self.count]
	self.items[self.count] = nil
	return result
end


