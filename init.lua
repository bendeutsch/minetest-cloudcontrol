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

local function parse_clouds(param)
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

local function format_color(color)
	if color.a then
		return string.format('#%02x%02x%02x%02x', color.r, color.g, color.b, color.a)
	else
		return string.format('#%02x%02x%02x', color.r, color.g, color.b)
	end
end

local function format_clouds(settings)
	local param = ""
	if settings.density then
		param = param .. "density " .. string.format('%.2f', settings.density) .. " "
	end
	if settings.color then
		param = param .. "color " .. format_color(settings.color) .. " "
	end
	if settings.ambient then
		param = param .. "ambient " .. format_color(settings.ambient) .. " "
	end
	if settings.height then
		param = param .. "height " .. string.format('%.2f', settings.height) .. " "
	end
	if settings.thickness then
		param = param .. "thickness " .. string.format('%.2f', settings.thickness) .. " "
	end
	if settings.speed then
		param = param .. "speed " .. string.format('%.2f', settings.speed.x) .. " "
		if settings.speed.y then
			param = param .. string.format('%.2f', settings.speed.y) .. " "
	    else
			param = param .. string.format('%.2f', settings.speed.z) .. " "
	    end
    end
	param = param:trim()
	return param
end

minetest.register_chatcommand("clouds", {
	params = "[density <num>] [color <#col>] [ambient <#col>] [height <num>] [thickness <num>] [speed <x> <z>]",
	description = "Control cloud appearance",
	func = function(caller, param)

		-- guaranteed to exist?
		local player = minetest.get_player_by_name(caller)
		local settings = parse_clouds(param)

		player:set_clouds(settings)
		settings = player:get_clouds()

		local cloudstring = format_clouds(settings)
		player:set_attribute('cloudcontrol:settings', cloudstring)
		return true, "Clouds set: " .. cloudstring
	end,
})

minetest.register_on_joinplayer(function(player)
	local cloudstring = player:get_attribute('cloudcontrol:settings')
	if cloudstring then
		player:set_clouds(parse_clouds(cloudstring))
	end
end)
