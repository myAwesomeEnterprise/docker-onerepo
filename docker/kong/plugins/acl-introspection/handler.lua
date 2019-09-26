local BasePlugin = require "kong.plugins.base_plugin"
-- http://w3.impa.br/~diego/software/luasocket/http.html
local http = require "socket.http"

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

  local aclPath = "https://127.0.0.1:8443/api/v1/acl/allow"
  local aclMethod = "POST"
  local aclBody = [[login=user&password=123]]
  local payload = [[ {"key":"My Key","name":"My Name","description":"The description","state":1} ]]

  -- https://gist.github.com/lidashuang/6286723
  local response, code, headers = http.request{
    url = aclPath,
    method = aclMethod,
    headers = {
    	["Content-Type"] = "application/json",
    	["Content-Length"] = aclBody:len()
    },
    source = ltn12.source.string(aclBody)
  }

  if code > 400 && code < 500 then
    return kong.response.exit(httpForbiddenCode, {
      message = httpForbiddenMsg
    })
  end

  kong.service.request.set_header("x-acl-allowed", true)
end

return AclIntrospection
