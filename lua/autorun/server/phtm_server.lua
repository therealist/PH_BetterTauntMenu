--//-------------------------------------------------------------------
--//
--//	DISTRO: 		Better Taunt Menu
--//	AUTHORS:		Vash Baldeus, Sean Hayes
--//	BASE:			AMT Prop Hunt
--//	BUILD:			v2.0
--//	RELEASE:		08.11.2020
--//	LICENSED TO:	GNU Public v3.0
--//				
--//	> phtm_server.lua
--//	This file contains the server-side code for the
--//	Prop Hunt taunt menu.
--//
--//-------------------------------------------------------------------

if ( SERVER )	then 
	util.AddNetworkString("send_taunt")
	net.Receive( "send_taunt", function( _, ply )
		local taunt = net.ReadString()
		local length = net.ReadFloat()
		local curtime = CurTime()
		if curtime > ply:GetNWFloat("nexttaunt") then
			if ply:Alive() then
				local timestaunted = ply:GetNWInt("timestaunted")
				timestaunted = timestaunted + 1
				ply:EmitSound(taunt,150)
				ply:SetNWFloat("lasttaunt", curtime)
				ply:SetNWFloat("nexttaunt", curtime + length)
				ply:SetNWFloat("tauntlength", length)
				ply:SetNWInt("timestaunted", timestaunted)
				ply.nexttaunt = curtime + length
			end
		else
			ply:ChatPrint("Please wait before taunting again")
		end
	end )
end
