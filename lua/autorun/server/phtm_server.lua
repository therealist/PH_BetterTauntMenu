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
