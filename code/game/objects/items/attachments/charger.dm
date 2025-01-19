/obj/item/attachment/charger
	name = "charging cable"
	desc = "Designed to be rail-mounted on a compatible firearm to provide increased accuracy and decreased spread."
	icon_state = "laserpointer"

	attach_features_flags = ATTACH_REMOVABLE_HAND|ATTACH_TOGGLE
	pixel_shift_x = 1
	pixel_shift_y = 4
	wield_delay = 0.1 SECONDS
	var/obj/item/charger_cord/cable

/obj/item/attachment/charger/Initialize()
	. = ..()
	cable = new /obj/item/charger_cord(src)

/obj/item/attachment/charger/Destroy()
	. = ..()
	QDEL_NULL(cable)

/obj/item/attachment/charger/apply_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	cable.to_charge = gun

/obj/item/attachment/charger/remove_attachment(obj/item/gun/gun, mob/user)
	. = ..()
	cable.to_charge = null

/obj/item/charger_cord
	name = "charging cord"
	desc = "A universal power cord for charging energy weapons on the go."
	icon = 'icons/obj/power.dmi'
	icon_state = "wire1"
	var/obj/item/gun/energy/to_charge
