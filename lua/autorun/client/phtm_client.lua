/*

		Taunt Menu for Prop Hunter
			by Vash Baldeus
				v1.1
				
		Extensively edited by The Realist
			for Reverse Logic Gaming

*/

if ( CLIENT) then
	timer.Create("TauntMenuUse",120,0, function()
											chat.AddText(Color(255,50,0),"[Taunt Menu]", Color(120,200,255)," To open the menu press F3")//Chat message for player.
										end)
	local ButtonTextColor	=	Color(255,255,255,255)
	local pl				=	LocalPlayer();			//Assign pl as LocalPlayer().
	pl.MenuOpen				=	0;						//Set for player MenuOpen to 0 by default.
	pl.MenuPage2			=	0;						//Set for player MenuPage3 to 0 by default
	pl.MenuPage3			=	0;						//Set for player MenuPage3 to 0 by default
	pl.hMenuPage2			=	0;					
	pl.hMenuPage3			=	0;
	bnp = 0
	pnp = 1
	bnh = 0
	pnh = 1
	menutoggle = 1
	
	local propButton={									//Prop Button text list
	"BOOM HEADSHOT!",
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
	"The One and Only",
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
	"Red vs. Blue: There is no eleven",
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
	}

	local propWString={									//Prop net.WriteString(text)
	"taunts/props/1.wav",
	"taunts/props/2.wav",
	"taunts/props/3.wav",
	"taunts/props/4.wav",
	"taunts/props/5.wav",
	"taunts/props/6.wav",
	"taunts/props/7.wav",
	"taunts/props/8.wav",
	"taunts/props/9.wav",
	"taunts/props/10.wav",
	"taunts/props/11.wav",
	"taunts/props/12.wav",
	"taunts/props/14.wav",
	"taunts/props/15.wav",
	"taunts/props/17.mp3",
	"taunts/props/18.wav",
	"taunts/props/19.wav",
	"taunts/props/20.wav",
	"taunts/props/30.wav",
	"taunts/props/31.mp3",
	"taunts/props/32.mp3",
	"taunts/props/33.mp3",
	"taunts/props/34.mp3",
	"taunts/props/35.mp3",
	"taunts/props/agun.mp3",
	"taunts/props/alert2.mp3",
	"taunts/props/almostcaught.mp3",
	"taunts/props/arch_bloody.mp3",
	"taunts/props/arch_dz.mp3",
	"taunts/props/attentionwhore.mp3",
	"taunts/props/balls.mp3",
	"taunts/props/bananasong.mp3",
	"taunts/props/barrelroll.mp3",
	"taunts/props/beepboopson.mp3",
	"taunts/props/beer1.mp3",
	"taunts/props/bees1.mp3",
	"taunts/props/bennyhill.mp3",
	"taunts/props/blow_it.mp3",
	"taunts/props/boioing.mp3",
	"taunts/props/bollockstoyou.mp3",
	"taunts/props/boondocksaints.mp3",
	"taunts/props/bugoff.mp3",
	"taunts/props/bunchofpansies.mp3",
	"taunts/props/bustedstripper.mp3",
	"taunts/props/carl.mp3",
	"taunts/props/cartmansuck.mp3",
	"taunts/props/cell.mp3",
	"taunts/props/ch3.mp3",
	"taunts/props/charge.mp3",
	"taunts/props/cheese.mp3",
	"taunts/props/codec2.mp3",
	"taunts/props/come_get_some.mp3",
	"taunts/props/coolest.mp3",
	"taunts/props/cornholio.mp3",
	"taunts/props/danceallday.mp3",
	"taunts/props/danglyparts.mp3",
	"taunts/props/denied.mp3",
	"taunts/props/doh.mp3",
	"taunts/props/dontjuststandthere.mp3",
	"taunts/props/dontmiss.mp3",
	"taunts/props/downsyndrome.mp3",
	"taunts/props/dr_evil-frickin_idiots.mp3",
	"taunts/props/drweird.mp3",
	"taunts/props/epicsaxguy.mp3",
	"taunts/props/extreme.mp3",
	"taunts/props/eyebrow.mp3",
	"taunts/props/fail.mp3",
	"taunts/props/firinmahlazah.mp3",
	"taunts/props/foamydisappointment.mp3",
	"taunts/props/foamysuckass.mp3",
	"taunts/props/fs.mp3",
	"taunts/props/getawayfromme.mp3",
	"taunts/props/gofuckurself.mp3",
	"taunts/props/goteamretard.mp3",
	"taunts/props/haax.mp3",
	"taunts/props/hellochum.mp3",
	"taunts/props/heresjohnny.mp3",
	"taunts/props/hibitch.mp3",
	"taunts/props/howdoyoufuckthatup.mp3",
	"taunts/props/iamabanana.mp3",
	"taunts/props/icphokuspokus.mp3",
	"taunts/props/imakethislookgood.mp3",
	"taunts/props/improved.mp3",
	"taunts/props/indestructible.mp3",
	"taunts/props/island.mp3",
	"taunts/props/its_a_trap.mp3",
	"taunts/props/itssofluffeh.mp3",
	"taunts/props/kick_ass_and_chew_bubblegum.mp3",
	"taunts/props/knoboff.mp3",
	"taunts/props/letsdance.mp3",
	"taunts/props/lookatscreen.mp3",
	"taunts/props/loser.mp3",
	"taunts/props/losinghorn.mp3",
	"taunts/props/lrtaunt1.mp3",
	"taunts/props/matrix1.mp3",
	"taunts/props/mk4_scorpion.mp3",
	"taunts/props/morecowbell.mp3",
	"taunts/props/needtopiss.mp3",
	"taunts/props/nicemodel.mp3",
	"taunts/props/nixonshutup.mp3",
	"taunts/props/ohbugger.mp3",
	"taunts/props/owow.mp3",
	"taunts/props/owwhatthe.mp3",
	"taunts/props/patbottom.mp3",
	"taunts/props/pissin.mp3",
	"taunts/props/poopchute.mp3",
	"taunts/props/predator.mp3",
	"taunts/props/reacharound.mp3",
	"taunts/props/readytoget.mp3",
	"taunts/props/redvsbluenoeleven.mp3",
	"taunts/props/robotchicken.mp3",
	"taunts/props/scatman.mp3",
	"taunts/props/scout1.mp3",
	"taunts/props/screamgoat.mp3",
	"taunts/props/seethatcoming.mp3",
	"taunts/props/shit.mp3",
	"taunts/props/shithimself.mp3",
	"taunts/props/shutyourfuckingmouth.mp3",
	"taunts/props/slow1.mp3",
	"taunts/props/smb_star.mp3",
	"taunts/props/smell_u.mp3",
	"taunts/props/solong.mp3",
	"taunts/props/stopblowingholes.mp3",
	"taunts/props/suckstobeme.mp3",
	"taunts/props/sweetbeer1.wav",
	"taunts/props/thisiscrazy.mp3",
	"taunts/props/thx.mp3",
	"taunts/props/tightspot2.mp3",
	"taunts/props/tightspot3.mp3",
	"taunts/props/ts_english.mp3",
	"taunts/props/vincelovemynuts.mp3",
	"taunts/props/weak.mp3",
	"taunts/props/werehere.mp3",
	"taunts/props/whatislove.mp3",
	"taunts/props/whatthefu.mp3",
	"taunts/props/whipsomebodysass.mp3",
	"taunts/props/whoohoo.mp3",
	"taunts/props/wrong.mp3",
	"taunts/props/wtf_fmj.mp3",
	"taunts/props/you_will_never.mp3",
	"taunts/props/youareabitch.mp3",
	"taunts/props/yougotskills.mp3",
	"taunts/props/yousmellfunny.mp3",
	"taunts/props/dotheflop.mp3",
	"taunts/props/wellknowwerenotdead.mp3",
	"taunts/props/arrowtotheknee.mp3",
	"taunts/props/mchammer.mp3",
	"taunts/props/ibelieveicanfly.mp3",
	"taunts/props/walkdino.mp3",
	"taunts/props/allyoueverdo.mp3",
	"taunts/props/creeperboom.mp3",
	"taunts/props/doyousmoke.mp3",
	"taunts/props/getupoffathatthing.mp3",
	"taunts/props/ilikebigbutts.mp3",
	"taunts/props/leedle.mp3",
	"taunts/props/meatbicycle.mp3",
	"taunts/props/nannerpuss.mp3",
	"taunts/props/nooo.mp3",
	"taunts/props/ohbobsaget.mp3",
	"taunts/props/ohnoohyeah.mp3",
	"taunts/props/oneofthesekids.mp3",
	"taunts/props/pooptrain.mp3",
	"taunts/props/showmeyourgenitals.mp3",
	"taunts/props/shunthenonbeliever.mp3",	
	"taunts/props/anusisbleeding.mp3",
	"taunts/props/booty.mp3",
	"taunts/props/crappier.mp3",
	"taunts/props/cunning.mp3",
	"taunts/props/dew.mp3",
	"taunts/props/enterprise.mp3",
	"taunts/props/fuckingfair.mp3",
	"taunts/props/headon2.mp3",
	"taunts/props/imthemap.mp3",
	"taunts/props/justthrowgrenades.mp3",
	"taunts/props/nigelaaugh.mp3",
	"taunts/props/nipplesexplode.mp3",
	"taunts/props/nowtolookatasses.mp3",
	"taunts/props/shootmeagain.mp3",
	"taunts/props/win982.mp3"
	}
	
	local hunterButton={								//Hunter Button text list
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
	"Boom Headshot (long)",
	"Scout: Owning you",
	"It's showtime",
	"Farkin' sneaky bastage",
	}

	local hunterWString={								//Hunter net.WriteString(text)
	"taunts/hunters/canthide.mp3",
	"taunts/hunters/comeon.mp3",
	"taunts/hunters/crappyshot.mp3",
	"taunts/hunters/donotrun.mp3",
	"taunts/hunters/foiledagain.mp3",
	"taunts/hunters/gonnakill.mp3",
	"taunts/hunters/holyhandgrenade.mp3",
	"taunts/hunters/isuck.mp3",
	"taunts/hunters/missed.mp3",
	"taunts/hunters/ohmygod.mp3",
	"taunts/hunters/ohnowesuckagain.mp3",
	"taunts/hunters/pleasefondle.mp3",
	"taunts/hunters/taken-kill_you.mp3",
	"taunts/hunters/thepeyote.mp3",
	"taunts/hunters/watchyourback.mp3",
	"taunts/hunters/whopainted.mp3",
	"taunts/hunters/eatlead.mp3",
	"taunts/hunters/gettingpissedoff.mp3",
	"taunts/hunters/getwinged.mp3",
	"taunts/hunters/gogetthem.mp3",
	"taunts/hunters/holyfuckisthiswrong.mp3",
	"taunts/hunters/hunterchase.mp3",
	"taunts/hunters/dogchasingcars.mp3",
	"taunts/hunters/boomheadshotlong.mp3",
	"taunts/hunters/owningyou1.mp3",
	"taunts/hunters/showtime.mp3",
	"taunts/hunters/sneaky.mp3",
	}
	
	function IsAlive(pl)//Checks if player alive & if menu is not open
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
			chat.AddText(Color(214,0,0),"[Taunt Menu]", Color(0,225,126)," You are dead, you need to be alive to use this.")//Chat message for player.
		end	
	end
	 
	function TeamCheck(pl)//Checks player team & opens last visited page by player.
		
	end

	//Props
	function phmp(pl)//Prop Menu
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
		 p1_base = vgui.Create( "DFrame")//Menu Frame.
			p1_base:SetSize(176, 571) 
			p1_base:SetPos(0,(ScrH() / 2)-285)//932, old 779
			p1_base:SetTitle(team.GetName( LocalPlayer():Team() ).." - Page " .. pnp)
			p1_base:SetVisible( true )
			p1_base:SetDeleteOnClose(false)
			p1_base:ShowCloseButton(false)
			p1_base:SetDraggable(false)
			p1_base:MakePopup()
			p1_base:SetKeyBoardInputEnabled(false)
			p1_base:SetMouseInputEnabled(true)
			p1_base.Paint = function()
								draw.RoundedBox( 8, 0, 0, p1_base:GetWide(), p1_base:GetTall(), MenuColor )
							end
		local p1_base_bX = vgui.Create( "DButton", p1_base )	//Random Taunt Button
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
									net.WriteString(table.Random(propWString))
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
									end
		local p1_base_bX = vgui.Create( "DButton", p1_base )	//Close Menu Button
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
		local p1_base_bPrv = vgui.Create( "DButton", p1_base )	//Previous Page Button
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
		local p1_base_bNxt = vgui.Create( "DButton", p1_base )	//Next Page Button
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
		
		if propButton[bnp + 1] != nil then
		local b1 = vgui.Create("DButton", p1_base)	//Button1
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if propButton[bnp + 2] != nil then
		local b2 = vgui.Create( "DButton", p1_base )	//Button2
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if propButton[bnp + 3] != nil then
		local b3 = vgui.Create( "DButton", p1_base )	//Button3
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if propButton[bnp + 4] != nil then
		local b4 = vgui.Create( "DButton", p1_base )	//Button4
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if propButton[bnp + 5] != nil then
		local b5 = vgui.Create( "DButton", p1_base )	//Button5
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if propButton[bnp + 6] != nil then
		local b6 = vgui.Create( "DButton", p1_base )	//Button6
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if propButton[bnp + 7] != nil then
		local b7 = vgui.Create( "DButton", p1_base )	//Button7
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if propButton[bnp + 8] != nil then
		local b8 = vgui.Create( "DButton", p1_base )	//Button8
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if propButton[bnp + 9] != nil then
		local b9 = vgui.Create( "DButton", p1_base )	//Button9
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if propButton[bnp + 10] != nil then
		local b10 = vgui.Create( "DButton", p1_base )	//Button10
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if propButton[bnp + 11] != nil then
		local b11 = vgui.Create( "DButton", p1_base )	//Button11		
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if propButton[bnp + 12] != nil then
		local b12 = vgui.Create( "DButton", p1_base )	//Button12
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if propButton[bnp + 13] != nil then
		local b13 = vgui.Create( "DButton", p1_base )	//Button13
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if propButton[bnp + 14] != nil then
		local b14 = vgui.Create( "DButton", p1_base )	//Button14
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
	end
	
		//Hunters
	function phmh(pl)//Prop Menu
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
		p1_base = vgui.Create( "DFrame")//Menu Frame.
			p1_base:SetSize(176, 571) 
			p1_base:SetPos(0,(ScrH() / 2)-285)//932, old 779
			p1_base:SetTitle(team.GetName( LocalPlayer():Team() ).." - Page " .. pnh)
			p1_base:SetVisible( true )
			p1_base:SetDeleteOnClose(false)
			p1_base:ShowCloseButton(false)
			p1_base:SetDraggable(false)
			p1_base:MakePopup()
			p1_base:SetKeyBoardInputEnabled(false)
			p1_base:SetMouseInputEnabled(true)
			p1_base.Paint = function()
								draw.RoundedBox( 8, 0, 0, p1_base:GetWide(), p1_base:GetTall(), MenuColor )
							end
		local p1_base_bX = vgui.Create( "DButton", p1_base )	//Random Taunt Button
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
									net.WriteString(table.Random(hunterWString))
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
									end
		local p1_base_bX = vgui.Create( "DButton", p1_base )	//Close Menu Button
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
		local p1_base_bPrv = vgui.Create( "DButton", p1_base )	//Previous Page Button
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
		local p1_base_bNxt = vgui.Create( "DButton", p1_base )	//Next Page Button
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
		
		if hunterButton[bnh + 1] != nil then
		local b1 = vgui.Create("DButton", p1_base)	//Button1
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if hunterButton[bnh + 2] != nil then
		local b2 = vgui.Create( "DButton", p1_base )	//Button2
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if hunterButton[bnh + 3] != nil then
		local b3 = vgui.Create( "DButton", p1_base )	//Button3
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if hunterButton[bnh + 4] != nil then
		local b4 = vgui.Create( "DButton", p1_base )	//Button4
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if hunterButton[bnh + 5] != nil then
		local b5 = vgui.Create( "DButton", p1_base )	//Button5
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if hunterButton[bnh + 6] != nil then
		local b6 = vgui.Create( "DButton", p1_base )	//Button6
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if hunterButton[bnh + 7] != nil then
		local b7 = vgui.Create( "DButton", p1_base )	//Button7
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if hunterButton[bnh + 8] != nil then
		local b8 = vgui.Create( "DButton", p1_base )	//Button8
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if hunterButton[bnh + 9] != nil then
		local b9 = vgui.Create( "DButton", p1_base )	//Button9
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if hunterButton[bnh + 10] != nil then
		local b10 = vgui.Create( "DButton", p1_base )	//Button10
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if hunterButton[bnh + 11] != nil then
		local b11 = vgui.Create( "DButton", p1_base )	//Button11		
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if hunterButton[bnh + 12] != nil then
		local b12 = vgui.Create( "DButton", p1_base )	//Button12
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if hunterButton[bnh + 13] != nil then
		local b13 = vgui.Create( "DButton", p1_base )	//Button13
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
		
		if hunterButton[bnh + 14] != nil then
		local b14 = vgui.Create( "DButton", p1_base )	//Button14
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
								net.SendToServer()
								p1_base:Close() pl.MenuOpen=0;
							end
		else end
	end
	
	//Hook List 
	hook.Add("phmp","Calling Prop Menu",phmp)//Hook to call phmp(Props)
	hook.Add("phmh","Calling Prop Menu",phmh)//Hook to call phmh(Hunters)
	hook.Add("TeamCheck","Call check pl.Team()",TeamCheck)//Hook to call TeamCheck
	
	local FKeyMenus = {
		KEY_F3 = IsAlive;
	};
	hook.Add( "PlayerBindPress", "PlayerBindPressFKeyMenus", function( _p, _bind, pressed )
		local _key = "KEY_" .. string.upper( input.LookupBinding( _bind ) );
		local _func = FKeyMenus[ _key ];
		if ( _func ) then  
			_func( LocalPlayer() );
		end 
	end);
end
