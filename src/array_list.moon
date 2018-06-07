require "collection"
export ArrayList
local *


class ArrayList extends Collection
	new: (items) =>
		@items = {}
		@indices = {}
		@add_all items if items
	
	iter: =>
		ipairs @items

	size: =>
		#@items

	get: (i) =>
		i = @get_true_index i
		@items[i]

	insert: (i, item) =>
		assert item, "attempt to insert() nil item"
		i = @get_true_index i
		assert i, "attempt to insert() to nil index"
		if i < 1 or i > @size! + 1
			error "index out of bounds: #{i}"
		increment_indices self, i
		table.insert @items, i, item
		insert_index self, i, item

	index_of: (item) =>
		assert item, "attempt to get index_of() nil item"
		indices = @indices_of item
		if indices and #indices > 0
			indices[1]

	indices_of: (item) =>
		assert item, "attempt to get indices_of() nil item"
		@indices[item]
	
	remove_at: (i) =>
		i = @get_true_index i
		assert i, "attempt to remove_at() nil index"
		decrement_indices self, i + 1
		item = @items[i]
		table.remove(@items, i)
		indices = @indices[item]
		for j, index in ipairs indices
			if index == i
				table.remove indices, j
				if #indices == 0
					@indices[item] = nil
				break

	clear: =>
		for k, _ in pairs @items
			@items[k] = nil
		for k, _ in pairs @indices
			@indices[k] = nil

	map: (func) =>
		if type(func) != "function"
			error("attempt to map() with type '#{type(func)}'")
		result = ArrayList!
		for _, item in @iter!
			result\add func(item)
		result

	filter: (pred) =>
		if type(pred) != "function"
			error("attempt to filter() with type '#{type(pred)}'")
		result = ArrayList!
		for _, item in @iter!
			result\add item if pred(item)
		result

	unique: =>
		result = ArrayList!
		for _, item in @iter!
			result\add item unless result\contains(item)
		result

	get_true_index: (i) =>
		if i < 0 then @size! + 1 + i
		else i


increment_indices = (start_i) =>
	for i = start_i, @size!
		item = @items[i]
		indices = @indices[item]
		for j, index in ipairs indices
			if index == i
				indices[j] += 1


decrement_indices = (start_i) =>
	for i = start_i, @size!
		item = @items[i]
		indices = @indices[item]
		for j, index in ipairs indices
			if index >= start_i
				indices[j] -= 1

	
insert_index = (i, item) =>
	indices = @indices[item]
	if not indices
		indices = {}
		@indices[item] = indices
	table.insert indices, i
	table.sort indices

