long_name = "Werekracken's Stone Warden Race Unlock Fork"
short_name = "wkstone-warden-race-unlock"
for_module = "tome"
version = {1,7,4}
addon_version = {1,0,0}
weight = 101
author = { "Werekracken" }
homepage = "https://te4.org/user/102798/addons"
description = [[
This is a fork of Bnnuy's Stone Warden Race Unlock addon which removes the race lock from stone warden that prevents creation of non-dwarf stone wardens.
This fork also makes stone warden talents available on adventurers and wanderers.

As a side effect, if you play with multiple addons you should now see all of the talents from those available on adventurers and wanderers too.
(Without this addon they are excluded if the class has not_on_random_boss set to true.)

This addon overloads the adventurer and wilder classes, and superloads the WandererSeed mod dialog.
----
Changelog
- v1.0.0 Initial release
]]
tags = {'Stone', 'stone', 'Warden', 'warden', 'Unlock', 'unlock'}

overload = true
superload = true
hooks = false
data = false