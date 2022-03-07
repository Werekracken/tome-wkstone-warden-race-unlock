local _M = loadPrevious(...)

require "engine.class"
local Dialog = require "engine.ui.Dialog"
local Separator = require "engine.ui.Separator"
local List = require "engine.ui.List"
local Button = require "engine.ui.Button"
local ButtonImage = require "engine.ui.ButtonImage"
local Textbox = require "engine.ui.Textbox"
local Textzone = require "engine.ui.Textzone"
local Checkbox = require "engine.ui.Checkbox"

module(..., package.seeall, class.inherit(Dialog))


local base_makeWanderer = _M.makeWanderer
function _M:makeWanderer()
	local retval = base_makeWanderer(self)

	local birth = self.birth
	local actor = self.actor
	local tts_class = {}
	local tts_generic = {}
	local tts_addons = {}

	-- Find all available trees
	for _, class in ipairs(birth.all_classes) do if class.id ~= "Adventurer" then
--		for _, sclass in ipairs(class.nodes) do if sclass.def and ((not sclass.def.not_on_random_boss) or (sclass.id == "Stone Warden" and birth.descriptors_by_type.race == "Dwarf")) then
		for _, sclass in ipairs(class.nodes) do if sclass.def then
			if birth.birth_descriptor_def.subclass[sclass.id].talents_types then
				local tt = birth.birth_descriptor_def.subclass[sclass.id].talents_types
				if type(tt) == "function" then tt = tt(birth) end

				for t, _ in pairs(tt) do
					local tt_def = actor:getTalentTypeFrom(t)
					if tt_def then
						tts_addons[tt_def.source] = true
						if tt_def.generic then
							table.insert(tts_generic, t)
						else
							table.insert(tts_class, t)
						end
					end
				end
			end

			if birth.birth_descriptor_def.subclass[sclass.id].unlockable_talents_types then
				local tt = birth.birth_descriptor_def.subclass[sclass.id].unlockable_talents_types
				if type(tt) == "function" then tt = tt(birth) end

				for t, v in pairs(tt) do
					if profile.mod.allow_build[v[3]] then
						local tt_def = actor:getTalentTypeFrom(t)
						if tt_def then
							tts_addons[tt_def.source] = true
							if tt_def.generic then
								table.insert(tts_generic, t)
							else
								table.insert(tts_class, t)
							end
						end
					end
				end
			end
		end end
	end end
	actor.randventurer_class_trees = tts_class
	actor.randventurer_generic_trees = tts_generic

	-- Compute the addons fingerprint
	local md5 = require "md5"
	tts_addons['@vanilla@'] = nil
	actor.randventurer_addons = {game.__mod_info.version_string}
	for a, _ in pairs(tts_addons) do
		local addon = game.__mod_info and game.__mod_info.addons and game.__mod_info.addons[a]
		if addon then
			table.insert(actor.randventurer_addons, a.."-"..(addon.addon_version_txt or addon.version_txt or "???"))
		else -- Shouldnt happen but heh
			table.insert(actor.randventurer_addons, a)
		end
	end
	-- Sort addons so that the fingerprint has meaning ;)
	table.sort(actor.randventurer_addons)
	local addons_md5 = mime.b64(md5.sum(table.concat(actor.randventurer_addons,'|')))
	actor.randventurer_fingerprint = addons_md5

	-- Make the seed, or use the given one
	local seed = rng.range(1, 99999999)
	if self.mode == "seed" and self.use_seed then
		local error = function() game:onTickEnd(function() require("engine.ui.Dialog"):simplePopup(_t"Wanderer Seed", _t"The wanderer seed you used was generated for a different set of DLC/addons. Your character will still work fine but you may not have the same talent set as the person that shared the seed with you.") end) end
		local _, _, iseed, check = self.use_seed:find("^([0-9]+)%-(.*)$")
		if not check or not tonumber(iseed) then
			error()
		else
			seed = tonumber(iseed)
			if check ~= addons_md5 then error() end
		end
	end
	rng.seed(seed)
	table.sort(actor.randventurer_class_trees)
	table.sort(actor.randventurer_generic_trees)
	table.shuffle(actor.randventurer_class_trees)
	table.shuffle(actor.randventurer_generic_trees)

	actor.randventurer_seed = seed.."-"..addons_md5

	rng.seed(os.time())

	-- Give the starting trees
	actor:randventurerLearn("class", true)
	actor:randventurerLearn("class", true)
	actor:randventurerLearn("class", true)
	actor:randventurerLearn("generic", true)

	self.finish()

	return retval
end

return _M
