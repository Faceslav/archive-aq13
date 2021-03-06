/*

### This file contains a list of all the areas in your station. Format is as follows:

/area/CATEGORY/OR/DESCRIPTOR/NAME 	(you can make as many subdivisions as you want)
	name = "NICE NAME" 				(not required but makes things really nice)
	icon = 'ICON FILENAME' 			(defaults to 'icons/turf/areas.dmi')
	icon_state = "NAME OF ICON" 	(defaults to "unknown" (blank))
	requires_power = FALSE 				(defaults to true)
	ambientsounds = list()				(defaults to GENERIC from sound.dm. override it as "ambientsounds = list('sound/ambience/signal.ogg')" or using another define.

NOTE: there are two lists of areas in the end of this file: centcom and station itself. Please maintain these lists valid. --rastaf0

*/


/*-----------------------------------------------------------------------------*/

/area/ai_monitored	//stub defined ai_monitored.dm

/area/ai_monitored/turret_protected

/area/space
	icon_state = "space"
	requires_power = TRUE
	always_unpowered = TRUE
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	power_light = FALSE
	power_equip = FALSE
	power_environ = FALSE
	valid_territory = FALSE
	outdoors = TRUE
	ambientsounds = SPACE
	blob_allowed = FALSE //Eating up space doesn't count for victory as a blob.

/area/space/nearstation
	icon_state = "space_near"
	dynamic_lighting = DYNAMIC_LIGHTING_IFSTARLIGHT

/area/start
	name = "start area"
	icon_state = "start"
	requires_power = FALSE
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	has_gravity = STANDARD_GRAVITY


/area/testroom
	requires_power = FALSE
	name = "Test Room"
	icon_state = "storage"

//EXTRA

/area/asteroid
	name = "Asteroida"
	icon_state = "asteroid"
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
	blob_allowed = FALSE //Nope, no winning on the asteroid as a blob. Gotta eat the station.
	valid_territory = FALSE
	ambientsounds = MINING

/area/asteroid/nearstation
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	ambientsounds = RUINS
	always_unpowered = FALSE
	requires_power = TRUE
	blob_allowed = TRUE

/area/asteroid/nearstation/bomb_site
	name = "Asteroida do testowania bomb"

//STATION13

//Maintenance

/area/maintenance
	ambientsounds = MAINTENANCE
	valid_territory = FALSE
	mood_bonus = -1
	mood_message = "<span class='nicegreen'>It's kind of cramped in here!\n</span>"
	lighting_colour_tube = "#ffe5cb"
	lighting_colour_bulb = "#ffdbb4"

//Departments

/area/maintenance/department/chapel
	name = "Tunel Techniczny Kaplica"
	icon_state = "maint_chapel"

/area/maintenance/department/chapel/monastery
	name = "Tunel Techniczny Klasztor"
	icon_state = "maint_monastery"

/area/maintenance/department/crew_quarters/bar
	name = "Tunel Techniczny Bar"
	icon_state = "maint_bar"

/area/maintenance/department/crew_quarters/dorms
	name = "Tunel Techniczny Sala Sypialna"
	icon_state = "maint_dorms"

/area/maintenance/department/eva
	name = "Tunel Techniczny EVA"
	icon_state = "maint_eva"

/area/maintenance/department/electrical
	name = "Tunel Techniczny Energetyka"
	icon_state = "maint_electrical"

/area/maintenance/department/engine/atmos
	name = "Tunel Techniczny Atmosferyka"
	icon_state = "maint_atmos"

/area/maintenance/department/security
	name = "Tunel Techniczny Ochrona"
	icon_state = "maint_sec"

/area/maintenance/department/security/upper
	name = "G??rny Tunel Techniczny Ochrona"

/area/maintenance/department/security/brig
	name = "Tunel Techniczny Areszt"
	icon_state = "maint_brig"

/area/maintenance/department/medical
	name = "Tunel Techniczny Szpital"
	icon_state = "medbay_maint"

/area/maintenance/department/medical/central
	name = "Centralny Tunel Techniczny Szpital"
	icon_state = "medbay_maint_central"

/area/maintenance/department/medical/morgue
	name = "Tunel Techniczny Kostnica"
	icon_state = "morgue_maint"

/area/maintenance/department/science
	name = "Tunel Techniczny Wydzia?? Badawczy"
	icon_state = "maint_sci"

/area/maintenance/department/science/central
	name = "Centralny Tunel Techniczny Wydzia?? Badawczy"
	icon_state = "maint_sci_central"

/area/maintenance/department/cargo
	name = "Tunel Techniczny ??adownia"
	icon_state = "maint_cargo"

/area/maintenance/department/bridge
	name = "Tunel Techniczny Mostek"
	icon_state = "maint_bridge"

/area/maintenance/department/engine
	name = "Tunel Techniczny In??ynieria"
	icon_state = "maint_engi"

/area/maintenance/department/science/xenobiology
	name = "Tunel Techniczny Ksenobiologia"
	icon_state = "xenomaint"
	xenobiology_compatible = TRUE


//Maintenance - Generic

/area/maintenance/aft
	name = "Tunel Techniczny Rufa"
	icon_state = "amaint"

/area/maintenance/aft/upper
	name = "G??rny Tunel Techniczny Rufa"

/area/maintenance/aft/secondary
	name = "Tunel Techniczny Rufa"
	icon_state = "amaint_2"

/area/maintenance/central
	name = "Centralny Tunel Techniczny"
	icon_state = "maintcentral"

/area/maintenance/central/secondary
	name = "Centralny Tunel Techniczny"
	icon_state = "maintcentral"

/area/maintenance/fore
	name = "Tunel Techniczny Dzi??b"
	icon_state = "fmaint"

/area/maintenance/fore/upper
	name = "G??rny Tunel Techniczny Dzi??b"

/area/maintenance/fore/secondary
	name = "Tunel Techniczny Dzi??b"
	icon_state = "fmaint_2"

/area/maintenance/starboard
	name = "Tunel Techniczny Sterburta"
	icon_state = "smaint"

/area/maintenance/starboard/upper
	name = "G??rny Tunel Techniczny Sterburta"

/area/maintenance/starboard/central
	name = "Centralny Tunel Techniczny Sterburta"
	icon_state = "smaint"

/area/maintenance/starboard/secondary
	name = "Drugorz??dny Tunel Techniczny Sterburta"
	icon_state = "smaint_2"

/area/maintenance/starboard/aft
	name = "Dolny Tunel Techniczny Sterburta"
	icon_state = "asmaint"

/area/maintenance/starboard/aft/secondary
	name = "Drugorz??dny Dolny Tunel Techniczny Sterburta"
	icon_state = "asmaint_2"

/area/maintenance/starboard/fore
	name = "Przedni Tunel Techniczny Sterburta"
	icon_state = "fsmaint"

/area/maintenance/port
	name = "Tunel Techniczny Bakburta"
	icon_state = "pmaint"

/area/maintenance/port/central
	name = "Centralny Tunel Techniczny Bakburta"
	icon_state = "maintcentral"

/area/maintenance/port/aft
	name = "G??rny Tunel Techniczny Bakburta"
	icon_state = "apmaint"

/area/maintenance/port/fore
	name = "Dolny Tunel Techniczny Bakburta"
	icon_state = "fpmaint"

/area/maintenance/disposal
	name = "Utylizacja Odpad??w"
	icon_state = "disposal"

/area/maintenance/disposal/incinerator
	name = "Spalarnia"
	icon_state = "incinerator"


//Hallway

/area/hallway
	lighting_colour_tube = "#fdf3ea"
	lighting_colour_bulb = "#ffebd6"

/area/hallway/primary/aft
	name = "Dolny G????wny Korytarz"
	icon_state = "hallA"

/area/hallway/primary/fore
	name = "G??rny G????wny Koryatrz"
	icon_state = "hallF"

/area/hallway/primary/starboard
	name = "G????wny Korytarz Sterburta"
	icon_state = "hallS"

/area/hallway/primary/port
	name = "G????wny Korytarz Bakburta"
	icon_state = "hallP"

/area/hallway/primary/central
	name = "Centralny G????wny Korytarz"
	icon_state = "hallC"

/area/hallway/primary/upper
	name = "G??rny Centralny G????wny Korytarz"
	icon_state = "hallC"

/area/hallway/secondary/command
	name = "Korytarz Dow??dztwa"
	icon_state = "bridge_hallway"

/area/hallway/secondary/construction
	name = "Strefa Budowlana"
	icon_state = "construction"

/area/hallway/secondary/exit
	name = "Korytarz Prom Ratunkowy"
	icon_state = "escape"

/area/hallway/secondary/exit/departure_lounge
	name = "Hala Odlot??w"
	icon_state = "escape_lounge"

/area/hallway/secondary/entry
	name = "Korytarz Hala Przylot??w"
	icon_state = "entry"

/area/hallway/secondary/service
	name = "Korytarz Us??ug"
	icon_state = "hall_service"

//Command

/area/bridge
	name = "Mostek"
	icon_state = "bridge"
	ambientsounds = list('sound/ambience/signal.ogg')

/area/bridge/meeting_room
	name = "Sala Konferencyjna Dyrektor??w Departament??w"
	icon_state = "meeting"

/area/bridge/meeting_room/council
	name = "Izba Rady"
	icon_state = "meeting"

/area/bridge/showroom/corporate
	name = "Sala Prezentacyjna"
	icon_state = "showroom"

/area/crew_quarters/heads/captain
	name = "Biuro Kapitana"
	icon_state = "captain"

/area/crew_quarters/heads/captain/private
	name = "Kwatera Kapitana"
	icon_state = "captain_private"

/area/crew_quarters/heads/chief
	name = "Biuro Majstra"
	icon_state = "ce_office"

/area/crew_quarters/heads/cmo
	name = "Biuro Ordynatora"
	icon_state = "cmo_office"

/area/crew_quarters/heads/hop
	name = "Biuro G??owy Personelu"
	icon_state = "hop_office"

/area/crew_quarters/heads/hos
	name = "Biuro G??owy Ochrony"
	icon_state = "hos_office"

/area/crew_quarters/heads/hor
	name = "Biuro Dyrektora Naukowego"
	icon_state = "rd_office"

/area/comms
	name = "Radiow??ze??"
	icon_state = "tcomsatcham"
	lighting_colour_tube = "#e2feff"
	lighting_colour_bulb = "#d5fcff"

/area/server
	name = "Serwerownia Systemu Wiadmo??ci"
	icon_state = "server"

//Crew

/area/crew_quarters/dorms
	name = "Dormitoria"
	icon_state = "dorms"
	safe = TRUE
	mood_bonus = 3
	mood_message = "<span class='nicegreen'>There's no place like the dorms!\n</span>"
	lighting_colour_tube = "#fff4d6"
	lighting_colour_bulb = "#ffebc1"

/area/crew_quarters/cryopods
	name = "Cryopod Room"
	safe = TRUE
	icon_state = "cryopod"
	lighting_colour_tube = "#e3ffff"
	lighting_colour_bulb = "#d5ffff"

/area/crew_quarters/dorms/barracks
	name = "Sypialnie"

/area/crew_quarters/dorms/barracks/male
	name = "Sypialnie M??skie"
	icon_state = "dorms_male"

/area/crew_quarters/dorms/barracks/female
	name = "Sypialnie Damskie"
	icon_state = "dorms_female"

/area/crew_quarters/toilet
	name = "Sala Sypialna Toaleta"
	icon_state = "toilet"
	lighting_colour_tube = "#e3ffff"
	lighting_colour_bulb = "#d5ffff"

/area/crew_quarters/toilet/auxiliary
	name = "Dodatkowa Toaleta"
	icon_state = "toilet"

/area/crew_quarters/toilet/locker
	name = "Szatnia Toaleta"
	icon_state = "toilet"

/area/crew_quarters/toilet/restrooms
	name = "Toalety"
	icon_state = "toilet"

/area/crew_quarters/locker
	name = "Szatnia"
	icon_state = "locker"

/area/crew_quarters/lounge
	name = "Hol"
	icon_state = "lounge"

/area/crew_quarters/fitness
	name = "Si??ownia"
	icon_state = "fitness"

/area/crew_quarters/fitness/locker_room
	name = "Szatnia Dzielona"
	icon_state = "locker"

/area/crew_quarters/fitness/recreation
	name = "Obszar Rekreacji"
	icon_state = "fitness"

/area/crew_quarters/fitness/locker_room/male
	name = "Szatnia M??ska"
	icon_state = "locker_male"

/area/crew_quarters/fitness/locker_room/female
	name = "Szatnia Damska"
	icon_state = "locker_female"


/area/crew_quarters/fitness/recreation
	name = "Strefa Wypoczynkowa"
	icon_state = "rec"

/area/crew_quarters/cafeteria
	name = "Kafeteria"
	icon_state = "cafeteria"

/area/crew_quarters/kitchen
	name = "Kuchnia"
	icon_state = "kitchen"
	lighting_colour_tube = "#e3ffff"
	lighting_colour_bulb = "#d5ffff"

/area/crew_quarters/kitchen/coldroom
	name = "Kuchnia Ch??odnia"
	icon_state = "kitchen_cold"

/area/crew_quarters/bar
	name = "Bar"
	icon_state = "bar"
	mood_bonus = 5
	lighting_colour_tube = "#fff4d6"
	lighting_colour_bulb = "#ffebc1"
	mood_message = "<span class='nicegreen'>Kocham przesiadywa?? w barze!\n</span>"

/area/crew_quarters/bar/atrium
	name = "Atrium"
	icon_state = "bar"

/area/crew_quarters/electronic_marketing_den
	name = "Market Cz????ci Elektronicznych"
	icon_state = "abandoned_m_den"

/area/crew_quarters/abandoned_gambling_den
	name = "Opuszczona Szulernia"
	icon_state = "abandoned_g_den"

/area/crew_quarters/abandoned_gambling_den/secondary
	icon_state = "abandoned_g_den_2"

/area/crew_quarters/theatre
	name = "Teatr"
	icon_state = "theatre"

/area/crew_quarters/theatre/abandoned
	name = "Opuszczony Teatr"
	icon_state = "abandoned_theatre"

/area/library
	name = "Biblioteka"
	icon_state = "library"
	flags_1 = NONE
	lighting_colour_tube = "#fff1cc"
	lighting_colour_bulb = "#ffe9b9"

/area/library/lounge
	name = "Biblioteka Hol"
	icon_state = "library_lounge"

/area/library/abandoned
	name = "Opuszczona Biblioteka"
	icon_state = "library"
	flags_1 = NONE

/area/library/artgallery
	name = "Galeria Sztuki"
	icon_state = "library_gallery"

/area/library/private
	name = "Biblioteka Czytalnia"
	icon_state = "library_gallery_private"

/area/library/upper
	name = "Biblioteka G??rne Pi??tro"
	icon_state = "library"

/area/library/printer
	name = "Biblioteka Drukarnia"
	icon_state = "library"

/area/library/abandoned
	name = "Opuszczona Biblioteka"
	icon_state = "abandoned_library"

/area/chapel
	icon_state = "chapel"
	ambientsounds = HOLY
	flags_1 = NONE
	clockwork_warp_allowed = FALSE
	clockwork_warp_fail = "The consecration here prevents you from warping in."

/area/chapel/main
	name = "Kaplica"

/area/chapel/main/monastery
	name = "Klasztor"

/area/chapel/office
	name = "Biuro Kapelana"
	icon_state = "chapeloffice"

/area/chapel/asteroid
	name = "Kaplica Asterioidy"
	icon_state = "explored"

/area/chapel/asteroid/monastery
	name = "Klasztor Asteroidy"

/area/chapel/dock
	name = "Dok Kaplicy"
	icon_state = "construction"

/area/lawoffice
	name = "Biuro Prawnicze"
	icon_state = "law"


//Engineering

/area/engine
	ambientsounds = ENGINEERING
	lighting_colour_tube = "#ffce93"
	lighting_colour_bulb = "#ffbc6f"

/area/engine/engine_smes
	name = "In??ynieria SMES"
	icon_state = "engine_smes"

/area/engine/engineering
	name = "In??ynieria"
	icon_state = "engine"

/area/engine/atmos
	name = "Atmosferyka"
	icon_state = "atmos"
	flags_1 = NONE

/area/engine/atmos/upper
	name = "G??rna Atmosferyka"

/area/engine/atmospherics_engine
	name = "Atmosferyka Silnik"
	icon_state = "atmos_engine"

/area/engine/engine_room //donut station specific
	name = "Maszynownia"
	icon_state = "atmos_engine"

/area/engine/lobby
	name = "In??ynieria Hol"
	icon_state = "engi_lobby"

/area/engine/engine_room/external
	name = "Supermateria Zewn??trzny Dost??p"
	icon_state = "engine_foyer"

/area/engine/supermatter
	name = "Reaktor Supermaterii"
	icon_state = "engine_sm"

/area/engine/break_room
	name = "Lobby In??ynierii"
	icon_state = "engine_break"
	mood_bonus = 2
	mood_message = "<span class='nicegreen'>Ahhh, dobrze zrobi?? sobie przerw??.\n</span>"

/area/engine/gravity_generator
	name = "Pomieszczenie Generatora Grawitacji"
	icon_state = "grav_gen"
	clockwork_warp_allowed = FALSE
	clockwork_warp_fail = "The gravitons generated here could throw off your warp's destination and possibly throw you into deep space."

/area/engine/storage
	name = "In??ynieria Magazyn"
	icon_state = "engi_storage"

/area/engine/storage_shared
	name = "In??ynieria Wsp????dzielony Magazyn"
	icon_state = "engi_storage"

/area/engine/transit_tube
	name = "Tuba Przesy??owa"
	icon_state = "transit_tube"


//Solars

/area/solar
	requires_power = FALSE
	dynamic_lighting = DYNAMIC_LIGHTING_IFSTARLIGHT
	valid_territory = FALSE
	blob_allowed = FALSE
	flags_1 = NONE
	ambientsounds = ENGINEERING

/area/solar/fore
	name = "G??rne Panele S??oneczne"
	icon_state = "yellow"

/area/solar/aft
	name = "Dolne Panele S??oneczne"
	icon_state = "yellow"

/area/solar/aux/port
	name = "G??rne Dodatkowe Panele S??oneczne Bakburta"
	icon_state = "panelsA"

/area/solar/aux/starboard
	name = "G??rne Dodatkowe Panele S??oneczne Sterburta"
	icon_state = "panelsA"

/area/solar/starboard
	name = "Panele S??oneczne Sterburta"
	icon_state = "panelsS"

/area/solar/starboard/aft
	name = "Dolne Panele S??oneczne Sterburta"
	icon_state = "panelsAS"

/area/solar/starboard/fore
	name = "G??rne Panele S??oneczne Sterburta"
	icon_state = "panelsFS"

/area/solar/port
	name = "Panele S??oneczne Bakburta"
	icon_state = "panelsP"

/area/solar/port/aft
	name = "Dolne Panele S??oneczne Bakburta"
	icon_state = "panelsAP"

/area/solar/port/fore
	name = "G??rne Panele S??oneczne Bakburta"
	icon_state = "panelsFP"

/area/solar/aisat
	name = "Panele S??oneczne Satelita AI"
	icon_state = "yellow"

//Solar Maint

/area/maintenance/solars
	name = "Tunel Techniczny Panele S??oneczne"
	icon_state = "yellow"

/area/maintenance/solars/port
	name = "Tunel Techniczny Panele S??oneczne Bakburta"
	icon_state = "SolarcontrolP"

/area/maintenance/solars/port/aft
	name = "Dolny Tunel Techniczny Panele S??oneczne Bakburta"
	icon_state = "SolarcontrolAP"

/area/maintenance/solars/port/fore
	name = "G??rny Tunel Techniczny Panele S??oneczne Bakburta"
	icon_state = "SolarcontrolFP"

/area/maintenance/solars/starboard
	name = "Tunel Techniczny Panele S??oneczne Sterburta"
	icon_state = "SolarcontrolS"

/area/maintenance/solars/starboard/aft
	name = "Dolny Tunel Techniczny Panele S??oneczne Sterburta"
	icon_state = "SolarcontrolAS"

/area/maintenance/solars/starboard/fore
	name = "G??rny Tunel Techniczny Panele S??oneczne Sterburta"
	icon_state = "SolarcontrolFS"

//Teleporter

/area/teleporter
	name = "Pomieszczenie Teleportera"
	icon_state = "teleporter"
	ambientsounds = ENGINEERING

/area/gateway
	name = "Brama"
	icon_state = "gateway"
	ambientsounds = ENGINEERING

//MedBay

/area/medical
	name = "Szpital"
	icon_state = "medbay1"
	ambientsounds = MEDICAL
	mood_bonus = 2
	mood_message = "<span class='nicegreen'>I feel safe in here!\n</span>"
	lighting_colour_tube = "#e7f8ff"
	lighting_colour_bulb = "#d5f2ff"
	mood_message = "<span class='nicegreen'>Czuj?? si?? tutaj bezpiecznie!\n</span>"

/area/medical/abandoned
	name = "Opuszczony Szpital"
	icon_state = "abandoned_medbay"
	ambientsounds = list('sound/ambience/signal.ogg')

/area/medical/medbay/central
	name = "Szpital G??owny"
	icon_state = "med_central"

/area/medical/medbay/lobby
	name = "Szpital Hol"
	icon_state = "med_lobby"

	//Medbay is a large area, these additional areas help level out APC load.

/area/medical/medbay/zone2
	name = "Szpital"
	icon_state = "medbay2"

/area/medical/medbay/aft
	name = "Szpital G??rny"
	icon_state = "med_aft"

/area/medical/storage
	name = "Szpital Magazyn"
	icon_state = "med_storage"

/area/medical/paramedic
	name = "Pomieszczenie Ratownik??w Medycznych"
	icon_state = "paramedic"

/area/medical/office
	name = "Gabinet Medyczny"
	icon_state = "med_office"

/area/medical/surgery/room_c
	name = "Sala Operacyjna C"
	icon_state = "surgery"

/area/medical/surgery/room_d
	name = "Sala Operacyjna D"
	icon_state = "surgery"

/area/medical/break_room
	name = "Szpital Pok??j Socjalny"
	icon_state = "med_break"

/area/medical/coldroom
	name = "Szpital Ch??odnia"
	icon_state = "kitchen_cold"

/area/medical/patients_rooms
	name = "Pokoje Pacjent??w"
	icon_state = "patients"

/area/medical/patients_rooms/room_a
	name = "Pok??j Pacjenta A"
	icon_state = "patients"

/area/medical/patients_rooms/room_b
	name = "Pok??j Pacjenta B"
	icon_state = "patients"

/area/medical/virology
	name = "Wirologia"
	icon_state = "virology"
	flags_1 = NONE

/area/medical/morgue
	name = "Kostnica"
	icon_state = "morgue"
	ambientsounds = SPOOKY
	mood_bonus = -2
	mood_message = "<span class='nicegreen'>It smells like death in here!\n</span>"

/area/medical/chemistry
	name = "Chemia"
	icon_state = "chem"

/area/medical/apothecary
	name = "Aptekarz"
	icon_state = "apothecary"

/area/medical/pharmacy
	name = "Farmaceutyka"
	icon_state = "pharmacy"

/area/medical/surgery
	name = "Chirurgia"
	icon_state = "surgery"

/area/medical/surgery/room_b
	name = "Sala Operacyjna B"
	icon_state = "surgery"

/area/medical/cryo
	name = "Kriogenika"
	icon_state = "cryo"

/area/medical/exam_room
	name = "Pomieszczenie Egzaminacyjne"
	icon_state = "exam_room"

/area/medical/genetics
	name = "Laboratorium Genetyczne"
	icon_state = "genetics"

/area/medical/genetics/cloning
	name = "Cloning Lab"
	icon_state = "cloning"

/area/medical/sleeper
	name = "Sala Medyczna"
	icon_state = "exam_room"

/area/medical/psychology
	name = "Biuro Psychologa"
	icon_state = "psychology"
	mood_bonus = 3
	mood_message = "<span class='nicegreen'>Czuj??, ??e kto?? wreszcie mnie rozumie.\n</span>"

//Security

/area/security
	name = "Ochrona"
	icon_state = "security"
	ambientsounds = HIGHSEC
	lighting_colour_tube = "#ffeee2"
	lighting_colour_bulb = "#ffdfca"

/area/security/main
	name = "Biuro Ochrony"
	icon_state = "security"

/area/security/brig
	name = "Areszt"
	icon_state = "brig"
	mood_bonus = -3
	mood_message = "<span class='nicegreen'>Nienawidz?? ciasnych cel w areszcie.\n</span>"

/area/security/brig/upper
	name = "G??rny Areszt"

/area/security/courtroom
	name = "Sala S??dowa"
	icon_state = "courtroom"

/area/security/prison
	name = "Skrzyd??o Wi??zienne"
	icon_state = "sec_prison"

/area/security/prison/toilet //radproof
	name = "Wi??zienie Toaleta"
	icon_state = "sec_prison_safe"

/area/security/prison/safe //radproof
	name = "Cele Wi??zienne"
	icon_state = "sec_prison_safe"

/area/security/prison/upper
	name = "G??rne Skrzyd??o Wi??zienne"
	icon_state = "prison_upper"

/area/security/prison/visit
	name = "Pomieszczenie Odwiedzin"
	icon_state = "prison_visit"

/area/security/prison/rec
	name = "Wi??zienna Sala Przes??ucha??"
	icon_state = "prison_rec"

/area/security/prison/mess
	name = "Wi??zienie Hol"
	icon_state = "prison_mess"

/area/security/prison/work
	name = "Wi??zienie Warsztat"
	icon_state = "prison_work"

/area/security/prison/shower
	name = "Wi??zienie Prysznic"
	icon_state = "prison_shower"

/area/security/prison/workout
	name = "Wi??zienie Si??ownia"
	icon_state = "prison_workout"

/area/security/prison/garden
	name = "Wi??zienie Ogr??d"
	icon_state = "prison_garden"

/area/security/prison/toilet
	name = "Wi??zienie Toaleta"
	icon_state = "sec_prison"

/area/security/processing
	name = "Prom Kolonia Karna"
	icon_state = "sec_processing"

/area/security/processing/cremation
	name = "Ochrona Krematorium"
	icon_state = "sec_cremation"

/area/security/warden
	name = "Dow??dztwo Aresztu"
	icon_state = "warden"

/area/security/detectives_office
	name = "Biuro Detektywa"
	icon_state = "detective"
	ambientsounds = list('sound/ambience/ambidet1.ogg','sound/ambience/ambidet2.ogg')

/area/security/detectives_office/private_investigators_office
	name = "Biuro Prywatnego Detektywa"
	icon_state = "investigate_office"

/area/security/range
	name = "Strzelnica"
	icon_state = "firingrange"

/area/security/execution
	icon_state = "execution_room"
	mood_bonus = -5
	mood_message = "<span class='nicegreen'>I feel a sense of impending doom.\n</span>"

/area/security/execution/transfer
	name = "Centrum Transferowe"
	icon_state = "sec_processing"

/area/security/execution/education
	name = "Sala Edukacji Wi????ni??w"

/area/security/nuke_storage
	name = "Skarbiec"
	icon_state = "nuke_storage"

/area/ai_monitored/nuke_storage
	name = "Skarbiec"
	icon_state = "nuke_storage"

/area/security/checkpoint
	name = "Punkt Kontrolny Ochrony"
	icon_state = "checkpoint1"

/area/security/checkpoint/auxiliary
	icon_state = "checkpoint_aux"

/area/security/checkpoint/escape
	icon_state = "checkpoint_esc"

/area/security/checkpoint/supply
	name = "Posterunek Ochrony - ??adownia"
	icon_state = "checkpoint_supp"

/area/security/checkpoint/engineering
	name = "Posterunek Ochrony - In??ynieria"
	icon_state = "checkpoint_engi"

/area/security/checkpoint/medical
	name = "Posterunek Ochrony - Szpital"
	icon_state = "checkpoint_med"

/area/security/checkpoint/science
	name = "Posterunek Ochrony - Wydzia?? Naukowy"
	icon_state = "checkpoint_sci"

/area/security/checkpoint/science/research
	name = "Posterunek Ochrony - Wydzia?? Naukowy"
	icon_state = "checkpoint_res"

/area/security/checkpoint/customs
	name = "Urz??d Celny"
	icon_state = "customs_point"

/area/security/checkpoint/customs/auxiliary
	icon_state = "customs_point_aux"

//Service

/area/quartermaster
	name = "Kwatermistrza"
	icon_state = "quart"
	lighting_colour_tube = "#ffe3cc"
	lighting_colour_bulb = "#ffdbb8"

/area/quartermaster/sorting
	name = "Biuro Pocztowe"
	icon_state = "cargo_delivery"

/area/quartermaster/warehouse
	name = "Magazyn"
	icon_state = "cargo_warehouse"

/area/quartermaster/warehouse/upper
	name = "G??rny Magazyn"

/area/quartermaster/office
	name = "Biuro ??adowni"
	icon_state = "cargo_office"

/area/quartermaster/storage
	name = "Strefa Za??adunku"
	icon_state = "cargo_bay"

/area/quartermaster/qm
	name = "Biuro Kwatermistrza"
	icon_state = "quart_office"

/area/quartermaster/qm/perch
	name = "Punkt Obserwacyjny Kwatermistrza"
	icon_state = "quart_perch"

/area/quartermaster/miningdock
	name = "Dok G??rniczy"
	icon_state = "mining"

/area/quartermaster/miningoffice
	name = "Biuro G??rnicze"
	icon_state = "mining"

/area/janitor
	name = "Schowek Sprz??tacza"
	icon_state = "janitor"
	flags_1 = NONE
	mood_bonus = -1
	mood_message = "<span class='nicegreen'>It feels dirty in here!\n</span>"

/area/hydroponics
	name = "Hydroponika"
	icon_state = "hydro"

/area/hydroponics/upper
	name = "G??rna Hydroponika"
	icon_state = "hydro"

/area/hydroponics/garden
	name = "Ogr??d"
	icon_state = "garden"
	mood_bonus = 2
	mood_message = "<span class='nicegreen'>It's so peaceful in here!\n</span>"

/area/hydroponics/garden/abandoned
	name = "Opuszczony Ogr??d"
	icon_state = "abandoned_garden"

/area/hydroponics/garden/monastery
	name = "Ogr??d Klasztoru"
	icon_state = "hydro"


//Science

/area/science
	name = "Wydzia?? Badawczy"
	icon_state = "toxlab"
	lighting_colour_tube = "#f0fbff"
	lighting_colour_bulb = "#e4f7ff"

/area/science/lab
	name = "Badania i Rozw??j"
	icon_state = "research"

/area/science/xenobiology
	name = "Laboratorium Ksenobiologii"
	icon_state = "xenobio"

/area/science/storage
	name = "Przechowalnia Toksyn"
	icon_state = "tox_storage"

/area/science/test_area
	valid_territory = FALSE
	name = "Obszar Testowania Toksyn"
	icon_state = "tox_test"

/area/science/mixing
	name = "Laboratorium Fuzji Toksyn"
	icon_state = "tox_mix"

/area/science/mixing/chamber
	name = "Komora Fuzji Toksyn"
	icon_state = "tox_mix_chamber"
	valid_territory = FALSE

/area/science/genetics
	name = "Laboratorium Genetyczne"
	icon_state = "geneticssci"

/area/science/misc_lab
	name = "Laboratorium Testowe"
	icon_state = "tox_misc"

/area/science/misc_lab/range
	name = "Obszar Testowania Wynalazk??w"
	icon_state = "tox_range"

/area/science/server
	name = "Serwerownia Wydzia??u Badawczego"
	icon_state = "server"

/area/science/explab
	name = "Laboratorium Eksperymentalne"
	icon_state = "exp_lab"

/area/science/robotics
	name = "Robotyka"
	icon_state = "robotics"

/area/science/robotics/mechbay
	name = "Zatoka Mech??w"
	icon_state = "mechbay"

/area/science/robotics/lab
	name = "Laboratorium Robotyki"
	icon_state = "ass_line"

/area/science/research
	name = "Wydzia?? Badawczy"
	icon_state = "science"

/area/science/research/abandoned
	name = "Opuszczone Laboratorium Badawcze"
	icon_state = "abandoned_sci"

/area/science/nanite
	name = "Laboratorium Nanitowe"
	icon_state = "nanite"

/area/xenoarch
	icon = 'icons/obj/xenoarch/areas.dmi'
	icon_state = "xenogen"
	has_gravity = STANDARD_GRAVITY

/area/xenoarch/arch
	name = "Ksenoarcheologia"
	icon_state = "xenoarch"

/area/xenoarch/bot
	name = "Ksenoarcheologia Botanika"
	icon_state = "xenobot"

/area/xenoarch/eng
	name = "Ksenoarcheologia In??ynieria"
	icon_state = "xenoeng"

/area/xenoarch/gen
	name = "Ksenoarcheologia Pomieszczenia Mieszkalne"
	icon_state = "xenogen"

/area/xenoarch/sec
	name = "Xenoarchaeology Security"
	icon_state = "xenosec"

/area/science/shuttledock
	name = "Science Shuttle Dock"
	icon_state = "toxmisc"

//Storage

/area/storage/tools
	name = "Dodatkowy Sk??ad Narz??dziowy"
	icon_state = "tool_storage"

/area/storage/primary
	name = "G????wny Sk??ad Narz??dziowy"
	icon_state = "primary_storage"

/area/storage/art
	name = "Sk??ad Przybor??w Plastycznych"
	icon_state = "art_storage"

/area/storage/tcom
	name = "Sk??ad Urz??dze?? Telekomunikacyjnych"
	icon_state = "tcom"
	valid_territory = FALSE

/area/storage/eva
	name = "Sk??ad EVA"
	icon_state = "eva"
	clockwork_warp_allowed = FALSE

/area/storage/emergency/starboard
	name = "Sk??ad Ratunkowy Sterburta"
	icon_state = "emergency_storage"

/area/storage/emergency/port
	name = "Sk??ad Ratunkowy Bakburta"
	icon_state = "emergency_storage"

/area/storage/tech
	name = "Sk??ad Techniczny"
	icon_state = "aux_storage"

/area/storage/mining
	name = "Publiczny Sk??ad G??rniczy"
	icon_state = "mining"

//Construction

/area/construction
	name = "Strefa Budowlana"
	icon_state = "construction"
	ambientsounds = ENGINEERING

/area/construction/mining/aux_base
	name = "Strefa Budowlana Bazy Dodatkowej"
	icon_state = "aux_base_construction"

/area/construction/storage_wing
	name = "Skrzyd??o Magazynowe"
	icon_state = "storage_wing"

// Vacant Rooms
/area/vacant_room
	name = "Wolne Pomieszczenie"
	icon_state = "vacant_room"
	ambientsounds = MAINTENANCE
	icon_state = "vacant_room"

/area/vacant_room/office
	name = "Wolne Biuro"
	icon_state = "vacant_office"

/area/vacant_room/commissary
	name = "Wolna Kantyna"
	icon_state = "vacant_commissary"

//AI

/area/ai_monitored/security/armory
	name = "Zbrojownia"
	icon_state = "armory"
	ambientsounds = HIGHSEC

/area/ai_monitored/security/armory/upper
	name = "G??rna Zbrojownia"

/area/ai_monitored/storage/eva
	name = "Sk??ad EVA"
	icon_state = "eva"
	ambientsounds = HIGHSEC

/area/ai_monitored/storage/satellite
	name = "AI Satellite Maint"
	icon_state = "storage"

/area/ai_monitored/storage/eva/upper
	name = "G??rny Sk??ad EVA"

/area/ai_monitored/storage/satellite
	name = "Tunel Techniczny Satelity AI"
	icon_state = "ai_storage"
	ambientsounds = HIGHSEC

	//Turret_protected

/area/ai_monitored/turret_protected
	ambientsounds = list('sound/ambience/ambimalf.ogg', 'sound/ambience/ambitech.ogg', 'sound/ambience/ambitech2.ogg', 'sound/ambience/ambiatmos.ogg', 'sound/ambience/ambiatmos2.ogg')

/area/ai_monitored/turret_protected/ai_upload
	name = "Komora Zgrywania AI"
	icon_state = "ai_upload"

/area/ai_monitored/turret_protected/ai_upload_foyer
	name = "??luza Komory Zgrywania AI"
	icon_state = "ai_upload_foyer"

/area/ai_monitored/turret_protected/ai
	name = "Komora AI"
	icon_state = "ai_chamber"

/area/ai_monitored/turret_protected/aisat
	name = "Satelita AI"
	icon_state = "ai"

/area/ai_monitored/turret_protected/aisat/atmos
	name = "Satelita AI Atmosferyka"
	icon_state = "ai"

/area/ai_monitored/turret_protected/aisat/foyer
	name = "Satelita AI Hol"
	icon_state = "ai_foyer"

/area/ai_monitored/turret_protected/aisat/service
	name = "Satelita AI Serwis"
	icon_state = "ai"

/area/ai_monitored/turret_protected/aisat/hallway
	name = "Satelita AI Korytarz"
	icon_state = "ai"

/area/aisat
	name = "Satelita AI Pow??oka"
	icon_state = "ai"

/area/ai_monitored/turret_protected/aisat_interior
	name = "Satelita AI Wej??cie"
	icon_state = "ai_interior"

/area/ai_monitored/turret_protected/AIsatextAS
	name = "Satelita AI Wyj??cie"
	icon_state = "ai_sat_east"

/area/ai_monitored/turret_protected/AIsatextAP
	name = "Satelita AI Wyj??cie"
	icon_state = "ai_sat_west"


// Telecommunications Satellite

/area/tcommsat
	clockwork_warp_allowed = FALSE
	clockwork_warp_fail = "For safety reasons, warping here is disallowed; the radio and bluespace noise could cause catastrophic results."
	ambientsounds = list('sound/ambience/ambisin2.ogg', 'sound/ambience/signal.ogg', 'sound/ambience/signal.ogg', 'sound/ambience/ambigen10.ogg', 'sound/ambience/ambitech.ogg',\
											'sound/ambience/ambitech2.ogg', 'sound/ambience/ambitech3.ogg', 'sound/ambience/ambimystery.ogg')

/area/tcommsat/computer
	name = "Pomieszczenie Kontrolne Telekomunikacji"
	icon_state = "tcomsatcomp"

/area/tcommsat/server
	name = "Serwerownia Telekomunikacji"
	icon_state = "tcomsatcham"

/area/tcommsat/server/upper
	name = "G??rna Serwerownia Telekomunikacji"

//External Hull Access
/area/maintenance/external
	name = "??luza Zewn??trznej Pow??oki"
	icon_state = "amaint"

/area/maintenance/external/aft
	name = "Dolna ??luza Zewn??trznej Pow??oki"

/area/maintenance/external/port
	name = "??luza Zewn??trznej Pow??oki Bakburta"

/area/maintenance/external/port/bow
	name = "G??rna ??luza Zewn??trznej Pow??oki Bakburta"

//Spacepods

/area/escapepodbay
	name = "Hol hangaru kapsu?? ratunkowych"
	icon_state = "escape"

/area/security/podbay
	name = "Hangar kapsu?? kosmicznych ochrony"
	icon_state = "security"

/area/mining_level_access
  	name = "Mining Level Access"
  	icon = 'icons/turf/areas.dmi'
  	icon_state = "milevel"
  	requires_power = FALSE
  	has_gravity = STANDARD_GRAVITY
  	dynamic_lighting = DYNAMIC_LIGHTING_FORCED

/area/mining_level_access/lower
	name = "Lower Mining Level Access"

/area/mining_level_access/upper
	name = "Upper Mining Level Access"
