/mob/living/simple_animal/hostile/retaliate/poison
    var/poison_per_bite = 0
    var/poison_type = /datum/reagent/toxin

/mob/living/simple_animal/hostile/retaliate/poison/AttackingTarget()
    . = ..()
    if(. && isliving(target))
        var/mob/living/L = target
        if(L.reagents && !poison_per_bite == 0)
            L.reagents.add_reagent(poison_type, poison_per_bite)
        return .

/mob/living/simple_animal/hostile/retaliate/poison/snake
        name = "snake"
        desc = "A slithery snake. These legless reptiles are the bane of mice and adventurers alike."
        icon_state = "snake"
        icon_living = "snake"
        icon_dead = "snake_dead"
        speak_emote = list("hisses")
        health = 20
        maxHealth = 20
        attacktext = "bites"
        melee_damage = 6
        response_help  = "pets"
        response_disarm = "shoos"
        response_harm   = "steps on"
        faction = list("hostile")
        ventcrawler = VENTCRAWLER_ALWAYS
        density = FALSE
        pass_flags = PASSTABLE | PASSMOB
        mob_size = MOB_SIZE_SMALL
        mob_biotypes = list(MOB_ORGANIC, MOB_BEAST, MOB_REPTILE)
        gold_core_spawnable = FRIENDLY_SPAWN
        obj_damage = 0
        environment_smash = ENVIRONMENT_SMASH_NONE
        mobsay_color = "#26F55A"
        poison_per_bite = 3
        poison_type = /datum/reagent/toxin/venom

/mob/living/simple_animal/hostile/retaliate/poison/snake/Initialize()
	. = ..()
	find_candidates()
	add_cell_sample()

/mob/living/simple_animal/hostile/retaliate/poison/snake/attack_ghost(mob/dead/observer/user)
	. = ..()
	give_to_ghost(user)

/mob/living/simple_animal/hostile/retaliate/poison/snake/add_cell_sample()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_SNAKE, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

/mob/living/simple_animal/hostile/retaliate/poison/snake/ListTargets(atom/the_target)
	. = oview(vision_range, targets_from) //get list of things in vision range
	var/list/living_mobs = list()
	var/list/mice = list()
	for (var/HM in .)
		//Yum a tasty mouse
		if(istype(HM, /mob/living/simple_animal/mouse))
			mice += HM
		if(isliving(HM))
			living_mobs += HM

	// if no tasty mice to chase, lets chase any living mob enemies in our vision range
	if(length(mice) == 0)
		//Filter living mobs (in range mobs) by those we consider enemies (retaliate behaviour)
		return  living_mobs & enemies
	return mice

/mob/living/simple_animal/hostile/retaliate/poison/snake/AttackingTarget()
        if(istype(target, /mob/living/simple_animal/mouse))
                visible_message("<span class='notice'>[name] consumes [target] in a single gulp!</span>", "<span class='notice'>You consume [target] in a single gulp!</span>")
                QDEL_NULL(target)
                adjustBruteLoss(-2)
        else
                return ..()