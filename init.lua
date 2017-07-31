--[[

Cloud control [cloudcontrol]
==========================

A simple mod to control your own clouds.

Copyright (C) 2015 Ben Deutsch <ben@bendeutsch.de>

License
-------

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
USA

]]

minetest.register_chatcommand("clouds", {
	params = "[height <height>]",
	description = "Control cloud appearance",
	func = function(caller, param)

		-- guaranteed to exist?
		local player = minetest.get_player_by_name(caller)

		param = param:trim()
		-- bare minimum: setting your own height
		local height = string.match(param, 'height +(%d+)')
		if height then
			player:set_clouds({
				height = height,
			})

			return true, "Clouds height set to " .. height
        else
			return false, "Invalid usage, see /help clouds"
		end
	end,
})
