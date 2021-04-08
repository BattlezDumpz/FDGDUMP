Base.Skin = {}

Base.Skin.currSkin = {} -- What the entity is currently wearing
Base.Skin.charSkin = {} -- What the characters saved skin in

Base.Skin.indexes = {
    clothing = {
        tshirt = {
            label = "Undershirt",
            type = "drawable",
            index = 8
        },
        torso = {
            label = "Torso",
            type = "drawable",
            index = 11
        },
        arms = {
            label = "Arms",
            type = "drawable",
            index = 3
        },
        decals = {
            label = "Decals",
            type = "drawable",
            index = 10
        },
        pants = {
            label = "Pants",
            type = "drawable",
            index = 4
        },
        shoes = {
            label = "Shoes",
            type = "drawable",
            index = 6
        },
        mask = {
            label = "Mask",
            type = "drawable",
            index = 1
        },
        bproof = {
            label = "Vest",
            type = "drawable",
            index = 9
        },
        chain = {
            label = "Chain",
            type = "drawable",
            index = 7
        },
        watch = {
            label = "Watches",
            type = "prop",
            index = 6
        },
        bracelet = {
            label = "Bracelet",
            type = "prop",
            index = 7
        },
        bag = {
            label = "Bag",
            type = "drawable",
            index = 5
        },
        helmet = {
            label = "Helmet",
            type = "prop",
            index = 0
        },
        ears = {
            label = "Ear Accessories",
            type = "prop",
            index = 2
        },
        glasses = {
            label = "Bag",
            type = "prop",
            index = 1
        },
    }
}

-- Clothing Toggles
CLOTHING_TOGGLES = {
    [0] = {
        helmet = -1,
        ears = -1,
        glasses = 0,
        mask = 0,
        chain = 0,
        watch = -1,
        bracelet = -1,
        tshirt = 15,
        torso = 15,
        arms = 15,
        shoes = 34,
        pants = 61,
        bproof = 0,
        decals = 0,
    },

    [1] = {
        helmet = -1,
        ears = -1,
        glasses = 5,
        mask = 0,
        chain = 0,
        watch = -1,
        bracelet = -1,
        tshirt = 14,
        torso = 15,
        arms = 15,
        shoes = 35,
        pants = 15,
        bproof = 0,
        decals = 0,
    }
}

local hiddenClothing = {}

-- Misc Functions
Base.Skin.getCurrentSkin = function()
    return Base.Skin.currSkin
end

Base.Skin.getCharSkin = function()
    return Base.Skin.charSkin
end

Base.Skin.getDefault = function()
    return {
        model = "mp_m_freemode_01",
        sex = 0,

        skin = Base.Skin.getDefaultSkin(),
        cosmetics = Base.Skin.getDefaultCosmetics(),
        clothing = Base.Skin.getDefaultClothing(),
        tattoos = {}
    }
end

Base.Skin.getDefaultSkin = function()
    return {
        mother = 0,
        father = 0,
        shapemix = 50,
        colour = 0,
        lip_thickness = 0,
        neck_thickness = 0,

        freckles = {texture = 0, opacity = 0},
        age = {texture = 0, opacity = 0},
        damage = {texture = 0, opacity = 0},
        complexion = {texture = 0, opacity = 0},
        blemish = {texture = 0, opacity = 0},

        nose = {width = 0, heigh = 0, twist = 0, peak_height = 0, peak_length = 0, peak_lowering = 0},
        cheeks = {width = 0, height = 0, chub = 0},
        eyes = {size = 0, colour = 0, brow_height = 0, brow_forward = 0},
        jaw = {width = 0, length = 0},
        chin = {lower = 0, length = 0, width = 0, tip = 0}
    }
end

Base.Skin.getDefaultCosmetics = function()
    return {
        head = {style = 1, thickness = 100, colour = 0, highlights = 0},
        beard = {style = 0, thickness = 0, colour = 0, highlights = 0},
        chest = {style = 0, thickness = 0, colour = 0, highlights = 0},
        eyebrows = {style = 0, thickness = 0, colour = 0, highlights = 0},
        lipstick = {style = 0, thickness = 0, colour = 0, highlights = 0},
        makeup = {style = 0, thickness = 0, colour = 0, highlights = 0},
        blush = {style = 0, thickness = 0, colour = 0, highlights = 0},
    }
end

Base.Skin.getDefaultClothing = function()
    return {
        helmet = {model = -1, texture = 0},
        glasses = {model = 0, texture = 0},
        ears = {model = -1, texture = 0},
        mask = {model = 0, texture = 0},
        torso = {model = 0, texture = 0},
        tshirt = {model = 0, texture = 0},
        arms = {model = 0, texture = 0},
        chain = {model = 0, texture = 0},
        watch = {model = -1, texture = 0},
        bracelet = {model = -1, texture = 0},
        pants = {model = 0, texture = 0},
        shoes = {model = 0, texture = 0},
        decals = {model = 0, texture = 0},
        bproof = {model = 0, texture = 0},
        bag = {model = 0, texture = 0},
    }
end

Base.Skin.getFeatureLabel = function(category, feature)
    return Base.Skin.indexes[category][feature].label
end

Base.Skin.getMinValue = function(feature)
    if feature == "helmet" or feature == "ears" then
        return -1
    else
        return 0
    end
end

Base.Skin.getMaxValue = function(category, feature, texture)
    if category == "clothing" then
        local playerPed = PlayerPedId()
        local elem = Base.Skin.indexes[category][feature]

        if not texture then
            if elem.type == "prop" then
                return GetNumberOfPedPropDrawableVariations(playerPed, elem.index) - 1
            else
                return GetNumberOfPedDrawableVariations(playerPed, elem.index) - 1
            end
        else
            if elem.type == "prop" then
                return GetNumberOfPedPropTextureVariations(playerPed, elem.index, Base.Skin.currSkin.clothing[feature].model) - 1
            else
                return GetNumberOfPedTextureVariations(playerPed, elem.index, Base.Skin.currSkin.clothing[feature].model) - 1
            end
        end
    end
end

-- Skin Setter
Base.Skin.setSkin = function(skin, saveSkin, entity)
    print("[Skin] Setting Skin")
    print("[Skin] Loading Model")
    if skin.model then
        Base.Skin.applyModel(skin.model, saveSkin, entity)
    else
        skin.model = "mp_m_freemode_01"
        Base.Skin.applyModel(skin.model, saveSkin, entity)
    end
    print("[Skin] Loading Skin")
    if skin.skin      then Base.Skin.applySkin(skin.skin, saveSkin, entity) end
    print("[Skin] Loading Clothing")
    if skin.clothing  then Base.Skin.applyClothing(skin.clothing, saveSkin, entity) end
    print("[Skin] Loading Tattoos")
    if skin.tattoos   then Base.Skin.applyTattoos(skin.tattoos, saveSkin, entity) end
    print("[Skin] Loading Cosmetics")
    if skin.cosmetics then Base.Skin.applyCosmetics(skin.cosmetics, saveSkin, entity) end
    print("[Skin] Skin Loaded!")

    if saveSkin then
        Base.Skin.saveCharSkin()
    end
end

Base.Skin.applyModel = function(model, saveSkin, entity)
    print("[Skin] Applying model now!")

    local ped = entity or PlayerPedId()
    local health = GetEntityHealth(ped)
    local modelHash = GetHashKey(model)

    print("[skin] Trying to load model! Model: "..modelHash)

    if not IsModelValid(modelHash) then
        print("[skin] Model didn't exist! Model: "..modelHash)
        return false
    end

    RequestModel(modelHash)
    print("Model Requested: "..modelHash)

    while not HasModelLoaded(modelHash) do
        RequestModel(modelHash)
        Citizen.Wait(0)
    end

    print("Model loaded!")

    if IsModelInCdimage(modelHash) and HasModelLoaded(modelHash) then
        print("Model is valid! Setting now!", ped)
        SetPlayerModel(PlayerId(), modelHash)
        SetPedDefaultComponentVariation(PlayerPedId())
    end

    SetModelAsNoLongerNeeded(modelHash)
    SetEntityHealth(PlayerPedId(), health)

    -- Save the skin
    if not entity then
        Base.Skin.currSkin.model = model

        if model == "mp_m_freemode_01" then
            Base.Skin.currSkin.sex = 0
        elseif model == "mp_f_freemode_01" then
            Base.Skin.currSkin.sex = 1
        else
            Base.Skin.currSkin.sex = 2
        end

        if saveSkin then
            Base.Skin.charSkin.model = model
            Base.Skin.charSkin.sex = Base.Skin.currSkin.sex
        end
    end
end

Base.Skin.applySkin = function(skin, saveSkin, entity)
    local ped = entity or PlayerPedId()

    -- Head Manipulation
    SetPedHeadBlendData(ped, skin.mother, skin.father, 0.0, skin.colour, skin.colour, 0.0, (skin.shapemix or 50)/100.0, 0.5, 0.0, true)

    -- Nose Features
    if skin.nose then
        SetPedFaceFeature(ped, 0, (skin.nose.width or 0.0)/100.0)
        SetPedFaceFeature(ped, 1, (skin.nose.height or 0.0)/100.0)
        SetPedFaceFeature(ped, 2, (skin.nose.peak_length or 0.0)/100.0)
        SetPedFaceFeature(ped, 3, (skin.nose.peak_lowering or 0.0)/100.0)
        SetPedFaceFeature(ped, 4, (skin.nose.peak_height or 0.0)/100.0)
        SetPedFaceFeature(ped, 5, (skin.nose.twist or 0.0)/100.0)
    end

    -- Eyes
    if skin.eyes then
        SetPedEyeColor(ped, skin.eyes.colour)
        SetPedFaceFeature(ped, 6, (skin.eyes.brow_height or 0.0)/100.0)
        SetPedFaceFeature(ped, 7, (skin.eyes.brow_forward or 0.0)/100.0)
        SetPedFaceFeature(ped, 11, (skin.eyes.opening or 0.0)/100.0)
    end

    -- Cheeks
    if skin.cheeks then
        SetPedFaceFeature(ped, 8, (skin.cheeks.height or 0.0)/100.0)
        SetPedFaceFeature(ped, 9, (skin.cheeks.width or 0.0)/100.0)
        SetPedFaceFeature(ped, 10, (skin.cheeks.chub or 0.0)/100.0)
    end    

    -- Lips
    SetPedFaceFeature(ped, 12, (skin.lip_thickness or 0.0)/100.0)

    -- Jaw
    if skin.jaw then
        SetPedFaceFeature(ped, 13, (skin.jaw.width or 0.0)/100.0)
        SetPedFaceFeature(ped, 14, (skin.jaw.length or 0.0)/100.0)
    end

    -- Cheeks
    if skin.chin then
        SetPedFaceFeature(ped, 15, (skin.chin.lower or 0.0)/100.0)
        SetPedFaceFeature(ped, 16, (skin.chin.length or 0.0)/100.0)
        SetPedFaceFeature(ped, 17, (skin.chin.width or 0.0)/100.0)
        SetPedFaceFeature(ped, 18, (skin.chin.tip or 0.0)/100.0)
    end

    -- Neck
    SetPedFaceFeature(ped, 19, (skin.neck_thickness or 0.0)/100.0)

    -- Facial Features    
    SetPedHeadOverlay(ped, 0, skin.blemish.texture, (skin.blemish.opacity or 0.0)/100.0) -- Blemishes
    SetPedHeadOverlay(ped, 3, skin.age.texture, (skin.age.opacity or 0.0)/100.0) -- Aging
    SetPedHeadOverlay(ped, 6, skin.complexion.texture, (skin.complexion.opacity or 0.0)/100.0) -- Complexion
    SetPedHeadOverlay(ped, 7, skin.damage.texture, (skin.damage.opacity or 0.0)/100.0) -- Sun Damage
    SetPedHeadOverlay(ped, 9, skin.freckles.texture, (skin.freckles.opacity or 0.0)/100.0) -- Moles-Freckles

    -- Save the skin
    if not entity then
        Base.Skin.currSkin.skin = skin
        if saveSkin then
            Base.Skin.charSkin.skin = table.clone(skin)
        end
    end
end

Base.Skin.applyClothing = function(clothing, saveSkin, entity)
    local ped = entity or PlayerPedId()
    local clothing = clothing
    local startClothing = table.clone(clothing)

    for k, state in pairs(hiddenClothing) do
        if state then
            clothing[k].model = CLOTHING_TOGGLES[Base.Skin.getCurrentSkin().sex][k]
        end
    end

    -- Clothing Props
    if clothing.helmet.model == -1 then
        ClearPedProp(ped, 0)
    else
        SetPedPropIndex(ped, 0, clothing.helmet.model, clothing.helmet.texture, 2)
    end

    if clothing.ears.model == -1 then
        ClearPedProp(ped, 2)
    else
        SetPedPropIndex(ped, 2, clothing.ears.model, clothing.ears.texture, 2)
    end

    if clothing.watch == nil or clothing.watch.model == -1 then
        ClearPedProp(ped, 6)
    else
        SetPedPropIndex(ped, 6, clothing.watch.model, clothing.watch.texture, 2)
    end

    if clothing.bracelet == nil or clothing.bracelet.model == -1 then
        ClearPedProp(ped, 7)
    else
        SetPedPropIndex(ped, 7, clothing.bracelet.model, clothing.bracelet.texture, 2)
    end

    SetPedPropIndex(ped, 1, clothing.glasses.model, clothing.glasses.texture, 2)  -- Glasses

    -- Component Variations
    SetPedComponentVariation(ped, 8,  clothing.tshirt.model, clothing.tshirt.texture, 2) -- Undershirt
    SetPedComponentVariation(ped, 11, clothing.torso.model,  clothing.torso.texture, 2)  -- Torso
    SetPedComponentVariation(ped, 3,  clothing.arms.model,   0, 2)                        -- Arms
    SetPedComponentVariation(ped, 10, clothing.decals.model, clothing.decals.texture, 2) -- decals
    SetPedComponentVariation(ped, 4,  clothing.pants.model,  clothing.pants.texture, 2)  -- pants
    SetPedComponentVariation(ped, 6,  clothing.shoes.model,  clothing.shoes.texture, 2)  -- shoes
    SetPedComponentVariation(ped, 1,  clothing.mask.model,   clothing.mask.texture, 2)   -- mask
    SetPedComponentVariation(ped, 9,  clothing.bproof.model, clothing.bproof.texture, 2) -- bulletproof
    SetPedComponentVariation(ped, 7,  clothing.chain.model,  clothing.chain.texture, 2)  -- chain
    SetPedComponentVariation(ped, 5,  clothing.bag.model,    clothing.bag.texture, 2)   -- Bag

    -- Save the skin
    if not entity then
        Base.Skin.currSkin.clothing = startClothing
        if saveSkin then Base.Skin.charSkin.clothing = table.clone(startClothing) end
    end
end

Base.Skin.applyTattoos = function(tattoos, saveSkin, entity)
    local ped = entity or PlayerPedId()

    ClearPedDecorations(ped)

    for i, tattoo in ipairs(tattoos) do
        SetPedDecoration(ped, GetHashKey(tattoo.collection), GetHashKey(tattoo.hash))
    end

    -- Save the skin
    if not entity then
        Base.Skin.currSkin.tattoos = tattoos
        if saveSkin then
            Base.Skin.charSkin.tattoos = table.clone(tattoos)
        end
    end
end

Base.Skin.applyCosmetics = function(cosmetics, saveSkin, entity)
    local ped = entity or PlayerPedId()

    if cosmetics.head then
        SetPedComponentVariation(ped, 2, cosmetics.head.style, 0, 2)
        SetPedHairColor(ped, cosmetics.head.colour, cosmetics.head.highlights)
    end

    -- Eyebrows
    if cosmetics.eyebrows then
        SetPedHeadOverlay(ped, 2, cosmetics.eyebrows.style, (cosmetics.eyebrows.thickness/100) + 0.0)
        SetPedHeadOverlayColor(ped, 2, 1, cosmetics.eyebrows.colour, cosmetics.eyebrows.highlights)
    end

    -- Beard
    if cosmetics.beard then
        SetPedHeadOverlay(ped, 1, cosmetics.beard.style, (cosmetics.beard.thickness/100) + 0.0)
        SetPedHeadOverlayColor(ped, 1, 1, cosmetics.beard.colour, cosmetics.beard.highlights)
    end

    -- Chest Hair
    if cosmetics.chest then
        SetPedHeadOverlay(ped, 10, cosmetics.chest.style, (cosmetics.chest.thickness/100) + 0.0)
        SetPedHeadOverlayColor(ped, 10, 1, cosmetics.chest.colour, cosmetics.chest.highlights)
    end

    -- Makeup
    if cosmetics.makeup then
        SetPedHeadOverlay(ped, 4, cosmetics.makeup.style, (cosmetics.makeup.thickness/100) + 0.0)
        SetPedHeadOverlayColor(ped, 4, 1, cosmetics.makeup.colour, cosmetics.makeup.highlights)
    end

    -- Lipstick
    if cosmetics.lipstick then
        SetPedHeadOverlay(ped, 8, cosmetics.lipstick.style, (cosmetics.lipstick.thickness/100) + 0.0)
        SetPedHeadOverlayColor(ped, 8, 2, cosmetics.lipstick.colour, cosmetics.lipstick.highlights)
    end

    -- Blush
    if cosmetics.blush then
        SetPedHeadOverlay(ped, 5, cosmetics.blush.style, (cosmetics.blush.thickness/100) + 0.0)
        SetPedHeadOverlayColor(ped, 5, 2, cosmetics.blush.colour, cosmetics.blush.highlights)
    end

    -- Save the cosmetics
    if not entity then
        Base.Skin.currSkin.cosmetics = cosmetics
        if saveSkin then
            Base.Skin.charSkin.cosmetics = table.clone(cosmetics)
        end
    end
end

Base.Skin.saveCurrSkin = function()
    Base.Skin.charSkin = table.clone(Base.Skin.currSkin)
    TriggerServerEvent("scripting:skin:saveSkin", Base.Skin.charSkin)
end

Base.Skin.saveCharSkin = function()
    TriggerServerEvent("scripting:skin:saveSkin", Base.Skin.charSkin)
end

-- External Setters for skin items
Base.Skin.setClothingItem = function(category, key, value, saveSkin, entity)
    if Base.Skin.currSkin.clothing[category] == nil then Base.Skin.currSkin.clothing[category] = {} end
    Base.Skin.currSkin.clothing[category][key] = value
    Base.Skin.applyClothing(Base.Skin.currSkin.clothing, saveSkin, entity)
    if saveSkin then Base.Skin.saveCharSkin() end
end

Base.Skin.setSkinItem = function(category, key, value, saveSkin, entity)
    if key then
        Base.Skin.currSkin.skin[category][key] = value
    else
        Base.Skin.currSkin.skin[category] = value
    end

    Base.Skin.applySkin(Base.Skin.currSkin.skin, saveSkin, entity)
    if saveSkin then Base.Skin.saveCharSkin() end
end

Base.Skin.setCosmeticItem = function(category, key, value, saveSkin, entity)
    if not Base.Skin.currSkin.cosmetics[category] then
        Base.Skin.currSkin.cosmetics[category] = {}
    end
    Base.Skin.currSkin.cosmetics[category][key] = value
    Base.Skin.applyCosmetics(Base.Skin.currSkin.cosmetics, saveSkin, entity)
    if saveSkin then Base.Skin.saveCharSkin() end
end

Base.Skin.addTattoo = function(collection, hash, saveSkin, entity)
    table.insert(Base.Skin.currSkin.tattoos, {collection = collection, hash = hash})
    Base.Skin.applyTattoos(Base.Skin.currSkin.tattoos, saveSkin, entity)
    if saveSkin then Base.Skin.saveCharSkin() end
end

Base.Skin.removeTattoo = function(index, entity)
    table.remove(Base.Skin.currSkin.tattoos, index)
    Base.Skin.applyTattoos(Base.Skin.currSkin.tattoos, saveSkin, entity)
    if saveSkin then Base.Skin.saveCharSkin() end
end

Base.Skin.setModel = function(model, saveSkin, entity)
    if model ~= Base.Skin.currSkin.model then
        Base.Skin.currSkin.model = model
        Base.Skin.setSkin(Base.Skin.currSkin, saveSkin, entity)
    end
end

Base.Skin.toggleItem = function(item, state)
    local PlayerData = Base.GetPlayerData()
    toggle = nil
    if item == "shirt" then
        if state == nil then
            if hiddenClothing.torso then
                toggle = false
            else
                toggle = true
            end
        else
            toggle = not state
        end

        hiddenClothing.torso = toggle
        hiddenClothing.tshirt = toggle
        hiddenClothing.chain = toggle
        hiddenClothing.arms = toggle
        hiddenClothing.decals = toggle

        print("[scripting/skin] Toggling clothing item: shirt. State: ",toggle)
        if toggle then
            itemState = "off"
            colour = "red"
        else
            itemState = "on"
            colour = "green"
        end
        Base.Log("Accessories Menu", PlayerData.logName .. " has toggled shirt | State: " ..itemState, colour, "accessories-menu")

    elseif CLOTHING_TOGGLES[Base.Skin.currSkin.sex][item] then
        if state == nil then
            if hiddenClothing[item] then
                toggle = false
            else
                toggle = true
            end
        else
            toggle = not state
        end

        hiddenClothing[item] = toggle
        if toggle then
            itemState = "off"
            colour = "red"
        else
            itemState = "on"
            colour = "green"
        end
        print("[scripting/skin] Toggling clothing item: "..item..". State: ",toggle)
        Base.Log("Accessories Menu", PlayerData.logName .. " has toggled " .. item .. "| State: " ..itemState, colour, "accessories-menu")
    end

    Base.Skin.applyClothing(Base.Skin.getCurrentSkin().clothing, false)
    return not toggle
end

Base.Skin.isItemHidden = function(item)
    return hiddenClothing[item]
end