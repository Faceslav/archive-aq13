
// **** Security gas mask ****

/obj/item/clothing/mask/gas/sechailer
	name = "security gas mask"
	desc = "A standard issue Security gas mask with integrated 'Compli-o-nator 3000' device. Plays over a dozen pre-recorded compliance phrases designed to get scumbags to stand still whilst you tase them. Do not tamper with the device."
	actions_types = list(/datum/action/item_action/halt, /datum/action/item_action/adjust)
	icon_state = "sechailer"
	item_state = "sechailer"
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	flags_inv = HIDEFACIALHAIR|HIDEFACE
	w_class = WEIGHT_CLASS_SMALL
	visor_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	visor_flags_inv = HIDEFACE
	flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	visor_flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	var/aggressiveness = 2
	var/cooldown_special
	var/recent_uses = 0
	var/broken_hailer = 0
	var/safety = TRUE

/obj/item/clothing/mask/gas/sechailer/swat
	name = "\improper SWAT mask"
	desc = "A close-fitting tactical mask with an especially aggressive Compli-o-nator 3000."
	actions_types = list(/datum/action/item_action/halt)
	icon_state = "swat"
	item_state = "swat"
	aggressiveness = 3
	flags_inv = HIDEFACIALHAIR|HIDEFACE|HIDEEYES|HIDEEARS|HIDEHAIR
	visor_flags_inv = 0
	armor = list("melee" = 10, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 20, "acid" = 40)

/obj/item/clothing/mask/gas/sechailer/swat/spacepol
	name = "spacepol mask"
	desc = "A close-fitting tactical mask created in cooperation with a certain megacorporation, comes with an especially aggressive Compli-o-nator 3000."
	icon_state = "spacepol"
	item_state = "spacepol"

/obj/item/clothing/mask/gas/sechailer/cyborg
	name = "security hailer"
	desc = "A set of recognizable pre-recorded messages for cyborgs to use when apprehending criminals."
	icon = 'icons/obj/device.dmi'
	icon_state = "taperecorder_idle"
	aggressiveness = 1 //Borgs are nicecurity!
	actions_types = list(/datum/action/item_action/halt)

/obj/item/clothing/mask/gas/sechailer/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	switch(aggressiveness)
		if(1)
			to_chat(user, "<span class='notice'>You set the restrictor to the middle position.</span>")
			aggressiveness = 2
		if(2)
			to_chat(user, "<span class='notice'>You set the restrictor to the last position.</span>")
			aggressiveness = 3
		if(3)
			to_chat(user, "<span class='notice'>You set the restrictor to the first position.</span>")
			aggressiveness = 1
		if(4)
			to_chat(user, "<span class='danger'>You adjust the restrictor but nothing happens, probably because it's broken.</span>")
	return TRUE

/obj/item/clothing/mask/gas/sechailer/wirecutter_act(mob/living/user, obj/item/I)
	if(aggressiveness != 4)
		to_chat(user, "<span class='danger'>You broke the restrictor!</span>")
		aggressiveness = 4
	return TRUE

/obj/item/clothing/mask/gas/sechailer/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/halt))
		halt()
	else
		adjustmask(user)

/obj/item/clothing/mask/gas/sechailer/attack_self()
	halt()
/obj/item/clothing/mask/gas/sechailer/emag_act(mob/user as mob)
	if(safety)
		safety = FALSE
		to_chat(user, "<span class='warning'>You silently fry [src]'s vocal circuit with the cryptographic sequencer.</span>")
	else
		return

/obj/item/clothing/mask/gas/sechailer/verb/halt()
	set category = "Object"
	set name = "HALT"
	set src in usr
	if(!isliving(usr))
		return
	if(!can_use(usr))
		return
	if(broken_hailer)
		to_chat(usr, "<span class='warning'>\The [src]'s hailing system is broken.</span>")
		return

	var/phrase = 0	//selects which phrase to use
	var/phrase_text = null
	var/phrase_sound = null


	if(cooldown < world.time - 30) // A cooldown, to stop people being jerks
		recent_uses++
		if(cooldown_special < world.time - 180) //A better cooldown that burns jerks
			recent_uses = initial(recent_uses)

		switch(recent_uses)
			if(3)
				to_chat(usr, "<span class='warning'>\The [src] is starting to heat up.</span>")
			if(4)
				to_chat(usr, "<span class='userdanger'>\The [src] is heating up dangerously from overuse!</span>")
			if(5) //overload
				broken_hailer = 1
				to_chat(usr, "<span class='userdanger'>\The [src]'s power modulator overloads and breaks.</span>")
				return

		switch(aggressiveness)		// checks if the user has unlocked the restricted phrases
			if(1)
				phrase = rand(1,5)	// set the upper limit as the phrase above the first 'bad cop' phrase, the mask will only play 'nice' phrases
			if(2)
				phrase = rand(1,11)	// default setting, set upper limit to last 'bad cop' phrase. Mask will play good cop and bad cop phrases
			if(3)
				phrase = rand(1,18)	// user has unlocked all phrases, set upper limit to last phrase. The mask will play all phrases
			if(4)
				phrase = rand(12,18)	// user has broke the restrictor, it will now only play shitcurity phrases

		if(!safety)
			phrase_text = "JEBA?? TWOJEGO PEDA??A TY G??WNO JEDZ??CA BURZO CHUJ??W I CHAPAJ KUTASA JEBANA DUPO WJE??DZAJ??CA G??WNO KURWA JEDZ PENISY W TWOJ?? PIERDOLON?? MORD?? I WYSRAJ ABORCJE KURWY ORAZ NAKUPKAJ I NASRAJ DO SWOJEJ DUPY TY FIUCIE KURWA ZASRANA MA??PO KURWA DUPA PALANCIE Z ODM??T??W G??WNA."
			phrase_sound = "emag"
		else

			switch(phrase)	//sets the properties of the chosen phrase
				if(1)				// good cop
					phrase_text = "STA??! STA??! STA??!"
					phrase_sound = "halt"
				if(2)
					phrase_text = "St??j w imieniu prawa."
					phrase_sound = "bobby"
				if(3)
					phrase_text = "Uleg??o???? jest w twoim najlepszym interesie."
					phrase_sound = "compliance"
				if(4)
					phrase_text = "Przygotuj si?? na sprawiedliwo????!"
					phrase_sound = "justice"
				if(5)
					phrase_text = "Uciekanie tylko wyd??u??y tw??j wyrok."
					phrase_sound = "running"
				if(6)				// bad cop
					phrase_text = "Nie ruszaj si??, szujo!"
					phrase_sound = "dontmove"
				if(7)
					phrase_text = "Na gleb??, szujo!"
					phrase_sound = "floor"
				if(8)
					phrase_text = "Martwy czy ??ywy, idziesz ze mn??."
					phrase_sound = "robocop"
				if(9)
					phrase_text = "B??g zes??a?? mnie dzi?? przeciw tym szumowinom, kt??rych nie mogli??my z??apa?? wczoraj."
					phrase_sound = "god"
				if(10)
					phrase_text = "Ani drgnij, ??mieciu!"
					phrase_sound = "freeze"
				if(11)
					phrase_text = "Stop right there, criminal scum!"
					phrase_sound = "imperial"
				if(12)				// LA-PD
					phrase_text = "St??j albo ci?? grzmotn??."
					phrase_sound = "bash"
				if(13)
					phrase_text = "No dalej, poka?? na co ci?? sta??."
					phrase_sound = "harry"
				if(14)
					phrase_text = "Przesta?? ??ama?? prawo, dupku."
					phrase_sound = "asshole"
				if(15)
					phrase_text = "Masz prawo zamkn???? mord??."
					phrase_sound = "stfu"
				if(16)
					phrase_text = "Zamknij si??, zbrodnio!"
					phrase_sound = "shutup"
				if(17)
					phrase_text = "Zmierz si?? z gniewem z??otej b??yskawicy."
					phrase_sound = "super"
				if(18)
					phrase_text = "Ja jestem, PRAWEM!"
					phrase_sound = "dredd"

		usr.audible_message("[usr]'s Compli-o-Nator: <font color='red' size='4'><b>[phrase_text]</b></font>")
		playsound(src.loc, "sound/voice/complionator/[phrase_sound].ogg", 100, 0, 4)
		cooldown = world.time
		cooldown_special = world.time
