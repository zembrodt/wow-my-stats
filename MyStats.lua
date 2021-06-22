-------------------------------------
--     MyStats v1.1.2 (BETA 1.4)     --
--       Author: WildCat-Man       --
--   Originally Started: 5/13/09   --
--  Originally Completed: 5/15/09  --
--      v1.1.2 Started: 5/20/09      --
--     v1.1.2 Completed: 5/20/09     --
-------------------------------------

--[[
	Go to the ReadMe file (MyStats/ReadMe/ReadMe.txt) for version history,
	contact information, further help and information, and steps on how to
	translate this AddOn to your language!
]]

----- Variables -----
local startTime = 0
local endTime = 0
local totalTime = 0
local totalDmg = 0

strOld = 0
strNew = 0
strDiff = 0
agiOld = 0
agiNew = 0
agiDiff = 0
staOld = 0
staNew = 0
staDiff = 0
intOld = 0
intNew = 0
intDiff = 0
sprOld = 0
sprNew = 0
sprDiff = 0
armrOld = 0
armrNew = 0
armrDiff = 0

stringWidth = {}
---------------------

--------------------------
--		UnitStat IDs:	--
--------------------------
--		1 Strength		--
--		2 Agility		--
--		3 Stamina		--
--		4 Intellect		--
--		5 Spirit		--
--------------------------

-- Move frame when mouse is clicked on it.
function MyStatsMainFrame_OnMouseDown()
	MyStatsMainFrame:StartMoving()
end
-- Stop frame when mouse unclicks from it.
function MyStatsMainFrame_OnMouseUp()
	MyStatsMainFrame:StopMovingOrSizing()
end
-- Close the frame when CloseButton is clicked.
function MyStatsMainFrame_CloseButton_OnClick()
	MyStatsMainFrame:Hide()
end
-- Set all combat stats back to 0 when RefreshButton is clicked.
-- Delete all '(+/- #)' next to stats.
function MyStatsMainFrame_RefreshButton_OnClick()
	MyStatsMainFrame_DamageTxt:SetText(MYSTATS_DAMAGE .. ": 0")
	MyStatsMainFrame_DpsTxt:SetText(MYSTATS_DPS .. ": 0.00")
	MyStatsMainFrame_TimeTxt:SetText(MYSTATS_TIME .. ": 0 " .. MYSTATS_SECONDS)
	totalTime = 0
	totalDmg = 0
	averageDps = 0
	
	local BaseStr, StatStr, PosBuffStr, NegBuffStr = UnitStat("player",1)
	strOld = StatStr
	MyStatsMainFrame_StrengthTxt:SetText(MYSTATS_STR .. ": " .. StatStr .. " ".. PosBuffStr .. " " .. NegBuffStr)
	local BaseAgi, StatAgi, PosBuffAgi, NegBuffAgi = UnitStat("player",2)
	agiOld = StatAgi
	MyStatsMainFrame_AgilityTxt:SetText(MYSTATS_AGI..": " .. StatAgi .. " " .. PosBuffAgi .. " " .. NegBuffAgi)
	local BaseSta, StatSta, PosBuffSta, NegBuffSta = UnitStat("player",3)
	staOld = StatSta
	MyStatsMainFrame_StaminaTxt:SetText(MYSTATS_STA..": "..StatSta.." " .. PosBuffSta.." ".. NegBuffSta)
	local BaseInt, StatInt, PosBuffInt, NegBuffInt = UnitStat("player",4)
	intOld = StatInt
	MyStatsMainFrame_IntellectTxt:SetText(MYSTATS_INT .. ": " .. BaseInt .. " " .. PosBuffInt .. " " .. NegBuffInt)
	local BaseSpr, StatSpr, PosBuffSpr, NegBuffSpr = UnitStat("player",5)
	sprOld = StatSpr
	MyStatsMainFrame_SpiritTxt:SetText(MYSTATS_SPR .. ": " .. BaseSpr .. " " .. PosBuffSpr .. " " .. NegBuffSpr)
	local BaseArmr, StatArmr, Armr, PosBuffArmr, NegBuffArmr = UnitArmor("player")
	armrOld = StatArmr
	MyStatsMainFrame_ArmorTxt:SetText(MYSTATS_ARMOR .. ": " .. StatArmr .. " " .. PosBuffArmr .. " " .. NegBuffArmr)
	
	local strWidth = MyStatsMainFrame_StrengthTxt:GetWidth()
	local agiWidth = MyStatsMainFrame_AgilityTxt:GetWidth()
	local staWidth = MyStatsMainFrame_StaminaTxt:GetWidth()
	local intWidth = MyStatsMainFrame_IntellectTxt:GetWidth()
	local sprWidth = MyStatsMainFrame_SpiritTxt:GetWidth()
	local armrWidth = MyStatsMainFrame_ArmorTxt:GetWidth()
	local combatWidth = MyStatsMainFrame_CombatTxt:GetWidth()
	local dmgWidth = MyStatsMainFrame_DamageTxt:GetWidth()
	local dpsWidth = MyStatsMainFrame_DpsTxt:GetWidth()
	local timeWidth = MyStatsMainFrame_TimeTxt:GetWidth()
	
	local maxLength = math.max(strWidth,agiWidth,staWidth,intWidth,sprWidth,armrWidth,combatWidth,dmgWidth,dpsWidth,timeWidth)
	
	MyStatsMainFrame:SetWidth(maxLength + 15)
end
-- Load frame, events, player's stats, variables, startup messages, and slash commands
-- when player enters the world.
function MyStatsMainFrame_OnLoad()
	MyStatsMainFrame:Show()
	
	MyStatsMainFrame:RegisterEvent("UNIT_STATS")
	MyStatsMainFrame:RegisterEvent("UNIT_COMBAT")
	MyStatsMainFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
	MyStatsMainFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
	
	MyStatsMainFrame_RefreshButton_OnClick()
	
	local strWidth = MyStatsMainFrame_StrengthTxt:GetWidth()
	table.insert(stringWidth,1,strWidth)
	local agiWidth = MyStatsMainFrame_AgilityTxt:GetWidth()
	table.insert(stringWidth,2,agiWidth)
	local staWidth = MyStatsMainFrame_StaminaTxt:GetWidth()
	table.insert(stringWidth,3,staWidth)
	local intWidth = MyStatsMainFrame_IntellectTxt:GetWidth()
	table.insert(stringWidth,4,intWidth)
	local sprWidth = MyStatsMainFrame_SpiritTxt:GetWidth()
	table.insert(stringWidth,5,sprWidth)
	local armrWidth = MyStatsMainFrame_ArmorTxt:GetWidth()
	table.insert(stringWidth,6,armrWidth)
	local combatWidth = MyStatsMainFrame_CombatTxt:GetWidth()
	table.insert(stringWidth,7,combatWidth)
	local dmgWidth = MyStatsMainFrame_DamageTxt:GetWidth()
	table.insert(stringWidth,8,dmgWidth)
	local dpsWidth = MyStatsMainFrame_DpsTxt:GetWidth()
	table.insert(stringWidth,9,dpsWidth)
	local timeWidth = MyStatsMainFrame_TimeTxt:GetWidth()
	table.insert(stringWidth,10,timeWidth)
	
	MyStatsMainFrame:SetWidth(getMaxStringLength(stringWidth) + 15)
	
	local BaseStr, StatStr, PosBuffStr, NegBuffStr = UnitStat("player",1)
	local BaseAgi, StatAgi, PosBuffAgi, NegBuffAgi = UnitStat("player",2)
	local BaseSta, StatSta, PosBuffSta, NegBuffSta = UnitStat("player",3)
	local BaseInt, StatInt, PosBuffInt, NegBuffInt = UnitStat("player",4)
	local BaseSpr, StatSpr, PosBuffSpr, NegBuffSpr = UnitStat("player",5)
	local BaseArmr, StatArmr, Armr, PosBuffArmr, NegBuffArmr = UnitArmor("player")
	
	MyStatsMainFrame_StrengthTxt:SetText(MYSTATS_STR .. ": " .. StatStr .. " " .. PosBuffStr .. " " .. NegBuffStr)
	MyStatsMainFrame_AgilityTxt:SetText(MYSTATS_AGI .. ": " .. StatAgi .. " " .. PosBuffAgi .. " " .. NegBuffAgi)
	MyStatsMainFrame_StaminaTxt:SetText(MYSTATS_STA .. ": " .. BaseSta .. " " .. PosBuffSta .. " " .. NegBuffSta)
	MyStatsMainFrame_IntellectTxt:SetText(MYSTATS_INT .. ": " .. BaseInt .. " " .. PosBuffInt .. " " .. NegBuffInt)
	MyStatsMainFrame_SpiritTxt:SetText(MYSTATS_SPR .. ": " .. StatSpr .. " " .. PosBuffSpr .. " " .. NegBuffSpr)
	MyStatsMainFrame_ArmorTxt:SetText(MYSTATS_ARMOR .. ": " .. Armr .. " " .. PosBuffArmr .. " " .. NegBuffArmr)
	
	strOld = StatStr
	agiOld = StatAgi
	staOld = StatSta
	intOld = StatInt
	sprOld = StatSpr
	armrOld = Armr
	
	
	
	MyStatsMainFrame_DamageTxt:SetText(MYSTATS_DAMAGE .. ": 0")
	MyStatsMainFrame_DpsTxt:SetText(MYSTATS_DPS .. ": 0.00")
	MyStatsMainFrame_TimeTxt:SetText(MYSTATS_TIME .. ": 0 " .. MYSTATS_SECONDS)
	
	DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT..MYSTATS_TITLE.."|r: "..ORANGE_FONT..MYSTATS_VERSION.."|r ("..RED_FONT..MYSTATS_BETA.."|r) "..MYSTATS_LOADED)
	DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT..MYSTATS_TYPE.."|r /mystatshelp "..GREEN_FONT..MYSTATS_FORINFO.."|r")
	
	SlashCmdList["MYSTATS"] = MyStats_SlashCmdHandler_Main;
	SLASH_MYSTATS1 = "/mystats"
	SLASH_MYSTATS2 = "/ms"
	
	SlashCmdList["MYSTATSREFRESH"] = MyStats_SlashCmdHandler_Refresh;
	SLASH_MYSTATSREFRESH1 = "/mystatsrefresh"
	SLASH_MYSTATSREFRESH2 = "/msrefresh"
	
	SlashCmdList["MYSTATSHELP"] = MyStats_SlashCmdHandler_Help;
	SLASH_MYSTATSHELP1 = "/mystatshelp"
	SLASH_MYSTATSHELP2 = "/mshelp"
	
	SlashCmdList["MYSTATSVERSION"] = MyStats_SlashCmdHandler_Version;
	SLASH_MYSTATSVERSION1 = "/mystatsversion"
	SLASH_MYSTATSVERSION2 = "/mystatsv"
	SLASH_MYSTATSVERSION3 = "/msversion"
	SLASH_MYSTATSVERSION4 = "/msv"
	
	SlashCmdList["MYSTATSCMD"] = MyStats_SlashCmdHandler_Cmd;
	SLASH_MYSTATSCMD1 = "/mystatscommands"
	SLASH_MYSTATSCMD2 = "/mystatscmd"
	SLASH_MYSTATSCMD3 = "/mscommands"
	SLASH_MYSTATSCMD4 = "/mscmd"
end
-- Opens the frame when Main slash commands are entered.
function MyStats_SlashCmdHandler_Main()
	MyStatsMainFrame:Show()
end
-- Sets all combat stats to 0 when Refresh commands are entered.
-- (Basically clicks on the RefreshButton for the player)
function MyStats_SlashCmdHandler_Refresh()
	MyStatsMainFrame_RefreshButton_OnClick()
end
-- Displays the Help message when the Help commands are entered.
function MyStats_SlashCmdHandler_Help()
	DEFAULT_CHAT_FRAME:AddMessage(MYSTATS_HELLO..MYSTATS_TITLE.." "..MYSTATS_VERSION.."\n\n"..MYSTATS_HELP1.."\n"..MYSTATS_DIRECTIONS.."\n"..MYSTATS_HELP2)
end
-- Displays the Version message when the Version commands are entered.
function MyStats_SlashCmdHandler_Version()
	DEFAULT_CHAT_FRAME:AddMessage(MYSTATS_THISIS.." "..MYSTATS_TITLE.." "..MYSTATS_VERSION.." ("..MYSTATS_BETA..") \n"..MYSTATS_README1.."\n"..MYSTATS_README2)
end
-- Displays the Commands message when the Cmd commands are entered.
function MyStats_SlashCmdHandler_Cmd()
	DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT..MYSTATS_CMDFOR.."|r "..MYSTATS_TITLE.." "..GREEN_FONT..MYSTATS_VERSION.."|r\n\nMYSTATS\n/mystats\n/ms\n\n"..MYSTATS_REFRESHSTATS.."\n/mystatsrefresh\n/msrefresh\n\n"..MYSTATS_HELP.."\n/mystatshelp\n/mshelp\n\n"..MYSTATS_VERSIONTXT.."\n/mystatsversion\n/mystatsv\n/msversion\n/msv\n\n"..MYSTATS_COMMANDS.."\n/mystatscommands\n/mystatscmd\n/mscommands\n/mscmd")
end

function getMaxStringLength(stringTable)
	local maxLength = 0;
	local i, length;
	for i,length in ipairs(stringTable) do
		if length > maxLength then
			maxLength = length;
		end
	end
	return maxLength;
end	
-- Controls whether or not player is in combat, not in combat, and the damage
-- the player is receiving. The updates the combat stats with these stats.
-- (Damage the player is taking (total), the average DPS the player is receiving,
-- and the amount of time the player has been in combat)
-- Updates the regular stats when the players stats change.
-- Shows the (+ #) next to stats.
function MyStatsMainFrame_OnEvent(frame, event, ...)
	if event == "PLAYER_REGEN_ENABLED" then
		endTime = GetTime()
		totalTime = endTime - startTime
		averageDps = totalDmg / totalTime
		MyStatsMainFrame_CombatTxt:SetText(MYSTATS_NOTINCOMBAT)
		MyStatsMainFrame_Combat_Text()
	elseif event == "PLAYER_REGEN_DISABLED" then
		MyStatsMainFrame_CombatTxt:SetText(MYSTATS_INCOMBAT)
		totalDamage = 0
		startTime = GetTime()
	elseif event == "UNIT_COMBAT" then
		if not InCombatLockdown() then
		
		else
			local unit,action,modifier,damage,damagetype = ...
			if unit == "player" and action ~= "HEAL" then 
				totalDmg = totalDmg + damage
				endTime = GetTime()
				totalTime = endTime - startTime
				averageDps = totalDmg / totalTime
				MyStatsMainFrame_Combat_Text()
			end
		end
	end
	
	if event == "UNIT_STATS" then
		local BaseStr, StatStr, PosBuffStr, NegBuffStr = UnitStat("player",1)
		local BaseAgi, StatAgi, PosBuffAgi, NegBuffAgi = UnitStat("player",2)
		local BaseSta, StatSta, PosBuffSta, NegBuffSta = UnitStat("player",3)
		local BaseInt, StatInt, PosBuffInt, NegBuffInt = UnitStat("player",4)
		local BaseSpr, StatSpr, PosBuffSpr, NegBuffSpr = UnitStat("player",5)
		local BaseArmr, StatArmr, Armr, PosBuffArmr, NegBuffArmr = UnitArmor("player")
		--[[
		if PosBuffStr > 0 then
			MyStatsMainFrame_StrengthTxt:SetText(MYSTATS_STR..": " ..StatStr .. " " .. PosBuffStr .. " " .. NegBuffStr)
			strOld = StatStr
		elseif PosBuffAgi > 0 then
			MyStatsMainFrame_AgilityTxt:SetText(MYSTATS_AGI..": " .. StatAgi .. " " .. PosBuffAgi .. " " .. NegBuffAgi)
			agiOld = StatAgi
		elseif PosBuffSta > 0 then
			MyStatsMainFrame_StaminaTxt:SetText(MYSTATS_STA..": " .. StatSta .. " " .. PosBuffSta .. " " .. NegBuffSta)
			staOld = StatSta
		elseif PosBuffInt > 0 then
			MyStatsMainFrame_IntellectTxt:SetText(MYSTATS_INT..": " .. BaseInt .. " " .. PosBuffInt .. " " .. NegBuffInt)
			intOld = StatInt
		elseif PosBuffSpr > 0 then
			MyStatsMainFrame_SpiritTxt:SetText(MYSTATS_SPR..": " .. StatSpr .. " " .. PosBuffSpr .. " " .. NegBuffSpr)
			sprOld = StatSpr
		elseif PosBuffArmr > 0 then
			MyStatsMainFrame_ArmorTxt:SetText(MYSTATS_ARMOR .. ": " .. StatArmr .. " " .. PosBuffArmr .. " " .. NegBuffArmr)
			armrOld = StatArmr
		end
		if PosBuffStr == 0 then
			MyStatsMainFrame_StrengthTxt:SetText(MYSTATS_STR .. ": " ..BaseStr .. " " .. PosBuffStr .. " "..NegBuffStr)
			strNew = BaseStr
		elseif PosBuffAgi == 0 then
			MyStatsMainFrame_AgilityTxt:SetText(MYSTATS_AGI ..": "..BaseAgi.." "..PosBuffAgi.." "..NegBuffAgi)
			agiNew = BaseAgi
		elseif PosBuffSta == 0 then
			MyStatsMainFrame_StaminaTxt:SetText(MYSTATS_STA..": "..BaseSta.." "..PosBuffSta.." "..NegBuffSta)
			staNew = BaseSta
		elseif PosBuffArmr == 0 then
			MyStatsMainFrame_ArmorTxt:SetText(MYSTATS_ARMOR..": "..BaseArmr.." "..PosBuffArmr.." "..NegBuffArmr)
			armrNew = BaseArmr
		end]]
	
		MyStatsMainFrame_StrengthTxt:SetText(MYSTATS_STR .. ": " .. StatStr .. " " .. PosBuffStr .. " " .. NegBuffStr)
		MyStatsMainFrame_AgilityTxt:SetText(MYSTATS_AGI .. ": " .. StatAgi .. " " .. PosBuffAgi .. " " .. NegBuffAgi)
		MyStatsMainFrame_StaminaTxt:SetText(MYSTATS_STA .. ": " .. BaseSta .. " " .. PosBuffSta .. " " .. NegBuffSta)
		MyStatsMainFrame_IntellectTxt:SetText(MYSTATS_INT .. ": " .. BaseInt .. " " .. PosBuffInt .. " " .. NegBuffInt)
		MyStatsMainFrame_SpiritTxt:SetText(MYSTATS_SPR .. ": " .. StatSpr .. " " .. PosBuffSpr .. " " .. NegBuffSpr)
		MyStatsMainFrame_ArmorTxt:SetText(MYSTATS_ARMOR .. ": " .. Armr .. " " .. PosBuffArmr .. " " .. NegBuffArmr)
		
		strNew = StatStr
		agiNew = StatAgi
		staNew = StatSta
		intNew = StatInt
		sprNew = StatSpr
		armrNew = StatArmr

		if ( strOld > strNew ) then
			strDiff = strOld - strNew
			MyStatsMainFrame_StrengthTxt:SetText(MYSTATS_STR .. ": " .. StatStr .. " (-"..strDiff..") ".. PosBuffStr .. " " .. NegBuffStr)
		elseif ( strOld < strNew ) then
			strDiff = strNew - strOld
			MyStatsMainFrame_StrengthTxt:SetText(MYSTATS_STR .. ": " .. StatStr .. " (+"..strDiff..") ".. PosBuffStr .. " " .. NegBuffStr)
		else
			strDiff = 0
			MyStatsMainFrame_StrengthTxt:SetText(MYSTATS_STR .. ": " .. StatStr .. " (+"..strDiff..") ".. PosBuffStr .. " " .. NegBuffStr)
		end
		
		if ( agiOld > agiNew ) then
			agiDiff = agiOld - agiNew
			MyStatsMainFrame_AgilityTxt:SetText(MYSTATS_AGI .. ": " .. StatAgi .. " (-"..agiDiff..") ".. PosBuffAgi .. " " .. NegBuffAgi)
		elseif ( agiOld < agiNew ) then
			agiDiff = agiNew - agiOld
			MyStatsMainFrame_AgilityTxt:SetText(MYSTATS_AGI .. ": " .. StatAgi .. " (+"..agiDiff..") ".. PosBuffAgi .. " " .. NegBuffAgi)
		else
			agiDiff = 0
			MyStatsMainFrame_AgilityTxt:SetText(MYSTATS_AGI .. ": " .. StatAgi .. " (+"..agiDiff..") ".. PosBuffAgi .. " " .. NegBuffAgi)
		end
		
		if ( staOld > staNew ) then
			staDiff = staOld - staNew
			MyStatsMainFrame_StaminaTxt:SetText(MYSTATS_STA .. ": " .. StatSta .. " (-"..staDiff..") ".. PosBuffSta .. " " .. NegBuffSta)
		elseif ( staOld < staNew ) then
			staDiff = staNew - staOld
			MyStatsMainFrame_StaminaTxt:SetText(MYSTATS_STA .. ": " .. StatSta .. " (+"..staDiff..") ".. PosBuffSta .. " " .. NegBuffSta)
		else
			staDiff = 0
			MyStatsMainFrame_StaminaTxt:SetText(MYSTATS_STA .. ": " .. StatSta .. " (+"..staDiff..") ".. PosBuffSta .. " " .. NegBuffSta)
		end
		
		if ( intOld > intNew ) then
			intDiff = intOld - intNew
			MyStatsMainFrame_IntellectTxt:SetText(MYSTATS_INT .. ": " .. StatInt .. " (-"..intDiff..") ".. PosBuffInt .. " " .. NegBuffInt)
		elseif ( agiOld < agiNew ) then
			agiDiff = agiNew - agiOld
			MyStatsMainFrame_IntellectTxt:SetText(MYSTATS_INT .. ": " .. StatInt .. " (+"..intDiff..") ".. PosBuffInt .. " " .. NegBuffInt)
		else
			intDiff = 0
			MyStatsMainFrame_IntellectTxt:SetText(MYSTATS_INT .. ": " .. StatInt .. " (+"..intDiff..") ".. PosBuffInt .. " " .. NegBuffInt)
		end
		
		if ( sprOld > sprNew ) then
			sprDiff = sprOld - sprNew
			MyStatsMainFrame_SpiritTxt:SetText(MYSTATS_SPR .. ": " .. StatSpr .. " (-"..sprDiff..") ".. PosBuffSpr .. " " .. NegBuffSpr)
		elseif ( sprOld < sprNew ) then
			sprDiff = sprNew - sprOld
			MyStatsMainFrame_SpiritTxt:SetText(MYSTATS_SPR .. ": " .. StatSpr .. " (+"..sprDiff..") ".. PosBuffSpr .. " " .. NegBuffSpr)
		else
			sprDiff = 0
			MyStatsMainFrame_SpiritTxt:SetText(MYSTATS_SPR .. ": " .. StatSpr .. " (+"..sprDiff..") ".. PosBuffSpr .. " " .. NegBuffSpr)
		end
		
		if ( armrOld > armrNew ) then
			armrDiff = armrOld - armrNew
			MyStatsMainFrame_ArmorTxt:SetText(MYSTATS_ARMOR .. ": " .. StatArmr .. " (-"..armrDiff..") ".. PosBuffArmr .. " " .. NegBuffArmr)
		elseif ( armrOld < armrNew ) then
			armrDiff = armrNew - armrOld
			MyStatsMainFrame_ArmorTxt:SetText(MYSTATS_ARMOR .. ": " .. StatArmr .. " (+"..armrDiff..") ".. PosBuffArmr .. " " .. NegBuffArmr)
		else
			armrDiff = 0
			MyStatsMainFrame_ArmorTxt:SetText(MYSTATS_ARMOR .. ": " .. StatArmr .. " (+"..armrDiff..") ".. PosBuffArmr .. " " .. NegBuffArmr)
		end
		
		local strWidth = MyStatsMainFrame_StrengthTxt:GetWidth()
		table.insert(stringWidth,1,strWidth)
		local agiWidth = MyStatsMainFrame_AgilityTxt:GetWidth()
		table.insert(stringWidth,2,agiWidth)
		local staWidth = MyStatsMainFrame_StaminaTxt:GetWidth()
		table.insert(stringWidth,3,staWidth)
		local intWidth = MyStatsMainFrame_IntellectTxt:GetWidth()
		table.insert(stringWidth,4,intWidth)
		local sprWidth = MyStatsMainFrame_SpiritTxt:GetWidth()
		table.insert(stringWidth,5,sprWidth)
		local armrWidth = MyStatsMainFrame_ArmorTxt:GetWidth()
		table.insert(stringWidth,6,armrWidth)
		local combatWidth = MyStatsMainFrame_CombatTxt:GetWidth()
		table.insert(stringWidth,7,combatWidth)
		local dmgWidth = MyStatsMainFrame_DamageTxt:GetWidth()
		table.insert(stringWidth,8,dmgWidth)
		local dpsWidth = MyStatsMainFrame_DpsTxt:GetWidth()
		table.insert(stringWidth,9,dpsWidth)
		local timeWidth = MyStatsMainFrame_TimeTxt:GetWidth()
		table.insert(stringWidth,10,timeWidth)
		
		MyStatsMainFrame:SetWidth(getMaxStringLength(stringWidth) + 15)
	end
end
-- Updates combat stats every time the player receives more damage. 
-- (Time only refreshes when player receives damage, does not update
-- in real time)
function MyStatsMainFrame_Combat_Text()
	local dmgTxtFormat = string.format(MYSTATS_DAMAGE .. ": %d", totalDmg)
	MyStatsMainFrame_DamageTxt:SetText(dmgTxtFormat)
	local dpsTxtFormat = string.format(MYSTATS_DPS .. ": %.2f", averageDps)
	MyStatsMainFrame_DpsTxt:SetText(dpsTxtFormat)
	local timeTxtFormat = string.format(MYSTATS_TIME .. ": %d " .. MYSTATS_SECONDS, totalTime)
	MyStatsMainFrame_TimeTxt:SetText(timeTxtFormat)
end
-- String variables for color codes.
--- Colors ---
GREEN_FONT = "|cFF00FF00";
RED_FONT = "|c00FF0000";
ORANGE_FONT = "|cffff9900";