long_name = "Werekracken's Stone Warden Race Unlock Fork"
short_name = "wkstone-warden-race-unlock"
for_module = "tome"
version = {1,7,4}
addon_version = {1,0,1}
weight = 101
author = { "Werekracken" }
homepage = "https://te4.org/user/102798/addons"
description = [[
This is a fork of Bnnuy's Stone Warden Race Unlock addon which removes the race lock from stone warden that prevents creation of non-dwarf stone wardens.
This fork also makes stone warden talents available on adventurers and wanderers.

As a side effect, if you play with multiple addons you should now see all of the talents from those available on adventurers and wanderers too.
(This addon makes talents with the not_on_random_boss available to adventurers and wanderers. Use them at your own risk.)

This addon overloads the adventurer and wilder classes, and superloads the WandererSeed mod dialog.

https://github.com/Werekracken/tome-wkstone-warden-race-unlock
----
Changelog
- v1.0.0 Initial release
- v1.0.1 Fixed an issue that was causing the talents screen to come up twice on character creation on all wanderers and causing the character to get double the trees at creation if you playing as a 3-in-1 wanderer using that addon.
]]
tags = {'Stone', 'stone', 'Warden', 'warden', 'Unlock', 'unlock'}

overload = true
superload = true
hooks = false
data = false