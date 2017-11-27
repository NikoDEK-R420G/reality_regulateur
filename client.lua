-------------------------------------
--Thanks to Povers for his tutorial--
----------Créer par Povers-----------
-------------------------------------

local regul = false
local speed = 0
local actualdamage = 0
local overregul = false
Citizen.CreateThread(function()
   while true do
	    Citizen.Wait(0)
		local veh = GetVehiclePedIsIn(GetPlayerPed(-1),false)
		local actualspeed = GetEntitySpeed(veh)
		local dmg = GetVehicleBodyHealth(veh)
		local allwheel = IsVehicleOnAllWheels(veh)

		if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
		    if IsControlJustPressed(1,38) and (actualspeed*3.6>60) and (GetVehicleCurrentGear(veh) > 0) then
				regul = not regul
				speed = actualspeed
				actualdamage = dmg
				ShowNotificationMain("Régulateur activer")
		    end
		    if not allwheel or not IsVehicleEngineOn(veh) or IsControlJustPressed(1,72) or IsControlJustPressed(1,76) or (tonumber(actualdamage - dmg) > 15) then
				regul = false
			elseif tonumber(actualdamage - dmg) > 15 then
				actualdamage = dmg
		    end
		    if regul and allwheel and not overregul then
		    	SetVehicleForwardSpeed(veh, speed)
			end	

			if IsControlJustPressed(1,71) and regul then
				overregul = true
			end
			if actualspeed < speed and regul and overregul then
				overregul = false
			end
		else
			regul = false
		end
	end
end)

function ShowNotificationMain(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
