/obj/item/attachment/gun/ballistic/custom_pistol
	name = "underbarrel pistol clip"
	desc = "A pistol clip for attaching pistols to underside of other guns."
	weapon_type = null
	//var/weapon_attached = FALSE

/obj/item/attachment/gun/ballistic/custom_pistol/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/gun/ballistic/automatic/pistol) && !attached_gun)
		attached_gun = I
		user.transferItemToLoc(attached_gun,src)

/obj/item/attachment/gun/ballistic/custom_pistol/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(attached_gun)
		attached_gun.forceMove(drop_location())
		attached_gun = null



