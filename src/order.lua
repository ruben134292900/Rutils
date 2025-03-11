---@class Order
local Order = {}
Order.__index = Order

-- Order Functions

---@type fun(): Order
function Order.new()
    ---@class Order
	local order = setmetatable({}, Order)

    order.from = 0
    order.to = 0

    ---@type (function | Order)[][]
    order.data = {}

	return order
end

---@type fun(self: Order, item: function | Order, index: integer)
function Order.addItem(self, item, index)
    self.from = self.from > index and index or self.from
    self.to = self.to < index and index or self.to

    if self.data[index] then
        table.insert(self.data[index], item)
    else
        self.data[index] = {}
        table.insert(self.data[index], item)
    end
end

--- Note: Arguments pass to other sub orders.
---@type fun(self: Order, ...: any)
function Order.draw(self, ...)
    for index = self.from, self.to do
        if self.data[index] then
            for i, v in next, self.data[index] do
                if type(v) == "function" then
                    v(...)
                else
                    v:draw(...)
                end
                self.data[index][i] = nil
            end
            self.data[index] = nil
        end
    end
end

return Order