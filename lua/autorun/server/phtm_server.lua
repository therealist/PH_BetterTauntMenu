if ( SERVER )	then 
	local TAUNT_DELAY = 3		//Taunt Delay Variable

	util.AddNetworkString("send_taunt")
	net.Receive( "send_taunt", function( _, ply )
		local taunt = net.ReadString()
		local curTime = CurTime()
		if curTime - ( ply.LastTaunt or 0 ) >= TAUNT_DELAY then
			ply.LastTaunt = CurTime() + TAUNT_DELAY
			if ply:Alive() then
				ply:EmitSound(taunt,150)
			else end
		end
	end )
end
