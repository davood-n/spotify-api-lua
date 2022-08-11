local AbstractType = require("SpotifyApi.AbstractType")


local Album = {}

function Album.new(spotifyAccessToken, identifier)
    local object = setmetatable({}, {__index = Album})
    local rawReturnData = AbstractType.https.request(
        {
            url = AbstractType.BaseAPIUrl .. "artist/" .. identifier,
            method = 'GET',
            headers = {
                ["Authorization"] = 'Bearer ' .. spotifyAccessToken,
            }
        }
    )
    object.data = AbstractType.https.json.parse(rawReturnData)
    return object
end


setmetatable(Album, {__index = AbstractType})

return Album