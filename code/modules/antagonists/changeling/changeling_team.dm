/datum/team/changeling
	name = "Thingling"
	member_name = "thinglings"

/datum/antagonist/changeling/create_team(datum/team/changeling/new_team)
	if(!new_team)
		//For now only one revolution at a time
		for(var/datum/antagonist/changeling/lings in GLOB.antagonists)
			if(!lings.owner)
				continue
			if(lings.changeling_team)
				changeling_team = lings.changeling_team
				return
		changeling_team = new /datum/team/changeling
		var/datum/objective/total_assimilation/assimilate = new
		assimilate.team = changeling_team
		changeling_team.objectives += assimilate
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	changeling_team = new_team

/datum/antagonist/changeling/get_team()
	return changeling_team

/datum/antagonist/changeling/proc/create_objectives()
	objectives |= changeling_team.objectives

/datum/antagonist/changeling/proc/remove_objectives()
	objectives -= changeling_team.objectives

///team objective

/datum/objective/total_assimilation
	name = "total assimilation"
	explanation_text = "Assimilate all station crewmembers. Third parties may be ignored, but new recruits always helps."
	team_explanation_text = "Assimilate all station crewmembers. Third parties may be ignored, but new recruits always helps."

/datum/objective/total_assimilation/check_completion()
	var/humans = 0
	var/thinglings = 0
	for(var/mob/living/carbon/human/assimilated in GLOB.player_list)
		if(!assimilated.client)
			continue
		if(assimilated.stat == DEAD)
			continue
		// if(!(assimilated.mind.assigned_role.job_flags & JOB_CREW_MEMBER))
		// 	continue
		if(!assimilated.mind.has_antag_datum(/datum/antagonist/changeling))
			humans++

		thinglings++
	return (humans < thinglings)

/datum/objective/break_quarentine
	name = "Escape"
	explanation_text = "One of us must escape off world to continue to spread our family."
	team_explanation_text = "One of us must escape off world to continue to spread our family. Get one of us on a shuttle to escape this frozen prison."


/datum/objective/break_quarentine/check_completion()
	for(var/mob/living/carbon/human/assimilated in GLOB.player_list)
		if(assimilated.mind)
			continue
		if(assimilated.mind.has_antag_datum(/datum/antagonist/changeling))
			var/area/escape = get_area(assimilated)
			if(escape.valid_escape)
				return TRUE

	return FALSE

/datum/team/revolution/roundend_report()
	if(!members.len)
		return

	var/report

	for(var/datum/objective/assimilate as anything in objectives)
		if(assimilate.check_completion())
			report = "<span class='greentext big'>The thinglings assimimilated a majority of the survivors...</span>"
		else
			report = "<span class='redtext big'>The thinglings have failed!</span>"

	return report
