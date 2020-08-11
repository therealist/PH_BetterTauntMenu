--//-------------------------------------------------------------------
--//
--//	DISTRO: 		Better Taunt Menu
--//	AUTHORS:		Vash Baldeus, Sean Hayes
--//	BASE:			AMT Prop Hunt
--//	BUILD:			v2.0
--//	RELEASE:		08.11.2020
--//	LICENSED TO:	GNU Public v3.0
--//				
--//	> phtm_client.lua
--//	This file contains the client-side code for the
--//	Prop Hunt taunt menu.
--//
--//-------------------------------------------------------------------

if ( CLIENT) then
--// Chat message
	timer.Create("TauntMenuUse",120,0, function()
											chat.AddText(Color(255,50,0),"[Taunt Menu]", Color(120,200,255)," To open the menu press F3, or Fn + F3. Press C to random taunt.")
										end)

--// INIT PARAMETERS
	local ButtonTextColor	=	Color(255,255,255,255)
	local pl				=	LocalPlayer();			--// Assign pl as LocalPlayer().
	pl.MenuOpen				=	0;						--// Set for player MenuOpen to 0 by default.
	pl.MenuPage2			=	0;						--// Set for player MenuPage3 to 0 by default
	pl.MenuPage3			=	0;						--// Set for player MenuPage3 to 0 by default
	pl.hMenuPage2			=	0;						--// Unused
	pl.hMenuPage3			=	0;						--// Unused
	bn 						= 	0						--// Initialize button number
	pn 						= 	1						--// Initialize page number
	menutoggle 				= 	1						--// Initialize menu as closed
	STORED_TAUNTS 			= 	5						--// Sets the number of played taunts to be stored
	sort					=	true					--// Sort from shortest to longest
	propplayedtaunts 		= 	{}						--// Initializes the stored Prop played taunts
	hunterplayedtaunts 		= 	{}						--// Initializes the stored Hunter played taunts

--// TAUNT LIST TABLE (see sv_lengthfinder for further instructions)
--// FORMAT: {"Button Name", "path/to/file.wav", 0.00000000},
--// Tabulation shows properly on Notepad++
--// Prop Taunt List (not needed if set as a global table in Prop Hunt sh_config file)
local proplist = {
	{"Homer Doh",							"rlg/taunts/props/2.wav", 							0.7494784593582},
	{"Go away or I shall taunt",			"rlg/taunts/props/3.wav", 							3.7144670486450},
	{"Shamwow",								"rlg/taunts/props/4.wav", 							4.0671200752258},
	{"Negative",							"rlg/taunts/props/5.wav", 							1.5319727659225},
	{"Over 9000",							"rlg/taunts/props/6.wav", 							7.0253062248230},
	{"LEROY JENKINS",						"rlg/taunts/props/7.wav", 							4.4251246452332},
	{"Please come again",					"rlg/taunts/props/8.wav", 							0.8919727802276},
	{"THIS IS SPARTA!",						"rlg/taunts/props/9.wav", 							2.9344217777252},
	{"What is wrong with you?",				"rlg/taunts/props/10.wav", 							2.0429933071136},
	{"Woohoo!",								"rlg/taunts/props/11.wav", 							0.7604535222053},
	{"Bill Cosby Pokeman",					"rlg/taunts/props/12.wav", 							4.0062584877014},
	{"Utorunaga Weeu!",						"rlg/taunts/props/14.wav", 							3.0719275474548},
	{"Snooping as usual I see?",			"rlg/taunts/props/15.wav", 							3.1919274330139},
	{"Aaah",								"rlg/taunts/props/17.mp3", 							10.893061637878},
	{"Get on the ball!",					"rlg/taunts/props/18.wav", 							1.0763719081879},
	{"Car horn",							"rlg/taunts/props/19.wav", 							1.0405442714691},
	{"Are you on the ball?",				"rlg/taunts/props/20.wav", 							1.1058503389359},
	{"Military Forces Eliminated",			"rlg/taunts/props/30.wav", 							2.0302948951721},
	{"Inner Circle Bad Boys",				"rlg/taunts/props/31.mp3", 							11.363265037537},
	{"Blood Rave",							"rlg/taunts/props/32.mp3", 							10.657958984375},
	{"Eric Prydz Call on Me",				"rlg/taunts/props/33.mp3", 							7.7583675384521},
	{"AoE 2 Healer",						"rlg/taunts/props/35.mp3", 							1.5151020288467},
	{"You call that a gun?",				"rlg/taunts/props/agun.mp3", 						1.8808163404465},
	{"MGS Alert",							"rlg/taunts/props/alert2.mp3", 						2.0897958278656},
	{"Tourette's Guy: All you do",			"rlg/taunts/props/allyoueverdo.mp3", 				6.0342855453491},
	{"Pirates: Almost caught...",			"rlg/taunts/props/almostcaught.mp3", 				6.2693877220154},
	{"My anus is bleeding!",				"rlg/taunts/props/anusisbleeding.mp3", 				2.7689795494080},
	{"Archer: Bloody Mary",					"rlg/taunts/props/arch_bloody.mp3", 				12.512653350830},
	{"Archer: Danger Zone",					"rlg/taunts/props/arch_dz.mp3", 					10.710204124451},
	{"Skyrim: Arrow to the Knee",			"rlg/taunts/props/arrowtotheknee.mp3", 				6.0081634521484},
	{"I'm an attention whore!",				"rlg/taunts/props/attentionwhore.mp3", 				6.0865306854248},
	{"Balls of steel",						"rlg/taunts/props/balls.mp3", 						2.4032652378082},
	{"Bananaphone",							"rlg/taunts/props/bananasong.mp3", 					5.4857144355774},
	{"SFA: Do a barrel roll!",				"rlg/taunts/props/barrelroll.mp3", 					1.1493877172470},
	{"TF2 Soldier: Beep boop, son.",		"rlg/taunts/props/beepboopson.mp3", 				2.2204082012177},
	{"Psychostick Beer",					"rlg/taunts/props/beer1.mp3", 						23.144489288330},
	{"Not the bees!",						"rlg/taunts/props/bees1.mp3", 						3.7093877792358},
	{"Yackety Sax",							"rlg/taunts/props/bennyhill.mp3", 					34.925712585449},
	{"Big Booty Bitches",					"rlg/taunts/props/bigbootybitches.mp3", 			24.163265228271},
	{"Blow it out your ass!",				"rlg/taunts/props/blow_it.mp3", 					1.5934693813324},
	{"Boi-oi-oing!",						"rlg/taunts/props/boioing.mp3", 					2.2987754344940},
	{"Bollocks to you!",					"rlg/taunts/props/bollockstoyou.mp3", 				0.8881632685661},
	{"A whole lotta fucks",					"rlg/taunts/props/boondocksaints.mp3", 				9.7697963714600},
	{"Tim Wilson Booty Man",				"rlg/taunts/props/booty.mp3", 						6.2693877220154},
	{"Bug off, you wanker!",				"rlg/taunts/props/bugoff.mp3", 						1.3844897747040},
	{"Just a bunch of pansies",				"rlg/taunts/props/bunchofpansies.mp3", 				3.0040817260742},
	{"Busted Daytona stripper",				"rlg/taunts/props/bustedstripper.mp3", 				2.7167346477509},
	{"Apollo 440 Can't Stop the Rock",		"rlg/taunts/props/cantstoptherock.mp3", 			16.822856903076},
	{"Carl, that kills people!",			"rlg/taunts/props/carl.mp3", 						2.5338776111603},
	{"Suck my balls",						"rlg/taunts/props/cartmansuck.mp3", 				2.9779591560364},
	{"Old Nokia cell phone",				"rlg/taunts/props/cell.mp3", 						3.8138775825500},
	{"Archer: Hookers",						"rlg/taunts/props/ch3.mp3", 						6.8963265419006},
	{"Trumpet: Charge!",					"rlg/taunts/props/charge.mp3", 						4.8326530456543},
	{"Cheese!",								"rlg/taunts/props/cheese.mp3", 						1.2799999713898},
	{"MetalGearAwesome Phone",				"rlg/taunts/props/codec2.mp3", 						2.1942856311798},
	{"Come get some",						"rlg/taunts/props/come_get_some.mp3", 				1.6457142829895},
	{"Coolest fucking story",				"rlg/taunts/props/coolest.mp3", 					5.0677552223206},
	{"I am Cornholio",						"rlg/taunts/props/cornholio.mp3", 					3.9183673858643},
	{"Bart: It got even crappier",			"rlg/taunts/props/crappier.mp3", 					2.5599999427795},
	{"Minecraft creeper explode",			"rlg/taunts/props/creeperboom.mp3", 				5.6163263320923},
	{"My disguise is too cunning",			"rlg/taunts/props/cunning.mp3", 					4.4930610656738},
	{"I can dance all day",					"rlg/taunts/props/danceallday.mp3", 				3.9444897174835},
	{"Ken Sebben: Dangly parts",			"rlg/taunts/props/danglyparts.mp3", 				2.9257142543793},
	{"Denied",								"rlg/taunts/props/denied.mp3", 						1.4106122255325},
	{"Bohemian Mtn Dew Rhapsody",			"rlg/taunts/props/dew.mp3", 						8.2808160781860},
	{"Homer - Doh",							"rlg/taunts/props/doh.mp3", 						0.6530612111091},
	{"Don't just stand there...",			"rlg/taunts/props/dontjuststandthere.mp3", 			3.0563266277313},
	{"Don't miss",							"rlg/taunts/props/dontmiss.mp3", 					1.6718367338181},
	{"Everybody do the flop!",				"rlg/taunts/props/dotheflop.mp3", 					2.6122448444366},
	{"Up, Left and Right Syndrome",			"rlg/taunts/props/downsyndrome.mp3", 				6.7395915985107},
	{"Do you smoke cigarettes or eat",		"rlg/taunts/props/doyousmoke.mp3", 					2.8995919227600},
	{"Surrounded by idiots",				"rlg/taunts/props/dr_evil-frickin_idiots.mp3", 		4.5191836357117},
	{"It hungers for more!",				"rlg/taunts/props/drweird.mp3", 					9.2995920181274},
	{"Captain Jean-Luc Picard song",		"rlg/taunts/props/enterprise.mp3", 					8.0718364715576},
	{"Epic Sax Guy",						"rlg/taunts/props/epicsaxguy.mp3", 					7.4187755584717},
	{"So fucking extreme!",					"rlg/taunts/props/extreme.mp3", 					2.9779591560364},
	{"Fuck you and your eyebrows!",			"rlg/taunts/props/eyebrow.mp3", 					3.6310203075409},
	{"Sad trombone",						"rlg/taunts/props/fail.mp3", 						3.6310203075409},
	{"I'ma firin' mah lazah!",				"rlg/taunts/props/firinmahlazah.mp3", 				16.117551803589},
	{"Foamy: Disappointment",				"rlg/taunts/props/foamydisappointment.mp3", 		2.5338776111603},
	{"Foamy: Suck ass",						"rlg/taunts/props/foamysuckass.mp3", 				5.4857144355774},
	{"Fork in the Garbage Disposal",		"rlg/taunts/props/forkinthegarbagedisposal.mp3", 	9.7436733245850},
	{"Fart song",							"rlg/taunts/props/fs.mp3", 							19.069387435913},
	{"MGA: Fucking fair",					"rlg/taunts/props/fuckingfair.mp3", 				2.0375509262085},
	{"Tourette's Guy: Fuck Salt",			"rlg/taunts/props/fucksalt.mp3", 					1.1755101680756},
	{"Epic Meal Time: Gay Bacon...",		"rlg/taunts/props/gaybaconstrips.mp3", 				2.7428572177887},
	{"Get away from me, bitch!",			"rlg/taunts/props/getawayfromme.mp3", 				1.4106122255325},
	{"JB Get Up Offa That Thing",			"rlg/taunts/props/getupoffathatthing.mp3", 			16.169795989990},
	{"Gimme Dat Butt!",						"rlg/taunts/props/gimmedatbutt.mp3", 				9.8481636047363},
	{"Hide-and-Go-Fuck-Yourself",			"rlg/taunts/props/gofuckurself.mp3", 				3.9706122875214},
	{"Go Team Retard",						"rlg/taunts/props/goteamretard.mp3", 				1.3322448730469},
	{"Breen HAAX!",							"rlg/taunts/props/haax.mp3", 						2.2204082012177},
	{"Head-On advert",						"rlg/taunts/props/headon2.mp3", 					6.8963265419006},
	{"Hello, chum!",						"rlg/taunts/props/hellochum.mp3", 					1.0448979139328},
	{"Here's Johnny!",						"rlg/taunts/props/heresjohnny.mp3", 				1.8808163404465},
	{"Hi, bitch",							"rlg/taunts/props/hibitch.mp3", 					5.4857144355774},
	{"How do you fuck that up?",			"rlg/taunts/props/howdoyoufuckthatup.mp3", 			1.4367346763611},
	{"I am a banana!",						"rlg/taunts/props/iamabanana.mp3", 					3.5526530742645},
	{"Soldier: I am Bilbo",					"rlg/taunts/props/iambilbo.mp3", 					4.8587756156921},
	{"B2M I Believe I Can Fly",				"rlg/taunts/props/ibelieveicanfly.mp3", 			15.830204010010},
	{"ICP Hokus Pokus",						"rlg/taunts/props/icphokuspokus.mp3", 				2.6383674144745},
	{"SM-A-L Baby Got Back",				"rlg/taunts/props/ilikebigbutts.mp3", 				18.024490356445},
	{"I make this look good",				"rlg/taunts/props/imakethislookgood.mp3", 			6.7395915985107},
	{"Situtaion has not improved",			"rlg/taunts/props/improved.mp3", 					2.5077550411224},
	{"I'm the map!",						"rlg/taunts/props/imthemap.mp3", 					6.2955102920532},
	{"Good thing I'm indestructible",		"rlg/taunts/props/indestructible.mp3", 				2.4555101394653},
	{"Anchorman: Whore island",				"rlg/taunts/props/island.mp3", 						2.9518368244171},
	{"Ackbar: It's a trap!",				"rlg/taunts/props/its_a_trap.mp3", 					1.3844897747040},
	{"It's so fluffeh!",					"rlg/taunts/props/itssofluffeh.mp3", 				1.6718367338181},
	{"MGA: Throw grenades at me",			"rlg/taunts/props/justthrowgrenades.mp3", 			1.2016326189041},
	{"Kalluri Vaanil (Benny Lava)",			"rlg/taunts/props/kallurivaanil.mp3", 				27.637550354004},
	{"Kick ass and chew bubblegum",			"rlg/taunts/props/kick_ass_and_chew_bubblegum.mp3",	4.8587756156921},
	{"Knob off, you tosspot!",				"rlg/taunts/props/knoboff.mp3", 					1.6195918321609},
	{"Patrick Star: Leedle",				"rlg/taunts/props/leedle.mp3", 						1.8808163404465},
	{"Let's dance, dickweed",				"rlg/taunts/props/letsdance.mp3", 					1.8285714387894},
	{"Look at the screen, dumb shit",		"rlg/taunts/props/lookatscreen.mp3", 				2.9779591560364},
	{"You are one pathetic loser",			"rlg/taunts/props/loser.mp3", 						4.3885712623596},
	{"Losing horn",							"rlg/taunts/props/losinghorn.mp3", 					4.6497960090637},
	{"Lionel Richie Hello",					"rlg/taunts/props/lrtaunt1.mp3", 					18.834285736084},
	{"Stop trying to hit me",				"rlg/taunts/props/matrix1.mp3", 					2.2987754344940},
	{"MC Chris: RE4 vs. KH",				"rlg/taunts/props/mcchris.mp3", 					24.894693374634},
	{"MC Hammer Can't Touch This",			"rlg/taunts/props/mchammer.mp3", 					11.755102157593},
	{"Krieg: Shiniest meat bicycle",		"rlg/taunts/props/meatbicycle.mp3", 				4.3885712623596},
	{"Scorpion: Get over here!",			"rlg/taunts/props/mk4_scorpion.mp3", 				1.9330612421036},
	{"More cowbell",						"rlg/taunts/props/morecowbell.mp3", 				3.9706122875214},
	{"Denny's Nannerpuss advert",			"rlg/taunts/props/nannerpuss.mp3", 					10.344490051270},
	{"I need to go piss soon...",			"rlg/taunts/props/needtopiss.mp3", 					2.8473470211029},
	{"Beetlejuice: Nice fuckin' model",		"rlg/taunts/props/nicemodel.mp3", 					2.3248980045319},
	{"Nigel: Aaaugh",						"rlg/taunts/props/nigelaaugh.mp3", 					2.2726531028748},
	{"My nipples explode with delight",		"rlg/taunts/props/nipplesexplode.mp3", 				2.0897958278656},
	{"Nixon Head: Shut up dammit!",			"rlg/taunts/props/nixonshutup.mp3", 				1.2016326189041},
	{"Metalocalypse: NOOO!",				"rlg/taunts/props/nooo.mp3", 						3.4481632709503},
	{"Makes a Man go NOOT NOOT",			"rlg/taunts/props/nootnoot.mp3", 					13.949387550354},
	{"Not Having Any Mayonnaise",			"rlg/taunts/props/nothavinganymayonnaise.mp3", 		2.2204082012177},
	{"MGA: Now to look at asses",			"rlg/taunts/props/nowtolookatasses.mp3", 			2.3510203361511},
	{"Tourette's Guy: Bob Saget!",			"rlg/taunts/props/ohbobsaget.mp3", 					1.9591836929321},
	{"Oh bugger...",						"rlg/taunts/props/ohbugger.mp3", 					1.0710203647614},
	{"Kook Aid Guy: Oh yeah!",				"rlg/taunts/props/ohnoohyeah.mp3", 					6.7918367385864},
	{"One of these kids is dead",			"rlg/taunts/props/oneofthesekids.mp3", 				4.3885712623596},
	{"Ow Ow Fuckity Ow!",					"rlg/taunts/props/owow.mp3", 						2.5599999427795},
	{"Ow what the shit was that?",			"rlg/taunts/props/owwhatthe.mp3", 					2.7689795494080},
	{"Pat you on the bottom",				"rlg/taunts/props/patbottom.mp3", 					4.6497960090637},
	{"Same thing we do every night",		"rlg/taunts/props/pinkyandthebrain.mp3", 			7.0530610084534},
	{"Just pissin' everybody off",			"rlg/taunts/props/pissin.mp3", 						3.4481632709503},
	{"Poop chute. Yeah.",					"rlg/taunts/props/poopchute.mp3", 					2.2204082012177},
	{"Krieg: Poop train",					"rlg/taunts/props/pooptrain.mp3", 					3.1608164310455},
	{"Predator noise",						"rlg/taunts/props/predator.mp3", 					6.7395915985107},
	{"Reach-around",						"rlg/taunts/props/reacharound.mp3", 				6.4522447586060},
	{"Reading Rainbow stinger",				"rlg/taunts/props/readingrainbow.mp3",				1.0710203647614},
	{"Ready to get fucked up",				"rlg/taunts/props/readytoget.mp3", 					2.5861225128174},
	{"There is no eleven!",					"rlg/taunts/props/redvsbluenoeleven.mp3", 			4.9893879890442},
	{"Robot Chicken ending theme",			"rlg/taunts/props/robotchicken.mp3", 				13.792653083801},
	{"Scatman John Scatman",				"rlg/taunts/props/scatman.mp3", 					16.378774642944},
	{"Scout: Nice try pal",					"rlg/taunts/props/scout1.mp3", 						0.9142857193946},
	{"Screaming sheep",						"rlg/taunts/props/screamgoat.mp3", 					2.0897958278656},
	{"Didn't see that coming",				"rlg/taunts/props/seethatcoming.mp3", 				1.7763265371323},
	{"Shit!",								"rlg/taunts/props/shit.mp3", 						1.1232652664185},
	{"I think he just shit himself",		"rlg/taunts/props/shithimself.mp3", 				15.542857170105},
	{"Shoot me again, I ain't dead",		"rlg/taunts/props/shootmeagain.mp3", 				16.796733856201},
	{"JLJ Show Me Your Genitals",			"rlg/taunts/props/showmeyourgenitals.mp3", 			11.911836624146},
	{"Shun the non-believer!",				"rlg/taunts/props/shunthenonbeliever.mp3", 			7.8367347717285},
	{"Shut your fucking mouth!",			"rlg/taunts/props/shutyourfuckingmouth.mp3", 		1.4367346763611},
	{"You're too slow!",					"rlg/taunts/props/slow1.mp3", 						1.3322448730469},
	{"Super Mario Brothers Star",			"rlg/taunts/props/smb_star.mp3", 					10.318367004395},
	{"Gassy Mexican: I can smell you",		"rlg/taunts/props/smell_u.mp3", 					1.2799999713898},
	{"So long, losers!",					"rlg/taunts/props/solong.mp3", 						2.1942856311798},
	{"Spooky Scary Skeletons",				"rlg/taunts/props/spookyscaryskeletons.mp3", 		24.946939468384},
	{"Stop blowing holes in my ship!",		"rlg/taunts/props/stopblowingholes.mp3", 			2.7951021194458},
	{"Sucks to be me right now",			"rlg/taunts/props/suckstobeme.mp3", 				1.5673469305038},
	{"Homer: Sweet beer",					"rlg/taunts/props/sweetbeer1.wav", 					4.3053059577942},
	{"The Bad Touch",						"rlg/taunts/props/thebadtouch.mp3", 				14.942040443420},
	{"Dude... This is crazy!",				"rlg/taunts/props/thisiscrazy.mp3", 				2.0636734962463},
	{"THX sound",							"rlg/taunts/props/thx.mp3", 						13.688162803650},
	{"Damn, we're in a tight spot.",		"rlg/taunts/props/tightspot2.mp3", 					2.4032652378082},
	{"DAMN! we're in a TIGHT SPOT!",		"rlg/taunts/props/tightspot3.mp3", 					1.7763265371323},
	{"English, do you speak it?",			"rlg/taunts/props/ts_english.mp3", 					2.3771429061890},
	{"Vince: Gonna love my nuts",			"rlg/taunts/props/vincelovemynuts.mp3", 			1.2799999713898},
	{"W(NW) Walk the Dinosaur",				"rlg/taunts/props/walkdino.mp3", 					17.893877029419},
	{"Shit's weak",							"rlg/taunts/props/weak.mp3", 						1.5673469305038},
	{"...we'll know we're not dead",		"rlg/taunts/props/wellknowwerenotdead.mp3", 		8.3853063583374},
	{"We're here to fuck shit up",			"rlg/taunts/props/werehere.mp3", 					1.3583673238754},
	{"Haddaway What Is Love",				"rlg/taunts/props/whatislove.mp3", 					31.137958526611},
	{"What the fuck?",						"rlg/taunts/props/whatthefu.mp3", 					1.8285714387894},
	{"Whip Somebody's Ass song",			"rlg/taunts/props/whipsomebodysass.mp3", 			26.592653274536},
	{"Woohoo!",								"rlg/taunts/props/whoohoo.mp3", 					1.4628571271896},
	{"Strong Bad: Windows 98",				"rlg/taunts/props/win982.mp3", 						6.3477549552917},
	{"What the hell is wrong...",			"rlg/taunts/props/wrong.mp3", 						2.0375509262085},
	{"What the fuck is that?",				"rlg/taunts/props/wtf_fmj.mp3", 					1.7240816354752},
	{"You will never get this",				"rlg/taunts/props/you_will_never.mp3", 				4.1273469924927},
	{"Turret: You are a bitch",				"rlg/taunts/props/youareabitch.mp3", 				1.3583673238754},
	{"You got skills",						"rlg/taunts/props/yougotskills.mp3", 				1.9330612421036},
	{"You smell funny",						"rlg/taunts/props/yousmellfunny.mp3", 				1.4889795780182}
}

--// Hunter Taunt List (not needed if set as a global table in Prop Hunt sh_config file)
local hunterlist = {
	{"You can run, but can't hide",			"rlg/taunts/hunters/canthide.mp3", 					2.4032652378082},
	{"Come on just die already!",			"rlg/taunts/hunters/comeon.mp3", 					2.9779591560364},
	{"Crappy shot",							"rlg/taunts/hunters/crappyshot.mp3", 				3.9444897174835},
	{"Don't run we are your friends",		"rlg/taunts/hunters/donotrun.mp3", 					2.1420407295227},
	{"Cursage, foiled again!",				"rlg/taunts/hunters/foiledagain.mp3", 				1.5934693813324},
	{"Gonna kill all these fucks",			"rlg/taunts/hunters/gonnakill.mp3", 				2.7167346477509},
	{"Holy hand grenade",					"rlg/taunts/hunters/holyhandgrenade.mp3", 			6.7657141685486},
	{"I suck",								"rlg/taunts/hunters/isuck.mp3", 					1.2799999713898},
	{"B.O. deflected the bullet",			"rlg/taunts/hunters/missed.mp3", 					3.9706122875214},
	{"Turret: Oh my god",					"rlg/taunts/hunters/ohmygod.mp3", 					0.8097959160804},
	{"Oh no! We suck again!",				"rlg/taunts/hunters/ohnowesuckagain.mp3", 			3.1346938610077},
	{"Please fondle my bum",				"rlg/taunts/hunters/pleasefondle.mp3", 				1.8024489879608},
	{"I will look for you and kill you",	"rlg/taunts/hunters/taken-kill_you.mp3", 			6.2432651519775},
	{"Gotta lay off the peyote",			"rlg/taunts/hunters/thepeyote.mp3", 				2.1420407295227},
	{"You best watch your back",			"rlg/taunts/hunters/watchyourback.mp3", 			2.0114285945892},
	{"Who painted my ass white?",			"rlg/taunts/hunters/whopainted.mp3", 				2.3771429061890},
	{"Eat lead, pansy",						"rlg/taunts/hunters/eatlead.mp3", 					1.7763265371323},
	{"MGA: Getting pissed off",				"rlg/taunts/hunters/gettingpissedoff.mp3", 			3.2391836643219},
	{"DJango: Get winged",					"rlg/taunts/hunters/getwinged.mp3", 				8.6465301513672},
	{"Go on, go get them!",					"rlg/taunts/hunters/gogetthem.mp3", 				1.5934693813324},
	{"Holy fuck is this wrong!",			"rlg/taunts/hunters/holyfuckisthiswrong.mp3", 		4.1273469924927},
	{"Won't hurt you when I catch",			"rlg/taunts/hunters/hunterchase.mp3", 				3.0040817260742},
	{"Joker: Dog chasing cars",				"rlg/taunts/hunters/dogchasingcars.mp3", 			1.7240816354752},
	{"Scout: Owning you",					"rlg/taunts/hunters/owningyou1.mp3", 				2.9257142543793},
	{"It's showtime",						"rlg/taunts/hunters/showtime.mp3", 					1.5934693813324},
	{"Farkin' sneaky bastage",				"rlg/taunts/hunters/sneaky.mp3", 					3.8138775825500},
	{"Dr. Tran Toy Cack Geese",				"rlg/taunts/hunters/flockofgeese.mp3", 				6.0342855453491},
	{"Silence! I Kill You!",				"rlg/taunts/hunters/silenceikillyou.mp3", 			1.9591836929321},
	{"KRS One-Sound of Da Police",			"rlg/taunts/hunters/soundofdapolice.mp3", 			5.1722450256348}
}

	--//Checks if player alive & if menu is not open
	function IsAlive(pl)
		if ( pl:Alive() && pl.MenuOpen !=1 ) then
			if pl:Team() == TEAM_HUNTERS || pl:Team() == TEAM_PROPS then
				hook.Run("ptm",pl)
				p1_base:SetVisible(true)
				pl.MenuOpen=1;
			else
				chat.AddText(Color(214,0,0),"[Taunt Menu]", Color(0,225,126)," You must be in one of the teams to use the menu.")
			end
		elseif ( pl:Alive() && pl.MenuOpen !=0 ) then
			if pl:Team() == TEAM_HUNTERS || pl:Team() == TEAM_PROPS then
				hook.Remove("ptm",pl)
				p1_base:SetVisible(false)
				p1_base:Close()
				pl.MenuOpen=0;
			end
		else
			chat.AddText(Color(214,0,0),"[Taunt Menu]", Color(0,225,126)," You are dead, you need to be alive to use this.")--//Chat message for player.
		end	
	end
	
	--//Checks player team & opens last visited page by player.
	function TeamCheck(pl)
		
	end
	
	--// Taunt Menu
	function ptm(pl)
	if not LocalPlayer():IsValid() then
		teamcolor = Color(0,255,255,255)
	else
		teamcolor = team.GetColor(LocalPlayer():Team())
	end
	
	tauntlist = {}
	playedtaunts = {}
	
	if LocalPlayer():Team() == TEAM_HUNTERS then
		tauntlist = huntertauntlist
		playedtaunts = hunterplayedtaunts
	elseif LocalPlayer():Team() == TEAM_PROPS then
		tauntlist = proptauntlist
		playedtaunts = propplayedtaunts
	else
	end
	
	if (sort) then
		table.sort(tauntlist, function(a, b) return a[3] < b[3] end)
	end
	
	local TCR = math.Clamp((teamcolor.r - 100), 0, 255)
	local TCG = math.Clamp((teamcolor.g - 100), 0, 255)
	local TCB = math.Clamp((teamcolor.b - 100), 0, 255)
	local BTCR = math.Clamp((TCR - 50), 0, 255)
	local BTCG = math.Clamp((TCG - 50), 0, 255)
	local BTCB = math.Clamp((TCB - 50), 0, 255)
	local MenuColor	= Color(TCR,TCG,TCB,200)
	local ButtonBGColor	= Color(BTCR,BTCG,BTCB,255)
		p1_base = vgui.Create( "DFrame")
			p1_base:SetSize(176, 571) 
			p1_base:SetPos(0,(ScrH() / 2)-285)
			p1_base:SetTitle(team.GetName( LocalPlayer():Team() ).." - Page " .. pn)
			p1_base:SetVisible( true )
			p1_base:SetDeleteOnClose(false)
			p1_base:ShowCloseButton(false)
			p1_base:SetDraggable(false)
			p1_base:MakePopup()
			p1_base:SetKeyBoardInputEnabled(false)
			p1_base:SetMouseInputEnabled(true)
			if table.Count(playedtaunts) > STORED_TAUNTS then
				table.remove(playedtaunts, 1)
			end
			p1_base.Paint = function()
								draw.RoundedBox( 8, 0, 0, p1_base:GetWide(), p1_base:GetTall(), MenuColor )
							end

		--// Random Taunt Button							
		local p1_base_bX = vgui.Create( "DButton", p1_base )
			p1_base_bX:SetSize(45, 23)
			p1_base_bX:SetPos(125, 5)
			p1_base_bX:SetText("Random")
			p1_base_bX:SetTextColor(ButtonTextColor)
			p1_base_bX.Paint	=	function()
										surface.SetDrawColor(ButtonBGColor)
										surface.DrawRect( 0, 0, p1_base_bX:GetWide(), p1_base_bX:GetTall() )
									end
			p1_base_bX.DoClick	=	function()
								net.Start("send_taunt")
									local rt = table.Random(tauntlist)[2]
									net.WriteString(rt)
									net.WriteString(rt[3])
									table.insert(playedtaunts, rt)
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
									end

		--// Close Menu Button									
		local p1_base_bX = vgui.Create( "DButton", p1_base )
			p1_base_bX:SetSize(35, 25)
			p1_base_bX:SetPos(69, 535)
			p1_base_bX:SetText("Close")
			p1_base_bX:SetTextColor(ButtonTextColor)
			p1_base_bX.Paint	=	function()
										surface.SetDrawColor(ButtonBGColor)
										surface.DrawRect( 0, 0, p1_base_bX:GetWide(), p1_base_bX:GetTall() )
									end
			p1_base_bX.DoClick	=	function()
										p1_base:Close()
										pl.MenuOpen=0;
									end
		
		

		--// Previous Page Button
		if bn > 0 then		
		local p1_base_bPrv = vgui.Create( "DButton", p1_base )
			p1_base_bPrv:SetSize(55, 25)
			p1_base_bPrv:SetPos(12, 535)
			p1_base_bPrv:SetText("Previous")
			p1_base_bPrv:SetTextColor(ButtonTextColor)
			p1_base_bPrv.Paint	=	function()
										surface.SetDrawColor(ButtonBGColor)
										surface.DrawRect( 0, 0, p1_base_bPrv:GetWide(), p1_base_bPrv:GetTall() )
									end
			p1_base_bPrv.DoClick	=	function()
											p1_base:Close()
											if bn > 0 then
												bn = bn - 14
												pn = pn - 1
											else 
												bn = 0
											end
											hook.Run("ptm",pl)
											pl.MenuPage2=0;
										end
		else end

		--// Next Page Button		
		if bn < (table.Count(tauntlist) - 14) then
		local p1_base_bNxt = vgui.Create( "DButton", p1_base )
			p1_base_bNxt:SetSize(55, 25)
			p1_base_bNxt:SetPos(107, 535)
			p1_base_bNxt:SetText("Next")
			p1_base_bNxt:SetTextColor(ButtonTextColor)
			p1_base_bNxt.Paint	=	function()
										surface.SetDrawColor(ButtonBGColor)
										surface.DrawRect( 0, 0, p1_base_bNxt:GetWide(), p1_base_bNxt:GetTall() )
									end
			p1_base_bNxt.DoClick =	function()
										p1_base:Close()
										if bn < (table.Count(tauntlist) - 14) then 
											bn = bn + 14
											pn = pn + 1
										else end
										hook.Run("ptm",pl)
									end
		else end

		--// Hunter Taunt Buttons
		for i = 1, 14 do
			if (tauntlist[bn + i]) != nil && not table.HasValue( playedtaunts, (tauntlist[bn + i])[2] ) then
			local b1 = vgui.Create("DButton", p1_base)
				b1:SetSize(150, 33)
				b1:SetPos(12,35*i) 
				b1:SetText((tauntlist[bn + i])[1]) 
				b1:SetTextColor(ButtonTextColor)
				b1.Paint	=	function()
					surface.SetDrawColor(ButtonBGColor)
					surface.DrawRect( 0, 0, b1:GetWide(), b1:GetTall() )
				end
				b1.DoClick	=	function () 
									net.Start("send_taunt")
										net.WriteString((tauntlist[bn + i])[2])
										net.WriteFloat((tauntlist[bn + i])[3])
										if pl:GetNWFloat("nexttaunt") < CurTime() then
											table.insert(playedtaunts, (tauntlist[bn + i])[2])
											net.SendToServer()
										else
											net.SendToServer()
										end
									p1_base:Close() pl.MenuOpen=0;
								end
			else end
		end
	end

	--// Hook List 
	hook.Add("ptm","Calling Prop Menu",ptm) --//Hook to call ptm(Hunters)
	hook.Add("TeamCheck","Call check pl.Team()",TeamCheck) --//Hook to call TeamCheck
	
	function showspare( ply, bind, pressed )
		if ( bind == "gm_showspare1" ) then
			IsAlive(LocalPlayer())
		end
	end
	hook.Add( "PlayerBindPress", "PlayerBindPress", showspare )
	
	hook.Add( "OnContextMenuOpen", "RandTaunt", function()
			net.Start("send_taunt")
			if LocalPlayer():Team() == TEAM_HUNTERS then
				local hrt = table.Random(huntertauntlist)
				name = hrt[2]
				length = hrt[3]
				net.WriteString(name)
				net.WriteFloat(length)
				table.insert(hunterplayedtaunts, hrt[2])
			elseif LocalPlayer():Team() == TEAM_PROPS then
				local prt = table.Random(proptauntlist)
				name = prt[2]
				length = prt[3]
				net.WriteString(name)
				net.WriteFloat(length)
				table.insert(propplayedtaunts, prt[2])
			end
			net.SendToServer()
	end)

end
