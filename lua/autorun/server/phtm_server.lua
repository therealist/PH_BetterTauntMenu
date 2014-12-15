if ( SERVER )	then 
	local TAUNT_DELAY = 6		//Taunt Delay Variable

	util.AddNetworkString("send_taunt")
	net.Receive( "send_taunt", function( _, ply )
		local taunt = net.ReadString()
		local curTime = CurTime()
		if curTime - ( ply.LastTaunt or 0 ) >= TAUNT_DELAY then
			ply.LastTaunt = CurTime() + TAUNT_DELAY
			if ply:Alive() then
				ply:EmitSound(taunt,150)
			else end
		else
			ply:ChatPrint("Please wait another " .. string.NiceTime( math.abs( curTime - (TAUNT_DELAY + ply.LastTaunt) ) ) .. " seconds before taunting again")
		end
	end )
end
