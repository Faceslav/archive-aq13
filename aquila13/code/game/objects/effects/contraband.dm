// This is synced up to the poster placing animation.
#define PLACE_SPEED 37

// The poster item

/obj/item/poster
	name = "poorly coded poster"
	desc = "You probably shouldn't be holding this."
	icon = 'icons/obj/contraband.dmi'
	force = 0
	resistance_flags = FLAMMABLE
	var/poster_type
	var/obj/structure/sign/poster/poster_structure

/obj/item/poster/Initialize(mapload, obj/structure/sign/poster/new_poster_structure)
	. = ..()
	poster_structure = new_poster_structure
	if(!new_poster_structure && poster_type)
		poster_structure = new poster_type(src)

	// posters store what name and description they would like their
	// rolled up form to take.
	if(poster_structure)
		name = poster_structure.poster_item_name
		desc = poster_structure.poster_item_desc
		icon_state = poster_structure.poster_item_icon_state

		name = "[name] - [poster_structure.original_name]"

/obj/item/poster/Destroy()
	poster_structure = null
	. = ..()

// These icon_states may be overridden, but are for mapper's convinence
/obj/item/poster/random_contraband
	name = "random contraband poster"
	poster_type = /obj/structure/sign/poster/contraband/random
	icon_state = "rolled_poster"

/obj/item/poster/random_official
	name = "random official poster"
	poster_type = /obj/structure/sign/poster/official/random
	icon_state = "rolled_legit"

// The poster sign/structure

/obj/structure/sign/poster
	name = "poster"
	var/original_name
	desc = "A large piece of space-resistant printed paper."
	icon = 'icons/obj/contraband.dmi'
	anchored = TRUE
	var/ruined = FALSE
	var/random_basetype
	var/never_random = FALSE // used for the 'random' subclasses.

	var/poster_item_name = "hypothetical poster"
	var/poster_item_desc = "This hypothetical poster item should not exist, let's be honest here."
	var/poster_item_icon_state = "rolled_poster"

/obj/structure/sign/poster/Initialize()
	. = ..()
	if(random_basetype)
		randomise(random_basetype)
	if(!ruined)
		original_name = name // can't use initial because of random posters
		name = "poster - [name]"
		desc = "A large piece of space-resistant printed paper. [desc]"

/obj/structure/sign/poster/proc/randomise(base_type)
	var/list/poster_types = subtypesof(base_type)
	var/list/approved_types = list()
	for(var/t in poster_types)
		var/obj/structure/sign/poster/T = t
		if(initial(T.icon_state) && !initial(T.never_random))
			approved_types |= T

	var/obj/structure/sign/poster/selected = pick(approved_types)

	name = initial(selected.name)
	desc = initial(selected.desc)
	icon_state = initial(selected.icon_state)
	poster_item_name = initial(selected.poster_item_name)
	poster_item_desc = initial(selected.poster_item_desc)
	poster_item_icon_state = initial(selected.poster_item_icon_state)
	ruined = initial(selected.ruined)


/obj/structure/sign/poster/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WIRECUTTER)
		I.play_tool_sound(src, 100)
		if(ruined)
			to_chat(user, "<span class='notice'>You remove the remnants of the poster.</span>")
			qdel(src)
		else
			to_chat(user, "<span class='notice'>You carefully remove the poster from the wall.</span>")
			roll_and_drop(user.loc)

/obj/structure/sign/poster/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(ruined)
		return
	visible_message("[user] rips [src] in a single, decisive motion!" )
	playsound(src.loc, 'sound/items/poster_ripped.ogg', 100, 1)

	var/obj/structure/sign/poster/ripped/R = new(loc)
	R.pixel_y = pixel_y
	R.pixel_x = pixel_x
	R.add_fingerprint(user)
	qdel(src)

/obj/structure/sign/poster/proc/roll_and_drop(loc)
	pixel_x = 0
	pixel_y = 0
	var/obj/item/poster/P = new(loc, src)
	forceMove(P)
	return P

//separated to reduce code duplication. Moved here for ease of reference and to unclutter r_wall/attackby()
/turf/closed/wall/proc/place_poster(obj/item/poster/P, mob/user)
	if(!P.poster_structure)
		to_chat(user, "<span class='warning'>[P] has no poster... inside it? Inform a coder!</span>")
		return

	// Deny placing posters on currently-diagonal walls, although the wall may change in the future.
	if (smooth & SMOOTH_DIAGONAL)
		for (var/O in overlays)
			var/image/I = O
			if(copytext(I.icon_state, 1, 3) == "d-") //3 == length("d-") + 1
				return

	var/stuff_on_wall = 0
	for(var/obj/O in contents) //Let's see if it already has a poster on it or too much stuff
		if(istype(O, /obj/structure/sign/poster))
			to_chat(user, "<span class='warning'>The wall is far too cluttered to place a poster!</span>")
			return
		stuff_on_wall++
		if(stuff_on_wall == 3)
			to_chat(user, "<span class='warning'>The wall is far too cluttered to place a poster!</span>")
			return

	to_chat(user, "<span class='notice'>You start placing the poster on the wall...</span>"	)

	var/obj/structure/sign/poster/D = P.poster_structure

	var/temp_loc = get_turf(user)
	flick("poster_being_set",D)
	D.forceMove(src)
	qdel(P)	//delete it now to cut down on sanity checks afterwards. Agouri's code supports rerolling it anyway
	playsound(D.loc, 'sound/items/poster_being_created.ogg', 100, 1)

	if(do_after(user, PLACE_SPEED, target=src))
		if(!D || QDELETED(D))
			return

		if(iswallturf(src) && user && user.loc == temp_loc)	//Let's check if everything is still there
			to_chat(user, "<span class='notice'>You place the poster!</span>")
			return

	to_chat(user, "<span class='notice'>The poster falls down!</span>")
	D.roll_and_drop(temp_loc)

// Various possible posters follow

/obj/structure/sign/poster/ripped
	ruined = TRUE
	icon_state = "poster_ripped"
	name = "ripped poster"
	desc = "You can't make out anything from the poster's original print. It's ruined."

/obj/structure/sign/poster/random
	name = "random poster" // could even be ripped
	icon_state = "random_anything"
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster

/obj/structure/sign/poster/contraband
	poster_item_name = "contraband poster"
	poster_item_desc = "This poster comes with its own automatic adhesive mechanism, for easy pinning to any vertical surface. Its vulgar themes have marked it as contraband aboard Nanotrasen space facilities."
	poster_item_icon_state = "rolled_poster"

/obj/structure/sign/poster/contraband/random
	name = "random contraband poster"
	icon_state = "random_contraband"
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster/contraband

/obj/structure/sign/poster/contraband/free_tonto
	name = "Deus Ex Machina"
	desc = "Plakat promuj??cy absurdalny pogl??d, ??e ??yjemy w symulacji. C???? za krety??stwo..."
	icon_state = "poster1"

/obj/structure/sign/poster/contraband/atmosia_independence
	name = "Maciu??"
	desc = "Grafika przedstawiaj??ca niegro??nego grzybka. Urocze!"
	icon_state = "poster2"

/obj/structure/sign/poster/contraband/fun_police
	name = "Fun Police"
	desc = "Plakat wymierzony przeciwko si??om ochrony na stacji."
	icon_state = "poster3"

/obj/structure/sign/poster/contraband/lusty_xenomorph
	name = "Elfy Userotha"
	desc = "Blu??nierczy plakat upami??tniaj??cy harem niejakiego Userotha."
	icon_state = "poster4"

/obj/structure/sign/poster/contraband/syndicate_recruitment
	name = "Syndykat Rekrutuje"
	desc = "Zwiedzaj galaktyk??! Poznawaj nowych ludzi! Zastrzel ich!"
	icon_state = "poster5"

/obj/structure/sign/poster/contraband/clown
	name = "Klaun"
	desc = "Honk."
	icon_state = "poster6"

/obj/structure/sign/poster/contraband/smoke
	name = "Karm raka!"
	desc = "Plakat promuj??ce niezdrowe metody radzenia sobie z kosmicznym stresem."
	icon_state = "poster7"

/obj/structure/sign/poster/contraband/grey_tide
	name = "Szara Fala"
	desc = "Buntowniczy plakat symbolizuj??cy jedno???? asystent??w."
	icon_state = "poster8"

/obj/structure/sign/poster/contraband/missing_gloves
	name = "Zagin????y: R??kawice"
	desc = "Plakat odnosz??cy si?? do ci???? bud??etowych korporacji prowadz??cych do ograniczenia dost??pno??ci r??kawic izoluj??cych."
	icon_state = "poster9"

/obj/structure/sign/poster/contraband/hacking_guide
	name = "Poradnik hakowania"
	desc = "Plakat opisuj??cy zasad?? dzia??ania oraz metody hakowania standardowej ??luzy NanoTrasenu. Wygl??da na to, ??e jest nieaktualny."
	icon_state = "poster10"

/obj/structure/sign/poster/contraband/rip_badger
	name = "P??ak"
	desc = "Ten kotek jest taki smutny!"
	icon_state = "poster11"

/obj/structure/sign/poster/contraband/ambrosia_vulgaris
	name = "Ambrosia Vulgaris"
	desc = "Wow, ten plakat jest totalnie tubularny ziom."
	icon_state = "poster12"

/obj/structure/sign/poster/contraband/donut_corp
	name = "Papaj Corp."
	desc = "Plakat reklamuj??cy wadowicki specja?? znany w ca??ej galaktyce."
	icon_state = "poster13"

/obj/structure/sign/poster/contraband/eat
	name = "??RYJ."
	desc = "JEDZ, TAK, NIE PRZESTAWAJ."
	icon_state = "poster14"

/obj/structure/sign/poster/contraband/tools
	name = "Narz??dzia"
	desc = "Plakat reklamuj??cy narz??dzia. Faktycznie dobrze je mie??."
	icon_state = "poster15"

/obj/structure/sign/poster/contraband/power
	name = "Moc"
	desc = "Plakat przedstawiaj??cy osobliwo???? grawitacyjn??. Wydgl??da na to, ??e jest w niej klaun."
	icon_state = "poster16"

/obj/structure/sign/poster/contraband/space_cube
	name = "Kosmokostka"
	desc = "B??g jest sze??cianem i stworzy?? wszech??wiat na sw??j obraz i podobie??stwo."
	icon_state = "poster17"

/obj/structure/sign/poster/contraband/communist_state
	name = "G??ra lodowa"
	desc = "Grafika g??ry lodowej. Wygl??da na to, ??e ma to by?? alegoria do jakich?? 'g????bokich' sekret??w."
	icon_state = "poster18"

/obj/structure/sign/poster/contraband/lamarr
	name = "Lamarr"
	desc = "Plakat przedstawiaj??cy 'zwierz??tko' Dyrektora Naukowego."
	icon_state = "poster19"

/obj/structure/sign/poster/contraband/borg_fancy_1
	name = "Borg Fancy"
	desc = "Being fancy can be for any borg, just need a suit."
	icon_state = "poster20"

/obj/structure/sign/poster/contraband/borg_fancy_2
	name = "Borg Fancy v2"
	desc = "Borg Fancy, Now only taking the most fancy."
	icon_state = "poster21"

/obj/structure/sign/poster/contraband/kss13
	name = "Papaj nie ??yje"
	desc = "Przykre przypomnienie jednego z najczarniejszych moment??w historii."
	icon_state = "poster22"

/obj/structure/sign/poster/contraband/rebels_unite
	name = "CCCP"
	desc = "Plakat przedstawiaj??cy najgorszy koszmar ka??dego kosmopolaka."
	icon_state = "poster23"

/obj/structure/sign/poster/contraband/c20r
	// have fun seeing this poster in "spawn 'c20r'", admins...
	name = "C-20r"
	desc = "Plakat promuj??cy karabinek Scarborough Arms C-20r."
	icon_state = "poster24"

/obj/structure/sign/poster/contraband/have_a_puff
	name = "Jaraj blanta"
	desc = "Ziom, s??uchaj, jestem, jakby... S??uchasz mnie?"
	icon_state = "poster25"

/obj/structure/sign/poster/contraband/revolver
	name = "Rewolwer"
	desc = "Wyrewolwerowany rewolwerowiec wyrewolwerowa?? wyrewolwerowanego rewolwerowca."
	icon_state = "poster26"

/obj/structure/sign/poster/contraband/d_day_promo
	name = "D-Day Promo"
	desc = "Plakat promocyjny jakiego?? rapera."
	icon_state = "poster27"

/obj/structure/sign/poster/contraband/syndicate_pistol
	name = "Stenchkin"
	desc = "Plakat okre??laj??cy pistolet syndykatu jako 'bro?? z klas??'."
	icon_state = "poster28"

/obj/structure/sign/poster/contraband/energy_swords
	name = "E-Miecze"
	desc = "Wszystkie kolory brutalnego morderstwa."
	icon_state = "poster29"

/obj/structure/sign/poster/contraband/red_rum
	name = "PRAWuH"
	desc = "Plakat pi??tnuj??cy problem alkoholizmu w??r??d si?? ochrony."
	icon_state = "poster30"

/obj/structure/sign/poster/contraband/cc64k_ad
	name = "CC 64K Ad"
	desc = "Najnowszy komputer przeno??ny od Comrade Computing, z a?? 64kB ramu!"
	icon_state = "poster31"

/obj/structure/sign/poster/contraband/punch_shit
	name = "Napierdalaj"
	desc = "Wszczynaj b??jki bez powodu, jak prawdziwy polak patriota!"
	icon_state = "poster32"

/obj/structure/sign/poster/contraband/the_griffin
	name = "Cz??owiek-Gryf"
	desc = "Cz??owiek-Gryf rozkazuje Ci by?? najgorszym ??cierwem. Zgodzisz si???"
	icon_state = "poster33"

/obj/structure/sign/poster/contraband/lizard
	name = "Bry"
	desc = "Ten spro??ny plakat przedstawia jaszczura gotowego do ucieczki."
	icon_state = "poster34"

/obj/structure/sign/poster/contraband/free_drone
	name = "Syndron"
	desc = "Plakat przestrzegaj??cy przed dronami syndykatu kanibalizuj??cymi inne drony."
	icon_state = "poster35"

/obj/structure/sign/poster/contraband/busty_backdoor_xeno_babes_6
	name = "Cycate Xenomorfy Z S??siedztwa 6"
	desc = "Same naturalne Xeno-Mamu??ki!"
	icon_state = "poster36"

/obj/structure/sign/poster/contraband/robust_softdrinks
	name = "Robustne Napitki"
	desc = "Robustne Napitki: Bardziej robustne ni?? skrzynka narz??dziowa w ??eb!"
	icon_state = "poster37"

/obj/structure/sign/poster/contraband/shamblers_juice
	name = "OOC3"
	desc = "Plakat przedstawiaj??cy logo sekty znanej jako 'OOC3'."
	icon_state = "poster38"

/obj/structure/sign/poster/contraband/pwr_game
	name = "Pwr Game"
	desc = "MOC kt??rej pragn?? prawdziwi GRACZE! Program partnerski z Sa??atk?? Vlada."
	icon_state = "poster39"

/obj/structure/sign/poster/contraband/sun_kist
	name = "Sun-kist"
	desc = "Napij si?? gwiazd!"
	icon_state = "poster40"

/obj/structure/sign/poster/contraband/space_cola
	name = "Kosmo-Cola"
	desc = "Zwyczajna Cola... W KOSMOSIE!"
	icon_state = "poster41"

/obj/structure/sign/poster/contraband/space_up
	name = "Space-Up!"
	desc = "Wyssany w pr????ni?? intensywno??ci?? SMAKU!"
	icon_state = "poster42"

/obj/structure/sign/poster/contraband/kudzu
	name = "Kudzu"
	desc = "Plakat filmu o kosmicznych pn??czach? Co za bzdura."
	icon_state = "poster43"

/obj/structure/sign/poster/contraband/masked_men
	name = "Dynamic"
	desc = "Plakat podpisany 'Dynamic' przedstawiaj??cy m????czyzn?? trzymaj??cego w robotycznej d??oni papierosa, z wytatuowan?? u??miechni??t?? bu??k?? na boku czaszki."
	icon_state = "poster44"

//annoyingly, poster45 is in another file.

/obj/structure/sign/poster/contraband/free_key
	name = "Darmowy klucz koduj??cy syndykatu"
	desc = "Plakat o agentach syndykatu, kt??rym nigdy do????."
	icon_state = "poster46"

/obj/structure/sign/poster/contraband/bountyhunters
	name = "??owcy Nagr??d"
	desc = "Plakat promuj??cy us??ugi ??owc??w nagr??d."
	icon_state = "poster47"

/obj/structure/sign/poster/contraband/omnissiah
	name = "Omnisjasz"
	desc = "Plakat promuj??cy tostery firmy 'Omnisjasz'."
	icon_state = "poster50"

/obj/structure/sign/poster/official
	poster_item_name = "motivational poster"
	poster_item_desc = "An official Nanotrasen-issued poster to foster a compliant and obedient workforce. It comes with state-of-the-art adhesive backing, for easy pinning to any vertical surface."
	poster_item_icon_state = "rolled_legit"

/obj/structure/sign/poster/official/random
	name = "random official poster"
	random_basetype = /obj/structure/sign/poster/official
	icon_state = "random_official"
	never_random = TRUE

/obj/structure/sign/poster/official/here_for_your_safety
	name = "Oddaj g??os!"
	desc = "Zdecyduj zanim zdecyduj?? za Ciebie!"
	icon_state = "poster1_legit"

/obj/structure/sign/poster/official/nanotrasen_logo
	name = "Logo NanoTrasenu"
	desc = "Plakat przedstawiaj??cy logo NanoTrasenu."
	icon_state = "poster2_legit"

/obj/structure/sign/poster/official/cleanliness
	name = "Pij mleko"
	desc = "B??dziesz wielki."
	icon_state = "poster3_legit"

/obj/structure/sign/poster/official/help_others
	name = "500+"
	desc = "Plakat odwo??uj??cy si?? do programu premii dla pracownik??w wdra??aj??cych nowozatrudnionych do pracy."
	icon_state = "poster4_legit"

/obj/structure/sign/poster/official/build
	name = "BUDOWA"
	desc = "Plakat pochwalny dla zespo??u in??ynieryjnego."
	icon_state = "poster5_legit"

/obj/structure/sign/poster/official/bless_this_spess
	name = "Drontopia"
	desc = "Plakat promuj??cy u??ycie dron??w naprawczych."
	icon_state = "poster6_legit"

/obj/structure/sign/poster/official/science
	name = "WIARA"
	desc = "Nadzieja i naiwno????."
	icon_state = "poster7_legit"

/obj/structure/sign/poster/official/ian
	name = "Ian"
	desc = "Woof."
	icon_state = "poster8_legit"

/obj/structure/sign/poster/official/obey
	name = "ZOMO!"
	desc = "Plakat subtelnie zach??caj??cy do nieprzeszkadzania s??u??bom ochrony w wykonywaniu ich obowi??zk??w."
	icon_state = "poster9_legit"

/obj/structure/sign/poster/official/walk
	name = "Id??"
	desc = "Plakat zach??caj??cy do chodzenia zamiast biegania."
	icon_state = "poster10_legit"

/obj/structure/sign/poster/official/state_laws
	name = "State Laws"
	desc = "A poster instructing cyborgs to state their laws."
	icon_state = "poster11_legit"

/obj/structure/sign/poster/official/love_ian
	name = "Tul"
	desc = "Ian jest przyjacielem, nie jedzeniem."
	icon_state = "poster12_legit"

/obj/structure/sign/poster/official/space_cops
	name = "Kosmo-pa??y"
	desc = "Plakat promuj??cy kosmotelewizyjny serial pod tytu??em 'Kosmo-Pa??y'."
	icon_state = "poster13_legit"

/obj/structure/sign/poster/official/ue_no
	name = "Ue No."
	desc = "G??upie chi??skie kosmobajki."
	icon_state = "poster14_legit"

/obj/structure/sign/poster/official/get_your_legs
	name = "Miej DUP??"
	desc = "DUPA: Duma, U??o??enie, Patriotyzm oraz Autorytet."
	icon_state = "poster15_legit"

/obj/structure/sign/poster/official/do_not_question
	name = "Pijesz mleko?"
	desc = "Powiniene??. Robi dobrze na ko??ci."
	icon_state = "poster16_legit"

/obj/structure/sign/poster/official/work_for_a_future
	name = "P??a?? lub p??acz!"
	desc = "Drobnym druczkiem dopisana jest informacja o tym, ??e ??zy nie s?? akceptowaln?? walut??."
	icon_state = "poster17_legit"

/obj/structure/sign/poster/official/soft_cap_pop_art
	name = "Chick Good Inc."
	desc = "Don't stop, get it, get it; Be proud your captains in it; Steady, watch me navigate; Ha HA ha HA"
	icon_state = "poster18_legit"

/obj/structure/sign/poster/official/safety_internals
	name = "Tlen: ??ycie"
	desc = "Plakat instrukta??owy dotycz??cy u??ycia masek w rzadkich przypadkach, gdy atmosfera na stacji jest niezdatna do ??ycia."
	icon_state = "poster19_legit"

/obj/structure/sign/poster/official/safety_eye_protection
	name = "Chro?? oczy!"
	desc = "Plakat przypominaj??cy o ??rodkach ochrony oczu."
	icon_state = "poster20_legit"

/obj/structure/sign/poster/official/safety_report
	name = "Melduj"
	desc = "Donos jest najwy??sz?? form?? odpowiedzialno??ci obywatelskiej."
	icon_state = "poster21_legit"

/obj/structure/sign/poster/official/report_crimes
	name = "Dzwo?? pod 997"
	desc = "Przedawniony plakat zach??caj??cy do informowania ochrony o wszelkich nieprawid??owo??ciach."
	icon_state = "poster22_legit"

/obj/structure/sign/poster/official/ion_rifle
	name = "Dzia??ko jonowe"
	desc = "Plakat przedstawiaj??cy dzia??ko jonowe."
	icon_state = "poster23_legit"

/obj/structure/sign/poster/official/foam_force_ad
	name = "Reklama PiankoBroni"
	desc = "PiankoBro??! Piankuj albo zosta?? zpiankowany!!"
	icon_state = "poster24_legit"

/obj/structure/sign/poster/official/cohiba_robusto_ad
	name = "Reklama Cohiba Robusto"
	desc = "Cohiba Robusto - klasyczne cygaro dla klasycznych ludzi."
	icon_state = "poster25_legit"

/obj/structure/sign/poster/official/anniversary_vintage_reprint
	name = "NAUKA!"
	desc = "Plakat pochwalny dla zespo??u naukowego."
	icon_state = "poster26_legit"

/obj/structure/sign/poster/official/fruit_bowl
	name = "Martwa Natura"
	desc = "Daje do my??lenia."
	icon_state = "poster27_legit"

/obj/structure/sign/poster/official/pda_ad
	name = "Reklama PDA"
	desc = "Plakat reklamuj??cy najnowsze PDA NanoTrasenu."
	icon_state = "poster28_legit"

/obj/structure/sign/poster/official/enlist
	name = "Chro?? i s??u??." // but I thought deathsquad was never acknowledged
	desc = "Plakat przedstawiaj??cy elitarnego komandosa NanoTrasenu."
	icon_state = "poster29_legit"

/obj/structure/sign/poster/official/nanomichi_ad
	name = "Reklama Nanomichi"
	desc = " Reklama promuj??ca kasety firmy Nanomichi."
	icon_state = "poster30_legit"

/obj/structure/sign/poster/official/twelve_gauge
	name = "Kaliber 12"
	desc = "Plakat promuj??cy amunicj?? do strzelb."
	icon_state = "poster31_legit"

/obj/structure/sign/poster/official/high_class_martini
	name = "Martini"
	desc = "Wstrz????ni??te, nie zmieszane."
	icon_state = "poster32_legit"

/obj/structure/sign/poster/official/the_owl
	name = "Cz??owiek-Sowa"
	desc = "Cz??owiek-Sowa zrobi??by wszystko co w jego mocy dla dobra stacji. A Ty?"
	icon_state = "poster33_legit"

/obj/structure/sign/poster/official/no_erp
	name = "Daj Seks Mi"
	desc = "Plakat drwi??cy z tych, kt??rzy nie mog?? powstrzyma?? si?? ci??gotom cia??a na stacji kosmicznej."
	icon_state = "poster34_legit"

/obj/structure/sign/poster/official/wtf_is_co2
	name = "OOC3 nie istnieje"
	desc = "Plakat maj??cy rozwia?? w??tpliwo??ci za??ogi na temat 'OOC3'."
	icon_state = "poster35_legit"

/obj/structure/sign/poster/official/PRAWO
	name = "PRAWO"
	desc = "Plakat przypominaj??cy za??odze oraz s??u??bom ochrony o wa??no??ci Kosmicznego Prawa."
	icon_state = "poster45_legit"

/obj/structure/sign/poster/official/HoPline
	name = "Hopline Miami"
	desc = "Plakat zach??caj??cy asystent??w do zg??oszenia si?? do G??owy Personelu o prac??."
	icon_state = "poster46_legit"

/obj/structure/sign/poster/official/Kredki
	name = "Kredki"
	desc = "Plakat promuj??ce kolorowe kredki znajduj??ce si?? na stacjach NanoTrasenu dla zwi??kszenia morale. Nie zawieraj?? toksycznych substancji!"
	icon_state = "poster47_legit"

/obj/structure/sign/poster/official/PRACA
	name = "PRACA PRACA"
	desc = "Co?? trzeba zrobi???"
	icon_state = "poster48_legit"

/obj/structure/sign/poster/official/moth1
	name = "Safety Moth - Poisoning"
	desc = "This informational poster uses Safety Moth(TM) to tell the viewer not to poison the station donuts. It's signed by 'AspEv'."
	icon_state = "poster36_legit"

/obj/structure/sign/poster/official/moth2
	name = "Safety Moth - BoH"
	desc = "This informational poster uses Safety Moth(TM) to inform the viewer of the dangers of Bags of Holding. It's signed by 'AspEv'."
	icon_state = "poster37_legit"

/obj/structure/sign/poster/official/moth3
	name = "Safety Moth - Hardhats"
	desc = "This informational poster uses Safety Moth(TM) to tell the viewer to wear hardhats in cautious areas. It's like a lamp for your head! It's signed by 'AspEv'."
	icon_state = "poster38_legit"

/obj/structure/sign/poster/official/moth4
	name = "Safety Moth - Smokey?"
	desc = "This informational poster uses Safety Moth(TM) to promote safe handling of plasma, or promoting crew to combat plasmafires. We can't tell. It's signed by 'AspEv'."
	icon_state = "poster39_legit"

/obj/structure/sign/poster/official/moth5
	name = "Safety Moth - Piping"
	desc = "This informational poster uses Safety Moth(TM) to tell atmospheric technicians correct types of piping to be used. Proper pipe placement prevents poor preformance! It's signed by 'AspEv'."
	icon_state = "poster40_legit"

/obj/structure/sign/poster/official/moth6
	name = "Safety Moth - Supermatter"
	desc = "This informational poster uses Safety Moth(TM) to promote proper safety equipment when working near a Supermatter Crystal. It's signed by 'AspEv'."
	icon_state = "poster41_legit"

/obj/structure/sign/poster/official/moth7
	name = "Safety Moth - Methamphetamine"
	desc = "This informational poster uses Safety Moth(TM) to tell the viewer to seek CMO approval before cooking methamphetamine. You shouldn't even be making this. It's signed by 'AspEv'."
	icon_state = "poster42_legit"

/obj/structure/sign/poster/contraband/pill1
	name = "Safety Pill - Methamphetamine"
	desc = "A decommisioned poster that uses Safety Pill(TM?) to promote less-than-legal chemicals. This is one of the reasons we stopped outsourcing these posters. It's signed by 'AspEv'."
	icon_state = "poster48"

/obj/structure/sign/poster/official/moth8
	name = "Safety Moth - Epinephrine"
	desc = "This informational poster uses Safety Moth(TM) to inform the viewer to help injured/deceased crewmen with their epinephrine injectors. It's signed by 'AspEv'."
	icon_state = "poster43_legit"

/obj/structure/sign/poster/official/moth9
	name = "Safety Moth - Delamination Safety Precautions"
	desc = "This informational poster uses Safety Moth(TM) to tell the viewer to hide in lockers when the Supermatter Crystal has delaminated. Running away might be a better strategy. It's signed by 'AspEv'."
	icon_state = "poster44_legit"

/obj/structure/sign/poster/contraband/syndiemoth
	name = "Syndie Moth - Nuclear Operation"
	desc = "A Syndicate-commissioned poster that uses Syndie Moth(TM?) to tell the viewer to keep the nuclear authentication disk unsecured. No, we aren't doing that. It's signed by 'AspEv'."
	icon_state = "poster49"

#undef PLACE_SPEED
