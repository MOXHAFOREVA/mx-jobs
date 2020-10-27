kasap = {
    [1] = {
        clc = { x = -106.1, y = 6204.71, z = 31.03 }, -- Toplama
        prsn = { x = -95.72, y = 6207.04, z = 31.03 }, -- İşleme
        sell = { x = 793.88, y = -735.49, z = 27.96, h = 86.87 }, -- Satma
        vehspawnmarker = { x = 784.71, y = -741.01, z = 27.45 }, -- Araç Spawnlanma Marker
        vehspawn = { x = 784.71, y = -741.01, z = 27.45 }, -- Araç Spawnlanma Yeri
        vehdel = { x = 797.74, y = -765.17, z = 26.59, h = 271.25 }, -- Araç Silme Yeri
        vehspawnprice = 1000,                                      -- Araç Spawnlandığında alınacak Olan Para
        AmountRequired = 3,                                         -- Önceki Itemdan alınması gereken miktar
        price = 1000,                                                   -- Satınca gelicek olan para
        clcitem = "tavuk",                                         -- Toplayınca Gelicek Olan Item                           
        sellitem = "paketlenmistavuk",                                      -- Satınca gidicek olan eşya
        limit = 10,                                                          -- Eşyanın limiti
        blipcoords = vector3(106.1, 6204.71, 31.03),
        blipsprite = 256,
        blipcolor = 5,
        blipname = "Kasap",
        clcblipcoords = vector3(-106.1, 6204.71, 31.03),
        clcblipsprite = 256,
        clcblipcolor = 5,
        clcblipname = "Tavuk İşleme",
        sellblipcoords = vector3(793.88, -735.49, 27.96),
        sellblipcoordsblipsprite = 256,
        sellblipcoordsblipcolor = 5,
        sellblipcoordsblipname = "Kasap Fabrikası Araç Çıkarma / Satış",
        
    }
}