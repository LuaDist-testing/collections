export instance_of
local *


instance_of = (obj, klass) ->
	obj and klass and class_is_a obj.__class, klass

class_is_a = (a, b) ->
	a and b and (a == b or a.__parent and class_is_a a.__parent, b)

