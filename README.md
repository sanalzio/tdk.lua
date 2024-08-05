# TDK.lua

Lua dili için Türk Dil Kurumu API modülü.

- [TDK.lua](#tdklua)
  - [Bağımlılıklar](#bağımlılıklar)
  - [Uyarılar](#uyarılar)
  - [Kurulum](#kurulum)
    - [Genel (global) kurulum](#genel-global-kurulum)
    - [Yerel (local) kurulum](#yerel-local-kurulum)
  - [Kullanımı](#kullanımı)
    - [`ara` fonskiyonu](#ara-fonskiyonu)
      - [kullanımı](#kullanımı-1)
    - [`json` modülünü içe aktarmayı engellemek](#json-modülünü-içe-aktarmayı-engellemek)
      - [Örnek:](#örnek)
    - [Sözlük (`tdk.sozluk.X`) değerleri](#sözlük-tdksozlukx-değerleri)
    - [`tdk.versiyon`](#tdkversiyon)
      - [Örnek kullanım:](#örnek-kullanım)
  - [Kullanılan Sözlük ve Klavuzlar](#kullanılan-sözlük-ve-klavuzlar)
    - [Genel Sözlükler](#genel-sözlükler)
    - [Lisans: GPLv3](#lisans-gplv3)

## Bağımlılıklar

- [LUA 5.1 - 5.4](https://www.lua.org/)
- [LuaSocket](https://lunarmodules.github.io/luasocket/)
- [json.lua](https://github.com/rxi/json.lua)
- İnternet Bağlantısı(Sadece kullanım esnasında)

## Uyarılar

- json.lua dosyası çalıştırılan kodun olduğu klasörde bulunmalıdır.
- LuaSocket hangi lua sürümü için kuruldu ise o lua sürümünü kullanmanız gerekir.

## Kurulum

### Genel (global) kurulum

```bash
wget --directory-prefix=/usr/local/share/lua/<5.x>/ https://raw.githubusercontent.com/rxi/json.lua/master/json.lua https://raw.githubusercontent.com/sanalzio/tdk.lua/master/src/tdk.lua
```

> [!IMPORTANT]
> `<5.x>` bolümünü `LuaSocket modülünün kurulu olduğu sürüme göre ayarlayın`

### Yerel (local) kurulum

```bash
wget https://raw.githubusercontent.com/rxi/json.lua/master/json.lua https://raw.githubusercontent.com/sanalzio/tdk.lua/master/src/tdk.lua
```

## Kullanımı

```lua
local tdk = require("tdk")

local query, error = tdk.ara("küplere binmek", tdk.sozluk.atasozleri_deyimler_sozlugu)
local query2, _ = tdk.ara("küplere binmek", tdk.sozluk.atasozleri_deyimler_sozlugu, false)

if error then -- eğer hata var ise
    print(error) -- örnek: > Sonuç bulunamadı
else
    print(query) --> table: 0x012345678912
    print(query2) --> [{"soz_id":"9024","sozum":"küplere binmek", ... "gosterim_tarihi":null}]
end
```

### `ara` fonskiyonu

`ara` fonksiyonu tdk api'ına arama isteği yollar ve çıktıyı istenen türde döndürür.

#### kullanımı

```lua
local sorgu, hata = tdk.ara(
  1. girdi: aranacak söz yada kelime,
  2. sözlük(opsiyonel): girdinin aranacağı tdk sözlüğü yada klavuzu. varsayılan: tdk.sozluk.gts,
  3. encode_json(opsiyonel)(true/false): çıktının table türüne çevrilip çevrilmeyeceği. varsayılan: true(çevir),
)

-- daha basit hali ile "tdk.ara(girdi, sözlük, true/false)"

-- eğer hata değerini kullanmayacaksanız hata yerine _ (alt çizgi) karakterini kullanın.
```

### `json` modülünü içe aktarmayı engellemek

Kod içerisinde `tdk` modülünü içe aktarmadan önce `tdk_load_json = false` satırını ekleyerek tdk modülünün, `json` modülünü kullanmasına engel olabilirsiniz. Bunun sonucunda eğer `ara` fonskiyonunun 3. argümanına `false` değeri girmeseniz bile çıktıyı `string` türünde döndürür.

#### Örnek:
```lua
tdk_load_json = false

local tdk = require("tdk")
```

### Sözlük (`tdk.sozluk.X`) değerleri

- `guncel_turkce_sozluk / gts`: Güncel Türkçe Sözlük
- `bati_kokenli_sozluk / bati`: Türkçede Batı Kökenli Kelimeler Sözlüğü
- `atasozleri_deyimler_sozlugu / atasozu`: Atasözleri ve Deyimler Sözlüğü
- `derleme_sozluk / derleme`: Derleme Sözlüğü
- `bilim_sanat_terimleri_sozlugu / bst`: Bilim ve Sanat Terimleri Sözlükleri ve Kılavuzları
- `yabanci_sozlerin_karsiligi_sozlugu / ysk`: Yabancı Sözlere Karşılıklar Kılavuzu
- `eren_turk_dilinin_etimolojik_sozlugu / etms`: Eren Türk Dilinin Etimolojik Sözlüğü

### `tdk.versiyon`

Modülün sürümünü belirtir.

#### Örnek kullanım:
```lua
local tdk = require("tdk")

print(tdk.versiyon) --> X.X.X
```

## Kullanılan Sözlük ve Klavuzlar

### Genel Sözlükler

- Güncel Türkçe Sözlük
- Türkçede Batı Kökenli Kelimeler Sözlüğü
- Tarama Sözlüğü
- Derleme Sözlüğü
- Atasözleri ve Deyimler Sözlüğü
- Yabancı Sözlere Karşılıklar Kılavuzu
- Eren Türk Dilinin Etimolojik Sözlüğü

<details>
<summary><h3>Bilim ve Sanat Terimleri Sözlükleri ve Kılavuzları</h3></summary>

- Ağaçişleri Terimleri Sözlüğü - 1968
- Anatomi Terimleri Sözlüğü - 2004
- Asalakbilim Terimleri Sözlüğü - 1970
- Atletizm Terimleri Sözlüğü - 1976
- Ayaktopu Terimleri Sözlüğü - 1974
- Aydınlatma Terimleri Sözlüğü - 1973
- Besin Hijyeni ve Teknolojisi Terimleri Sözlüğü
- Bilgisayar Terimleri Karşılıklar Kılavuzu - 2007
- Bilişim Terimleri Sözlüğü - 1981
- Bitkibilim Terimleri (Botanik) - 1948
- Biyokimya Terimleri Sözlüğü
- Biyoloji Terimleri Sözlüğü - 1998
- Budunbilim Terimleri Sözlüğü - 1973
- Cerrahi Terimleri Sözlüğü
- Ceza Yargılama Yöntemi Yasası Terimleri Sözlüğü - 1972
- Cimnastik Terimleri Sözlüğü - 1969
- Coğrafya Terimleri Sözlüğü - 1980
- Çiftteker Terimleri Sözlüğü - 1970
- Dilbilgisi Terimleri Sözlüğü - 1972
- Dilbilim Terimleri Sözlüğü - 1949
- Dirilbilim (Biyoloji) Terimleri - 1948
- Doğum ve Jinekoloji Terimleri Sözlüğü - 2004
- Dölerme ve Suni Tohumlama Terimleri Sözlüğü - 2004
- Döşem Terimleri Sözlüğü (Su, Gaz, Isıtma, Havalandırma) - 1969
- Edebiyat ve Söz Sanatı Terimleri Sözlüğü - 1948
- Eğitim Terimleri Sözlüğü - 1974
- Ekonometri Terimleri Karşılıklar Sözlüğü
- Farmakoloji ve Toksikoloji Terimleri Sözlüğü
- Felsefe Terimleri Sözlüğü - 1975
- Fizik Terimleri Sözlüğü - 1983
- Fiziksel Kimya Terimleri Sözlüğü - 1978
- Fizyoloji Terimleri Sözlüğü
- Geometri - 2000
- Gökbilim Terimleri Sözlüğü - 1969
- Gösterim Sanatları Terimleri Sözlüğü - 1983
- Gramer Terimleri Sözlüğü - 2003
- Gümrük Terimleri Sözlüğü - 1972
- Güreş Terimleri Sözlüğü - 1974
- Güzel Sanatlar Terimleri Sözlüğü - 1968
- Halkbilim Terimleri Sözlüğü - 1978
- Hayvan Besleme ve Beslenme Hastalıkları Terimleri Sözlüğü - 2004
- Hemşirelik Terimleri Sözlüğü - 2015
- Histoloji-Embriyoloji Terimleri Sözlüğü
- İç Hastalıkları Terimleri Sözlüğü
- İktisat Terimleri Sözlüğü - 2004
- İlaç ve Eczacılık Terimleri Sözlüğü - 2014
- İstatistik Terimleri Sözlüğü - 1983
- Kentbilim Terimleri Sözlüğü - 1980
- Kılıçoyunu Terimleri Sözlüğü - 1970
- Kimya Terimleri Sözlüğü - 2007
- Kimya Terimleri Sözlüğü - 1981
- Kitaplıkbilim Terimleri Sözlüğü - 1974
- Kriminoloji Terimleri Sözlüğü
- Madencilik Terimleri Kılavuzu - 1979
- Mantık Terimleri Sözlüğü - 1976
- Matematik Terimleri Sözlüğü - 1983
- Medenî Hukuk Terimleri Sözlüğü (Osmanlıcadan Türkçeye - Türkçeden Osmanlıcaya) - 1966
- Metalbilim İşlem Terimleri Sözlüğü - 1972
- Mikrobiyoloji Terimleri Sözlüğü - 2004
- Nükleer Enerji Terimleri Sözlüğü - 1995
- Orta Öğretim Terimleri Kılavuzu - 1963
- Otomobilcilik ve Motor Bilgisi Terimleri Sözlüğü - 1980
- Parazitoloji Terimleri Sözlüğü
- Patoloji Terimleri Sözlüğü - 2007
- Ruhbilim Terimleri Sözlüğü - 1974
- Sepettopu Terimleri Sözlüğü - 1969
- Sinema ve Televizyon Terimleri Sözlüğü - 1981
- Su Ürünleri Terimleri Sözlüğü - 2007
- Tarım Terimleri - 1949
- Tarih Terimleri Sözlüğü - 1974
- Tecim, Maliye, Sayışmanlık ve Güvence Terimleri Sözlüğü - 1972
- Teknik Terimler I (Makina öğeleri. Elektroteknik. Yapı Makinaları, İçten Yanmalı Motorlar, Bastıraklar, Teknibilim, Dayanım, Temel Tekniği, Gereç) - 1949
- Tıp Terimleri Kılavuzu - 2010
- Tiyatro Terimleri Sözlüğü - 1966
- Toplumbilim Terimleri Sözlüğü - 1975
- Türe Terimleri
- Türk Dünyası Gramer Terimleri Kılavuzu - 1997
- Türkçe Hekimlik Terimleri Üzerine Bir Deneme - 1944
- Uçantop, Alantopu, Masatopu Terimleri Sözlüğü - 1968
- Uluslararası Metroloji Sözlüğü
- Uygulayım Terimleri Sözlüğü - 1980
- Veteriner Hekimliği Tarihi ve Deontoloji Terimleri Sözlüğü - 2004
- Veteriner Hekimliği Terimleri Sözlüğü
- Viroloji Terimleri Sözlüğü - 2004
- Yapım İyeliği Terimleri Sözlüğü - 1971
- Yapıt Hakları Terimleri Sözlüğü - 1971
- Yazın Terimleri Sözlüğü - 1974
- Yerbilim Terimleri Sözlüğü - 1971
- Yöntembilim Terimleri Sözlüğü - 1981
- Yumrukoyunu Terimleri Sözlüğü - 1968
- Zanaat Terimleri Sözlüğü - 1976
- Zooloji Terimleri Sözlüğü - 1963
- Zootekni Terimleri Sözlüğü - 2007
- 
</details>

### Lisans: GPLv3
