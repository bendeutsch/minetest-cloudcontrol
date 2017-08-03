# Cloud control [cloudcontrol]

Simple cloud control mod for Minetest.

Version: 1.0.0

License:
  Code: LGPL 2.1 (see included LICENSE file)

Report bugs or request help on the forum topic.

## Description

This mod aims to replace the original `cloud_height` client configuration
setting. Since the introduction of the Lua API for clouds, the only use
case of this setting is when the player cares about their clouds, but the
server does not. This mod aims to cover this use case.

For single player games, just install this mod, and configure your clouds
to your heart's desire. For servers, ask the server administrators to
install this mod; it only allows players to set their own clouds (which is
a client-only effect anyway), everyone else can ignore it. 

## Dependencies
* A recent enough client and server with the clouds Lua API (0.4.16 and up) 
* No dependencies on mods

## Installation

Unzip the archive, rename the folder to to `cloudcontrol` if it is named
differently and place it in `minetest/mods/`

(  Linux: If you have a linux system-wide installation place
    it in `~/.minetest/mods/.`  )

(  If you only want this to be used in a single world, place
    the folder in worldmods/ in your worlddirectory.  )

For further information or help see:
http://wiki.minetest.com/wiki/Installing_Mods
