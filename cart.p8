pico-8 cartridge // http://www.pico-8.com
version 27
__lua__
_has = function(e, _c)
  for c in all(e) do
    if not e[_c] then
      return false
    end
  end
  return true
end
System = function(components, func)
  return function(entity_list)
    for e in all(entity_list) do
      if _has(e, components) then
        func()
      end
    end
  end
end
local Entity
do
  local _class_0
  local _base_0 = {
    addCompo = function(self, _c)
      _c.hostEntity = self
      return add(self.compoList, _c)
    end,
    rmCompo = function(self, _compoName)
      for c in all(self.compoList) do
        if c.name == _compoName then
          del(self.compoList, c.name)
        end
      end
    end,
    getCompo = function(self, _compoName)
      for c in all(self.compoList) do
        if c.name == _compoName then
          return c
        end
      end
    end,
    update = function(self)
      for c in all(self.compoList) do
        c:update()
      end
    end,
    draw = function(self)
      for c in all(self.compoList) do
        c:draw()
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, _name)
      self.name = _name
      self.compoList = { }
      self.id = ''
      return addCompo(Position())
    end,
    __base = _base_0,
    __name = "Entity"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Entity = _class_0
end
local Player
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    draw = function(self)
      local pos = self:getCompo("pos")
      return circfill(pos.x, pos.y, 4, 8)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(_x, _y)
      if _x == nil then
        _x = 64
      end
      if _y == nil then
        _y = 64
      end
      local pos = self:getCompo("pos")
      pos.x = _x
      pos.y = _y
      return self:addCompo(PlayerControl())
    end,
    __base = _base_0,
    __name = "Player",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Player = _class_0
end
local Component
do
  local _class_0
  local _base_0 = {
    update = function(self) end,
    draw = function(self) end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, _name)
      self.name = _name
      self.id = ''
      self.hostEntity = ''
    end,
    __base = _base_0,
    __name = "Component"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Component = _class_0
end
local Position
do
  local _class_0
  local _parent_0 = Component
  local _base_0 = {
    update = function(self)
      self.x = self.x + self.vel.x
      self.y = self.y + self.vel.y
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, _x, _y, _vx, _vy)
      if _x == nil then
        _x = 0
      end
      if _y == nil then
        _y = 0
      end
      if _vx == nil then
        _vx = 0
      end
      if _vy == nil then
        _vy = 0
      end
      self.name = "pos"
      self.x = _x
      self.y = _y
      self.vel = {
        x = _vx,
        y = _vy
      }
    end,
    __base = _base_0,
    __name = "Position",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Position = _class_0
end
local PlayerControl
do
  local _class_0
  local _parent_0 = Component
  local _base_0 = {
    update = function(self)
      local pos = self.hostEntity.getCompo("pos")
      if (btn(0)) then
        pos.vel.x = 1
      end
      if (btn(1)) then
        pos.vel.x = -1
      end
      if (btn(2)) then
        pos.vel.y = 1
      end
      if (btn(3)) then
        pos.vel.y = -1
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self)
      self.name = "player-control"
    end,
    __base = _base_0,
    __name = "PlayerControl",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  PlayerControl = _class_0
end
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    draw = function(self)
      local pos = self:getCompo("pos")
      return circfill(pos.x, pos.y, 4, 8)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(_x, _y)
      if _x == nil then
        _x = 64
      end
      if _y == nil then
        _y = 64
      end
      local pos = self:getCompo("pos")
      pos.x = _x
      pos.y = _y
      return self:addCompo(PlayerControl())
    end,
    __base = _base_0,
    __name = "Player",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Player = _class_0
end
_init = function()
  print("hallo")
  world = { }
  return add(world, Player())
end
_update = function()
  for e in all(world) do
    e:update()
  end
end
_draw = function()
  cls()
  print("Hallo")
  for e in all(world) do
    e:draw()
  end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
