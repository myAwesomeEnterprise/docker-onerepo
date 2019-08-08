local BasePlugin = require "kong.plugins.base_plugin"

local AclIntrospection = BasePlugin:extend()

AclIntrospection.VERSION = "1.0.0"
AclIntrospection.PRIORITY = 10

function AclIntrospection:new()
  AclIntrospection.super.new(self, "acl-introspection")
end

function AclIntrospection:access(conf)
  AclIntrospection.super.access(self)

  -- Implement any custom logic here
  ngx.log(ngx.INFO, "========= edc:ACL v0.0.007 =========")

  local httpForbiddenCode = conf.hide and 404 or 403
  local httpForbiddenMsg  = conf.hide and "Not Found" or "Access Forbidden"

  local requestPath       = kong.request.get_path() -- example /api/v1/users
  local requestAuth       = kong.request.get_header("x-authenticated-userid") -- uuid | nil

  if false then
    return kong.response.exit(httpForbiddenCode, {
      message = httpForbiddenMsg
    })
  end

  kong.service.request.set_header("x-acl-allowed", true)
end

return AclIntrospection
