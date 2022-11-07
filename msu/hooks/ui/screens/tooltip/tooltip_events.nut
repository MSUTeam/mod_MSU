::mods_hookNewObjectOnce("ui/screens/tooltip/tooltip_events", function(o) {
	local tactical_queryTileTooltipData = o.tactical_queryTileTooltipData;
	o.tactical_queryTileTooltipData = function()
	{
		local ret = tactical_queryTileTooltipData();
		if (ret != null && ::Tactical.TurnSequenceBar.getActiveEntity() != null && ::Tactical.TurnSequenceBar.getActiveEntity().isPlayerControlled())
		{
			::Tactical.TurnSequenceBar.getActiveEntity().getSkills().onQueryTileTooltip(::Tactical.State.getLastTileHovered(), ret);
		}
		return ret;
	}

	local general_querySkillTooltipData = o.general_querySkillTooltipData;
	o.general_querySkillTooltipData = function( _entityId, _skillId )
	{
		local entity = ::Tactical.getEntityByID(_entityId);

		if (entity != null)
		{
			local skill = entity.getSkills().getSkillByID(_skillId);

			if (skill != null)
			{
				local tooltip = skill.getTooltip();
				skill.getContainer().onQueryTooltip(skill, tooltip);
				return tooltip;
			}
		}

		return null;
	}

	local general_queryStatusEffectTooltipData = o.general_queryStatusEffectTooltipData;
	o.general_queryStatusEffectTooltipData = function( _entityId, _statusEffectId )
	{
		local entity = ::Tactical.getEntityByID(_entityId);

		if (entity != null)
		{
			local statusEffect = entity.getSkills().getSkillByID(_statusEffectId);

			if (statusEffect != null)
			{
				local tooltip = statusEffect.getTooltip();
				statusEffect.getContainer().onQueryTooltip(statusEffect, tooltip);
				return tooltip;
			}
		}

		return null;
	}

	o.onQueryMSUTooltipData <- function( _data )
	{
		return ::MSU.System.Tooltips.getTooltip(_data.modId, _data.elementId).getUIData(_data);
	}

	local general_queryUIElementTooltipData = o.general_queryUIElementTooltipData;
	// deprecated, MSU settings (and future tooltips) should now use onQueryMSUTooltipData
	o.general_queryUIElementTooltipData = function( _entityId, _elementId, _elementOwner )
	{
		local ret = general_queryUIElementTooltipData(_entityId, _elementId, _elementOwner);

        // Paragon Level mention/overwrite
        if(_elementId == "character-screen.left-panel-header-module.Experience" || _elementId == "character-screen.left-panel-header-module.Level")
        {
            foreach(entry in ret)
            {
                if (entry.id == 2 && entry.type == "description")
                {
                    entry.text = ::MSU.String.replace(entry.text, "11th character level, characters are veterans and", "paragon level " + ::Const.XP.MaxLevelWithPerkpoints + " characters")
					break;
				}
            }
        }

		if (ret == null)
		{
			if (_elementId.find("msu-settings") == 0)
			{
				local threePartArray = split(_elementId, ".")
				local setting = ::getModSetting(threePartArray[1], threePartArray[2]);
				return [
					{
						id = 1,
						type = "title",
						text = setting.getName()
					},
					{
						id = 2,
						type = "description",
						text = setting.getDescription()
					}
				];
			}
		}
		return ret;
	}
});
