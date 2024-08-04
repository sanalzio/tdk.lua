local tdk = require("tdk")
local json = require("json")

local query, error = tdk.ara("küplere binmek", tdk.sozluk.atasozleri_deyimler_sozlugu)

if error then
    print(error)
else
    print(json.encode(query))
end