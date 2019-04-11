----------------------------------------------------
--
--		Taunt Menu for Prop Hunt
--			by Vash Baldeus
--				v1.1
--				
--  Extensively edited by The Realist
--	    for Reverse Logic Gaming
--
----------------------------------------------------

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
	bnp 					= 	0						--// Initialize Prop button number
	pnp 					= 	1						--// Initialize Prop page number
	bnh 					= 	0						--// Initialize Hunter button number
	pnh 					= 	1						--// Initialize Hunter page number
	menutoggle 				= 	1						--// Initialize menu as closed
	STORED_TAUNTS 			= 	5						--// Sets the number of played taunts to be stored
	propplayedtaunts 		= 	{}						--// Initializes the stored Prop played taunts
	hunterplayedtaunts 		= 	{}						--// Initializes the stored Hunter played taunts

--// Prop Button text list	
	local propButton={
	"Homer Doh",
	"Go away or I shall taunt",
	"Shamwow",
	"Negative",
	"Over 9000",
	"LEROY JENKINS",
	"Please come again",
	"THIS IS SPARTA!",
	"What is wrong with you?",
	"Woohoo!",
	"Bill Cosby Pokeman",
	"Utorunaga Weeu!",
	"Snooping as usual I see?",
	"Aaah",
	"Get on the ball!",
	"Car horn",
	"Are you on the ball?",
	"Military Forces Eliminated",
	"Inner Circle Bad Boys",
	"Blood Rave",
	"Eric Prydz Call on Me",
	"AoE 2 Healer",
	"You call that a gun?",
	"MGS Alert",
	"Almost caught...",
	"Archer: Bloody Mary",
	"Archer: Danger Zone",
	"I'm an attention whore!",
	"Balls of steel",
	"Bananaphone",
	"Do a barrel roll!",
	"Beep boop, son.",
	"Psychostick Beer",
	"Not the bees!",
	"Yackety Sax",
	"Blow it out your ass!",
	"Boi-oi-oing!",
	"Bollocks to you!",
	"A whole lotta fucks",
	"Bug off, you wanker!",
	"Just a bunch of pansies",
	"Busted Daytona stripper",
	"Carl, that kills people!",
	"Suck my balls",
	"Old Nokia cell phone",
	"Archer: Hookers",
	"Trumpet: Charge!",
	"Cheese!",
	"MetalGearAwesome Phone",
	"Come get some",
	"Coolest fucking story",
	"I am Cornholio",
	"I can dance all day",
	"Ken Sebben: Dangly parts",
	"Denied",
	"Homer - Doh",
	"Don't just stand there...",
	"Don't miss",
	"Up, Left and Right Syndrome",
	"Surrounded by idiots",
	"It hungers for more!",
	"Epic Sax Guy",
	"So fucking extreme!",
	"Fuck you and your eyebrows!",
	"Sad trombone",
	"I'ma firin' mah lazah!",
	"Foamy: Disappointment",
	"Foamy: Suck ass",
	"Fart song",
	"Get away from me, bitch!",
	"Hide-and-Go-Fuck-Yourself",
	"Go Team Retard",
	"Breen HAAX!",
	"Hello, chum!",
	"Here's Johnny!",
	"Hi, bitch",
	"How do you fuck that up?",
	"I am a banana!",
	"ICP Hokus Pokus",
	"I make this look good",
	"Situtaion has not improved",
	"Good thing I'm indestructible",
	"Anchorman: Whore island",
	"It's a trap!",
	"It's so fluffeh!",
	"Kick ass and chew bubblegum",
	"Knob off, you tosspot!",
	"Let's dance, dickweed",
	"Look at the screen, dumb shit",
	"You are one pathetic loser",
	"Losing horn",
	"Lionel Richie Hello",
	"Stop trying to hit me",
	"Get over here!",
	"More cowbell",
	"I need to go piss soon...",
	"Beetlejuice: Nice fuckin' model",
	"Nixon Head: Shut up dammit!",
	"Oh bugger...",
	"Ow Ow Fuckity Ow!",
	"Ow what the shit was that?",
	"Pat you on the bottom",
	"Just pissin' everybody off",
	"Poop chute. Yeah.",
	"Predator noise",
	"Reach-around",
	"Ready to get fucked up",
	"There is no eleven!",
	"Robot Chicken ending theme",
	"Scatman John Scatman",
	"Scout: Nice try pal",
	"Screaming goat",
	"Didn't see that coming",
	"Shit!",
	"I think he just shit himself",
	"Shut your fucking mouth!",
	"You're too slow!",
	"Super Mario Brothers Star",
	"Gassy Mexican: I can smell you",
	"So long, losers!",
	"Stop blowing holes in my ship!",
	"Sucks to be me right now",
	"Homer: Sweet beer",
	"Dude... This is crazy!",
	"THX sound",
	"Damn, we're in a tight spot.",
	"Damn we're in a tight spot!",
	"English, do you speak it?",
	"Vince: Gonna love my nuts",
	"Shit's weak",
	"We're here to fuck shit up",
	"Haddaway What Is Love",
	"What the fuck?",
	"Whip Somebody's Ass song",
	"Woohoo!",
	"What the hell is wrong...",
	"What the fuck is that?",
	"You will never get this",
	"Turret: You are a bitch",
	"You got skills",
	"You smell funny",
	"Everybody do the flop!",
	"...we'll know we're not dead",
	"Arrow to the knee",
	"MC Hammer Can't Touch This",
	"B2M I Believe I Can Fly",
	"W(NW) Walk the Dinosaur",
	"Tourette's Guy: All you do",
	"Minecraft creeper explode",
	"Do you smoke cigarettes or eat",
	"JB Get Up Offa That Thing",
	"SM-A-L Baby Got Back",
	"Patrick Star: Leedle",
	"Krieg: Shiniest meat bicycle",
	"Denny's Nannerpuss advert",
	"Metalocalypse: NOOO!",
	"Tourette's Guy: Bob Saget!",
	"Kook Aid Guy: Oh yeah!",
	"One of these kids is dead",
	"Krieg: Poop train",
	"Show Me Your Genitals song",
	"Shun the non-believer!",
	"My anus is bleeding!",
	"Tim Wilson Booty Man",
	"Bart: It got even crappier",
	"My disguise is too cunning",
	"Bohemian Mtn Dew Rhapsody",
	"Captain Jean-Luc Picard song",
	"MGA: Fucking fair",
	"Head-On advert",
	"I'm the map!",
	"MGA: Throw grenades at me",
	"Nigel: Aaaugh",
	"My nipples explode with delight",
	"MGA: Now to look at asses",
	"Shoot me again, I ain't dead",
	"Strong Bad: Windows 98",
	"Big Booty Bitches",
	"Apollo 440-Can't Stop the Rock",
	"Fork in the Garbage Disposal",
	"Tourette's Guy - Fuck Salt",
	"Epic Meal Time Gay Bacon...",
	"Gimme Dat Butt!",
	"Kalluri Vaanil (Benny Lava)",
	"Not Having Any Mayonnaise",
	"Pinky and the Brain",
	"Reading Rainbow stinger",
	"Spooky Scary Skeletons",
	"The Bad Touch",
	"Makes a Man go NOOT NOOT",
	"Somebody kill me!"
	}

--// Prop net.WriteString(text)
	local propWString={
	"rlg/taunts/props/2.wav",
	"rlg/taunts/props/3.wav",
	"rlg/taunts/props/4.wav",
	"rlg/taunts/props/5.wav",
	"rlg/taunts/props/6.wav",
	"rlg/taunts/props/7.wav",
	"rlg/taunts/props/8.wav",
	"rlg/taunts/props/9.wav",
	"rlg/taunts/props/10.wav",
	"rlg/taunts/props/11.wav",
	"rlg/taunts/props/12.wav",
	"rlg/taunts/props/14.wav",
	"rlg/taunts/props/15.wav",
	"rlg/taunts/props/17.mp3",
	"rlg/taunts/props/18.wav",
	"rlg/taunts/props/19.wav",
	"rlg/taunts/props/20.wav",
	"rlg/taunts/props/30.wav",
	"rlg/taunts/props/31.mp3",
	"rlg/taunts/props/32.mp3",
	"rlg/taunts/props/33.mp3",
	"rlg/taunts/props/35.mp3",
	"rlg/taunts/props/agun.mp3",
	"rlg/taunts/props/alert2.mp3",
	"rlg/taunts/props/almostcaught.mp3",
	"rlg/taunts/props/arch_bloody.mp3",
	"rlg/taunts/props/arch_dz.mp3",
	"rlg/taunts/props/attentionwhore.mp3",
	"rlg/taunts/props/balls.mp3",
	"rlg/taunts/props/bananasong.mp3",
	"rlg/taunts/props/barrelroll.mp3",
	"rlg/taunts/props/beepboopson.mp3",
	"rlg/taunts/props/beer1.mp3",
	"rlg/taunts/props/bees1.mp3",
	"rlg/taunts/props/bennyhill.mp3",
	"rlg/taunts/props/blow_it.mp3",
	"rlg/taunts/props/boioing.mp3",
	"rlg/taunts/props/bollockstoyou.mp3",
	"rlg/taunts/props/boondocksaints.mp3",
	"rlg/taunts/props/bugoff.mp3",
	"rlg/taunts/props/bunchofpansies.mp3",
	"rlg/taunts/props/bustedstripper.mp3",
	"rlg/taunts/props/carl.mp3",
	"rlg/taunts/props/cartmansuck.mp3",
	"rlg/taunts/props/cell.mp3",
	"rlg/taunts/props/ch3.mp3",
	"rlg/taunts/props/charge.mp3",
	"rlg/taunts/props/cheese.mp3",
	"rlg/taunts/props/codec2.mp3",
	"rlg/taunts/props/come_get_some.mp3",
	"rlg/taunts/props/coolest.mp3",
	"rlg/taunts/props/cornholio.mp3",
	"rlg/taunts/props/danceallday.mp3",
	"rlg/taunts/props/danglyparts.mp3",
	"rlg/taunts/props/denied.mp3",
	"rlg/taunts/props/doh.mp3",
	"rlg/taunts/props/dontjuststandthere.mp3",
	"rlg/taunts/props/dontmiss.mp3",
	"rlg/taunts/props/downsyndrome.mp3",
	"rlg/taunts/props/dr_evil-frickin_idiots.mp3",
	"rlg/taunts/props/drweird.mp3",
	"rlg/taunts/props/epicsaxguy.mp3",
	"rlg/taunts/props/extreme.mp3",
	"rlg/taunts/props/eyebrow.mp3",
	"rlg/taunts/props/fail.mp3",
	"rlg/taunts/props/firinmahlazah.mp3",
	"rlg/taunts/props/foamydisappointment.mp3",
	"rlg/taunts/props/foamysuckass.mp3",
	"rlg/taunts/props/fs.mp3",
	"rlg/taunts/props/getawayfromme.mp3",
	"rlg/taunts/props/gofuckurself.mp3",
	"rlg/taunts/props/goteamretard.mp3",
	"rlg/taunts/props/haax.mp3",
	"rlg/taunts/props/hellochum.mp3",
	"rlg/taunts/props/heresjohnny.mp3",
	"rlg/taunts/props/hibitch.mp3",
	"rlg/taunts/props/howdoyoufuckthatup.mp3",
	"rlg/taunts/props/iamabanana.mp3",
	"rlg/taunts/props/icphokuspokus.mp3",
	"rlg/taunts/props/imakethislookgood.mp3",
	"rlg/taunts/props/improved.mp3",
	"rlg/taunts/props/indestructible.mp3",
	"rlg/taunts/props/island.mp3",
	"rlg/taunts/props/its_a_trap.mp3",
	"rlg/taunts/props/itssofluffeh.mp3",
	"rlg/taunts/props/kick_ass_and_chew_bubblegum.mp3",
	"rlg/taunts/props/knoboff.mp3",
	"rlg/taunts/props/letsdance.mp3",
	"rlg/taunts/props/lookatscreen.mp3",
	"rlg/taunts/props/loser.mp3",
	"rlg/taunts/props/losinghorn.mp3",
	"rlg/taunts/props/lrtaunt1.mp3",
	"rlg/taunts/props/matrix1.mp3",
	"rlg/taunts/props/mk4_scorpion.mp3",
	"rlg/taunts/props/morecowbell.mp3",
	"rlg/taunts/props/needtopiss.mp3",
	"rlg/taunts/props/nicemodel.mp3",
	"rlg/taunts/props/nixonshutup.mp3",
	"rlg/taunts/props/ohbugger.mp3",
	"rlg/taunts/props/owow.mp3",
	"rlg/taunts/props/owwhatthe.mp3",
	"rlg/taunts/props/patbottom.mp3",
	"rlg/taunts/props/pissin.mp3",
	"rlg/taunts/props/poopchute.mp3",
	"rlg/taunts/props/predator.mp3",
	"rlg/taunts/props/reacharound.mp3",
	"rlg/taunts/props/readytoget.mp3",
	"rlg/taunts/props/redvsbluenoeleven.mp3",
	"rlg/taunts/props/robotchicken.mp3",
	"rlg/taunts/props/scatman.mp3",
	"rlg/taunts/props/scout1.mp3",
	"rlg/taunts/props/screamgoat.mp3",
	"rlg/taunts/props/seethatcoming.mp3",
	"rlg/taunts/props/shit.mp3",
	"rlg/taunts/props/shithimself.mp3",
	"rlg/taunts/props/shutyourfuckingmouth.mp3",
	"rlg/taunts/props/slow1.mp3",
	"rlg/taunts/props/smb_star.mp3",
	"rlg/taunts/props/smell_u.mp3",
	"rlg/taunts/props/solong.mp3",
	"rlg/taunts/props/stopblowingholes.mp3",
	"rlg/taunts/props/suckstobeme.mp3",
	"rlg/taunts/props/sweetbeer1.wav",
	"rlg/taunts/props/thisiscrazy.mp3",
	"rlg/taunts/props/thx.mp3",
	"rlg/taunts/props/tightspot2.mp3",
	"rlg/taunts/props/tightspot3.mp3",
	"rlg/taunts/props/ts_english.mp3",
	"rlg/taunts/props/vincelovemynuts.mp3",
	"rlg/taunts/props/weak.mp3",
	"rlg/taunts/props/werehere.mp3",
	"rlg/taunts/props/whatislove.mp3",
	"rlg/taunts/props/whatthefu.mp3",
	"rlg/taunts/props/whipsomebodysass.mp3",
	"rlg/taunts/props/whoohoo.mp3",
	"rlg/taunts/props/wrong.mp3",
	"rlg/taunts/props/wtf_fmj.mp3",
	"rlg/taunts/props/you_will_never.mp3",
	"rlg/taunts/props/youareabitch.mp3",
	"rlg/taunts/props/yougotskills.mp3",
	"rlg/taunts/props/yousmellfunny.mp3",
	"rlg/taunts/props/dotheflop.mp3",
	"rlg/taunts/props/wellknowwerenotdead.mp3",
	"rlg/taunts/props/arrowtotheknee.mp3",
	"rlg/taunts/props/mchammer.mp3",
	"rlg/taunts/props/ibelieveicanfly.mp3",
	"rlg/taunts/props/walkdino.mp3",
	"rlg/taunts/props/allyoueverdo.mp3",
	"rlg/taunts/props/creeperboom.mp3",
	"rlg/taunts/props/doyousmoke.mp3",
	"rlg/taunts/props/getupoffathatthing.mp3",
	"rlg/taunts/props/ilikebigbutts.mp3",
	"rlg/taunts/props/leedle.mp3",
	"rlg/taunts/props/meatbicycle.mp3",
	"rlg/taunts/props/nannerpuss.mp3",
	"rlg/taunts/props/nooo.mp3",
	"rlg/taunts/props/ohbobsaget.mp3",
	"rlg/taunts/props/ohnoohyeah.mp3",
	"rlg/taunts/props/oneofthesekids.mp3",
	"rlg/taunts/props/pooptrain.mp3",
	"rlg/taunts/props/showmeyourgenitals.mp3",
	"rlg/taunts/props/shunthenonbeliever.mp3",	
	"rlg/taunts/props/anusisbleeding.mp3",
	"rlg/taunts/props/booty.mp3",
	"rlg/taunts/props/crappier.mp3",
	"rlg/taunts/props/cunning.mp3",
	"rlg/taunts/props/dew.mp3",
	"rlg/taunts/props/enterprise.mp3",
	"rlg/taunts/props/fuckingfair.mp3",
	"rlg/taunts/props/headon2.mp3",
	"rlg/taunts/props/imthemap.mp3",
	"rlg/taunts/props/justthrowgrenades.mp3",
	"rlg/taunts/props/nigelaaugh.mp3",
	"rlg/taunts/props/nipplesexplode.mp3",
	"rlg/taunts/props/nowtolookatasses.mp3",
	"rlg/taunts/props/shootmeagain.mp3",
	"rlg/taunts/props/win982.mp3",
	"rlg/taunts/props/bigbootybitches.mp3",
	"rlg/taunts/props/cantstoptherock.mp3",
	"rlg/taunts/props/forkinthegarbagedisposal.mp3",
	"rlg/taunts/props/fucksalt.mp3",
	"rlg/taunts/props/gaybaconstrips.mp3",
	"rlg/taunts/props/gimmedatbutt.mp3",
	"rlg/taunts/props/kallurivaanil.mp3",
	"rlg/taunts/props/nothavinganymayonnaise.mp3",
	"rlg/taunts/props/pinkyandthebrain.mp3",
	"rlg/taunts/props/readingrainbow.mp3",
	"rlg/taunts/props/spookyscaryskeletons.mp3",
	"rlg/taunts/props/thebadtouch.mp3",
	"rlg/taunts/props/nootnoot.mp3",
	"rlg/taunts/props/somebodykillme.mp3"
	}

--// Hunter Button text list
	local hunterButton={
	"You can run, but can't hide",
	"Come on just die already!",
	"Crappy shot",
	"Don't run we are your friends",
	"Cursage, foiled again!",
	"Gonna kill all these fucks",
	"Holy hand grenade",
	"I suck",
	"B.O. deflected the bullet",
	"Turret: Oh my god",
	"Oh no! We suck again!",
	"Please fondle my bum",
	"I will look for you and kill you",
	"Gotta lay off the peyote",
	"You best watch your back",
	"Who painted my ass white?",
	"Eat lead, pansy",
	"MGA: Getting pissed off",
	"DJango: Get winged",
	"Go on, go get them!",
	"Holy fuck is this wrong!",
	"Won't hurt you when I catch",
	"Joker: Dog chasing cars",
	"Scout: Owning you",
	"It's showtime",
	"Farkin' sneaky bastage",
	"Dr. Tran Toy Cack Geese",
	"Silence! I Kill You!",
	"KRS One-Sound of Da Police"
	}

--//Hunter net.WriteString(text)
	local hunterWString={
	"rlg/taunts/hunters/canthide.mp3",
	"rlg/taunts/hunters/comeon.mp3",
	"rlg/taunts/hunters/crappyshot.mp3",
	"rlg/taunts/hunters/donotrun.mp3",
	"rlg/taunts/hunters/foiledagain.mp3",
	"rlg/taunts/hunters/gonnakill.mp3",
	"rlg/taunts/hunters/holyhandgrenade.mp3",
	"rlg/taunts/hunters/isuck.mp3",
	"rlg/taunts/hunters/missed.mp3",
	"rlg/taunts/hunters/ohmygod.mp3",
	"rlg/taunts/hunters/ohnowesuckagain.mp3",
	"rlg/taunts/hunters/pleasefondle.mp3",
	"rlg/taunts/hunters/taken-kill_you.mp3",
	"rlg/taunts/hunters/thepeyote.mp3",
	"rlg/taunts/hunters/watchyourback.mp3",
	"rlg/taunts/hunters/whopainted.mp3",
	"rlg/taunts/hunters/eatlead.mp3",
	"rlg/taunts/hunters/gettingpissedoff.mp3",
	"rlg/taunts/hunters/getwinged.mp3",
	"rlg/taunts/hunters/gogetthem.mp3",
	"rlg/taunts/hunters/holyfuckisthiswrong.mp3",
	"rlg/taunts/hunters/hunterchase.mp3",
	"rlg/taunts/hunters/dogchasingcars.mp3",
	"rlg/taunts/hunters/owningyou1.mp3",
	"rlg/taunts/hunters/showtime.mp3",
	"rlg/taunts/hunters/sneaky.mp3",
	"rlg/taunts/hunters/flockofgeese.mp3",
	"rlg/taunts/hunters/silenceikillyou.mp3",
	"rlg/taunts/hunters/soundofdapolice.mp3"
	}

--//Checks if player alive & if menu is not open
	function IsAlive(pl)
		if ( pl:Alive() && pl.MenuOpen !=1 ) then
				if pl:Team() == TEAM_HUNTERS then
					hook.Run("phmh",pl)
					p1_base:SetVisible(true)
					pl.MenuOpen=1;
				elseif pl:Team() == TEAM_PROPS then
					hook.Run("phmp",pl)
					p1_base:SetVisible(true)
					pl.MenuOpen=1;
				else
					chat.AddText(Color(214,0,0),"[Taunt Menu]", Color(0,225,126)," You must be in one of the teams to use the menu.")
				end
		elseif ( pl:Alive() && pl.MenuOpen !=0 ) then 
			if pl:Team() == TEAM_HUNTERS then
				hook.Remove("phmh",pl)
				p1_base:SetVisible(false)
				p1_base:Close()
				pl.MenuOpen=0;
			elseif pl:Team() == TEAM_PROPS then	
				hook.Remove("phmp",pl)
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

--// PROP Taunt Menu
	function phmp(pl)
	if not LocalPlayer():IsValid() then
		teamcolor = Color(0,255,255,255)
	else
		teamcolor = team.GetColor(LocalPlayer():Team())
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
			p1_base:SetTitle(team.GetName( LocalPlayer():Team() ).." - Page " .. pnp)
			p1_base:SetVisible( true )
			p1_base:SetDeleteOnClose(false)
			p1_base:ShowCloseButton(false)
			p1_base:SetDraggable(false)
			p1_base:MakePopup()
			p1_base:SetKeyBoardInputEnabled(false)
			p1_base:SetMouseInputEnabled(true)
			if table.Count(propplayedtaunts) > STORED_TAUNTS then
				table.remove(propplayedtaunts, 1)
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
									local prt = table.Random(propWString)
									net.WriteString(prt)
									table.insert(propplayedtaunts, prt)
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
		if bnp > 0 then
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
											if bnp > 0 then
												bnp = bnp - 14
												pnp = pnp - 1
											else 
												bnp = 0
											end
											hook.Run("phmp",pl)
											pl.MenuPage2=0;
										end
		else end

--//Next Page Button		
		if bnp < (table.Count(propButton) - 14) then
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
										if bnp < (table.Count(propButton) - 14) then 
											bnp = bnp + 14
											pnp = pnp + 1
										else end
										hook.Run("phmp",pl)
									end	
		end

--// Button 1		
		if propButton[bnp + 1] != nil && not table.HasValue(propplayedtaunts, propWString[bnp + 1]) then
		local b1 = vgui.Create("DButton", p1_base)
			b1:SetSize(150, 33)
			b1:SetPos(12,35) 
			b1:SetText(propButton[bnp + 1]) 
			b1:SetTextColor(ButtonTextColor)
			b1.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b1:GetWide(), b1:GetTall() )
							end
			b1.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(propWString[bnp + 1])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(propplayedtaunts, propWString[bnp + 1])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 2		
		if propButton[bnp + 2] != nil && not table.HasValue(propplayedtaunts, propWString[bnp + 2]) then
		local b2 = vgui.Create( "DButton", p1_base )
			b2:SetSize(150, 33)
			b2:SetPos(12, 70)
			b2:SetText(propButton[bnp + 2])
			b2:SetTextColor(ButtonTextColor)
			b2.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b2:GetWide(), b2:GetTall() )
							end
			b2.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(propWString[bnp + 2])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(propplayedtaunts, propWString[bnp + 2])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 3		
		if propButton[bnp + 3] != nil && not table.HasValue(propplayedtaunts, propWString[bnp + 3]) then
		local b3 = vgui.Create( "DButton", p1_base )
			b3:SetSize(150, 33)
			b3:SetPos(12, 105)
			b3:SetText(propButton[bnp + 3])
			b3:SetTextColor(ButtonTextColor)
			b3.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b3:GetWide(), b3:GetTall() )
							end
			b3.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(propWString[bnp + 3])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(propplayedtaunts, propWString[bnp + 3])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 4		
		if propButton[bnp + 4] != nil && not table.HasValue(propplayedtaunts, propWString[bnp + 4]) then
		local b4 = vgui.Create( "DButton", p1_base )
			b4:SetSize(150, 33)
			b4:SetPos(12, 140)
			b4:SetText(propButton[bnp + 4])
			b4:SetTextColor(ButtonTextColor)
			b4.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b4:GetWide(), b4:GetTall() )
							end
			b4.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(propWString[bnp + 4])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(propplayedtaunts, propWString[bnp + 4])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 5		
		if propButton[bnp + 5] != nil && not table.HasValue(propplayedtaunts, propWString[bnp + 5]) then
		local b5 = vgui.Create( "DButton", p1_base )
			b5:SetSize(150, 33)
			b5:SetPos(12, 175)
			b5:SetText(propButton[bnp + 5])
			b5:SetTextColor(ButtonTextColor)
			b5.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b5:GetWide(), b5:GetTall() )
							end
			b5.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(propWString[bnp + 5])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(propplayedtaunts, propWString[bnp + 5])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 6		
		if propButton[bnp + 6] != nil && not table.HasValue(propplayedtaunts, propWString[bnp + 6]) then
		local b6 = vgui.Create( "DButton", p1_base )
			b6:SetSize(150, 33)
			b6:SetPos(12, 210)
			b6:SetText(propButton[bnp + 6])
			b6:SetTextColor(ButtonTextColor)
			b6.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b6:GetWide(), b6:GetTall() )
							end
			b6.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(propWString[bnp + 6])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(propplayedtaunts, propWString[bnp + 6])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 7		
		if propButton[bnp + 7] != nil && not table.HasValue(propplayedtaunts, propWString[bnp + 7]) then
		local b7 = vgui.Create( "DButton", p1_base )
			b7:SetSize(150, 33)
			b7:SetPos(12, 245)
			b7:SetText(propButton[bnp + 7])
			b7:SetTextColor(ButtonTextColor)
			b7.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b7:GetWide(), b7:GetTall() )
							end
			b7.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(propWString[bnp + 7])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(propplayedtaunts, propWString[bnp + 7])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 8		
		if propButton[bnp + 8] != nil && not table.HasValue(propplayedtaunts, propWString[bnp + 8]) then
		local b8 = vgui.Create( "DButton", p1_base )
			b8:SetSize(150, 33)
			b8:SetPos(12, 280)
			b8:SetText(propButton[bnp + 8])
			b8:SetTextColor(ButtonTextColor)
			b8.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b8:GetWide(), b8:GetTall() )
							end
			b8.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(propWString[bnp + 8])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(propplayedtaunts, propWString[bnp + 8])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 9		
		if propButton[bnp + 9] != nil && not table.HasValue(propplayedtaunts, propWString[bnp + 9]) then
		local b9 = vgui.Create( "DButton", p1_base )
			b9:SetSize(150, 33)
			b9:SetPos(12, 315)
			b9:SetText(propButton[bnp + 9])
			b9:SetTextColor(ButtonTextColor)
			b9.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b9:GetWide(), b9:GetTall() )
							end
			b9.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(propWString[bnp + 9])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(propplayedtaunts, propWString[bnp + 9])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 10		
		if propButton[bnp + 10] != nil && not table.HasValue(propplayedtaunts, propWString[bnp + 10]) then
		local b10 = vgui.Create( "DButton", p1_base )
			b10:SetSize(150, 33)
			b10:SetPos(12, 350)
			b10:SetText(propButton[bnp + 10])
			b10:SetTextColor(ButtonTextColor)
			b10.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b10:GetWide(), b10:GetTall() )
							end
			b10.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(propWString[bnp + 10])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(propplayedtaunts, propWString[bnp + 10])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 11		
		if propButton[bnp + 11] != nil && not table.HasValue(propplayedtaunts, propWString[bnp + 11]) then
		local b11 = vgui.Create( "DButton", p1_base )		
			b11:SetSize(150, 33)
			b11:SetPos(12, 385)
			b11:SetText(propButton[bnp + 11])
			b11:SetTextColor(ButtonTextColor)
			b11.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b11:GetWide(), b11:GetTall() )
							end
			b11.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(propWString[bnp + 11])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(propplayedtaunts, propWString[bnp + 11])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 12		
		if propButton[bnp + 12] != nil && not table.HasValue(propplayedtaunts, propWString[bnp + 12]) then
		local b12 = vgui.Create( "DButton", p1_base )
			b12:SetSize(150, 33)
			b12:SetPos(12, 420)
			b12:SetText(propButton[bnp + 12])
			b12:SetTextColor(ButtonTextColor)
			b12.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b12:GetWide(), b12:GetTall() )
							end
			b12.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(propWString[bnp + 12])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(propplayedtaunts, propWString[bnp + 12])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 13		
		if propButton[bnp + 13] != nil && not table.HasValue(propplayedtaunts, propWString[bnp + 13]) then
		local b13 = vgui.Create( "DButton", p1_base )
			b13:SetSize(150, 33)
			b13:SetPos(12, 455)
			b13:SetText(propButton[bnp + 13])
			b13:SetTextColor(ButtonTextColor)
			b13.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b13:GetWide(), b13:GetTall() )
							end
			b13.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(propWString[bnp + 13])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(propplayedtaunts, propWString[bnp + 13])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 14		
		if propButton[bnp + 14] != nil && not table.HasValue(propplayedtaunts, propWString[bnp + 14]) then
		local b14 = vgui.Create( "DButton", p1_base )
			b14:SetSize(150, 33)
			b14:SetPos(12, 490)
			b14:SetText(propButton[bnp + 14])
			b14:SetTextColor(ButtonTextColor)
			b14.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b14:GetWide(), b14:GetTall() )
							end
			b14.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(propWString[bnp + 14])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(propplayedtaunts, propWString[bnp + 14])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
	end
	
--// HUNTER Taunt Menu
	function phmh(pl)--//Hunter Menu
	if not LocalPlayer():IsValid() then
		teamcolor = Color(0,255,255,255)
	else
		teamcolor = team.GetColor(LocalPlayer():Team())
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
			p1_base:SetTitle(team.GetName( LocalPlayer():Team() ).." - Page " .. pnh)
			p1_base:SetVisible( true )
			p1_base:SetDeleteOnClose(false)
			p1_base:ShowCloseButton(false)
			p1_base:SetDraggable(false)
			p1_base:MakePopup()
			p1_base:SetKeyBoardInputEnabled(false)
			p1_base:SetMouseInputEnabled(true)
			if table.Count(hunterplayedtaunts) > STORED_TAUNTS then
				table.remove(hunterplayedtaunts, 1)
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
									local hrt = table.Random(hunterWString)
									net.WriteString(hrt)
									table.insert(hunterplayedtaunts, hrt)
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
		
		if bnh > 0 then

--// Previous Page Button		
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
											if bnh > 0 then
												bnh = bnh - 14
												pnh = pnh - 1
											else 
												bnh = 0
											end
											hook.Run("phmh",pl)
											pl.MenuPage2=0;
										end
		else end

--// Next Page Button		
		if bnh < (table.Count(hunterButton) - 14) then
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
										if bnh < (table.Count(hunterButton) - 14) then 
											bnh = bnh + 14
											pnh = pnh + 1
										else end
										hook.Run("phmh",pl)
									end
		else end

--// Button 1		
		if hunterButton[bnh + 1] != nil && not table.HasValue(hunterplayedtaunts, hunterWString[bnh + 1]) then
		local b1 = vgui.Create("DButton", p1_base)
			b1:SetSize(150, 33)
			b1:SetPos(12,35) 
			b1:SetText(hunterButton[bnh + 1]) 
			b1:SetTextColor(ButtonTextColor)
			b1.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b1:GetWide(), b1:GetTall() )
							end
			b1.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(hunterWString[bnh + 1])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(hunterplayedtaunts, hunterWString[bnh + 1])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 2		
		if hunterButton[bnh + 2] != nil && not table.HasValue(hunterplayedtaunts, hunterWString[bnh + 2]) then
		local b2 = vgui.Create( "DButton", p1_base )
			b2:SetSize(150, 33)
			b2:SetPos(12, 70)
			b2:SetText(hunterButton[bnh + 2])
			b2:SetTextColor(ButtonTextColor)
			b2.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b2:GetWide(), b2:GetTall() )
							end
			b2.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(hunterWString[bnh + 2])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(hunterplayedtaunts, hunterWString[bnh + 2])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 3		
		if hunterButton[bnh + 3] != nil && not table.HasValue(hunterplayedtaunts, hunterWString[bnh + 3]) then
		local b3 = vgui.Create( "DButton", p1_base )
			b3:SetSize(150, 33)
			b3:SetPos(12, 105)
			b3:SetText(hunterButton[bnh + 3])
			b3:SetTextColor(ButtonTextColor)
			b3.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b3:GetWide(), b3:GetTall() )
							end
			b3.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(hunterWString[bnh + 3])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(hunterplayedtaunts, hunterWString[bnh + 3])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 4		
		if hunterButton[bnh + 4] != nil && not table.HasValue(hunterplayedtaunts, hunterWString[bnh + 4]) then
		local b4 = vgui.Create( "DButton", p1_base )
			b4:SetSize(150, 33)
			b4:SetPos(12, 140)
			b4:SetText(hunterButton[bnh + 4])
			b4:SetTextColor(ButtonTextColor)
			b4.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b4:GetWide(), b4:GetTall() )
							end
			b4.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(hunterWString[bnh + 4])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(hunterplayedtaunts, hunterWString[bnh + 4])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 5		
		if hunterButton[bnh + 5] != nil && not table.HasValue(hunterplayedtaunts, hunterWString[bnh + 5]) then
		local b5 = vgui.Create( "DButton", p1_base )
			b5:SetSize(150, 33)
			b5:SetPos(12, 175)
			b5:SetText(hunterButton[bnh + 5])
			b5:SetTextColor(ButtonTextColor)
			b5.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b5:GetWide(), b5:GetTall() )
							end
			b5.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(hunterWString[bnh + 5])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(hunterplayedtaunts, hunterWString[bnh + 5])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 6		
		if hunterButton[bnh + 6] != nil && not table.HasValue(hunterplayedtaunts, hunterWString[bnh + 6]) then
		local b6 = vgui.Create( "DButton", p1_base )
			b6:SetSize(150, 33)
			b6:SetPos(12, 210)
			b6:SetText(hunterButton[bnh + 6])
			b6:SetTextColor(ButtonTextColor)
			b6.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b6:GetWide(), b6:GetTall() )
							end
			b6.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(hunterWString[bnh + 6])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(hunterplayedtaunts, hunterWString[bnh + 6])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 7		
		if hunterButton[bnh + 7] != nil && not table.HasValue(hunterplayedtaunts, hunterWString[bnh + 7]) then
		local b7 = vgui.Create( "DButton", p1_base )
			b7:SetSize(150, 33)
			b7:SetPos(12, 245)
			b7:SetText(hunterButton[bnh + 7])
			b7:SetTextColor(ButtonTextColor)
			b7.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b7:GetWide(), b7:GetTall() )
							end
			b7.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(hunterWString[bnh + 7])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(hunterplayedtaunts, hunterWString[bnh + 7])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 8		
		if hunterButton[bnh + 8] != nil && not table.HasValue(hunterplayedtaunts, hunterWString[bnh + 8]) then
		local b8 = vgui.Create( "DButton", p1_base )
			b8:SetSize(150, 33)
			b8:SetPos(12, 280)
			b8:SetText(hunterButton[bnh + 8])
			b8:SetTextColor(ButtonTextColor)
			b8.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b8:GetWide(), b8:GetTall() )
							end
			b8.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(hunterWString[bnh + 8])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(hunterplayedtaunts, hunterWString[bnh + 8])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 9		
		if hunterButton[bnh + 9] != nil && not table.HasValue(hunterplayedtaunts, hunterWString[bnh + 9]) then
		local b9 = vgui.Create( "DButton", p1_base )
			b9:SetSize(150, 33)
			b9:SetPos(12, 315)
			b9:SetText(hunterButton[bnh + 9])
			b9:SetTextColor(ButtonTextColor)
			b9.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b9:GetWide(), b9:GetTall() )
							end
			b9.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(hunterWString[bnh + 9])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(hunterplayedtaunts, hunterWString[bnh + 9])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 10		
		if hunterButton[bnh + 10] != nil && not table.HasValue(hunterplayedtaunts, hunterWString[bnh + 10]) then
		local b10 = vgui.Create( "DButton", p1_base )
			b10:SetSize(150, 33)
			b10:SetPos(12, 350)
			b10:SetText(hunterButton[bnh + 10])
			b10:SetTextColor(ButtonTextColor)
			b10.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b10:GetWide(), b10:GetTall() )
							end
			b10.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(hunterWString[bnh + 10])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(hunterplayedtaunts, hunterWString[bnh + 10])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 11		
		if hunterButton[bnh + 11] != nil && not table.HasValue(hunterplayedtaunts, hunterWString[bnh + 11]) then
		local b11 = vgui.Create( "DButton", p1_base )		
			b11:SetSize(150, 33)
			b11:SetPos(12, 385)
			b11:SetText(hunterButton[bnh + 11])
			b11:SetTextColor(ButtonTextColor)
			b11.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b11:GetWide(), b11:GetTall() )
							end
			b11.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(hunterWString[bnh + 11])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(hunterplayedtaunts, hunterWString[bnh + 11])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 12		
		if hunterButton[bnh + 12] != nil && not table.HasValue(hunterplayedtaunts, hunterWString[bnh + 12]) then
		local b12 = vgui.Create( "DButton", p1_base )
			b12:SetSize(150, 33)
			b12:SetPos(12, 420)
			b12:SetText(hunterButton[bnh + 12])
			b12:SetTextColor(ButtonTextColor)
			b12.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b12:GetWide(), b12:GetTall() )
							end
			b12.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(hunterWString[bnh + 12])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(hunterplayedtaunts, hunterWString[bnh + 12])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 13		
		if hunterButton[bnh + 13] != nil && not table.HasValue(hunterplayedtaunts, hunterWString[bnh + 13]) then
		local b13 = vgui.Create( "DButton", p1_base )
			b13:SetSize(150, 33)
			b13:SetPos(12, 455)
			b13:SetText(hunterButton[bnh + 13])
			b13:SetTextColor(ButtonTextColor)
			b13.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b13:GetWide(), b13:GetTall() )
							end
			b13.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(hunterWString[bnh + 13])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(hunterplayedtaunts, hunterWString[bnh + 13])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end

--// Button 14		
		if hunterButton[bnh + 14] != nil && not table.HasValue(hunterplayedtaunts, hunterWString[bnh + 14]) then
		local b14 = vgui.Create( "DButton", p1_base )
			b14:SetSize(150, 33)
			b14:SetPos(12, 490)
			b14:SetText(hunterButton[bnh + 14])
			b14:SetTextColor(ButtonTextColor)
			b14.Paint	=	function()
								surface.SetDrawColor(ButtonBGColor)
								surface.DrawRect( 0, 0, b14:GetWide(), b14:GetTall() )
							end
			b14.DoClick	=	function () 
								net.Start("send_taunt")
									net.WriteString(hunterWString[bnh + 14])
									if pl:GetNWFloat("nexttaunt") < CurTime() then
										table.insert(hunterplayedtaunts, hunterWString[bnh + 14])
										net.SendToServer()
									else
										net.SendToServer()
									end
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
	end
	
--// Hook List 
	hook.Add("phmp","Calling Prop Menu",phmp) --//Hook to call phmp(Props)
	hook.Add("phmh","Calling Prop Menu",phmh) --//Hook to call phmh(Hunters)
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
				local hrt = table.Random(hunterWString)
				net.WriteString(hrt)
				table.insert(hunterplayedtaunts, hrt)
			elseif LocalPlayer():Team() == TEAM_PROPS then
				local prt = table.Random(propWString)
				net.WriteString(prt)
				table.insert(propplayedtaunts, prt)
			end
			net.SendToServer();
	end);

end
