MyStats v1.1 (BETA 1.3)

By: WildCat-Man

Create date:            5/13/09
v0.1 Completed:    5/14/09
v0.1 Released:        N/A
v0.2 Completed:    5/14/09
v0.2 Released:        N/A
v0.2.6 Completed: 5/15/09
v0.2.6 Released:    N/A
v0.2.8 Completed: 5/16/09
v0.2.8 Released:     N/A
v0.2.9 Completed: 5/17/09
v0.2.9 Released:     N/A
v0.3 Completed:     5/18/09
v0.3 Released:         N/A
v0.3.5 Completed:  5/18/09
v0.3.5 Released:      N/A
v0.4 Completed:      5/18/09
v0.4 Released:         5/18/09
v1.0 Completed:      5/19/09
v1.0 Released:         5/19/09
v1.1 Completed:      5/19/09
v1.1 Released:         5/19/09
v1.1.2 Completed:  5/20/09
v1.1.2 Releaed:       5/20/09

BETA 1.0 Released: 5/18/09
BETA 1.2 Released: 5/19/09
BETA 1.3 Released: 5/19/09
BETA 1.4 Released: 5/20/09
<Insert Future Versions Here>

Any questions? Comments? Thoughts? Bugs?
     Contact me at: wildcatman9009@gmail.com

Or vist my wesite at: N/A

Want to translate to your language? Contact me by email. 
     Go to 'Localization' below for more details.

-------------------------------------------------------------------------------------
Notes
-------------------------------------------------------------------------------------

-Read the 'Help' section for an explanation on the MyStats window

<Add Future Notes Here>

-------------------------------------------------------------------------------------
Help
-------------------------------------------------------------------------------------

The numbers and letters in the MyStats window are:

      Stat Name - Total Stat Number - Stat Number (PosBuffs Only) - 
          Stat Number (NegBuffs Only)
	
      Ex: Agility: 209 - 114 - 0
	
      Stat Name is, well, the name of the stat.
	
      Total Stat Number is the number your stat will show in the                             'Character' window. It includes the base stat (without buffs and            your armor on), Positive Buffs and Negative Buffs.
	
       PosBuffs are anything from buffs that give you extra Stamina, to                  enchants on your armor, to the '+ 5 Strength' (etc) your armor has.
	
        NegBuffs are the same, just, of course, negative.
       
        When you put a new piece of armor on you'll see a '(+26)' or 
	'(-35)' ect, this means that stat was affected positively, or
	negatively by this new equipment/taking off equipment.
         To make these dissappear (because if you take the item off/put
	it back on, it will say '(+0)'), press the 'BLUE' button at the 
	top-lefthand side of the 'MyStats' frame.

         I added some new features, such as the 'Not In Combat' will change
	to 'In Combat' while you are being attacked, and vice-versa.
         The 'Dmg Taken' and 'Dps Taken' are the total damage you have
	been hit with through this fight, and the mob's average dps
	on your character. The 'Time' is the amount of time you've 
	been in combat (in seconds). (These stats only update every
	time you get hit by the mob)
          When the fight is over, you can leave the stats, or press the blue, 
          or 'Refresh' button to reset Dmg and Dps to 0. Time
          automatically resets to 0 when your character is attacked by a mob
          again, but you can keep adding up the Dmg and Dps stats.
		
For further help contact me at my email (wildcatman9009@gmail.com)

-------------------------------------------------------------------------------------
Future Updates:
-------------------------------------------------------------------------------------

-Add new stats according to what class your character is
-Allow user to customize what frame shows
-I may add a MyStats_Leveling plugin, shows where your character
   should level, and what instances/raids it should do, etc.

<Contact me for updates you'd like to see>

--------------------------------------------------------------------------------------
Version History:
--------------------------------------------------------------------------------------
v0.1:     -To large and complicated
              -Loads of windows not needed
              -Hint: That's why v0.2 was finished so quickly
              -Issues with MyStats frame
              -YourStats not loading

v0.2:     -Issues with remaining frames cut from v0.1
              -'Strength' not showing on MyStats
              -YourStats not working correctly
              -Cut more windows
              -Such as the 'Help', 'Version', and 'ClassSetUp' windows
	  -ClassSetUp is not needed anymore.

v0.2.6:  -Fixed issues regarding the 'Strength' text on MyStats window
              -Fixed slash command issues
              -More YourStats issues
              -Frame adjusting to size of text bug

v0.2.8:  -Cut YourStats, to many problems
              -Cut the adjusting frame code for now (will fix it in later update)

v0.2.9:  -Cut the 'Options' window

v0.3:      -Added in the 'Combat' section of MyStats
               -Showing how much a stat has gained/lost still bugged

v0.3.5:   -Added the 'Armor' section to MyStats
               -Added the 'Refresh' button
               -Showing how much a stat has gained/lost still bugged

v0.4:      -Fixed the stat gained/lost mechanism, added it to the
                        'Refresh' button
               -Added in localization
               -First version released (in beta stage)
               -Bug where frame displays (+ 'total stat') when loaded
                        (ex: Str: 193 (+193) 126 0)

v1.0:      -Released in Release stage
               -Fixed the on load frame bug (in v0.4)

v1.1:      -Frame's size adjusts according the max size of one of the texts
               -Bug that puts (+0) next to all the stats randomly sometimes
v1.1.2:   -Fixed bugs regarding the Intellect and Spirit stats
               -Bug where if armor you are wearing is common or below, the 
                    armor stat will not update 

--------------------------------------------------------------------------------------
Beta History
--------------------------------------------------------------------------------------
-BETA 1.0:  -Released 5/18/09
                      -In beta stage on Curse.com, users can only download on
                          the MyStats development page.

-BETA 1.2:  -Released 5/19/09
                      -In beta stage, but no users have used MyStats (as I know
                          of) yet, so kept it in a beta version, but moved it up to 
                          v1.0 since all bugs have been worked out (as far as I
                          know of) and features added. (Although I'll try to update
                          every once in a while for MAJOR new features, that'll
                          include minor features I've been working on)

-BETA 1.3:  -Released 5/19/09
                      -I fixed more bugs
                      -Added the frame adjusting to max text size automatically

-BETA 1.4:  -Released 5/20/09
                      -Fixed more bugs

--------------------------------------------------------------------------------------
Localization
--------------------------------------------------------------------------------------

This falls under translating any part of my addon (such as ingame 
features, the notes, or the ReadMe.txt file), if you would like to translate
this AddOn into another language, check the localization.lua file for which languages haven't been translated. Here is a list of translations so far:
	enUS (English)

Not much, but if you'd like to translate ingame text, go to localization.lua, and scroll down to the bottom to the uncommented-out section, and copy all the capital words into a file to email to me. Next 
to each capitilized word in the original localization.lua, there should be
some text inbetween two "s, translate that text inside for each
corresponding capital word/phrase (ex: MYSTATS_TITLE) would be
every time you see MyStats, but since this is the title you don't have to 
translate it. Thank you very much if you're interested, and I'll credit you
on site where this is uploaded and in here.