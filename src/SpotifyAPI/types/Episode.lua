local AbstractType = require("SpotifyApi.AbstractType")


local Episode = {}

function Episode.new(spotifyAccessToken, identifier)
    local object = setmetatable({}, {__index = Episode})
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


setmetatable(Episode, {__index = AbstractType})

return Episode