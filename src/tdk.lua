------------------- ○ --------------------
--○    lua için TDK api kütüphanesi    ○--
------------------- ○ --------------------
---                                    ---
---           Lisans: GPLv3            ---
---          Yazar: Sanalzio           ---
---                                    ---
---   Bağımlılıklar:                   ---
---    - LUA 5.1 - 5.4,                ---
---    - LuaSocket,                    ---
---    - json.lua,                     ---
---    - İnternet Bağlantısı           ---
---     (Sadece kullanım esnasında)    ---
---                                    ---
---   Uyarı:                           ---
---    LuaSocket'in kurulduğu lua      ---
---    sürümünü kullanmalısınız,       ---
---    aksi taktirde bazı hatalar      ---
---    alabilirsiniz.                  ---
---                                    ---
------------------------------------------




--- Kullanımı
--
-- İçe aktarma:
--   local tdk = require("tdk")
--
-- Arama:
--
--  "ara" fonksiyonunun argümanları:
--    query(zorunlu) : aranacak girdi, kelime, söz.
--    dictionary(opsiyonel) : kelime girdisinin aranacağı sözlük. Varsayılan: tdk.sozluk.guncel_turkce_sozluk
--
--   ───┬─── fonksiyonun kullanımı ────
--    1 │ local tdk = require("tdk")
--    2 │ 
--    3 │ local query, error = tdk.ara("küplere binmek", tdk.sozluk.atasozleri_deyimler_sozlugu)
--    4 │ 
--    5 │ if error then -- eğer hata var ise
--    6 │     print(error) -- örnek: > Sonuç bulunamadı
--    7 │ else -- eğer hata yok ise
--    8 │     print(query) --> table: 0x012345678912
--    9 │ end



--- İçe aktarımlar ---

local http = require("socket.http") -- TDK apisi üzerinden veri çekmek için
local url = require("socket.url") -- Aranacak girdiyi uri formatında kodlamak için
local json = require("json") -- Çekilen veriyi table tipine çevirmek için

--- İçe aktarımlar ---



--- Değişkenler ---

local M = {}

M.version = "1.0.0"

local sozluk = {
    -- Güncel Türkçe Sözlük
    guncel_turkce_sozluk = "gts?",
    gts = "gts?",

    -- Türkçede Batı Kökenli Kelimeler Sözlüğü
    bati_kokenli_sozluk = "bati?",
    bati = "bati?",

    -- Atasözleri ve Deyimler Sözlüğü
    atasozleri_deyimler_sozlugu = "atasozu?",
    atasozu = "atasozu?",

    -- Derleme Sözlüğü
    derleme_sozluk = "derleme?",
    derleme = "derleme?",

    -- Bilim ve Sanat Terimleri Sözlükleri ve Kılavuzları
    bilim_sanat_terimleri_sozlugu = "terim?eser_ad=t%C3%BCm%C3%BC&",
    bst = "terim?eser_ad=t%C3%BCm%C3%BC&",

    -- Yabancı Sözlere Karşılıklar Kılavuzu
    yabanci_sozlerin_karsiligi_sozlugu = "kilavuz?prm=ysk&",
    ysk = "kilavuz?prm=ysk&",

    -- Eren Türk Dilinin Etimolojik Sözlüğü
    eren_turk_dilinin_etimolojik_sozlugu = "etms?",
    etms = "etms?",
}

--- Değişkenler ---



--- Fonksiyonlar ---

-- Modüle dahil değildir. API'dan veri çekmek için kısayol fonksiyonu.
local function request(url)

    local body, code, headers, status = http.request(url)

    local success = true

    if code ~= 200 then
        success = false
        return {
            code = code,
            headers = headers,
            status = status,
            success = success
        }
    end

    return {
        body = body,
        code = code,
        headers = headers,
        status = status,
        success = success
    }

end


-- Arama fonksiyonu tdk.ara(query, dictionary = tdk.sozluk.gts)
--   query: aranacak kelime,
--   dictionary(opsiyonel): sozluk id'si (varsayılan tdk.sozluk.gts)
function M.ara(query, dictionary)

    dictionary = dictionary or sozluk.guncel_turkce_sozluk -- varsayılan: Güncel Türkçe Sözlük

    local req_url = "https://sozluk.gov.tr/" .. dictionary .. "ara=" .. url.escape(query) -- aranacak girdiyi uri formatına kodlayıp sözlük ile bir api bağlantı link oluştur
    local req = request(req_url) -- bağlantı linkine veri isteği yolla
    local result = json.decode(req.body) -- verileri json formatına dönustur

    if result["error"] then
        return result, result["error"]
    end

    return result, nil
end

--- Fonksiyonlar ---



--- Ana kod ---

M.sozluk = sozluk

return M

--- Ana kod ---