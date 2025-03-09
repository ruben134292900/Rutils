---@class Vector3
local Vector3 = {}
---@private
Vector3.__index = Vector3

-- Constants

-- Variables

-- Functions

---@type fun(a: number, b: number, time: number): number
local function lerp(a, b, time)
    return a + (b - a) * time
end

---@type fun(vector: Vector3): number
local function getMagnitude(vector)
    return math.sqrt(vector.x ^ 2 + vector.y ^ 2 + vector.z ^ 2)
end

---@type fun(vector: Vector3): Vector3
local function getUnit(vector)
    local Magnitude = getMagnitude(vector)
    return vector / Magnitude
end

---@type fun(vector0: Vector3, vector1: Vector3): Vector3
local function getCrossProduct(vector0, vector1)
    return Vector3.new(
        vector0.y * vector1.z - vector0.z * vector1.y,
        vector0.z * vector1.x - vector0.x * vector1.z,
        vector0.x * vector1.y - vector0.y * vector1.x
    )
end

---@type fun(vector0: Vector3, vector1: Vector3): number
local function getDotProduct(vector0, vector1)
    return vector0:getMagnitude() * vector1:getMagnitude() * math.cos(0)
end

---@type fun(vector0: Vector3, vector1: Vector3, alpha: number): Vector3
local function lerpVector(vector0, vector1, alpha)
    return Vector3.new(
        lerp(vector0.x, vector1.x, alpha),
        lerp(vector0.y, vector1.y, alpha),
        lerp(vector0.z, vector1.z, alpha)
    )
end

-- Vector3 Constants

-- Vector3 Functions

---@type fun(x: number?, y: number?, z: number?): Vector3
function Vector3.new(x, y, z)
    ---@class Vector3
	local vector2 = setmetatable({}, Vector3)

    vector2.x = x or 0
    vector2.y = y or 0
    vector2.z = z or 0

	return vector2
end

---@type fun(self: Vector3): number, number, number
function Vector3.getComponents(self)
    return self.x, self.y, self.z
end

---@type fun(self: Vector3): number
function Vector3.getMagnitude(self)
    return getMagnitude(self)
end

---@type fun(self: Vector3): Vector3
function Vector3.getUnit(self)
    return getUnit(self)
end

---@type fun(self: Vector3, vector): Vector3
function Vector3.cross(self, vector)
    return getCrossProduct(self, vector)
end

---@type fun(self: Vector3, vector): number
function Vector3.dot(self, vector)
    return getDotProduct(self, vector)
end

---@type fun(self: Vector3, target: Vector3, alpha: number): Vector3
function Vector3.lerp(self, target, alpha)
    return lerpVector(self, target, alpha)
end

---@private
---@type fun(a: Vector3, b: number | Vector3): Vector3
function Vector3.__add(a, b)
    local bType = type(b)
    local result = Vector3.new()

    if bType == "table" then
        result.x = a.x + b.x
        result.y = a.y + b.y
        result.z = a.z + b.z
    elseif bType == "number" then
        result.x = a.x + b
        result.y = a.y + b
        result.z = a.z + b
    end

    return result
end

---@private
---@type fun(a: Vector3, b: number | Vector3): Vector3
function Vector3.__sub(a, b)
    local bType = type(b)
    local result = Vector3.new()

    if bType == "table" then
        result.x = a.x - b.x
        result.y = a.y - b.y
        result.z = a.z - b.z
    elseif bType == "number" then
        result.x = a.x - b
        result.y = a.y - b
        result.z = a.z - b
    end

    return result
end

---@private
---@type fun(a: number | Vector3, b: number | Vector3): Vector3
function Vector3.__div(a, b)
    local aType = type(a)
    local bType = type(b)
    local result = Vector3.new()

    if aType == "table" and bType == "table" then
        result.x = a.x / b.x
        result.y = a.y / b.y
        result.z = a.z / b.z
    elseif aType == "table" and bType == "number" then
        result.x = a.x / b
        result.y = a.y / b
        result.z = a.z / b
    elseif aType == "number" and bType == "table" then
        result.x = a / b.x
        result.y = a / b.y
        result.z = a / b.z
    end

    return result
end

---@private
---@type fun(a: number | Vector3, b: number | Vector3): Vector3
function Vector3.__mul(a, b)
    local aType = type(a)
    local bType = type(b)
    local result = Vector3.new()

    if aType == "table" and bType == "table" then
        result.x = a.x * b.x
        result.y = a.y * b.y
        result.z = a.z * b.z
    elseif aType == "table" and bType == "number" then
        result.x = a.x * b
        result.y = a.y * b
        result.z = a.z * b
    elseif aType == "number" and bType == "table" then
        result.x = a * b.x
        result.y = a * b.y
        result.z = a * b.z
    end

    return result
end

---@private
---@type fun(a: Vector3, b: number | Vector3): Vector3
function Vector3.__pow(a, b)
    local bType = type(b)
    local result = Vector3.new()

    if bType == "table" then
        result.x = a.x ^ b.x
        result.y = a.y ^ b.y
        result.z = a.z ^ b.z
    elseif bType == "number" then
        result.x = a.x ^ b
        result.y = a.y ^ b
        result.z = a.z ^ b
    end

    return result
end

---@private
---@type fun(self: Vector3): Vector3
function Vector3.__unm(self)
    return Vector3.new(-self.x, -self.y, -self.z)
end

---@private
---@type fun(self: Vector3): string
function Vector3.__tostring(self)
    return self.x .. " " .. self.y .. " " .. self.z
end

return Vector3