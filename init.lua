if not core.settings:get_bool("hide_minimap_unconditional", false) then
	core.register_privilege("minimap", {
		description = "Allows players to use the minimap",
		give_to_singleplayer = false,
	})

	local time = 0
	core.register_globalstep(function(dtime)
		time = time + dtime
		if time > 20 then
			time = 0
			for _, player in pairs(core.get_connected_players()) do
				local name = player:get_player_name()
				local privs = core.get_player_privs(name)
				if not privs.minimap then
					player:hud_set_flags({ minimap = false })
				elseif privs.minimap == true then
					player:hud_set_flags({ minimap = true })
				end
			end
		end
	end)
else
	core.register_on_joinplayer(function(player)
		player:hud_set_flags({ minimap = false })
	end)
end
