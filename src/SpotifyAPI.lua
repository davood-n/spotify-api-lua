local https = require('http.core')

local Result = require('SpotifyAPI.Result')

local SpotifyAPI = {}
SpotifyAPI.__index = SpotifyAPI

    SpotifyAPI.Enum = {

    }

    function SpotifyAPI.new(clientId, clientSecret)
        local object = setmetatable({},{__index = SpotifyAPI})
        local rawResponse = https.request({
            url = 'https://accounts.spotify.com/api/token',
            method = 'POST',
            headers = {
                ["Authorization"] = 'Basic ' .. clientId .. ':' .. clientSecret,
                ["Content-Type"] = 'application/x-www-form-urlencoded',
            },
            payload = 'grant_type=client_credentials'
        })
        object.accessToken = https.json.parse(rawResponse)["access_token"]

        return object
    end

    function SpotifyAPI:search(options)
        assert(type(options) == "table", "Invalid argument: type must be a table, got ".. type(options))
        assert(options.query, "A query string must be provided! Pleases define o.query!")


        -- [[ Local helper functions ]] --

        local filterBuilder = function(filterTable)
            local filterString = ""
            for k,v in pairs(filterTable) do
                filterString = filterString .. https.LuaSocketModules.Url.escape(k) .. ":" .. https.LuaSocketModules.Url.escape(v)
    
                if (k ~= #filterTable) then
                    filterString = filterString .. "+"
                end
            end
            return filterString
        end

        local queryBuilder = function (queryTable)
            local queryString = "?"
            for k,v in pairs(queryTable) do
                queryString = queryString .. https.LuaSocketModules.Url.escape(k) .. "=" .. https.LuaSocketModules.Url.escape(v)
    
                if (k ~= #queryTable) then
                    queryString = queryString .. "&"
                end
            end
            return queryString
        end
        

        -- [[ End local helper functions ]] --


        local query = options.query
        -- Add filters to query 
        if options.filters then
            assert(type(options.filters) == "table", "Invalid type for 'filters' option: type must be a table, got ".. type(options.filters))

            query = query .. "%20" .. filterBuilder(options.filters)
        end

        local type = options.type or "album,track,artist,playlist,show,episode"
        local limit = options.limit or 25
        local offset = options.offset or 0

        local escapedQuery = https.LuaSocketModules.Url.escape(query)
        local headerTable = {
            ["Authorization"] = 'Bearer ' .. self.accessToken,
        }

        local searchUrl = "https://api.spotify.com/v1/search" .. queryBuilder({
            q = escapedQuery,
            type = type,
            limit = limit,
            offset = offset
        })

        local rawResponse = https.request({
            url = searchUrl,
            method = "GET",
            headers = headerTable,
        })

        local response = https.json.parse(rawResponse)

        return Result.new(self.accessToken, response)
    end

return SpotifyAPI
