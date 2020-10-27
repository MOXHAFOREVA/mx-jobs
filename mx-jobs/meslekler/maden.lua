maden = {
    [1] = {
        clc = { x = 0, y = 1, z = 1 }, -- Toplama -- Kullanılmıyor...
        prsn = { x = 1, y = 1, z = 1 }, -- İşleme - Kullanılmıyor...
        sell = { x = -621.96, y = -230.74, z = 39.06 }, -- Satma
        vehspawnmarker = { x = 1, y = 1, z = 1 }, -- Araç Spawnlanma Marker
        vehspawn = { x = 1, y = 1, z = 1, h = 1 }, -- Araç Spawnlanma Yeri
        vehdel = { x = 1, y = 1, z = 1, h = 1 }, -- Araç Silme Yeri
        vehspawnprice = 1000,                                      -- Araç Spawnlandığında alınacak Olan Para
        AmountRequired = 3,                                           -- Satarken Alınacak miktar
        diamondprice = 1000,                                           -- Elmas Fiyatı
        ironprice = 1000,                                           -- Demir Fiyatı
        goldprice = 1000,                                           -- Altın Fiyatı
        diamondname = "elmas",                                           -- Elmas Item ismi
        goldname = "altin",                                           -- Altın ismi
        ironname = "demir",                                           -- Demir ismi
        limit = 10,                                                          -- Eşyanın limiti
        blipcoords = vector3(-593.41, 2079.82, 131.42),
        blipsprite = 365,
        blipcolor = 28,
        blipname = "Maden Ocağı",
        -- clcblipcoords = vector3(-593.41, 2079.82, 131.42), deaktif açmak isterseniz client/main lua inceleyin.
        -- clcblipsprite = 475,
        -- clcblipcolor = 2,
        -- clcblipname = "Maden Ocağı",
        sellblipcoords = vector3(-623.45, -231.57, 38.06),
        sellblipcoordsblipsprite = 365,
        sellblipcoordsblipcolor = 28,
        sellblipcoordsblipname = "Değerli Eşya Alıcısı",
    }
}