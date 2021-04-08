------------------------------------------------------------------
--                          Functions
------------------------------------------------------------------

-- Get entity in front of player
function GetEntInFrontOfPlayer(Distance, Ped)
  local Ent = nil
  local CoA = GetEntityCoords(Ped, 1)
  local CoB = GetOffsetFromEntityInWorldCoords(Ped, 0.0, Distance, 0.0)
  local RayHandle = StartShapeTestRay(CoA.x, CoA.y, CoA.z, CoB.x, CoB.y, CoB.z, -1, Ped, 0)
  local A,B,C,D,Ent = GetRaycastResult(RayHandle)
  return Ent
end

local function RotationToDirection(rotation)
  local adjustedRotation = 
  { 
    x = (math.pi / 180) * rotation.x, 
    y = (math.pi / 180) * rotation.y, 
    z = (math.pi / 180) * rotation.z 
  }
  local direction = 
  {
    x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
    y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
    z = math.sin(adjustedRotation.x)
  }
  return direction
end

-- Camera's coords
function GetCoordsFromCam(distance)
  local cameraRotation = GetGameplayCamRot()
  local cameraCoord = GetGameplayCamCoord()
  local direction = RotationToDirection(cameraRotation)
  local destination = { 
    x = cameraCoord.x + direction.x * distance, 
    y = cameraCoord.y + direction.y * distance, 
    z = cameraCoord.z + direction.z * distance 
  }

  return destination.x, destination.y, destination.z
end

-- Get entity's ID and coords from where player sis targeting
function Target(Distance, Ped)
  local Entity = nil
  cameraCoord = GetGameplayCamCoord()
  farCoordsX, farCoordsY, farCoordsZ = GetCoordsFromCam(Distance)
  local RayHandle = StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, farCoordsX, farCoordsY, farCoordsZ, -1, Ped, 0)
  local A,B,C,D,Entity = GetRaycastResult(RayHandle)
  return Entity, farCoordsX, farCoordsY, farCoordsZ
end