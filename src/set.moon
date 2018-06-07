require "array_list"
export Set


class Set extends ArrayList
	insert: (i, item) =>
		if not @contains item
			super i, item

