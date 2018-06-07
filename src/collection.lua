require("util.class")
do
  local _class_0
  local _base_0 = {
    iter = function(self)
      return error("not implemented")
    end,
    size = function(self)
      return error("not implemented")
    end,
    index_of = function(self, item)
      return error("not implemented")
    end,
    insert = function(self, i, item)
      return error("not implemented")
    end,
    remove_at = function(self, i)
      return error("not implemented")
    end,
    is_empty = function(self)
      return self:size() == 0
    end,
    add = function(self, item)
      return self:insert(self:size() + 1, item)
    end,
    add_all = function(self, collection)
      for _, item in ipairs(Collection.get_items_in(collection)) do
        self:add(item)
      end
    end,
    contains = function(self, item)
      assert(item, "attempt to get contains() for nil item")
      return self:index_of(item) ~= nil
    end,
    remove = function(self, item)
      local i = self:index_of(item)
      assert(i, "attempt to remove() item not in collection")
      return self:remove_at(i)
    end,
    remove_all = function(self, collection)
      for _, item in ipairs(Collection.get_items_in(collection)) do
        self:remove(item)
      end
    end,
    foreach = function(self, consumer)
      for _, item in self:iter() do
        consumer(item)
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function() end,
    __base = _base_0,
    __name = "Collection"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self.get_items_in = function(collection)
    if type(collection) ~= "table" then
      error("attempt to get_items_in() for type '" .. tostring(type(collection)) .. "'")
    end
    if instance_of(collection, Collection) then
      local items = { }
      for _, item in collection:iter() do
        table.insert(items, item)
      end
      return items
    else
      return collection
    end
  end
  Collection = _class_0
  return _class_0
end
