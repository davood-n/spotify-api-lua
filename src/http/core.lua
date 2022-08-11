require("socket")

-- required modules --
local https = require("ssl.https")
local url = require("socket.url")
local LTN12 = require("ltn12")
local json = require("lib.json")
local base64 = require("lib.base64")
-- end required modules --


local HttpCore = {}
HttpCore.__index = HttpCore

HttpCore.json = json
HttpCore.base64 = base64


HttpCore.LuaSocketModules = 
{
    Url = url,    
}


function HttpCore.request(options)
    assert(options ~= nil, "'options' must not be nil.")
    assert(options.url ~= nil, "URL needs to be specified.")

    -- Initialize vars --
    local url_ = options.url
    local method = string.upper(options.method) or "GET"
    local body = ""
    local contentLength = 0
    local headerTable = options.headers or {} 

    
    if options.payload ~= nil then
        -- beggning of body builder --
        -- body = options.payload
        assert(type(options.payload) == "table", "payload must be a table!")
        for k,v in pairs(options.payload) do
            if body == "" then
                body = url.escape(k) .. "=" .. url.escape(v)
            else
                body = body .. "&" .. url.escape(k) .. "=" .. url.escape(v)
            end

        end
    end
    
    
    contentLength = string.len(body)
    
    if options.headers ~= nil then
        headerTable = options.headers
    end
    
    -- Setting default header stuff --
    headerTable["Content-Length"] = contentLength
    if headerTable["Content-Type"] == "" or headerTable["Content-Type"] == nil then
        headerTable["Content-Type"] = "application/x-www-payload-urlencoded"
    end
    -- End default header stuff -- 

    local returnData = {}
    https.request{
        url = url_,
        headers = headerTable,
        method = method,
        body = body,
        source = LTN12.source.string(body),
        sink = LTN12.sink.table(returnData)
    }


    local chunkBuilder = ""
    for i=1,#returnData do
        chunkBuilder = chunkBuilder .. returnData[i]
    end
    return chunkBuilder
end

return HttpCore