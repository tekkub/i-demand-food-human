
function class(parent)
  local _class = {_prototype = {}}
  local class_mt = {}
  setmetatable(_class, class_mt)

  if parent then
    class_mt.__index = parent

    if parent._prototype then
      setmetatable(_class._prototype, {__index = parent._prototype})
    end
  end

  function class_mt:__call(...)
    local instance = setmetatable({}, {__index = self._prototype})
    if instance.Initialize then instance:Initialize(...) end
    return instance
  end

  return _class, _class._prototype
end
