
local function noop() end

function class(parent)
  local class_mt = {}
  local instances_mt = {}

  local class_ = {
    _instances = setmetatable({}, instances_mt),
    _prototype = {_super = noop}
  }
  setmetatable(class_, class_mt)

  if parent then
    class_mt.__index = parent

    function instances_mt:__newindex(k, v)
      parent._instances[k] = v
      return rawset(self, k, v)
    end

    if parent._prototype then
      setmetatable(class_._prototype, {__index = parent._prototype})

      function class_._prototype:_super(name, ...)
        local f = parent._prototype[name]
        if f then return f(self, ...) end
      end
    end
  end

  function class_mt:__call(...)
    local instance = setmetatable({}, {__index = self._prototype})
    self._instances[instance] = true
    if instance.initialize then instance:initialize(...) end
    return instance
  end

  return class_, class_._prototype
end
