local DrawingText = {}

local function toggleNuiFrame(shouldShow)
  SetNuiFocus(shouldShow, shouldShow)
  SendReactMessage('setVisible', shouldShow)
end

RegisterCommand('+scenes', function()
  toggleNuiFrame(true)
end)

RegisterKeyMapping("+scenes", "Start Scenes", "keyboard", "o")

RegisterNUICallback('hideFrame', function(_, cb)
  toggleNuiFrame(false)
  cb({})
end)

RegisterNUICallback('placescene', function(data, cb)
  local text = data.text
  local distance = tonumber(data.distancenumber)
  if distance < 0 or distance > 10 then
    TriggerEvent('chat:addMessage', {
      color = { 255, 0, 0},
      multiline = true,
      args = {"System", "Distance must be between 0 and 10"}
  })
  else
    exports['ud-laser']:ToggleCreationLaser(function(coords)
      local textData = {
        text = text,
        coords = {x = coords.x, y = coords.y, z = coords.z},
        distance = distance
      }
      table.insert(DrawingText, textData)
      TriggerServerEvent('placescene:placed', textData)
    end)
  end
  toggleNuiFrame(false)
  cb('ok')
end)

RegisterNetEvent('placescene:received')
AddEventHandler('placescene:received', function(textData)
  table.insert(DrawingText, textData)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    for i, textData in ipairs(DrawingText) do
      local distance = #(vector3(textData.coords.x, textData.coords.y, textData.coords.z) - pedCoords)
      if distance <= textData.distance then
        DrawText3D(textData.text, textData.coords.x, textData.coords.y, textData.coords.z)
      end
    end
  end
end)

function DrawText3D(text, x, y, z)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  if onScreen then
    SetTextScale(0.35, 0.35)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(_x, _y)
  end
end