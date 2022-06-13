/obj/item/mecha_parts/mecha_equipment/weapon
	name = "mecha weapon"
	range = MECHA_RANGED
	destroy_sound = 'sound/mecha/weapdestr.ogg'
	var/projectile
	var/fire_sound
	var/projectiles_per_shot = 1
	var/variance = 0
	var/randomspread = 0 //use random spread for machineguns, instead of shotgun scatter
	var/projectile_delay = 0
	var/firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect	//the visual effect appearing when the weapon is fired.
	var/kickback = TRUE //Will using this weapon in no grav push mecha back.

/obj/item/mecha_parts/mecha_equipment/weapon/can_attach(obj/mecha/M)
	if(!..())
		return FALSE
	if(istype(M, /obj/mecha/combat))
		return TRUE
	if((locate(/obj/item/mecha_parts/concealed_weapon_bay) in M.contents) && !(locate(/obj/item/mecha_parts/mecha_equipment/weapon) in M.equipment))
		return TRUE
	return FALSE

/obj/item/mecha_parts/mecha_equipment/weapon/proc/get_shot_amount()
	return projectiles_per_shot

/obj/item/mecha_parts/mecha_equipment/weapon/action(atom/target, params)
	if(!action_checks(target))
		return 0

	var/turf/curloc = get_turf(chassis)
	var/turf/targloc = get_turf(target)
	if (!targloc || !istype(targloc) || !curloc)
		return 0
	if (targloc == curloc)
		return 0

	set_ready_state(0)
	for(var/i=1 to get_shot_amount())
		var/obj/item/projectile/A = new projectile(curloc)
		A.firer = chassis.occupant
		A.original = target
		if(!A.suppressed && firing_effect_type)
			new firing_effect_type(get_turf(src), chassis.dir)

		var/spread = 0
		if(variance)
			if(randomspread)
				spread = round((rand() - 0.5) * variance)
			else
				spread = round((i / projectiles_per_shot - 0.5) * variance)
		A.preparePixelProjectile(target, chassis.occupant, params, spread)

		A.fire()
		playsound(chassis, fire_sound, 50, 1)

		sleep(max(0, projectile_delay))

	if(kickback)
		chassis.newtonian_move(turn(chassis.dir,180))
	chassis.log_message("Fired from [src.name], targeting [target].", LOG_MECHA)
	return 1


//Base energy weapon type
/obj/item/mecha_parts/mecha_equipment/weapon/energy
	name = "general energy weapon"
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/energy

/obj/item/mecha_parts/mecha_equipment/weapon/energy/get_shot_amount()
	return min(round(chassis.cell.charge / energy_drain), projectiles_per_shot)

/obj/item/mecha_parts/mecha_equipment/weapon/energy/start_cooldown()
	set_ready_state(0)
	chassis.use_power(energy_drain*get_shot_amount())
	addtimer(CALLBACK(src, .proc/set_ready_state, 1), equip_cooldown)

/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser
	equip_cooldown = 8
	name = "\improper CH-PS \"Immolator\" laser cannon"
	desc = "A weapon for combat exosuits. Shoots basic lasers."
	icon_state = "mecha_laser"
	energy_drain = 30
	projectile = /obj/item/projectile/beam/laser
	fire_sound = 'sound/weapons/laser.ogg'
	harmful = TRUE

/obj/item/mecha_parts/mecha_equipment/weapon/energy/disabler
	equip_cooldown = 3
	name = "\improper CH-DS \"Peacemaker\" disabler"
	desc = "A weapon for combat exosuits. Shoots basic disablers."
	icon_state = "mecha_disabler"
	energy_drain = 30
	projectile = /obj/item/projectile/beam/disabler
	fire_sound = 'sound/weapons/taser2.ogg'

/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/heavy
	equip_cooldown = 15
	name = "\improper CH-LC \"Solaris\" heavy laser cannon"
	desc = "A weapon for combat exosuits. Shoots heavy lasers."
	icon_state = "mecha_laser2"
	energy_drain = 60
	projectile = /obj/item/projectile/beam/laser/heavylaser
	fire_sound = 'sound/weapons/lasercannonfire.ogg'

/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/xray
	equip_cooldown = 10
	name = "\improper CH-XC \"Transitum\" x-ray laser"
	desc = "A weapon for combat exosuits. Shoots concentrated X-ray blasts."
	icon_state = "mecha_xray"
	energy_drain = 60
	projectile = /obj/item/projectile/beam/xray
	fire_sound = 'sound/weapons/laser3.ogg'

/obj/item/mecha_parts/mecha_equipment/weapon/energy/ion
	equip_cooldown = 20
	name = "\improper MKIV ion heavy cannon"
	desc = "A weapon for combat exosuits. Shoots technology-disabling ion beams. Don't catch yourself in the blast!"
	icon_state = "mecha_ion"
	energy_drain = 120
	projectile = /obj/item/projectile/ion
	fire_sound = 'sound/weapons/laser.ogg'

/obj/item/mecha_parts/mecha_equipment/weapon/energy/tesla
	equip_cooldown = 35
	name = "\improper MKI Tesla Cannon"
	desc = "A weapon for combat exosuits. Fires bolts of electricity similar to the experimental tesla engine."
	icon_state = "mecha_ion"
	energy_drain = 500
	projectile = /obj/item/projectile/energy/tesla/cannon
	fire_sound = 'sound/magic/lightningbolt.ogg'
	harmful = TRUE

/obj/item/mecha_parts/mecha_equipment/weapon/energy/pulse
	equip_cooldown = 30
	name = "eZ-13 MK2 heavy pulse rifle"
	desc = "A weapon for combat exosuits. Shoots powerful destructive blasts capable of demolishing obstacles."
	icon_state = "mecha_pulse"
	energy_drain = 120
	projectile = /obj/item/projectile/beam/pulse/heavy
	fire_sound = 'sound/weapons/marauder.ogg'
	harmful = TRUE

/obj/item/mecha_parts/mecha_equipment/weapon/energy/plasma
	equip_cooldown = 10
	name = "217-D Heavy Plasma Cutter"
	desc = "A device that shoots resonant plasma bursts at extreme velocity. The blasts are capable of crushing rock and demolishing solid obstacles."
	icon_state = "mecha_plasmacutter"
	item_state = "plasmacutter"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	energy_drain = 30
	projectile = /obj/item/projectile/plasma/adv/mech
	fire_sound = 'sound/weapons/plasma_cutter.ogg'
	harmful = TRUE

/obj/item/mecha_parts/mecha_equipment/weapon/energy/plasma/can_attach(obj/mecha/working/M)
	if(..()) //combat mech
		return 1
	else if(M.equipment.len < M.max_equip && istype(M))
		return 1
	return 0

/obj/item/mecha_parts/mecha_equipment/weapon/energy/taser
	name = "\improper PBT \"Pacifier\" mounted taser"
	desc = "A weapon for combat exosuits. Shoots non-lethal stunning electrodes."
	icon_state = "mecha_taser"
	energy_drain = 20
	equip_cooldown = 8
	projectile = /obj/item/projectile/energy/electrode
	fire_sound = 'sound/weapons/taser.ogg'


/obj/item/mecha_parts/mecha_equipment/weapon/honker
	name = "\improper HoNkER BlAsT 5000"
	desc = "Equipment for clown exosuits. Spreads fun and joy to everyone around. Honk!"
	icon_state = "mecha_honker"
	energy_drain = 200
	equip_cooldown = 150
	range = MECHA_MELEE|MECHA_RANGED
	kickback = FALSE

/obj/item/mecha_parts/mecha_equipment/weapon/honker/can_attach(obj/mecha/combat/honker/M)
	if(..())
		if(istype(M))
			return 1
	return 0

/obj/item/mecha_parts/mecha_equipment/weapon/honker/action(target, params)
	if(!action_checks(target))
		return
	playsound(chassis, 'sound/items/airhorn.ogg', 100, 1)
	chassis.occupant_message("<font color='red' size='5'>HONK</font>")
	for(var/mob/living/carbon/M in ohearers(6, chassis))
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(istype(H.ears, /obj/item/clothing/ears/earmuffs))
				continue
		var/turf/turf_check = get_turf(M)
		if(isspaceturf(turf_check) && !turf_check.Adjacent(src)) //in space nobody can hear you honk.
			continue
		to_chat(M, "<font color='red' size='7'>HONK</font>")
		M.SetSleeping(0)
		M.stuttering += 20
		M.adjustEarDamage(0, 30)
		M.Paralyze(60)
		if(prob(30))
			M.Stun(200)
			M.Unconscious(80)
		else
			M.Jitter(500)

	log_message("Honked from [src.name]. HONK!", LOG_MECHA)
	var/turf/T = get_turf(src)
	message_admins("[ADMIN_LOOKUPFLW(chassis.occupant)] used a Mecha Honker in [ADMIN_VERBOSEJMP(T)]")
	log_game("[key_name(chassis.occupant)] used a Mecha Honker in [AREACOORD(T)]")
	return 1


//Base ballistic weapon type
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic
	name = "general ballistic weapon"
	fire_sound = 'sound/weapons/gunshot.ogg'
	var/projectiles
	var/projectiles_cache //ammo to be loaded in, if possible.
	var/projectiles_cache_max
	var/projectile_energy_cost
	var/disabledreload //For weapons with no cache (like the rockets) which are reloaded by hand
	var/ammo_type

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/get_shot_amount()
	return min(projectiles, projectiles_per_shot)

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/action_checks(target)
	if(!..())
		return 0
	if(projectiles <= 0)
		return 0
	return 1

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/get_equip_info()
	return "[..()] \[[src.projectiles][projectiles_cache_max &&!projectile_energy_cost?"/[projectiles_cache]":""]\][!disabledreload &&(src.projectiles < initial(src.projectiles))?" - <a href='?src=[REF(src)];rearm=1'>Rearm</a>":null]"


/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/rearm()
	if(projectiles < initial(projectiles))
		var/projectiles_to_add = initial(projectiles) - projectiles
		if(projectile_energy_cost)
			while(chassis.get_charge() >= projectile_energy_cost && projectiles_to_add)
				projectiles++
				projectiles_to_add--
				chassis.use_power(projectile_energy_cost)

		else
			if(!projectiles_cache)
				return FALSE
			if(projectiles_to_add <= projectiles_cache)
				projectiles = projectiles + projectiles_to_add
				projectiles_cache = projectiles_cache - projectiles_to_add
			else
				projectiles = projectiles + projectiles_cache
				projectiles_cache = 0

		send_byjax(chassis.occupant,"exosuit.browser","[REF(src)]",src.get_equip_info())
		log_message("Rearmed [src.name].", LOG_MECHA)
		return TRUE


/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/needs_rearm()
	. = !(projectiles > 0)



/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/Topic(href, href_list)
	..()
	if (href_list["rearm"])
		src.rearm()
	return

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/action(atom/target)
	if(..())
		projectiles -= get_shot_amount()
		send_byjax(chassis.occupant,"exosuit.browser","[REF(src)]",src.get_equip_info())
		return 1


/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/carbine
	name = "\improper FD-11 \"Bush Boss\" Thermal Defoliant"
	desc = "A weapon for combat exosuits. Fires incendiary canisters."
	icon_state = "mecha_carbine"
	equip_cooldown = 10
	projectile = /obj/item/projectile/bullet/incendiary/fnx99
	fire_sound = 'sound/weapons/flamethrower.ogg'
	projectiles = 20
	projectiles_cache = 0
	projectiles_cache_max = 60
	harmful = TRUE
	ammo_type = "incendiary"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/silenced
	name = "\improper S.H.H. \"Quietus\" Carbine"
	desc = "A weapon for combat exosuits. A mime invention, field tests have shown that targets cannot even scream before going down."
	icon_state = "mecha_mime"
	equip_cooldown = 30
	projectile = /obj/item/projectile/bullet/mime
	fire_sound = 'sound/weapons/gunshot_silenced.ogg'
	projectiles = 16
	projectiles_cache = 0
	projectiles_cache_max = 52
	harmful = TRUE
	ammo_type = "lmg"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot
	name = "\improper LBX AC 10 \"Scattershot\""
	desc = "A weapon for combat exosuits. Shoots a spread of pellets."
	icon_state = "mecha_scatter"
	equip_cooldown = 20
	projectile = /obj/item/projectile/bullet/scattershot
	fire_sound = 'sound/weapons/scattershot.ogg'
	projectiles = 25
	projectiles_cache = 0
	projectiles_cache_max = 75
	projectiles_per_shot = 5
	variance = 25
	harmful = TRUE
	ammo_type = "scattershot"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg
	name = "\improper Ultra AC 2"
	desc = "A weapon for combat exosuits. Shoots a rapid, five shot burst."
	icon_state = "mecha_uac2"
	equip_cooldown = 10
	projectile = /obj/item/projectile/bullet/lmg
	fire_sound = 'sound/weapons/rifleshot.ogg'
	projectiles = 50
	projectiles_cache = 0
	projectiles_cache_max = 150
	projectiles_per_shot = 5
	variance = 10
	randomspread = 1
	projectile_delay = 2
	harmful = TRUE
	ammo_type = "lmg"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/chaingun
	name = "\improper LCG-4-NL \"Jaruz\" Riot Chaingun"
	desc = "A weapon for combat exosuits. Shoots a barrage of non-lethal rubber pellets."
	icon_state = "mecha_chaingun"
	equip_cooldown = 5
	projectile = /obj/item/projectile/bullet/pellet/shotgun_rubbershot
	fire_sound = "sound/weapons/chaingun.ogg"
	projectiles = 100
	projectiles_cache = 0
	projectiles_cache_max = 300
	projectiles_per_shot = 5
	variance = 5
	randomspread = 1
	projectile_delay = 1
	harmful = TRUE
	ammo_type = "nl"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack
	name = "\improper HEML-3 missile rack"
	desc = "A weapon for combat exosuits. Launches light explosive missiles."
	icon_state = "mecha_missilerack"
	projectile = /obj/item/projectile/bullet/a84mm_he
	fire_sound = 'sound/weapons/rocketlaunch.ogg'
	projectiles = 3
	projectiles_cache = 0
	projectiles_cache_max = 0
	disabledreload = TRUE
	equip_cooldown = 120
	harmful = TRUE
	ammo_type = "missiles_he"


/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher
	var/missile_speed = 2
	var/missile_range = 30
	var/diags_first = FALSE

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/action(target)
	if(!action_checks(target))
		return
	var/obj/O = new projectile(chassis.loc)
	playsound(chassis, fire_sound, 50, 1)
	log_message("Launched a [O.name] from [name], targeting [target].", LOG_MECHA)
	projectiles--
	proj_init(O)
	O.throw_at(target, missile_range, missile_speed, chassis.occupant, FALSE, diagonals_first = diags_first)
	return 1

//used for projectile initilisation (priming flashbang) and additional logging
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/proc/proj_init(var/obj/O)
	return


/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/flashbang
	name = "\improper SGL-6 grenade launcher"
	desc = "A weapon for combat exosuits. Launches primed flashbangs."
	icon_state = "mecha_grenadelnchr"
	projectile = /obj/item/grenade/flashbang
	fire_sound = 'sound/weapons/grenadelaunch.ogg'
	projectiles = 6
	missile_speed = 1.5
	projectiles_cache = 0
	projectiles_cache_max = 18
	equip_cooldown = 60
	var/det_time = 20
	ammo_type = "flashbang"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/flashbang/proj_init(var/obj/item/grenade/flashbang/F)
	var/turf/T = get_turf(src)
	message_admins("[ADMIN_LOOKUPFLW(chassis.occupant)] fired a [src] in [ADMIN_VERBOSEJMP(T)]")
	log_game("[key_name(chassis.occupant)] fired a [src] in [AREACOORD(T)]")
	addtimer(CALLBACK(F, /obj/item/grenade/flashbang.proc/prime), det_time)

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/flashbang/clusterbang //Because I am a heartless bastard -Sieve //Heartless? for making the poor man's honkblast? - Kaze
	name = "\improper SOB-3 grenade launcher"
	desc = "A weapon for combat exosuits. Launches primed clusterbangs. You monster."
	icon_state = "mecha_cluster"
	projectiles = 3
	projectile = /obj/item/grenade/clusterbuster
	projectiles_cache = 0
	projectiles_cache_max = 0
	disabledreload = TRUE
	equip_cooldown = 90
	ammo_type = "clusterbang"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/railgun
	name = "\improper GER-X1 Railgun"
	desc = "A weapon for combat exosuits. Launches hypervelocity projectiles that penetrate everything in their path including your mom."
	icon_state = "mecha_railgun"
	fire_sound = 'sound/weapons/railgun.ogg'
	projectiles = 1
	projectile = /obj/item/projectile/bullet/p50/penetrator/railgun
	projectiles_cache = 0
	projectiles_cache_max = 10
	//projectile_energy_cost = 250
	equip_cooldown = 180
	ammo_type = "railgun"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/BBchaingun
	name = "\improper LCG-4-BB \"Ratat\" BB Chaingun"
	desc = "Toy chaingun for exosuits. This is so much fun!"
	icon_state = "mecha_toychaingun"
	equip_cooldown = 5
	projectile = /obj/item/projectile/bullet/reusable/foam_dart
	fire_sound = "sound/weapons/chaingun.ogg"
	projectiles = 100
	projectiles_cache = 0
	projectiles_cache_max = 500
	projectiles_per_shot = 5
	variance = 5
	randomspread = 1
	projectile_delay = 1
	harmful = FALSE
	ammo_type = "BB"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/BBchaingun/can_attach(obj/mecha/combat/M)
	if(..())
		if(istype(M))
			return 1
	return 0

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/banana_mortar
	name = "banana mortar"
	desc = "Equipment for clown exosuits. Launches banana peels."
	icon_state = "mecha_bananamrtr"
	projectile = /obj/item/grown/bananapeel
	fire_sound = 'sound/items/bikehorn.ogg'
	projectiles = 15
	missile_speed = 1.5
	projectile_energy_cost = 100
	equip_cooldown = 20

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/banana_mortar/can_attach(obj/mecha/combat/honker/M)
	if(..())
		if(istype(M))
			return 1
	return 0

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/mousetrap_mortar
	name = "mousetrap mortar"
	desc = "Equipment for clown exosuits. Launches armed mousetraps."
	icon_state = "mecha_mousetrapmrtr"
	projectile = /obj/item/assembly/mousetrap/armed
	fire_sound = 'sound/items/bikehorn.ogg'
	projectiles = 15
	missile_speed = 1.5
	projectile_energy_cost = 100
	equip_cooldown = 10

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/mousetrap_mortar/can_attach(obj/mecha/combat/honker/M)
	if(..())
		if(istype(M))
			return 1
	return 0

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/mousetrap_mortar/proj_init(var/obj/item/assembly/mousetrap/armed/M)
	M.secured = 1


//Classic extending punching glove, but weaponised!
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/punching_glove
	name = "\improper Oingo Boingo Punch-face"
	desc = "Equipment for clown exosuits. Delivers fun right to your face!"
	icon_state = "mecha_punching_glove"
	energy_drain = 250
	equip_cooldown = 20
	range = MECHA_MELEE|MECHA_RANGED
	missile_range = 5
	projectile = /obj/item/punching_glove
	fire_sound = 'sound/items/bikehorn.ogg'
	projectiles = 10
	projectile_energy_cost = 500
	diags_first = TRUE

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/punching_glove/can_attach(obj/mecha/combat/honker/M)
	if(..())
		if(istype(M))
			return 1
	return 0

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/punching_glove/action(target)
	. = ..()
	if(.)
		chassis.occupant_message("<font color='red' size='5'>HONK</font>")

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/punching_glove/proj_init(obj/item/punching_glove/PG)
	if(!istype(PG))
		return
	 //has to be low sleep or it looks weird, the beam doesn't exist for very long so it's a non-issue
	chassis.Beam(PG, icon_state = "chain", time = missile_range * 20, maxdistance = missile_range + 2, beam_sleep_time = 1)

/obj/item/punching_glove
	name = "punching glove"
	desc = "INCOMING HONKS"
	throwforce = 35
	icon_state = "punching_glove"

/obj/item/punching_glove/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!..())
		if(ismovableatom(hit_atom))
			var/atom/movable/AM = hit_atom
			AM.safe_throw_at(get_edge_target_turf(AM,get_dir(src, AM)), 7, 2)
		qdel(src)