/datum/round_event_control/carp_migration
	name = "Carp Migration"
	typepath = /datum/round_event/carp_migration
	weight = 10
	min_players = 10
	earliest_start = 30 MINUTES
	max_occurrences = 6

/datum/round_event/carp_migration
	announceWhen	= 3
	startWhen = 50
	var/hasAnnounced = FALSE

/datum/round_event/carp_migration/setup()
	startWhen = rand(40, 60)

/datum/round_event/carp_migration/announce(fake)
	priority_announce("Wykryto nieznane formy życia w okolicy [station_name()], zaleca się ostrożność.", "Ostrzeżenie biologiczne")


/datum/round_event/carp_migration/start()
	var/mob/living/simple_animal/hostile/carp/fish
	for(var/obj/effect/landmark/carpspawn/C in GLOB.landmarks_list)
		if(prob(95))
			fish = new (C.loc)
		else
			fish = new /mob/living/simple_animal/hostile/carp/megacarp(C.loc)
			fishannounce(fish) //Prefer to announce the megacarps over the regular fishies
	fishannounce(fish)

/datum/round_event/carp_migration/proc/fishannounce(atom/fish)	
	if (!hasAnnounced)
		announce_to_ghosts(fish) //Only anounce the first fish
		hasAnnounced = TRUE