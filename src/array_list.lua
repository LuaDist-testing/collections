require("collection")
local increment_indices, decrement_indices, insert_index
do
  local _class_0
  local _parent_0 = Collection
  local _base_0 = {
    iter = function(self)
      return ipairs(self.items)
    end,
    size = function(self)
      return #self.items
    end,
    get = function(self, i)
      i = self:get_true_index(i)
      return self.items[i]
    end,
    insert = function(self, i, item)
      assert(item, "attempt to insert() nil item")
      i = self:get_true_index(i)
      assert(i, "attempt to insert() to nil index")
      if i < 1 or i > self:size() + 1 then
        error("index out of bounds: " .. tostring(i))
      end
      increment_indices(self, i)
      table.insert(self.items, i, item)
      return insert_index(self, i, item)
    end,
    index_of = function(self, item)
      assert(item, "attempt to get index_of() nil item")
      local indices = self:indices_of(item)
      if indices and #indices > 0 then
        return indices[1]
      end
    end,
    indices_of = function(self, item)
      assert(item, "attempt to get indices_of() nil item")
      return self.indices[item]
    end,
    remove_at = function(self, i)
      i = self:get_true_index(i)
      assert(i, "attempt to remove_at() nil index")
      decrement_indices(self, i + 1)
      local item = self.items[i]
      table.remove(self.items, i)
      local indices = self.indices[item]
      for j, index in ipairs(indices) do
        if index == i then
          table.remove(indices, j)
          if #indices == 0 then
            self.indices[item] = nil
          end
          break
        end
      end
    end,
    clear = function(self)
      for k, _ in pairs(self.items) do
        self.items[k] = nil
      end
      for k, _ in pairs(self.indices) do
        self.indices[k] = nil
      end
    end,
    map = function(self, func)
      if type(func) ~= "function" then
        error("attempt to map() with type '" .. tostring(type(func)) .. "'")
      end
      local result = ArrayList()
      for _, item in self:iter() do
        result:add(func(item))
      end
      return result
    end,
    filter = function(self, pred)
      if type(pred) ~= "function" then
        error("attempt to filter() with type '" .. tostring(type(pred)) .. "'")
      end
      local result = ArrayList()
      for _, item in self:iter() do
        if pred(item) then
          result:add(item)
        end
      end
      return result
    end,
    unique = function(self)
      local result = ArrayList()
      for _, item in self:iter() do
        if not (result:contains(item)) then
          result:add(item)
        end
      end
      return result
    end,
    get_true_index = function(self, i)
      if i < 0 then
        return self:size() + 1 + i
      else
        return i
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, items)
      self.items = { }
      self.indices = { }
      if items then
        return self:add_all(items)
      end
    end,
    __base = _base_0,
    __name = "ArrayList",
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
  ArrayList = _class_0
end
increment_indices = function(self, start_i)
  for i = start_i, self:size() do
    local item = self.items[i]
    local indices = self.indices[item]
    for j, index in ipairs(indices) do
      if index == i then
        indices[j] = indices[j] + 1
      end
    end
  end
end
decrement_indices = function(self, start_i)
  for i = start_i, self:size() do
    local item = self.items[i]
    local indices = self.indices[item]
    for j, index in ipairs(indices) do
      if index >= start_i then
        indices[j] = indices[j] - 1
      end
    end
  end
end
insert_index = function(self, i, item)
  local indices = self.indices[item]
  if not indices then
    indices = { }
    self.indices[item] = indices
  end
  table.insert(indices, i)
  return table.sort(indices)
end
