Cfg = {}
-- Cfg.limit = false -- Eşyanın limiti olsun mu ? Üzerinde uğraşulmadı hataları olabilir. [kaldırıldı.] # Removed

Cfg.npc = true -- #TR True yada false girin TRUE = olsun FALSE = olmasın #EN Would you create Npc? True = Yes False = No 

Cfg.peds = { -- https://wiki.rage.mp/index.php?title=Peds
    terzi = {ped = 0x0703F106, x = 612.95, y = 2762.71, z = 42.09, h = 268.14},
    kasap = {ped = 0xD8F9CD47, x = 793.88, y = -735.49, z = 27.96, h = 86.87},
    maden = {ped = 0xECD04FE9, x = -621.96, y = -230.74, z = 38.06, h = 121.19},
    prtkl = {ped = 0x8CCE790F, x = 456.18, y = -2059.24, z = 23.92, h = 273.45},
    sarap = {ped = 0x8CCE790F, x = 53.41, y = -1478.74, z = 29.29, h = 190.89}
}

Cfg.mainjoblimit = 400000             -- #TR Ana mesleğin limiti #EN Mainjob daily limit
Cfg.sidejoblimit = 400000             -- #TR Yan mesleğin limiti #EN Sidejob daily limit

MX = {
    ['Terzi'] = {
        inform = {
            jobRequired = false,            -- Do you need a profession or not
            job = "terzi",                 -- Job name   
            jobType = "mainjob",           -- Mainjob or sidejob
            limit = 5,                     -- Removed
            vehspawnprice = 1000,          -- Removed
            price = 1000,                  -- Item price 
            bb = {},                       
            olditem = "kumas",             -- Collection Item
            item = "kiyafet",              -- Progress item
            AmountRequired = 3,            -- How many pieces needed to sell
            [1] = {
                Type = "collection",       
                pos = { x = 712.79, y = -959.35, z = 30.4 },
                DrawText = "Press ~g~[E]~s~ to collection fabric",  -- 3D TEXT
                Progressbar = {duration = 500, text = "Collecting fabric", animDict = "missheistdockssetup1clipboard@idle_a", anim = "idle_a"}, 
                addItemCount = 1,          
                blip = {coords = vector3(712.64, -959.36, 30.4), sprite = 366, color = 2, name = "Collection fabric"} -- https://docs.fivem.net/docs/game-references/blips/ 
            },
            [2] = {
                Type = "progress",         
                pos = { x = 714.82, y = -972.12, z = 30.4 }, 
                DrawText = "Press ~r~[E]~s~ to processing fabric",
                Progressbar = {duration = 500, text = "Fabric Processing", animDict = "missheistdockssetup1clipboard@idle_a", anim = "idle_a"},
                addItemCount = 1,
                blip = {coords = vector3(714.100, -959.36, 30.4), sprite = 366, color = 2, name = "processing fabric"}
            },
            [3] = {
                Type = "selling",
                pos = { x = 614.36, y = 2762.6, z = 42.09 }, 
                DrawText = "Press ~r~[E]~s~ to sell clothes",
                Progressbar = {duration = 500, text = "Selling clothes", animDict = "missheistdockssetup1clipboard@idle_a", anim = "idle_a"},
                addItemCount = 1,
                blip = {coords = vector3(614.36, 2762.6, 42.09), sprite = 366, color = 2, name = "Sell clothes"}
            }
        }
    },
    ['Maden'] = {
        inform = {
            jobRequired = false,
            job = "maden",
            jobType = "sidejob", 
            limit = 50,
            price = {3000, 2000, 1000},    
            olditem = nil,
            item = {"elmas", "altin", "demir"},   
            AmountRequired = 3,
            [1] = {
                Type = "collection",
                pos = {x = -591.47, y = 2076.52, z = 131.37},
                DrawText = "Press ~y~E~s~ to dig",
                Progressbar = {duration = 500, text = "Receiving Fabric", animDict = "missheistdockssetup1clipboard@idle_a", anim = "idle_a"},
                addItemCount = 1,
                blip = {coords = vector3(-593.41, 2079.82, 131.42), sprite = 365, color = 28, name = "Mine"}
            },
            [2] = {
                Type = "selling",
                pos = { x = -621.96, y = -230.74, z = 39.06 }, -- Satma
                DrawText = "Press ~r~[E]~s~ to sell gems",
                Progressbar = {duration = 500, text = "Selling Fabric", animDict = "missheistdockssetup1clipboard@idle_a", anim = "idle_a"},
                addItemCount = 1,
                blip = {coords = vector3(-623.45, -231.57, 38.06), sprite = 365, color = 28, name = "Valuable Item Buyer"}
            }
        }
    },
    ['Kasap'] = {
        inform = {
            jobRequired = false,
            job = "kasap",
            jobType = "mainjob", 
            limit = 50,
            price = 1000,           
            bb = {}, -- Elleme.         
            olditem = "tavuk",
            item = "paketlenmistavuk",  
            AmountRequired = 3,
            [1] = {
                Type = "collection",
                pos = { x = -106.1, y = 6204.71, z = 31.03 }, -- Collection 
                DrawText = "Press  ~r~E~s~ to get cut meat",
                Progressbar = {duration = 500, text = "Meats are bought", animDict = "missheistdockssetup1clipboard@idle_a", anim = "idle_a"},
                addItemCount = 1,
                blip = {coords = vector3(106.1, 6204.71, 31.03), sprite = 256, color = 5, name = "Butcher"}
            },
            [2] = {
                Type = "progress",
                pos = { x = -95.72, y = 6207.04, z = 31.03 }, -- İşleme
                DrawText = "press  ~r~[E]~s~ to cook",
                Progressbar = {duration = 500, text = "Cooking", animDict = "missheistdockssetup1clipboard@idle_a", anim = "idle_a"},
                addItemCount = 1,
                blip = {coords = vector3(106.1, 6204.71, 31.03), sprite = 256, color = 5, name = "Chicken Processing"}
            },
            [3] = {
                Type = "selling",
                pos = { x = 793.88, y = -735.49, z = 27.96 }, -- Satma
                DrawText = "Push ~r~[E]~s~ to sell chickens",
                Progressbar = {duration = 500, text = "Selling", animDict = "missheistdockssetup1clipboard@idle_a", anim = "idle_a"},
                addItemCount = 1,
                blip = {coords = vector3(793.88, -735.49, 27.96), sprite = 256, color = 5, name = "Butcher\'s Factory Vehicle Launching / Selling"}
            }
        }
    },
    ['Portakal'] = {
        inform = {
            jobRequired = false,
            job = "portakal",
            jobType = "sidejob", 
            limit = 50,
            vehspawnprice = 1000,
            price = 1000,
            olditem = "portakal",
            item = "portakalsuyu",           
            bb = {}, -- Elleme.       
            AmountRequired = 3,                                 
            [1] = {
                Type = "collection",
                pos = {x = 2316.86,  y = 4993.01,  z = 42.03},
                DrawText = "Press ~r~E~s~ to pick orange",
                Progressbar = {duration = 500, text = "Picking orange", animDict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "high_center_up"},
                addItemCount = 1,
                blip = {coords = vector3(2312.24, 4981.01, 43.43), sprite = 467, color = 2, name = "Picking orange"}
            },
            [2] = {
                Type = "progress",
                pos = { x = -1660.21, y = -1043.88, z = 13.15 }, -- İşleme
                DrawText = "Press ~y~E~s~ to process orange",
                Progressbar = {duration = 500, text = "Processing orange", animDict = "missheistdockssetup1clipboard@idle_a", anim = "idle_a"},
                addItemCount = 1,
                blip = {coords = vector3(-1660.21, -1043.88, 13.15), sprite = 467, color = 2, name = "Process orange"}
            },
            [3] = {
                Type = "selling",
                pos = { x = 456.18, y = -2059.24, z = 24.92 }, -- Satma
                DrawText = "Press ~y~E~s~ to selling orange",
                Progressbar = {duration = 500, text = "Selling", animDict = "missheistdockssetup1clipboard@idle_a", anim = "idle_a"},
                addItemCount = 1,
                blip = {coords = vector3(456.18, -2059.24, 24.92), sprite = 467, color = 2, name = "Sell orange"}
            }
        }
    },
    ['Uzum'] = {
        inform = {
            jobRequired = false,
            job = "uzum",
            jobType = "sidejob", 
            limit = 50,
            vehspawnprice = 1000,
            price = 1000,           
            bb = {}, -- Elleme.       
            olditem = "uzum",
            item = "sarap",      
            AmountRequired = 3,              
            [1] = {
                Type = "collection",
                pos = {x = 1921.62, y = 4803.87, z = 44.23},
                DrawText = "Press ~r~E~s~ to collection grape",
                Progressbar = {duration = 500, text = "collecting", animDict = "amb@prop_human_bum_bin@base", anim = "base"},
                addItemCount = 1,
                blip = {coords = vector3(1921.89, 4804.24, 44.16), sprite = 468, color = 7, name = "Collection grape"},
            },
            [2] = {
                Type = "progress",
                pos = { x = 2553.5, y = 4668.1, z = 34.01 }, -- İşleme
                DrawText = "Press ~y~E~s~ to process grapes",
                Progressbar = {duration = 500, text = "Processing", animDict = "missheistdockssetup1clipboard@idle_a", anim = "idle_a"},
                addItemCount = 1,
                blip = {coords = vector3(2553.5, 4668.1, 34.01), sprite = 468, color = 7, name = "Process grapes"},
            },
            [3] = {
                Type = "selling",
                pos = { x = 53.41, y = -1478.74, z = 29.29 }, -- Satma
                DrawText = "Press ~y~E~s~ to sell wines",
                Progressbar = {duration = 500, text = "selling wines", animDict = "missheistdockssetup1clipboard@idle_a", anim = "idle_a"},
                addItemCount = 1,
                blip = {coords = vector3(53.41, -1478.74, 29.29), sprite = 468, color = 7, name = "sell wines"}
            }
        }
    }
}
