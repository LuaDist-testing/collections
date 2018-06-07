require "util.class"
export Collection
local *


class Collection
	iter: =>
		error "not implemented"

	size: =>
		error "not implemented"

	index_of: (item) =>
		error "not implemented"

	insert: (i, item) =>
		error "not implemented"

	remove_at: (i) =>
		error "not implemented"

	is_empty: =>
		@size! == 0

	add: (item) =>
		@insert(@size! + 1, item)

	add_all: (collection) =>
		for _, item in ipairs Collection.get_items_in collection
			@add item

	contains: (item) =>
		assert item, "attempt to get contains() for nil item"
		@index_of(item) != nil

	remove: (item) =>
		i = @index_of item
		assert i, "attempt to remove() item not in collection"
		@remove_at(i)

	remove_all: (collection) =>
		for _, item in ipairs Collection.get_items_in collection
			@remove item

	foreach: (consumer) =>
		for _, item in @iter!
			consumer item

	@get_items_in: (collection) ->
		if type(collection) != "table"
			error "attempt to get_items_in() for type '#{type(collection)}'"
		if instance_of(collection, Collection)
			items = {}
			for _, item in collection\iter!
				table.insert(items, item)
			items
		else
			collection

