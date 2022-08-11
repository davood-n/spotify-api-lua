local AbstractType = require("SpotifyApi.AbstractType")


local Artist = {}

function Artist.new(spotifyAccessToken, identifier)
    local object = setmetatable({}, {__index = Artist})
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


setmetatable(Artist, {__index = AbstractType})

return Artist