Config = {}
Config.Locale = {
  ['cash'] = 'cash $%s',
  ['inventory'] = 'inventory',
  ['use'] = 'use',
  ['give'] = 'give',
  ['remove'] = 'throw',
  ['return'] = 'return',
  ['give_to'] = 'give to',
  ['amount'] = 'amount',
  ['giveammo'] = 'give ammo',
  ['amountammo'] = 'amount of ammo',
  ['noammo'] = 'you do not have enough ammo!',
  ['gave_item'] = 'you gave ~y~%sx~s~ ~b~%s~s~ to ~y~%s~s~',
  ['received_item'] = 'you received ~y~%sx~s~ ~b~%s~s~ from ~b~%s~s~',
  ['gave_weapon'] = 'you gave ~y~1x~s~ ~b~%s~s~ with ~o~%sx~s~ bullets to ~y~%s~s~.',
  ['received_weapon'] = 'you received ~y~1x~s~ ~b~%s~s~ with ~o~%sx~s~ bullets from ~b~%s~s~.',
  ['gave_ammo'] = 'you gave ~o~%sx~s~ bullets to ~y~%s~s~.',
  ['received_ammo'] = 'you received ~o~%sx~s~ bullets from ~b~%s~s~.',
  ['gave_money'] = 'you gave ~g~$%s~s~ to ~y~%s~s~',
  ['received_money'] = 'you received ~g~$%s~s~ from ~b~%s~s~',
  ['gave_account_money'] = 'you gave ~g~$%s~s~ (%s) to ~y~%s~s~',
  ['received_account_money'] = 'you received ~g~$%s~s~ (%s) from ~b~%s~s~',
  ['amount_invalid'] = 'invalid amount',
  ['players_nearby'] = 'no players nearby',
  ['ex_inv_lim'] = 'action not possible, exceeding inventory limit for ~y~%s~s~',
  ['imp_invalid_quantity'] = 'action impossible, invalid quantity',
  ['imp_invalid_amount'] = 'action impossible, invalid amount',
  ['delete_five_min'] = 'the item will be ~r~thrown~s~ in 5 minutes',
  ['threw'] = 'you ~r~threw~s~',
  ['threw_weapon'] = 'you ~r~threw~s~ ~y~1x~s~ ~b~%s~s~ with ~o~%sx~s~ bullets!',
  -- Salary related
  ['received_salary'] = 'you received your salary: ~g~$%s~s~',
  ['received_help'] = 'you recieved your welfare check: ~g~$%s~s~',
  ['company_nomoney'] = 'the company you\'re employeed at is too poor to pay out your salary.',
  ['received_paycheck'] = 'received paycheck',
  ['bank'] = 'bank',
  ['black_money'] = 'dirty Money',
  
  ['act_imp'] = 'action impossible',
  ['in_vehicle'] = 'you can\'t give anything to someone in a vehicle',
  ['cannot_pickup_room'] = 'you do not have enough space in your inventory to pick up ~y~%s~s~!',
  -- Commands
  ['setjob'] = 'assign a job to a user',
  ['id_param'] = 'the ID of the player',
  ['setjob_param2'] = 'the job you wish to assign',
  ['setjob_param3'] = 'the job level',
  ['load_ipl'] = 'load IPL',
  ['unload_ipl'] = 'unload IPL',
  ['play_anim'] = 'play animation',
  ['play_emote'] = 'play emote',
  ['spawn_car'] = 'spawn a car',
  ['spawn_car_param'] = 'name of car',
  ['delete_vehicle'] = 'deletes Vehicle',
  ['delete_veh_param'] = 'press enter',
  ['spawn_object'] = 'spawn object',
  ['spawn_ped'] = 'spawn ped',
  ['spawn_ped_param'] = 'example a_m_m_hillbilly_01',
  ['givemoney'] = 'give money',
  ['setmoney'] = 'set money for a player',
  ['money_type'] = 'valid money types: cash, bank, black',
  ['money_set'] = 'someone ~y~highly ranked~s~ just set ~g~$%s~s~ (%s) for you!',
  ['money_amount'] = 'amount of money',
  ['invalid_account'] = 'invalid account',
  ['account'] = 'account',
  ['giveaccountmoney'] = 'give account money',
  ['invalid_item'] = 'invalid item',
  ['item'] = 'item',
  ['giveitem'] = 'give item',
  ['weapon'] = 'weapon',
  ['giveweapon'] = 'give weapon',
  ['disconnect'] = 'disconnect from the server',
  ['chat_clear'] = 'clear the chat',
  ['chat_clear_all'] = 'clear the chat for everyone',
  -- Weapons
  ['weapon_knife'] = 'Knife',
  ['weapon_nightstick'] = 'Nightstick',
  ['weapon_hammer'] = 'Hammer',
  ['weapon_bat'] = 'Bat',
  ['weapon_golfclub'] = 'Golf Club',
  ['weapon_crowbar'] = 'Crow Bar',
  ['weapon_pistol'] = 'Pistol',
  ['weapon_combatpistol'] = 'Combat Pistol',
  ['weapon_appistol'] = 'AP Pistol',
  ['weapon_pistol50'] = 'Pistol .50',
  ['weapon_microsmg'] = 'Micro SMG',
  ['weapon_smg'] = 'SMG',
  ['weapon_assaultsmg'] = 'Assault SMG',
  ['weapon_assaultrifle'] = 'Assault Rifle',
  ['weapon_carbinerifle'] = 'Carbine Rifle',
  ['weapon_advancedrifle'] = 'Advanced Rifle',
  ['weapon_mg'] = 'MG',
  ['weapon_combatmg'] = 'Combat MG',
  ['weapon_pumpshotgun'] = 'Pump Shotgun',
  ['weapon_sawnoffshotgun'] = 'Sawed-off Shotgun',
  ['weapon_assaultshotgun'] = 'Assault Shotgun',
  ['weapon_bullpupshotgun'] = 'Bullpup Shotgun',
  ['weapon_stungun'] = 'Tazer',
  ['weapon_sniperrifle'] = 'Sniper Rifle',
  ['weapon_heavysniper'] = 'Heavy Sniper',
  ['weapon_remotesniper'] = 'Remote Sniper',
  ['weapon_grenadelauncher'] = 'Grenade Launcher',
  ['weapon_rpg'] = 'Rocket Launcher',
  ['weapon_stinger'] = 'Stinger',
  ['weapon_minigun'] = 'Minigun',
  ['weapon_grenade'] = 'Grenade',
  ['weapon_stickybomb'] = 'Sticky Bomb',
  ['weapon_smokegrenade'] = 'Smoke Grenade',
  ['weapon_bzgas'] = 'BZ Gas',
  ['weapon_molotov'] = 'Molotov Cocktail',
  ['weapon_fireextinguisher'] = 'Fire Extinguisher',
  ['weapon_petrolcan'] = 'Jerrycan',
  ['weapon_digiscanner'] = 'Digiscanner',
  ['weapon_ball'] = 'Ball',
  ['weapon_snspistol'] = 'SNS Pistol',
  ['weapon_bottle'] = 'Bottle',
  ['weapon_gusenberg'] = 'Gusenberg Sweeper',
  ['weapon_specialcarbine'] = 'Special Carbine',
  ['weapon_heavypistol'] = 'Heavy Pistol',
  ['weapon_bullpuprifle'] = 'Bullpup Rifle',
  ['weapon_dagger'] = 'Dagger',
  ['weapon_vintagepistol'] = 'Vintage Pistol',
  ['weapon_firework'] = 'Firework',
  ['weapon_musket'] = 'Musket',
  ['weapon_heavyshotgun'] = 'Heavy Shotgun',
  ['weapon_marksmanrifle'] = 'Marksman Rifle',
  ['weapon_hominglauncher'] = 'Homing Launcher',
  ['weapon_proxmine'] = 'Proximity Mine',
  ['weapon_snowball'] = 'Snowball',
  ['weapon_flaregun'] = 'Flaregun',
  ['weapon_garbagebag'] = 'Garbage Bag',
  ['weapon_handcuffs'] = 'Handcuffs',
  ['weapon_combatpdw'] = 'Combat PDW',
  ['weapon_marksmanpistol'] = 'Marksman Pistol',
  ['weapon_knuckle'] = 'Knuckledusters',
  ['weapon_hatchet'] = 'Hatchet',
  ['weapon_railgun'] = 'Railgun',
  ['weapon_machete'] = 'Machete',
  ['weapon_machinepistol'] = 'Machine Pistol',
  ['weapon_switchblade'] = 'Switchblade',
  ['weapon_revolver'] = 'Heavy Revolver',
  ['weapon_dbshotgun'] = 'Double Barrel Shotgun',
  ['weapon_compactrifle'] = 'Compact Rifle',
  ['weapon_autoshotgun'] = 'Auto Shotgun',
  ['weapon_battleaxe'] = 'Battle Axe',
  ['weapon_compactlauncher'] = 'Compact Launcher',
  ['weapon_minismg'] = 'Mini SMG',
  ['weapon_pipebomb'] = 'Pipe Bomb',
  ['weapon_poolcue'] = 'Pool Cue',
  ['weapon_wrench'] = 'Pipe Wrench',
  ['weapon_flashlight'] = 'Flashlight',
  ['gadget_nightvision'] = 'Night Vision',
  ['gadget_parachute'] = 'Parachute',
  ['weapon_flare'] = 'Flare Gun',
  ['weapon_snspistol_mk2'] = 'SNS Pistol Mk II',
  ['weapon_revolver_mk2'] = 'Heavy Revolver Mk II',
  ['weapon_doubleaction'] = 'Double-Action Revolver',
  ['weapon_specialcarabine_mk2'] = 'Special Carbine Mk II',
  ['weapon_bullpruprifle_mk2'] = 'Bullpup Rifle Mk II',
  ['weapon_pumpshotgun_mk2'] = 'Pump Shotgun Mk II',
  ['weapon_marksmanrifle_mk2'] = 'Marksman Rifle Mk II',
  ['weapon_assaultrifle_mk2'] = 'Assault Rifle Mk II ',
  ['weapon_carbinerifle_mk2'] = 'Carbine Rifle Mk II ',
  ['weapon_combatmg_mk2'] = 'Combat MG Mk II',
  ['weapon_heavysniper_mk2'] = 'Heavy Sniper Mk II',
  ['weapon_pistol_mk2'] = 'Pistol Mk II',
  ['weapon_smg_mk2'] = 'SMG Mk II',
}

function _U(str)
    if Config.Locale[str] then
        return Config.Locale[str]
    else
        return "Language option ["..str.."] not found"
    end
end

Config.Weapons = {

  {
    name = "WEAPON_FLASHBANG",
    label = "Flashbang",
    components = {}
  },

  {
    name = 'WEAPON_KNIFE',
    label = _U('weapon_knife'),
    components = {}
  },

  {
    name = 'WEAPON_NIGHTSTICK',
    label = _U('weapon_nightstick'),
    components = {}
  },

  {
    name = 'WEAPON_HAMMER',
    label = _U('weapon_hammer'),
    components = {}
  },

  {
    name = 'WEAPON_BAT',
    label = _U('weapon_bat'),
    components = {}
  },

  {
    name = 'WEAPON_GOLFCLUB',
    label = _U('weapon_golfclub'),
    components = {}
  },

  {
    name = 'WEAPON_CROWBAR',
    label = _U('weapon_crowbar'),
    components = {}
  },

  {
    name = 'WEAPON_PISTOL',
    label = _U('weapon_pistol'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_PISTOL_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_PISTOL_CLIP_02') },
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP_02') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_PISTOL_VARMOD_LUXE') }
    }
  },

  {
    name = 'WEAPON_COMBATPISTOL',
    label = _U('weapon_combatpistol'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_02') },
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER') }
    }
  },

  {
    name = 'WEAPON_APPISTOL',
    label = _U('weapon_appistol'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_APPISTOL_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_APPISTOL_CLIP_02') },
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_APPISTOL_VARMOD_LUXE') }
    }
  },

  {
    name = 'WEAPON_PISTOL50',
    label = _U('weapon_pistol50'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_PISTOL50_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_PISTOL50_CLIP_02') },
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_PISTOL50_VARMOD_LUXE') }
    }
  },

  {
    name = 'WEAPON_REVOLVER',
    label = _U('weapon_revolver'),
    components = {}
  },

  {
    name = 'WEAPON_SNSPISTOL',
    label = _U('weapon_snspistol'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_SNSPISTOL_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_SNSPISTOL_CLIP_02') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SNSPISTOL_VARMOD_LOWRIDER') }
    }
  },

  {
    name = 'WEAPON_HEAVYPISTOL',
    label = _U('weapon_heavypistol'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_02') },
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_HEAVYPISTOL_VARMOD_LUXE') }
    }
  },

  {
    name = 'WEAPON_VINTAGEPISTOL',
    label = _U('weapon_vintagepistol'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_02') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') }
    }
  },

  {
    name = 'WEAPON_MICROSMG',
    label = _U('weapon_microsmg'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MICROSMG_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MICROSMG_CLIP_02') },
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
      { name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_MICROSMG_VARMOD_LUXE') }
    }
  },

  {
    name = 'WEAPON_SMG',
    label = _U('weapon_smg'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_SMG_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_SMG_CLIP_02') },
      { name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_SMG_CLIP_03') },
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
      { name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO_02') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SMG_VARMOD_LUXE') }
    }
  },

  {
    name = 'WEAPON_SMG_MK2',
    label = 'SMG MK2',
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_SMG_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_SMG_CLIP_02') },
      { name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_SMG_CLIP_03') },
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
      { name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO_02') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SMG_VARMOD_LUXE') }
    }
  },

  {
    name = 'WEAPON_ASSAULTSMG',
    label = _U('weapon_assaultsmg'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_02') },
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
      { name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER') }
    }
  },

  {
    name = 'WEAPON_MINISMG',
    label = _U('weapon_minismg'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MINISMG_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MINISMG_CLIP_02') }
    }
  },

  {
    name = 'WEAPON_MACHINEPISTOL',
    label = _U('weapon_machinepistol'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_02') },
      { name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_03') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') }
    }
  },

  {
    name = 'WEAPON_COMBATPDW',
    label = _U('weapon_combatpdw'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_02') },
      { name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_03') },
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
      { name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
      { name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL') }
    }
  },
  
  {
    name = 'WEAPON_PUMPSHOTGUN',
    label = _U('weapon_pumpshotgun'),
    components = {
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_SR_SUPP') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER') }
    }
  },

  {
    name = 'WEAPON_PUMPSHOTGUN_MK2',
    label = 'Pump Shotgun MK2',
    components = {}
  },

  {
    name = 'WEAPON_SAWNOFFSHOTGUN',
    label = _U('weapon_sawnoffshotgun'),
    components = {
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE') }
    }
  },

  {
    name = 'WEAPON_ASSAULTSHOTGUN',
    label = _U('weapon_assaultshotgun'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_02') },
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
      { name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
    }
  },

  {
    name = 'WEAPON_BULLPUPSHOTGUN',
    label = _U('weapon_bullpupshotgun'),
    components = {
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
      { name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
    }
  },

  {
    name = 'WEAPON_HEAVYSHOTGUN',
    label = _U('weapon_heavyshotgun'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_02') },
      { name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_03') },
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
      { name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
    }
  },

  {
    name = 'WEAPON_ASSAULTRIFLE',
    label = _U('weapon_assaultrifle'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02') },
      { name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_03') },
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
      { name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
      { name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_VARMOD_LUXE') }
    }
  },

  {
    name = 'WEAPON_CARBINERIFLE',
    label = _U('weapon_carbinerifle'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_02') },
      { name = 'clip_box', label = _U('component_clip_box'), hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_03') },
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
      { name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
      { name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_CARBINERIFLE_VARMOD_LUXE') }
    }
  },

  {
    label = "Carbine Rifle MK2", 
    name = "WEAPON_CARBINERIFLE_MK2",
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_CARBINERIFLE_MK2_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_CARBINERIFLE_MK2_CLIP_02') },
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
      { name = 'holographic', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SIGHTS') },
      { name = 'smallscope', label = "Small Scope", hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO_MK2') },
      { name = 'largescope', label = "Large Scope", hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM_MK2') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
      { name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP_02') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_CARBINERIFLE_VARMOD_LUXE') },
      { name = 'tracer_rounds', label = 'Tracer Rounds', hash = GetHashKey('COMPONENT_CARBINERIFLE_VARMOD_LUXE') },
      { name = 'incendiary_rounds', label = 'Incendiary Rounds', hash = GetHashKey('COMPONENT_CARBINERIFLE_MK2_CLIP_INCENDIARY') },
      { name = 'armour_piercing_rounds', label = 'Armour Piercing Rounds', hash = GetHashKey('COMPONENT_CARBINERIFLE_MK2_CLIP_ARMORPIERCING') },
      { name = 'fmj_rounds', label = 'FMJ Rounds', hash = GetHashKey('COMPONENT_CARBINERIFLE_MK2_CLIP_FMJ') },
    }
  }, 

  {
    name = 'WEAPON_ADVANCEDRIFLE',
    label = _U('weapon_advancedrifle'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_02') },
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
      { name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE') }
    }
  },

  {
    name = 'WEAPON_SPECIALCARBINE',
    label = _U('weapon_specialcarbine'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_02') },
      { name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_03') },
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
      { name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
      { name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER') }
    }
  },

  {
    name = 'WEAPON_BULLPUPRIFLE',
    label = _U('weapon_bullpuprifle'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_02') },
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
      { name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
      { name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_BULLPUPRIFLE_VARMOD_LOW') }
    }
  },

  {
    name = 'WEAPON_COMPACTRIFLE',
    label = _U('weapon_compactrifle'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_02') },
      { name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_03') }
    }
  },

  {
    name = 'WEAPON_MG',
    label = _U('weapon_mg'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MG_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MG_CLIP_02') },
      { name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL_02') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_MG_VARMOD_LOWRIDER') }
    }
  },

  {
    name = 'WEAPON_COMBATMG',
    label = _U('weapon_combatmg'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMBATMG_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMBATMG_CLIP_02') },
      { name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM') },
      { name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_COMBATMG_VARMOD_LOWRIDER') }
    }
  },

  {
    name = 'WEAPON_GUSENBERG',
    label = _U('weapon_gusenberg'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_GUSENBERG_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_GUSENBERG_CLIP_02') },
    }
  },

  {
    name = 'WEAPON_SNIPERRIFLE',
    label = _U('weapon_sniperrifle'),
    components = {
      { name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE') },
      { name = 'scope_advanced', label = _U('component_scope_advanced'), hash = GetHashKey('COMPONENT_AT_SCOPE_MAX') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SNIPERRIFLE_VARMOD_LUXE') }
    }
  },

  {
    name = 'WEAPON_HEAVYSNIPER',
    label = _U('weapon_heavysniper'),
    components = {
      { name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE') },
      { name = 'scope_advanced', label = _U('component_scope_advanced'), hash = GetHashKey('COMPONENT_AT_SCOPE_MAX') }
    }
  },

  {
    name = 'WEAPON_MARKSMANRIFLE',
    label = _U('weapon_marksmanrifle'),
    components = {
      { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_01') },
      { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_02') },
      { name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
      { name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM') },
      { name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
      { name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
      { name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_MARKSMANRIFLE_VARMOD_LUXE') }
    }
  },

  {
    name = 'WEAPON_GRENADELAUNCHER',
    label = _U('weapon_grenadelauncher'),
    components = {}
  },

  {
    name = 'WEAPON_RPG',
    label = _U('weapon_rpg'),
    components = {}
  },

  {
    name = 'WEAPON_STINGER',
    label = _U('weapon_stinger'),
    components = {}
  },

  {
    name = 'WEAPON_MINIGUN',
    label = _U('weapon_minigun'),
    components = {}
  },

  {
    name = 'WEAPON_GRENADE',
    label = _U('weapon_grenade'),
    components = {}
  },

  {
    name = 'WEAPON_STICKYBOMB',
    label = _U('weapon_stickybomb'),
    components = {}
  },

  {
    name = 'WEAPON_SMOKEGRENADE',
    label = _U('weapon_smokegrenade'),
    components = {}
  },

  {
    name = 'WEAPON_BZGAS',
    label = _U('weapon_bzgas'),
    components = {}
  },

  {
    name = 'WEAPON_MOLOTOV',
    label = _U('weapon_molotov'),
    components = {}
  },

  {
    name = 'WEAPON_FIREEXTINGUISHER',
    label = _U('weapon_fireextinguisher'),
    components = {}
  },

  {
    name = 'WEAPON_PETROLCAN',
    label = _U('weapon_petrolcan'),
    components = {}
  },

  {
    name = 'WEAPON_DIGISCANNER',
    label = _U('weapon_digiscanner'),
    components = {}
  },

  {
    name = 'WEAPON_BALL',
    label = _U('weapon_ball'),
    components = {}
  },

  {
    name = 'WEAPON_BOTTLE',
    label = _U('weapon_bottle'),
    components = {}
  },

  {
    name = 'WEAPON_DAGGER',
    label = _U('weapon_dagger'),
    components = {}
  },

  {
    name = 'WEAPON_FIREWORK',
    label = _U('weapon_firework'),
    components = {}
  },

  {
    name = 'WEAPON_MUSKET',
    label = _U('weapon_musket'),
    components = {}
  },

  {
    name = 'WEAPON_STUNGUN',
    label = _U('weapon_stungun'),
    components = {}
  },

  {
    name = 'WEAPON_HOMINGLAUNCHER',
    label = _U('weapon_hominglauncher'),
    components = {}
  },

  {
    name = 'WEAPON_PROXMINE',
    label = _U('weapon_proxmine'),
    components = {}
  },

  {
    name = 'WEAPON_SNOWBALL',
    label = _U('weapon_snowball'),
    components = {}
  },

  {
    name = 'WEAPON_FLAREGUN',
    label = _U('weapon_flaregun'),
    components = {}
  },

  {
    name = 'WEAPON_GARBAGEBAG',
    label = _U('weapon_garbagebag'),
    components = {}
  },

  {
    name = 'WEAPON_HANDCUFFS',
    label = _U('weapon_handcuffs'),
    components = {}
  },

  {
    name = 'WEAPON_MARKSMANPISTOL',
    label = _U('weapon_marksmanpistol'),
    components = {}
  },

  {
    name = 'WEAPON_KNUCKLE',
    label = _U('weapon_knuckle'),
    components = {}
  },

  {
    name = 'WEAPON_HATCHET',
    label = _U('weapon_hatchet'),
    components = {}
  },

  {
    name = 'WEAPON_RAILGUN',
    label = _U('weapon_railgun'),
    components = {}
  },

  {
    name = 'WEAPON_MACHETE',
    label = _U('weapon_machete'),
    components = {}
  },

  {
    name = 'WEAPON_SWITCHBLADE',
    label = _U('weapon_switchblade'),
    components = {}
  },

  {
    name = 'WEAPON_DBSHOTGUN',
    label = _U('weapon_dbshotgun'),
    components = {}
  },

  {
    name = 'WEAPON_AUTOSHOTGUN',
    label = _U('weapon_autoshotgun'),
    components = {}
  },

  {
    name = 'WEAPON_BATTLEAXE',
    label = _U('weapon_battleaxe'),
    components = {}
  },

  {
    name = 'WEAPON_COMPACTLAUNCHER',
    label = _U('weapon_compactlauncher'),
    components = {}
  },

  {
    name = 'WEAPON_PIPEBOMB',
    label = _U('weapon_pipebomb'),
    components = {}
  },

  {
    name = 'WEAPON_POOLCUE',
    label = _U('weapon_poolcue'),
    components = {}
  },

  {
    name = 'WEAPON_WRENCH',
    label = _U('weapon_wrench'),
    components = {}
  },

  {
    name = 'WEAPON_FLASHLIGHT',
    label = _U('weapon_flashlight'),
    components = {}
  },

  {
    name = 'GADGET_NIGHTVISION',
    label = _U('gadget_nightvision'),
    components = {}
  },

  {
    name = 'GADGET_PARACHUTE',
    label = _U('gadget_parachute'),
    components = {}
  },

  {
    name = 'WEAPON_FLARE',
    label = _U('weapon_flare'),
    components = {}
  },

  {
    name = 'WEAPON_DOUBLEACTION',
    label = _U('weapon_doubleaction'),
    components = {}
  }

}