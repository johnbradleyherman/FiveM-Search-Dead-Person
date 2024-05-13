ESX = exports['es_extended']:getSharedObject()

RegisterCommand('steal', function()
    local player = PlayerPedId()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 1.5 then
        local closestPlayerPed = GetPlayerPed(closestPlayer)
        if IsPlayerDead(closestPlayer) then
            local success = lib.progressBar({
                duration = 10000,
                label = 'Stealing...',
                canCancel = true,
                disable = {
                    move = true,
                    combat = true,
                    car = true,
                    sprint = true
                },
                anim = {
                    dict = 'anim@gangops@facility@servers@bodysearch@',
                    clip = 'player_search'
                },
            })  
            if success then
                exports.ox_inventory:openInventory('player', GetPlayerServerId(closestPlayer))
                Citizen.Wait(3000) 
                ClearPedTasks(player)
                ClearPedSecondaryTask(player)
            else
                lib.notify({
                    title = 'Cancelled',
                    type = 'info',
                    duration = 5000,
                    position = 'center-right',
                    style = {
                        backgroundColor = '#1C1C1C',
                        color = '#C1C2C5',
                        borderRadius = '8px',
                        ['.description'] = {
                            fontSize = '16px',
                            color = '#B0B3B8'
                        },
                    },
                })
            end
        else
            lib.notify({
                title = 'The person is not dead',
                type = 'error',
                duration = 5000,
                position = 'center-right',
                style = {
                    backgroundColor = '#1C1C1C',
                    color = '#C1C2C5',
                    borderRadius = '8px',
                    ['.description'] = {
                        fontSize = '16px',
                        color = '#B0B3B8'
                    },
                },
            })
        end
    else
        lib.notify({
            title = 'No nearby dead person',
            type = 'error',
            duration = 5000,
            position = 'center-right',
            style = {
                backgroundColor = '#1C1C1C',
                color = '#C1C2C5',
                borderRadius = '8px',
                ['.description'] = {
                    fontSize = '16px',
                    color = '#B0B3B8'
                },
            },
        })
    end
end)
