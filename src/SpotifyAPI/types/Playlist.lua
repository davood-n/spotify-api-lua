local AbstractType = require("SpotifyApi.AbstractType")


local Playlist = {}

function Playlist.new(spotifyAccessToken, identifier)
    local object = setmetatable({}, {__index = Playlist})
    local rawReturnData = AbstractType.https.request(
        {
            url = AbstractType.BaseAPIUrl .. "playlist/" .. identifier,
            method = 'GET',
            headers = {
                ["Authorization"] = 'Bearer ' .. spotifyAccessToken,
            }
        }
    )
    object.data = AbstractType.https.json.parse(rawReturnData)
    return object
end


setmetatable(Playlist, {__index = AbstractType})

return Playlist