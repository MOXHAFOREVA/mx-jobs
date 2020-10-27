terzi = {
    [1] = {
        clc = { x = 712.79, y = -959.35, z = 30.4 }, -- Toplama
        prsn = { x = 714.82, y = -972.12, z = 30.4 }, -- İşleme
        sell = { x = 614.36, y = 2762.6, z = 42.09 }, -- Satma
        sellingnpc = {},
        AmountRequired = 3, -- İşlemek İçin Önceki Itemın Gerekli OLan Miktarı
        vehspawnmarker = { x = 744.74, y = -954.99, z = 24.61 }, -- Araç Spawnlanma Marker
        vehspawn = { x = 744.74, y = -954.99, z = 24.61, h = 255.53 }, -- Araç Spawnlanma Yeri
        vehdel = { x = 744.45, y = -968.16, z = 24.6, h = 88.31 }, -- Araç Silme Yeri
        vehspawnprice = 1000,                                      -- Araç Spawnlandığında alınacak Olan Para
        price = 1000,                                              -- Satınca gelicek olan para
        clcitem = "kumas",                                         -- Toplayınca Gelicek Olan Item                           
        sellitem = "kiyafet",                                      -- Satınca gidicek olan eşya
        limit = 10,                                                          -- Eşyanın limiti
        blipcoords = vector3(712.64, -959.36, 30.4),             -- blipler... 
        blipsprite = 366,
        blipcolor = 2,
        blipname = "Kumaş Alma",
        clcblipcoords = vector3(714.100, -959.36, 30.4),
        clcblipsprite = 366,
        clcblipcolor = 2,
        clcblipname = "Kıyafet Yapma",
        sellblipcoords = vector3(614.36, 2762.6, 42.09 ),
        sellblipcoordsblipsprite = 366,
        sellblipcoordsblipcolor = 2,
        sellblipcoordsblipname = "Kıyafet Satma",
    }
}