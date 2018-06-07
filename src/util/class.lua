local class_is_a
instance_of = function(obj, klass)
  return obj and klass and class_is_a(obj.__class, klass)
end
class_is_a = function(a, b)
  return a and b and (a == b or a.__parent and class_is_a(a.__parent, b))
end
