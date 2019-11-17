local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local Entity = require 'lib.core.entity'

local Graphics = Class{
    __includes = Entity,
    type = 'graphics',
    name = 'graphics',
}

function Graphics:add(opt)
    Entity.add(self, opt)

    self:register('pre-draw', function() self:preDraw() end)
    self:register('post-draw', function() self:postDraw() end)
    
    self.properties.graphics = (opt.graphics and Class.clone(opt.graphics)) or {}
end

function Graphics:setSize(width, height)
    local w = width or 0
    local h = height or w
    self.size = vector(w,h)
end

function Graphics:setGraphics()
    for k,v in pairs(self.properties.graphics) do love.graphics[k](v) end
end

function Graphics:preDraw()
    love.graphics.reset()
    self:setGraphics()
    love.graphics.applyTransform(self.transform)
end

function Graphics:postDraw()
    love.graphics.reset()
end

return Graphics
