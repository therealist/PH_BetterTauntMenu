--//-------------------------------------------------------------------
--//
--//	DISTRO: 		Better Taunt Menu
--//	AUTHORS:		Vash Baldeus, Sean Hayes
--//	BASE:			AMT Prop Hunt
--//	BUILD:			v2.0
--//	RELEASE:		08.11.2020
--//	LICENSED TO:	GNU Public v3.0
--//				
--//	> sv_lengthfinder.lua
--//	This file contains the client-side code for the
--//	Prop Hunt taunt menu.
--//
--//-------------------------------------------------------------------


--// SPECIAL PREPARATION INSTRUCTIONS: SEE THIS FIRST
--// STEP 01. Acquire sound files. These can be either WAV or MP3 format.
--// STEP 02. Use a program like Audacity to trim silence from the beginning/end of your sound files.
--// STEP 03. Ensure all your files are the same sample rate (44.1kHz) and bit depth (16 bit).
--// STEP 04. Make a copy of your files.
--// STEP 05. Use a program like Audacity to convert the copied files to WAV format in MONO only.
--// STEP 06. Move the copied files to desired location in your Garrysmod sound directory.
--// STEP 07. Change filepath below to match whatever comes after "sound/" in your new directory.
--// STEP 08. Type getwavlengths in console and wait 10-15 seconds.
--// STEP 09. Open the wavlengths.txt file in garrysmod/data.
--// STEP 10. Copy the table to your sh_config file.
--// STEP 11. Change BUTTON_NAME to whatever you want shown on the taunt menu button.
--// STEP 12. Change the file extension back to .mp3 for any MP3s in your original files.
--// STEP 13. Delete the copied files, and place the originals in the same directory.
--// STEP 14. If you have done everything correctly, both WAV and MP3s should have lengths now.
--// STEP 15. Repeat for any additional directories as needed.


--// Place the filepaths to the wavs you want to find the length of. Outputs to data folder. Files MUST be MONO.
--// If files are not MONO, length will return double its actual value.
--// Tabulation is formatted for Notepad++.
if SERVER then
	filepath = "rlg/taunts/props/"
	intermed = {}
	outtable = {}

	concommand.Add("getwavlengths", function(ply, cmd, args)
	intermed, nouse = file.Find("sound/" .. filepath .. "*.wav", "GAME")
	for _, v in ipairs(intermed) do
		outtable[#outtable + 1] = filepath .. v
	end
	
	PROP_TAUNTS_WAVS = outtable
	tabchr = "	"
		tsize = #PROP_TAUNTS_WAVS
		for k, v in pairs (PROP_TAUNTS_WAVS) do
			pathchrsize = string.len(v)
			sizeintabs = math.floor(pathchrsize / 4)
			tabcount = 10 - sizeintabs
			for i=0, tabcount, 1 do
				tabchr = tabchr .. "	"
			end
			
			if file.Read("wavlengths.txt") == nil then
				towrite = "{\"BUTTON_NAME\", 						\"" .. v .. "\", " .. tabchr .. math.Round(SoundDuration(v), 8) .. "},\n"
				tabchr = "	"
			else
				if k < tsize then 
					towrite = file.Read("wavlengths.txt") .. "{\"BUTTON_NAME\", 						\"" .. v .. "\", " .. tabchr .. math.Round(SoundDuration(v), 8) .. "},\n"
				else
					towrite = file.Read("wavlengths.txt") .. "{\"BUTTON_NAME\", 						\"" .. v .. "\", " .. tabchr .. math.Round(SoundDuration(v), 8) .. "}\n"
				end
			end
			tabchr = "	"
				file.Write("wavlengths.txt", towrite)
		end
	
	end)
end
