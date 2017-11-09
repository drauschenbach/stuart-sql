local isInstanceOf = function(obj, class)
  return type(obj) == 'table' and obj.isInstanceOf ~= nil and obj:isInstanceOf(class) end
return isInstanceOf
