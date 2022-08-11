--[[ Required modules ]]--
local Album = require("types.Album")
local Artist = require("types.Artist")
local Episode = require("types.Episode")
local Playlist = require("types.Playlist")
local Track = require("types.Track")
--[[ End required modules ]]--


local Result = {}
Result.__index = Result

function Result.new(spotifyAccessToken, data)
    local object = setmetatable({},{__index = Result})
    object.spotifyAccessToken = spotifyAccessToken
    object.data = data

    return object
end

function Result:getTracks()
    local temporaryTableOfTrackObjects = {}
    for i in pairs(self.data.tracks.items) do
        table.insert(temporaryTableOfTrackObjects, 1, Track.new(self.spotifyAccessToken, self.data.tracks.items[i].track.id))
    end
    return temporaryTableOfTrackObjects
end

function Result:getAlbums()
    local temporaryTableOfAlbumObjects = {}
    for i in pairs(self.data.albums.items) do
        table.insert(temporaryTableOfAlbumObjects, 1, Album.new(self.spotifyAccessToken, self.data.albums.items[i].album.id))
    end
    return temporaryTableOfAlbumObjects
end

function Result:getArtists()
    local temporaryTableOfArtistObjects = {}
    for i in pairs(self.data.artists.items) do
        table.insert(temporaryTableOfArtistObjects, 1, Artist.new(self.spotifyAccessToken, self.data.artists.items[i].artist.id))
    end
    return temporaryTableOfArtistObjects
end

function Result:getEpisodes()
    local temporaryTableOfEpisodeObjects = {}
    for i in pairs(self.data.episodes.items) do
        table.insert(temporaryTableOfEpisodeObjects, 1, Episode.new(self.spotifyAccessToken, self.data.episodes.items[i].episode.id))
    end
    return temporaryTableOfEpisodeObjects
end


function Result:getShows()
    local temporaryTableOfShowObjects = {}
    for i in pairs(self.data.shows.items) do
        table.insert(temporaryTableOfShowObjects, 1, Playlist.new(self.spotifyAccessToken, self.data.shows.items[i].show.id))
    end
    return temporaryTableOfShowObjects
end

function Result:getPlaylists()
    local temporaryTableOfPlaylistObjects = {}
    for i in pairs(self.data.playlists.items) do
        table.insert(temporaryTableOfPlaylistObjects, 1, Playlist.new(self.spotifyAccessToken, self.data.playlists.items[i].playlist.id))
    end
    return temporaryTableOfPlaylistObjects
end



return Result
