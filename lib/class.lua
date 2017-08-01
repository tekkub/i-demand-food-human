
local function noop() end

function class(parent)
  local class_mt = {}
  local instances_mt = {}

  local _class = {
    _instances = setmetatable({}, instances_mt),
    _prototype = {super = noop}
  }
  setmetatable(_class, class_mt)

  if parent then
    class_mt.__index = parent

    function instances_mt:__newindex(k, v)
      parent._instances[k] = v
      return rawset(self, k, v)
    end

    if parent._prototype then
      setmetatable(_class._prototype, {__index = parent._prototype})

      function _class._prototype:super(name, ...)
        local f = parent._prototype[name]
        if f then return f(self, ...) end
      end
    end
  end

  function class_mt:__call(...)
    local instance = setmetatable({}, {__index = self._prototype})
    self._instances[instance] = true
    if instance.Initialize then instance:Initialize(...) end
    return instance
  end

  return _class, _class._prototype
end
