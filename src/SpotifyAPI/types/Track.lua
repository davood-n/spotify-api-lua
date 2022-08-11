local AbstractType = require("SpotifyApi.AbstractType")


local Track = {}

function Track.new(spotifyAccessToken, identifier)
    local object = setmetatable({}, {__index = Track})
    local rawReturnData = AbstractType.https.request(
        {
            url = AbstractType.BaseAPIUrl .. "track/" .. identifier,
            method = 'GET',
            headers = {
                ["Authorization"] = 'Bearer ' .. spotifyAccessToken,
            }
        }
    )
    object.data = AbstractType.https.json.parse(rawReturnData)
    return object
end


setmetatable(Track, {__index = AbstractType})

return Track