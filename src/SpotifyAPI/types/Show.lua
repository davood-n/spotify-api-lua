local AbstractType = require("SpotifyApi.AbstractType")


local Show = {}

function Show.new(spotifyAccessToken, identifier)
    local object = setmetatable({}, {__index = Show})
    local rawReturnData = AbstractType.https.request(
        {
            url = AbstractType.BaseAPIUrl .. "episode/" .. identifier,
            method = 'GET',
            headers = {
                ["Authorization"] = 'Bearer ' .. spotifyAccessToken,
            }
        }
    )
    object.data = AbstractType.https.json.parse(rawReturnData)
    return object
end


setmetatable(Show, {__index = AbstractType})

return Show