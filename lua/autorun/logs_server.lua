--[[
	
	Simple logs. Made by fghdx.
	https://github.com/fghdx/Gmod-Simple-Logs/
	fghdx.me

]]--

if CLIENT then return end --Make sure the client does not try to run any lua in this file.

-- Function to call when a player dies.
function player_die( victim, inflictor, killer)

	--I do not know the PlayerDeath function too well and I have no idea why
	--but it would not return a weapon it would instead return the killer.
	--The workaround is setting weapon equal to the weapon the killer is holding
	--As far as I could figure out.

	player_name = victim:Name() --Get the Vicims name
	weapon = killer:GetActiveWeapon():GetClass() --Get the weapon the victim was killed with
	killer_name = killer:Name() --Get killers name
	time = os.time() --Get the time the player died

	umsg.Start( "player_die_info" );-------------------------
		umsg.String(player_name)-----------------------------
		umsg.String(killer_name)--------Sending the Data to 
		umsg.String(weapon)-------------be recieved by client
		umsg.Long(time)--------------------------------------
	umsg.End();----------------------------------------------


end
hook.Add( "PlayerDeath", "playerDeath", player_die )

-- Function to call when a player takes damage
function player_take_damage( victim, attacker, healthLeft, damageTaken )
	if attacker:IsPlayer() then --Make sure player is hurt by another player, rather than the world or console.
		player_name = victim:Name() --Get the Vicims name
		attacker = attacker:Name() --Get attackers name
		damage = damageTaken --Get the damage Dealt
		time = os.time() --Get the time of the event

		umsg.Start( "player_hurt_info" );------------------------
			umsg.String(player_name)-----------------------------
			umsg.String(attacker)-----------Sending the Data to 
			umsg.Long(damage)---------------be recieved by client
			umsg.Long(time)--------------------------------------
		umsg.End();----------------------------------------------
	end
end
hook.Add( "PlayerHurt", "playerHurt", player_take_damage )

--Function called when player spawns a prop.
function player_spawn_prop( ply, model )

	player_name = ply:Name()
	time = os.time() --Get the time of the event

	umsg.Start( "player_spawn_info" );------------------------
		umsg.String(player_name)-----------------------------
		umsg.String(model)------------Sending the Data to 
		umsg.Long(time)---------------be recieved by client
	umsg.End();----------------------------------------------
end
hook.Add("PlayerSpawnProp", "playerSpawnProp", player_spawn_prop)


----------------------------------------------------------
------------------ADD NEW FUNCTIONS HERE------------------
----------------------------------------------------------

--[[
EXAMPLE:

function function_name( param1, param2 )
	
	variable = param1

	umsg.Start( "USERMESSAGE_NAME" );
		umsg.String(variable)
		umsg.Long(os.time())
	umsg.End();
end
hook.Add("HOOK", "HOOK_IDENTIFIER", function_name)

]]