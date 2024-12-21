/obj/item/multitool/holotool
	name = "GEC Holotool"
	desc = "An overengineered POS."
	icon_state = "wrench_combat"
	item_state = "wrench_combat"
	var/set_tool = null
	tool_behaviour = null
	slot_flags = ITEM_SLOT_BELT
	actions_types = list(/datum/action/item_action/toggle_holotool)
	//var/cell_override = /obj/item/stock_parts/cell/high

/obj/item/multitool/holotool/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/datum/action/item_action/toggle_holotool
	name = "Set Tool"

/datum/action/item_action/toggle_holotool/Trigger()
	if(istype(target,/obj/item/multitool/holotool))
		var/obj/item/multitool/holotool/tool_to_trigger = target
		tool_to_trigger

/obj/item/multitool/holotool/proc/handle_radial()
	var/list/tool_list = list(
		"Crowbar" = image(icon = 'icons/obj/tools.dmi', icon_state = "crowbar"),
		"Multitool" = image(icon = 'icons/obj/device.dmi', icon_state = "multitool"),
		"Screwdriver" = image(icon = 'icons/obj/tools.dmi', icon_state = "screwdriver_map"),
		"Wirecutters" = image(icon = 'icons/obj/tools.dmi', icon_state = "cutters_map"),
		"Wrench" = image(icon = 'icons/obj/tools.dmi', icon_state = "wrench"),
		"Welding Tool" = image(icon = 'icons/obj/tools.dmi', icon_state = "miniwelder"),
		"Analyzer" = image(icon = 'icons/obj/device.dmi', icon_state = "analyzer"),
		"T-Ray Scanner" = image(icon = 'icons/obj/device.dmi', icon_state = "T-ray1")
		)
	tool_result = show_radial_menu(user, src, tool_list, custom_check = CALLBACK(src, PROC_REF(check_menu), user), require_near = TRUE, tooltips = TRUE)
	if(!check_menu(user))
		return

/obj/item/multitool/holotool/attack_self(mob/user)
	. = ..()
	if(on)
		on = FALSE
		force = initial(force)
		w_class = initial(w_class)
		throwforce = initial(throwforce)
		tool_behaviour = initial(tool_behaviour)
		attack_verb = list("bopped")
		toolspeed = initial(toolspeed)
		playsound(user, 'sound/weapons/saberoff.ogg', 5, TRUE)
		to_chat(user, "<span class='warning'>[src] can now be concealed.</span>")
	else
		on = TRUE
		force = 15
		w_class = WEIGHT_CLASS_NORMAL
		throwforce = 10

		toolspeed = 0.5
		hitsound = 'sound/weapons/blade1.ogg'
		playsound(user, 'sound/weapons/saberon.ogg', 5, TRUE)
		to_chat(user, "<span class='warning'>[src] is now active. Woe onto your enemies!</span>")
	update_appearance()

/obj/item/multitool/holotool/proc/handle_tool_behavior(mob/user)
	switch(tool_result)
		if("Crowbar")
			tool_behaviour = TOOL_CROWBAR
		if("Multitool")
			tool_behaviour = TOOL_MULTITOOL
		if("Screwdriver")
			tool_behaviour = TOOL_SCREWDRIVER
		if("Wirecutters")
			tool_behaviour = TOOL_WIRECUTTER
		if("Wrench")
			tool_behaviour = TOOL_WRENCH
		if("Welding Tool")
			tool_behaviour = TOOL_WELDER
		if("Analyzer")
			tool_behaviour = TOOL_ANALYZER

