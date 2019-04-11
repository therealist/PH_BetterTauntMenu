if ( SERVER )	then 
	TAUNT_DELAY = 6		//Taunt Delay Variable
	util.AddNetworkString("send_taunt")
	net.Receive( "send_taunt", function( _, ply )
		local taunt = net.ReadString()
		local curtime = CurTime()
		if CurTime() > ply:GetNWFloat("nexttaunt") then
			if ply:Alive() then
				local timestaunted = ply:GetNWInt("timestaunted")
				timestaunted = timestaunted + 1
				ply:EmitSound(taunt,150)
				ply:SetNWFloat("lasttaunt", CurTime())
				ply:SetNWFloat("nexttaunt", CurTime() + TAUNT_DELAY)
				ply:SetNWInt("timestaunted", timestaunted)
				ply.nexttaunt = CurTime() + TAUNT_DELAY
			end
		else
			ply:ChatPrint("Please wait before taunting again")
		end
	end )
end
