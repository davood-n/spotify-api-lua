--[[ Required modules ]]--

local https = require('http.core')

--[[ End Required modules ]]--


local AbstractType = {}
AbstractType.__index = AbstractType

AbstractType.BaseAPIUrl = "https://api.spotify.com/v1/"
AbstractType.https = https

function AbstractType.new(spotifyAccessToken, identifier)
    local object = setmetatable({},{__index = AbstractType})
    local rawReturnData = https.request(
        {
            url = AbstractType.BaseAPIUrl .. "track/" .. identifier,
            method = 'GET',
            headers = {
                ["Authorization"] = 'Bearer ' .. spotifyAccessToken,
            }
        }
    )
    object.data = https.json.parse(rawReturnData)
    return object
end

function AbstractType:getData()
    return self.data
end

return AbstractType