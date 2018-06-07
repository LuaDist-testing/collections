# collections
Provides basic collection classes for Lua

### Included Classes
- Collection (abstract base class for all collections in the module)
- ArrayList
- Set

More to come...

### ArrayList

`ArrayList`'s Implementation caches its items' indices to speed up O(n) calls like `contains()` and `index_of()`.

```lua
require "array_list"

list = ArrayList()
shallow_collection_copy = ArrayList(collection)
shallow_array_copy = ArrayList { 1, 2, 3 }

-- All methods accepting an index can also use negative indices, where -1 is the last item in the list,
-- -2 is the second to last item in the list, etc.
list:size()
list:iter() -- equivalent to ipairs(list.items)
list:get(index)
list:is_empty()
list:insert(index, item)
list:add(item)
list:add_all(items) -- can be array or another collection
list:index_of(item) -- first index of the item
list:indices_of(item) -- array of indices of all occurrences of the item
list:contains(item)
list:remove_at(index)
list:remove(item)
list:remove_all(items) -- can be array or another collection
list:clear()
list:map(func) -- returns copy of list with map function applied
list:filter(pred) -- returns copy of list with filter applied
list:foreach(consumer) -- equivalent to for _, item in list:iter()
list:unique() -- returns copy of list with unique elements only; order is preserved
list:get_true_index(index) -- returns actual index, allowing for negative indices
```

###Set

```lua
require "set"

set = Set()
shallow_collection_copy = Set(collection)
shallow_array_copy = Set { 1, 2, 3 }
-- the Set class extends ArrayList, so all available methods are the same.
```
