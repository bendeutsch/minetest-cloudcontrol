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

local function parse(param)
	local settings = {}

	param = param:trim()

	local density = string.match(param, 'density +([%d.]+)')
	if density then
		settings.density = density
	end

	local color = string.match(param, 'color +(#[0-9a-f]+)')
	if color then
		settings.color = color
	end

	local ambient = string.match(param, 'ambient +(#[0-9a-f]+)')
	if ambient then
		settings.ambient = ambient
	end

	local height = string.match(param, 'height +([%d.]+)')
	if height then
		settings.height = height
	end

	local thickness = string.match(param, 'thickness +([%d.]+)')
	if thickness then
		settings.thickness = thickness
	end

	local speed_x, speed_z = string.match(param, 'speed +([%d.-]+) +([%d.-]+)')
	if speed_z then
		settings.speed = { x = speed_x, y = speed_z, z = speed_z }
	end

	return settings
end

minetest.register_chatcommand("clouds", {
	params = "[density <num>] [color <#col>] [ambient <#col>] [height <num>] [thickness <num>] [speed <x> <z>]",
	description = "Control cloud appearance",
	func = function(caller, param)

		-- guaranteed to exist?
		local player = minetest.get_player_by_name(caller)
		local settings = parse(param)

		player:set_clouds(settings)

		return true, "Clouds set"
	end,
})
