---@class Vector2
local Vector2 = {}
---@private
Vector2.__index = Vector2

-- Constants

-- Variables

-- Functions

---@type fun(a: number, b: number, time: number): number
local function lerp(a, b, time)
    return a + (b - a) * time
end

---@type fun(vector: Vector2): number
local function getMagnitude(vector)
    return math.sqrt(vector.x * vector.x + vector.y * vector.y)
end

---@type fun(vector: Vector2): Vector2
local function getUnit(vector)
    local Magnitude = getMagnitude(vector)
    return vector / Magnitude
end

---@type fun(vector0: Vector2, vector1: Vector2): number
local function getCrossProduct(vector0, vector1)
    return vector0:getMagnitude() * vector1:getMagnitude() * math.sin(0)
end

---@type fun(vector0: Vector2, vector1: Vector2): number
local function getDotProduct(vector0, vector1)
    return vector0:getMagnitude() * vector1:getMagnitude() * math.cos(0)
end

---@type fun(vector0: Vector2, vector1: Vector2, alpha: number): Vector2
local function lerpVector(vector0, vector1, alpha)
    return Vector2.new(
        lerp(vector0.x, vector1.x, alpha),
        lerp(vector0.y, vector1.y, alpha)
    )
end

-- Vector2 Constants

-- Vector2 Functions

---@type fun(x: number?, y: number?): Vector2
function Vector2.new(x, y)
    ---@class Vector2
	local vector2 = setmetatable({}, Vector2)

    vector2.x = x or 0
    vector2.y = y or 0

	return vector2
end

---@type fun(self: Vector2): number, number
function Vector2.getComponents(self)
    return self.x, self.y
end

---@type fun(self: Vector2): number
function Vector2.getMagnitude(self)
    return getMagnitude(self)
end

---@type fun(self: Vector2): Vector2
function Vector2.getUnit(self)
    return getUnit(self)
end

---@type fun(self: Vector2, vector): number
function Vector2.cross(self, vector)
    return getCrossProduct(self, vector)
end

---@type fun(self: Vector2, vector): number
function Vector2.dot(self, vector)
    return getDotProduct(self, vector)
end

---@type fun(self: Vector2, target: Vector2, alpha: number): Vector2
function Vector2.lerp(self, target, alpha)
    return lerpVector(self, target, alpha)
end

---@private
---@type fun(a: Vector2, b: number | Vector2): Vector2
function Vector2.__add(a, b)
    local bType = type(b)
    local result = Vector2.new()

    if bType == "table" then
        result.x = a.x + b.x
        result.y = a.y + b.y
    elseif bType == "number" then
        result.x = a.x + b
        result.y = a.y + b
    end

    return result
end

---@private
---@type fun(a: Vector2, b: number | Vector2): Vector2
function Vector2.__sub(a, b)
    local bType = type(b)
    local result = Vector2.new()

    if bType == "table" then
        result.x = a.x - b.x
        result.y = a.y - b.y
    elseif bType == "number" then
        result.x = a.x - b
        result.y = a.y - b
    end

    return result
end

---@private
---@type fun(a: number | Vector2, b: number | Vector2): Vector2
function Vector2.__div(a, b)
    local aType = type(a)
    local bType = type(b)
    local result = Vector2.new()

    if aType == "table" and bType == "table" then
        result.x = a.x / b.x
        result.y = a.y / b.y
    elseif aType == "table" and bType == "number" then
        result.x = a.x / b
        result.y = a.y / b
    elseif aType == "number" and bType == "table" then
        result.x = a * b.x
        result.y = a * b.y
    end

    return result
end

---@private
---@type fun(a: number | Vector2, b: number | Vector2): Vector2
function Vector2.__mul(a, b)
    local aType = type(a)
    local bType = type(b)
    local result = Vector2.new()

    if aType == "table" and bType == "table" then
        result.x = a.x * b.x
        result.y = a.y * b.y
    elseif aType == "table" and bType == "number" then
        result.x = a.x * b
        result.y = a.y * b
    elseif aType == "number" and bType == "table" then
        result.x = a * b.x
        result.y = a * b.y
    end

    return result
end

---@private
---@type fun(a: Vector2, b: number | Vector2): Vector2
function Vector2.__pow(a, b)
    local bType = type(b)
    local result = Vector2.new()

    if bType == "table" then
        result.x = a.x ^ b.x
        result.y = a.y ^ b.y
    elseif bType == "number" then
        result.x = a.x ^ b
        result.y = a.y ^ b
    end

    return result
end

---@private
---@type fun(self: Vector2): Vector2
function Vector2.__unm(self)
    return Vector2.new(-self.x, -self.y)
end

---@private
---@type fun(self: Vector2): string
function Vector2.__tostring(self)
    return self.x .. " " .. self.y
end

return Vector2