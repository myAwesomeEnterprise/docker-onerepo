local BasePlugin = require "kong.plugins.base_plugin"

local AclIntrospection = BasePlugin:extend()

AclIntrospection.VERSION = "1.0.0"
AclIntrospection.PRIORITY = 10

function AclIntrospection:new()
  AclIntrospection.super.new(self, "acl-introspection")
end

function AclIntrospection:access(config)
  AclIntrospection.super.access(self)

  -- Implement any custom logic here
end

return AclIntrospection
