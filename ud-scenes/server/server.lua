RegisterNetEvent('placescene:placed')
AddEventHandler('placescene:placed', function(textData)
    TriggerClientEvent('placescene:received', -1, textData)
end)