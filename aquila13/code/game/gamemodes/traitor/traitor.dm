/datum/game_mode
	var/traitor_name = "traitor"
	var/list/datum/mind/traitors = list()

	var/datum/mind/exchange_red
	var/datum/mind/exchange_blue

/datum/game_mode/traitor
	name = "traitor"
	config_tag = "traitor"
	report_type = "traitor"
	antag_flag = ROLE_TRAITOR
	false_report_weight = 20 //Reports of traitors are pretty common.
	restricted_jobs = list("Cyborg")//They are part of the AI if he is traitor so are they, they use to get double chances
	protected_jobs = list("Security Officer", "Warden", "Detective", "Head of Security", "Captain", "Brig Physician", "Prisoner")
	allowed_special = list(/datum/special_role/undercover)
	required_players = 0
	required_enemies = 1
	recommended_enemies = 4
	reroll_friendly = 1
	enemy_minimum_age = 0

	announce_span = "danger"
	announce_text = "There are Syndicate agents on the station!\n\
	<span class='danger'>Traitors</span>: Accomplish your objectives.\n\
	<span class='notice'>Crew</span>: Do not let the traitors succeed!"

	title_icon = "traitor"

	var/list/datum/mind/pre_traitors = list()
	var/traitors_possible = 4 //hard limit on traitors if scaling is turned off
	var/num_modifier = 0 // Used for gamemodes, that are a child of traitor, that need more than the usual.
	var/antag_datum = /datum/antagonist/traitor //what type of antag to create
	var/traitors_required = TRUE //Will allow no traitors


/datum/game_mode/traitor/pre_setup()

	if(CONFIG_GET(flag/protect_roles_from_antagonist))
		restricted_jobs += protected_jobs

	if(CONFIG_GET(flag/protect_assistant_from_antagonist))
		restricted_jobs += "Assistant"

	if(CONFIG_GET(flag/protect_heads_from_antagonist))
		restricted_jobs += GLOB.command_positions
	if(num_players() < 10)
		restricted_jobs += "AI"

	var/num_traitors = 1

	var/tsc = CONFIG_GET(number/traitor_scaling_coeff)
	if(tsc)
		num_traitors = max(1, min(round(num_players() / (tsc * 2)) + 2 + num_modifier, round(num_players() / tsc) + num_modifier))
	else
		num_traitors = max(1, min(num_players(), traitors_possible))

	for(var/j = 0, j < num_traitors, j++)
		if (!antag_candidates.len)
			break
		var/datum/mind/traitor = antag_pick(antag_candidates, ROLE_TRAITOR)
		pre_traitors += traitor
		traitor.special_role = traitor_name
		traitor.restricted_roles = restricted_jobs
		log_game("[key_name(traitor)] has been selected as a [traitor_name]")
		antag_candidates.Remove(traitor)

	var/enough_tators = !traitors_required || pre_traitors.len > 0

	if(!enough_tators)
		setup_error = "Not enough traitor candidates"
		return FALSE
	else
		return TRUE


/datum/game_mode/traitor/post_setup()
	for(var/datum/mind/traitor in pre_traitors)
		var/datum/antagonist/traitor/new_antag = new antag_datum()
		addtimer(CALLBACK(traitor, /datum/mind.proc/add_antag_datum, new_antag), rand(10,100))
	if(!exchange_blue)
		exchange_blue = -1 //Block latejoiners from getting exchange objectives
	..()

	//We're not actually ready until all traitors are assigned.
	gamemode_ready = FALSE
	addtimer(VARSET_CALLBACK(src, gamemode_ready, TRUE), 101)
	return TRUE

/datum/game_mode/traitor/make_antag_chance(mob/living/carbon/human/character) //Assigns traitor to latejoiners
	var/tsc = CONFIG_GET(number/traitor_scaling_coeff)
	var/traitorcap = min(round(GLOB.joined_player_list.len / (tsc * 2)) + 2 + num_modifier, round(GLOB.joined_player_list.len / tsc) + num_modifier)
	if((SSticker.mode.traitors.len + pre_traitors.len) >= traitorcap) //Upper cap for number of latejoin antagonists
		return
	if((SSticker.mode.traitors.len + pre_traitors.len) <= (traitorcap - 2) || prob(100 / (tsc * 2)))
		if(antag_flag in character.client.prefs.be_special)
			if(!is_banned_from(character.ckey, list(ROLE_TRAITOR, ROLE_SYNDICATE)) && !QDELETED(character))
				if(age_check(character.client))
					if(!(character.job in restricted_jobs))
						add_latejoin_traitor(character.mind)

/datum/game_mode/traitor/proc/add_latejoin_traitor(datum/mind/character)
	var/datum/antagonist/traitor/new_antag = new antag_datum()
	character.add_antag_datum(new_antag)

/datum/game_mode/traitor/generate_report()
	return "Przechwycona komunikacja pomi??dzy stacjami Syndykatu wykaza??a, ??e na waszej stacji istnieje mo??liwo???? ukrytych kom??rek ??pi??cych agent??w. Posiadaj?? oni wszczepion?? pami????, kt??ra mo??e zosta?? uruchomiona w ka??dej chwili, mo??liwe, ??e sami agenci jeszcze nie wiedz??, ??e s?? agentami. Zachowajcie czujno????."

/datum/game_mode/traitor/generate_credit_text()
	var/list/round_credits = list()
	var/len_before_addition

	round_credits += "<center><h1>Agenci Syndykatu [syndicate_name()]:</h1>"
	len_before_addition = round_credits.len
	for(var/datum/mind/traitor in traitors)
		round_credits += "<center><h2>[traitor.name] jako zdrajca [syndicate_name()]</h2>"
	if(len_before_addition == round_credits.len)
		round_credits += list("<center><h2>Zdrajcy ukryli swoj?? zdradliwo????!</h2>", "<center><h2>Nie mogli??my ich zlokalizowa??!</h2>")
	round_credits += "<br>"

	round_credits += ..()
	return round_credits
