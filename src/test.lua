local tdk = require("tdk")

local query, error = tdk.ara("küplere binmek", tdk.sozluk.atasozleri_deyimler_sozlugu, nil)

if error then
    print(error)
else
    print(query)
end