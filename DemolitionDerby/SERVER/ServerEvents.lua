local CurrentlySpawnedProps = {}

RegisterServerEvent('DD:Server:MapInformations')
--AddEventHandler('DD:Server:MapInformations', function(SpawnedProps, ReferenceZ, RandomVehicleClass)
AddEventHandler('DD:Server:MapInformations', function(RandomVehicleClass)
	CurrentlySpawnedProps = SpawnedProps
--	TriggerClientEvent('DD:Client:MapInformations', -1, CurrentlySpawnedProps, ReferenceZ, RandomVehicleClass)
	TriggerClientEvent('DD:Client:MapInformations', -1, RandomVehicleClass)
end)

RegisterServerEvent('DD:Server:SyncTimeAndWeather')
AddEventHandler('DD:Server:SyncTimeAndWeather', function(Time, Weather)
	TriggerClientEvent('DD:Client:SyncTimeAndWeather', -1, Time, Weather)
end)

RegisterServerEvent('DD:Server:Ready')
AddEventHandler('DD:Server:Ready', function(Player)
	TriggerClientEvent('DD:Client:Ready', -1, Player)
end)

RegisterServerEvent('DD:Server:GetRandomMap')
AddEventHandler('DD:Server:GetRandomMap', function()
	math.randomseed(tonumber(tostring(os.time()):reverse():sub(1,6)))
	local RandomMapName = Maps[math.random(#Maps)]
	local MapFile = io.open('DemolitionDerbyMaps' .. GetOSSep() .. RandomMapName, 'r')
	local MapFileContent = MapFile:read('*a')
	local MapFileContentToLUA = MapToLUA(MapFileContent)
	MapFile:close()
	TriggerClientEvent('DD:Client:SpawnMap', -1, RandomMapName, MapFileContentToLUA, source)
end)

RegisterServerEvent('DD:Server:Countdown')
AddEventHandler('DD:Server:Countdown', function(State)
	TriggerClientEvent('DD:Client:Countdown', -1, State)
end)

RegisterServerEvent('DD:Server:GameFinished')
AddEventHandler('DD:Server:GameFinished', function()
	TriggerClientEvent('DD:Client:GameFinished', -1)
end)

RegisterServerEvent('DD:Server:IsGameRunning')
AddEventHandler('DD:Server:IsGameRunning', function()
	if GetNumPlayerIndices() > 1 then
		TriggerClientEvent('DD:Client:IsGameRunning', -1, source)
	else
		TriggerClientEvent('DD:Client:IsGameRunningAnswer', source, false)
	end
end)

RegisterServerEvent('DD:Server:IsGameRunningAnswer')
AddEventHandler('DD:Server:IsGameRunningAnswer', function(Player, State)
	TriggerClientEvent('DD:Client:IsGameRunningAnswer', Player, State)
end)

RegisterServerEvent('DD:Server:GetDevInfos')
AddEventHandler('DD:Server:GetDevInfos', function()
	TriggerClientEvent('DD:Client:GotDevInfos', source, IsPlayerAceAllowed(source, 'DD'), Maps)
end)

RegisterServerEvent('DD:Server:DevMode')
AddEventHandler('DD:Server:DevMode', function(DevMode)
	TriggerClientEvent('DD:Client:DevMode', -1, DevMode)
end)

RegisterServerEvent('DD:Server:LoadMap')
AddEventHandler('DD:Server:LoadMap', function(Map)
	if TableContainsValue(Maps, Map) then
		local MapFile = io.open('DemolitionDerbyMaps' .. GetOSSep() .. Map, 'r')
		local MapFileContent = MapFile:read('*a')
		local MapFileContentToLUA = MapToLUA(MapFileContent)
		MapFile:close()
		TriggerClientEvent('DD:Client:SpawnMap', -1, Map, MapFileContentToLUA, source)
	end
end)

