"ISLAND for
 			PLUNDERED HEARTS
	(c) Copyright 1987 Infocom, Inc. All Rights Reserved."

<OBJECT ISLAND
      (IN GLOBAL-OBJECTS)
      (DESC "St. Sinistra")
      (SYNONYM ISLAND SINISTRA CLIFF BEACH)
      (ADJECTIVE ST)
      (FLAGS NARTICLEBIT)
      (ACTION ISLAND-F)>

<ROUTINE ISLAND-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,LIBRARY>
		       <PERFORM ,V?EXAMINE ,GLOBE>)
		      (<INNER-DECK ,HERE>
		       <TELL ,YOU-CANT "see it from here" ,PCR>)
		      (<OR <SHIP-BOARD ,HERE>
			   <EQUAL? ,HERE ,SHALLOWS 
				   ,LAGOON ,BY-SHIP ,ON-LADDER>>
		       <TELL
"St. Sinistra is blessed with lush tropical beauty,
jungle besieging the mansion atop the southern cliffs" ,PCR>)
		      (T
		       <PERFORM ,V?LOOK>
		       <RTRUE>)>)>>

<ROUTINE BELOW-GROUND (RM)
	 <COND (<OR <EQUAL? .RM ,STAIRWELL ,BOTTOM-STAIRS>
		    <EQUAL? .RM ,ANTEROOM ,DUNGEON>
		    <EQUAL? .RM ,PASSAGE-1 ,PASSAGE-2 ,PASSAGE-4>
		    <EQUAL? .RM ,CELL-1 ,CELL-2 ,CELL-4>>
		<RTRUE>)
	       (T <RFALSE>)>> 

<OBJECT BUSHES
	(IN BEACH)
	(DESC "bushes")
	(SYNONYM BUSHES DRAGOO SOLDIERS)
	(FLAGS PLURALBIT NDESCBIT)>

<ROOM BEACH
      (IN ROOMS)
      (DESC "Beach")
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (UP PER BEACH-EXIT)
      (NORTH PER BEACH-EXIT)
      (NW PER BEACH-EXIT)
      (EAST TO SHALLOWS)
      (GLOBAL STAIRS SEA VINE PSEUD-SKIFF DEBRIS)
      (ACTION BEACH-F)>

<ROUTINE BEACH-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a tiny beach, at the base of vine-covered cliffs.
To the east,">
		<COND (<FSET? ,SHIP ,MUNGBIT>
		       <TELL
" across the debris-ridden lagoon, black
reefs speckle the blue endless sea">)
		      (T
		       <TELL T ,SHIP " floats serenely on the lagoon">)>
		<COND (,ENDGAME
		       <TELL
". Halfway out to the ship is a skiff crowded
with men; another skiff sits on the sand">)>
		<TELL ,PCR ,INDENT
"Immediately north of you, a rocky staircase is hewn into the cliff. ">
	        <COND (<RUNNING? ,I-ENDGAME>
		       <TELL
"A sizable number of dragoons huddle at the top.">)
		      (T
		       <RTRUE>)>
		;<COND (,ENDGAME
		       <TELL
" The wind has picked up, pushing the surf farther up the beach.">)
		      >)
	       (<AND <EQUAL? .RARG ,M-END>
		     ,ENDGAME
		     <NOT <FSET? ,STONE ,TOUCHBIT>>
		     <QUEUED? ,I-ENDGAME>>
		<MOVE ,STONE ,BEACH>
		<FSET ,STONE ,TOUCHBIT>
		<TELL ,INDENT
"You splash into the rising surf and pain needles up your leg. Blood swirls
out from your shoe in the shallow water, flowing over a small pointed stone"
,PCR>)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <VERB? ENTER>
		     <PRSO? ,SHALLOWS>>
		<DO-WALK ,P?EAST>
		<RTRUE>)
	       (<AND <EQUAL? .RARG ,M-ENTER>
		     <IN? ,COOKIE ,LAWN>>
		<TELL "\"I know 'e ain't down there!\" Cookie cries." CR>)>>

<ROUTINE BEACH-EXIT ()
	 <COND (<RUNNING? ,I-ENDGAME>
		<TELL "You would be safer aboard" TR ,SHIP>
		<RFALSE>)
	       (T
		<RETURN ,LAWN>)>>

<OBJECT PSEUD-SKIFF
	(IN LOCAL-GLOBALS)
	(DESC "skiff")
	(SYNONYM SKIFF BOAT)
	(FLAGS NDESCBIT)
	(ACTION P-SKIFF-F)>

<ROUTINE P-SKIFF-F ()
	 <COND (<EQUAL? ,HERE ,BEACH>
		<TELL
CTHE ,SKIFF " is out of reach. Wade into the shallows" ,PCR>)
	       (<EQUAL? ,HERE ,ON-LADDER>
		<COND (<NOT ,SKIFF-TIED>
		       <TELL ,YOU-CANT-SEE-ANY D ,SKIFF " here." CR>
		       <RFATAL>)
		      (<VERB? ENTER BOARD>
		       <DO-WALK ,P?DOWN>)
		      (T
		       <RFALSE>)>)>>

<ROOM LAWN
      (IN ROOMS)
      (DESC "Lawn")
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (WEST TO FOREST)
      (NORTH TO VERANDA)
      (UP TO VERANDA)
      (IN TO FOLLY)
      (EAST TO FOLLY)
      (DOWN TO BEACH)
      (SE TO BEACH)
      (SOUTH TO BEACH)
      (GLOBAL VEROBJ FOLLY-OBJECT HEDGE)
      (ACTION LAWN-F)>

<ROUTINE LAWN-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Jungle looms around this clipped lawn, a path meandering westward into the
dense undergrowth. To the east is a folly entangled in blooming jasmine.
The way to the beach is obscure, but visible to the southeast.
Behind the folly a thorny hedge blocks the cliff view of the sea.">
	        <COND (<NOT ,ENDGAME>
		       <TELL CR ,INDENT
"Music and voices float from the veranda to the north.">)
		      (T
		       <RTRUE>)>)
	       (<EQUAL? .RARG ,M-END>
		<COND (<NOT <FSET? ,HERE ,ACTORBIT>>
		       <FSET ,HERE ,ACTORBIT>
		       <TELL ,INDENT
"Two men stand whispering in the shadows. You catch an occasional word,
\"Davis dead... girl... Falcon on Sinistra.\" The men separate, the
well-dressed one going into the ballroom as the other slinks into the bushes.
You see his face. Crulley!" CR>)
		      (,COOKIE-LOOKING
		       <I-COOKIE T>)
		      (T
		       <RTRUE>)>)>>

<ROUTINE GEN-FLOWER ()
	 <COND (<EQUAL? ,HERE ,FOLLY>
		,FLOWER)>> 

<OBJECT FLOWER
	(IN FOLLY)
	(DESC "flower")
	(SYNONYM FLOWER JASMINE)
	(ADJECTIVE LOVELY)
	(FLAGS NDESCBIT)
	(GENERIC GEN-FLOWER)
	(ACTION FLOWER-F)>

<ROUTINE FLOWER-F ()
	 <COND (<AND <VERB? TAKE PICK>
		     <NOT <FSET? ,FLOWER ,TAKEBIT>>>
		<TELL "You can't bear to pick" TR ,FLOWER>)
	       (<VERB? SMELL>
		<TELL "Ah, jasmine! Mama grew this in her garden" ,PCR>)>>
		

<ROOM FOLLY
      (IN ROOMS)
      (DESC "Folly")
      (LDESC
"Perfumed by the heady odor of the night-blooming jasmine
entwined in the bamboo latticework, this folly is a cool, dark haven.")
      (FLAGS ONBIT RLANDBIT NARTICLEBIT INDOORSBIT)
      (SYNONYM FOLLY)
      (EAST PER FOLLY-EXIT)
      (IN PER FOLLY-EXIT)
      (WEST TO LAWN)
      (OUT TO LAWN)
      (GLOBAL FOLLY-OBJECT)
      (ACTION FOLLY-F)>

<ROUTINE FOLLY-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,FOLLY ,TOUCHBIT>>
		     <NOT <FSET? ,LAFS-ROOM ,TOUCHBIT>>
		     <IN? ,DAD ,CELL-4>>
		<SETG HERO-CTR 1>
		<QUEUE I-HFOLLY 2>)>>

<OBJECT FOLLY-OBJECT 
	(IN LOCAL-GLOBALS)
	(DESC "folly")
	(SYNONYM FOLLY GAZEBO JASMINE)
	(GENERIC GEN-FLOWER)
	(FLAGS NDESCBIT)
	(ACTION FOLLY-OBJ-F)>

<ROUTINE FOLLY-OBJ-F ()
	 <COND (<VERB? ENTER>
		<COND (<EQUAL? ,HERE ,IN-HEDGE>
		       <DO-WALK ,P?WEST>)
		      (<EQUAL? ,HERE ,LAWN>
		       <DO-WALK ,P?EAST>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,IN-HEDGE>
		       <TELL
CTHE ,FOLLY-OBJECT " is invisible beyond the leaves to the west" ,PCR>)
		      (<EQUAL? ,HERE ,FOLLY>
		       <V-LOOK>
		       <RTRUE>)
		      (T
		       <TELL
CTHE ,FOLLY-OBJECT " is obscured by tangled vines" ,PCR>)>)>>

<OBJECT BENCH
	(IN FOLLY)
	(DESC "bench")
	(LDESC "A bench is built into the wall, circling the folly.")
	(SYNONYM BENCH)
	(FLAGS CONTBIT SURFACEBIT VEHBIT SEARCHBIT OPENBIT)>

<GLOBAL SLAT-OPEN <>>

<OBJECT SLAT
	(IN FOLLY)
	(DESC "loose slat")
	(LDESC "One bamboo slat at the back seems to be loose.")
	(SYNONYM SLAT)      ;"HOLE"
	(ADJECTIVE BAMBOO LOOSE)
	(FLAGS TRYTAKEBIT)
	(ACTION SLAT-F)>

<ROUTINE SLAT-F ()
	 <COND (<AND <VERB? TAKE>
		     <NOT ,SLAT-OPEN>>
		<TELL
"Only the bottom of the slat is loose. The rest is
tightly woven into the frame of the folly" ,PCR>)
	       (<VERB? UNTIE REMOVE>
		<IMPOSSIBLES>)
	       (<VERB? MOVE FIDDLE PUSH>
		<COND (,SLAT-OPEN
		       <TELL ,YOU-HAVE-ALREADY " done that." CR>)
		      (T
		       <SETG SLAT-OPEN T>
		       <FCLEAR ,HOLE ,INVISIBLE>
		       <FSET ,SLAT ,NDESCBIT>
		       <TELL
"You twist aside the " D ,SLAT ", wedging the
end into the woven wall. The remaining hole, just above the
bench, looks big enough to snake " D ,ME " through" ,PCR>)>)
	       (<VERB? EXAMINE>
		<TELL "The bamboo slat at the back of the folly ">
		<COND (<FSET? ,SLAT ,NDESCBIT>
		       <TELL
"has been pulled aside, making a hole in the wall" ,PCR>)
		      (T
		       <TELL "appears to be loose" ,PCR>)>)>>

<OBJECT HOLE
	(IN FOLLY)
	(DESC "hole")
	(SYNONYM HOLE)
	(FLAGS INVISIBLE OPENBIT)
	(ACTION HOLE-F)>

<ROUTINE HOLE-F ()
	 <COND (<VERB? ENTER>
		<DO-WALK ,P?EAST>)
	       (<VERB? THROW PUT-THROUGH PUT>
		<COND (<PRSO? ,HANDS>
		       <TELL ,HUH>)
		      (<PRSO? ,RETICULE>
		       <RFALSE>)
		      ;(<PRSO? ,HOOPS>
		       <RFALSE>)
		      (T
		       <PRONOUN>
		       <TELL " fall">
		       <COND (<NOT <FSET? ,PRSO ,PLURALBIT>>
			      <TELL "s">)>
		       <TELL " through the hole">
		       <MOVE ,PRSO ,IN-HEDGE>
		       <TELL ,PCR>)>)
	       (<VERB? LOOK-INSIDE>
		<TELL ,YOU-SEE 
" a few leaves near to you, more fading into green obscurity" ,PCR>)>>

<ROUTINE FOLLY-EXIT ()
	 <COND (,SLAT-OPEN
		<COND (<FSET? ,GOWN ,WORNBIT>
		       <TELL "You might rip" TR ,GOWN>
		       <RFALSE>)
		      (T
		       ;<COND ;(<IN? ,HOOPS ,PROTAGONIST>
			      <MOVE ,HOOPS ,FOLLY>
			      <TELL
"The hoops won't fit through" T ,HOLE ", so you ">
			      <COND (<FSET? ,HOOPS ,WORNBIT>
				     <FCLEAR ,HOOPS ,WORNBIT>
				     <TELL "remove them, and ">)>
			      <TELL
"leave them on the floor of" T ,FOLLY-OBJECT ", crawling through" ,PCR CR>)>
		       ;<COND (<EQUAL? <LOC ,HERO> ,FOLLY>
			      <REMOVE ,HERO>)>
		       <RETURN ,IN-HEDGE>)>)
	       (T
		<TELL ,CANT-GO>
		<RETURN ,FALSE>)>>

<ROOM IN-HEDGE
      (IN ROOMS)
      (DESC "In the Hedge")
      (LDESC 
"You crouch in the green rustlings of the hedge. Not far east, wind keens up
the cliff, high above swells breaking against a rocky shore. You know the
folly is somewhere to the west. North, the hedge is somewhat less dense.")
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (NORTH TO BY-HOUSE)
      (SOUTH
"You might fight your way a few feet into the thorns
but you'd only tear your clothes.")
      (WEST TO FOLLY IF SLAT-OPEN
                     ELSE "You can't see any way to get past into the folly.")
      (EAST "Death lies that way, my lady.")
      (GLOBAL FOLLY-OBJECT HEDGE)>
  
<ROOM BY-HOUSE
      (IN ROOMS)
      (DESC "By the House")
      (SOUTH TO IN-HEDGE)
      (NORTH
"You might fight your way a few feet into the thorns
but you'd only tear your clothes.") 
      ;(WEST PER LWINDOW-EXIT)
      (WEST TO LIBRARY IF LIB-WINDOW IS OPEN)
      (EAST "Death lies that way, my lady.")
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (GLOBAL LIB-WINDOW HEDGE)
      (ACTION BY-HOUSE-F)>

<ROUTINE BY-HOUSE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You crouch in" T ,HEDGE " by the house, twigs poking into you, the cliff
crumbling away to the east. " CTHE ,HEDGE " seems less dense to the south. A">
		<TELL-OPEN/CLOSED ,LIB-WINDOW T>
		<TELL " window is directly west of you.">)>>

<OBJECT LIB-WINDOW                  ;"in BY-HOUSE and LIBRARY"
	(IN LOCAL-GLOBALS)
	(DESC "window")
	(SYNONYM GLASS WINDOW)
	(ADJECTIVE LARGE GLASS SMALL PANE PANES)
	(ACTION WINDOW-F)>

<OBJECT VER-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "french door")
	(SYNONYM DOOR DOORS)
	(FLAGS NDESCBIT DOORBIT)
	(ACTION DOOR-F)>

<ROOM VERANDA
      (IN ROOMS)
      (DESC "Veranda")
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (NORTH PER BALLROOM-ENTRANCE)
      (DOWN TO LAWN)
      (SOUTH TO LAWN)
      (EAST "The steps lead south.")
      (WEST "The steps lead south.")
      (GLOBAL STAIRS VEROBJ VER-DOOR)
      (ACTION VERANDA-F)>

<ROUTINE VERANDA-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Steps lead south from this white marble veranda to a clipped lawn.
To the north">
		<COND (<QUEUED? ,I-ENDGAME>
		       <TELL
" the wreckage left by the duel is visible in the ballroom.">
		       <RTRUE>)
		      (<NOT <FSET? ,VER-DOOR ,OPENBIT>>
		       <TELL ", beyond a closed glass door,">)>
		<COND (,ENDGAME
		       <TELL " is">)
		      (T
		       <TELL " a line of people blocks your view of">)>
		<TELL " the ballroom.">)
	       (<AND <EQUAL? .RARG ,M-END>
		     ,COOKIE-LOOKING>
		<I-COOKIE T>)>>

<OBJECT VEROBJ      ;"VERANDA-OBJECT"
	(IN LOCAL-GLOBALS)
	(DESC "veranda")
	(SYNONYM VERANDA PORCH)
	(FLAGS NDESCBIT)>

<ROOM TRADE-ENTRANCE
      (IN ROOMS)
      (DESC "Trade Entrance")
      (LDESC
"You are on a well-trampled lawn at the side of the house, one low doorway
leading in to the east. Gravelled paths lead north and south into the
undergrowth.")
      ;("Obviously this is where carts from the village unload supplies into
the kitchen, through a low doorway to the east.")
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (SOUTH TO FOREST)
      (NORTH PER AROUND-HOUSE)
      (IN TO KITCHEN)
      (EAST TO KITCHEN)
      (WEST "The undergrowth is much too thick to enter.")>

<ROUTINE AROUND-HOUSE ()
	 <TELL "The gravel path is just wide enough for a cart to pass.
It bends around the west wing of the house, leading you to" ,ELLIPSIS>
	 <COND (<EQUAL? ,HERE ,MAIN-ENTRANCE>
		<RETURN ,TRADE-ENTRANCE>)
	       (T
		<RETURN ,MAIN-ENTRANCE>)>>

<ROOM FOREST
      (IN ROOMS)
      (DESC "Forest")
      (LDESC "Buried in the subtropical undergrowth, you lose all
sense of being on someone's private estate; jungle seems to extend for
miles on all sides of you. A footworn path curves from east to north here,
and the vegetation lessens to the northeast.")
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (NORTH TO TRADE-ENTRANCE)
      (NE TO CLEARING)
      (EAST TO LAWN)
      (ACTION FOREST-F)>

<ROUTINE FOREST-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <FSET? ,FOREST ,EVERYBIT>>
		<DEQUEUE I-CATCH-KISS>
		<FCLEAR ,FOREST ,EVERYBIT>
		<TELL ,INDENT
"Two whispered voices come from the path ahead, one reassuring, the other
desperate -- they sound like" T ,DAD " and Lucy. Peering over a bush, you see
the couple share a fond embrace before they meander off into the jungle." CR>)>>

<ROOM CLEARING
      (IN ROOMS)
      (DESC "Clearing")
      (LDESC
"You are in a small clearing under the western side of the house.
Heavy vines creep up the wall past a second floor window, open
to the night air. Southwest is an opening in the bushes.")
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      ;(UP PER CLIMBING-VINE)
      (UP PER CLIMBING)
      (EAST "The west wall of the house is that way.")
      (OUT TO FOREST)
      (SW TO FOREST)
      (WEST TO FOREST)
      (GLOBAL WINDOW TREE VINE)
      (ACTION CLEARING-F)>

<ROUTINE CLEARING-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-BEG>
		     <OR <PRSO? ,WINDOW>
			 <PRSI? ,WINDOW>>>
		<COND (<VERB? EXAMINE LOOK-INSIDE>
		       <TELL ,YOU-SEE " only an embossed ceiling." CR>)
		      (<VERB? ENTER>
		       <DO-WALK ,P?UP>
		       <RTRUE>)
		      (T
		       <CANT-REACH ,WINDOW>)>)>>

<OBJECT VINE
	(IN LOCAL-GLOBALS)
	(DESC "vine")
	(SYNONYM VINE VINES)
	(ADJECTIVE HEAVY)
	(FLAGS PLURALBIT NDESCBIT TRYTAKEBIT)
	(ACTION VINE-F)>

<ROUTINE VINE-F ()
	 <COND (<AND <EQUAL? ,HERE ,BEACH>
		     <NOT <VERB? EXAMINE>>>
		<CANT-REACH ,VINE>)
	       (<VERB? TAKE>
		<TELL
"You tug, but are unable to get any substantial length of vine" ,PCR>)
	       ;(<AND <VERB? CUT>
		     <HELD? ,DAGGER>>
		<TELL "The vines are too fibrous to admit cutting" ,PCR>) 
	       (<AND <VERB? CLIMB ;CLIMB-UP>
		     <EQUAL? ,HERE ,CLEARING>>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<AND <VERB? CLIMB CLIMB-DOWN>
		     <EQUAL? ,HERE ,BEDROOM>>
		<DO-WALK ,P?DOWN>
		<RTRUE>)>> 

;<ROUTINE ;CLIMBING-VINE ()
	 <COND (,BOY-DRESS?
		<COND (<EQUAL? ,HERE ,CLEARING>
		       <TELL "You take a firm grasp on a particularly
thick tendril, jerk once to secure it, and scamper up the wall like some
huge tropical spider. It is easy to climb into the window" ,PCR CR>
		       <RETURN ,BEDROOM>)
		      (T
		       <TELL "Almost without thinking you slide down the
jasmine vine. You're getting quite adept at clambering about in boy's
clothes" ,PCR>
		       <RETURN ,CLEARING>)>)
	       (T
		<TELL "In these clothes? You jest" ,PCR>
		<RFALSE>)>>

<ROOM MAIN-ENTRANCE
      (IN ROOMS)
      (DESC "Main Entrance")
      (LDESC
"The front door stands open to the south, light splayed out onto a drive
stretching north into the jungle. A path leads around the western wing of
the house; jutting out from the east wing is a tall hedge.")
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (SOUTH TO FOYER)
      (IN TO FOYER)
      (EAST
"A tall hedge prevents you from going around the east wing of the house.")
      (WEST PER AROUND-HOUSE)
      (NORTH TO FRONT-DRIVE)
      (GLOBAL HEDGE)>

<ROOM FRONT-DRIVE
      (IN ROOMS)
      (DESC "Front Drive")
      (LDESC
"A rutted drive runs north-south here, from a high spiked gate through the
jungle to Lafond's mansion. You hide in the bushes nearby.")
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (NORTH "Dragoons guard the gate.")
      (SOUTH TO MAIN-ENTRANCE)
      (EAST  "The underbrush is much too thick to enter.")
      (WEST "The underbrush is much too thick to enter.")
      ;(ACTION FRONT-DRIVE-F)>

;<ROUTINE FRONT-DRIVE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<QUEUE I-PATROL -1>)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <VERB? YELL>>
		<SETG PATROL-CTR 4>
		<DEQUEUE I-PATROL>
		<I-PATROL T>)>>

<OBJECT HEDGE
	(IN LOCAL-GLOBALS)
	(DESC "hedge")
	(SYNONYM HEDGE)>

<OBJECT FRONT-GATE
	(IN FRONT-DRIVE)
	(DESC "gate")
	(SYNONYM GATE FENCE)
	(FLAGS NDESCBIT DOORBIT LOCKEDBIT)>

;<GLOBAL PATROL-CTR 0>

;<ROUTINE I-PATROL ("OPTIONAL" (CALLED-BY-PATROL-F <>))
	 <COND (<NOT <EQUAL? ,HERE ,FRONT-DRIVE>>
		<DEQUEUE I-PATROL>
		<RFALSE>)>
	 <COND (<NOT .CALLED-BY-PATROL-F>
		<TELL ,INDENT>)>
	 <COND (<EQUAL? ,PATROL-CTR 4>
		<TELL
"\"Ho, who goes there?\" a dragoon calls, turning towards you. ">
		<COND (,BOY-DRESS?
		       <FWTD
"\"A boy -- out after curfew? I wonder what Lafond will say about this.\"
They rush through the gate, grabbing you to throw you off the grounds.
Unfortunately, in that close contact, they discover your gender.">)
		      (<FSET? ,GOWN ,WORNBIT>
		       <TELL
"\"Miss,\" he bows respectfully, \"Governor Lafond would prefer it if you
remained indoors. It is not safe to be out alone in the night.\" He comes
through the gate and ushers you into the front door" ,PCR CR>
		       <GOTO ,FOYER>)
		      (T
		       <JIGS-UP
"\"Lafond does not tolerate beggars!\" They throw you off the cliff.">)>
		<RTRUE>)
	       (T
		<TELL
"Joking quietly among themselves, a small patrol paces back and forth on the
other side of the gate. The dragoons have not yet noticed you, hiding in the
darkness of the bushes." CR>)>
	 <SETG PATROL-CTR <+ ,PATROL-CTR 1>>>  

;<ROOM ROAD
      (IN ROOMS)
      (DESC "Village Road")
      (LDESC "A rutted, overgrown dirt road leads north, the only route to
the village. Far south of you, dragoons pace in front of a high spiked gate.")
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (NORTH
"You can barely walk on your sore ankle, and have no wish to crawl.")
      (EAST "The underbrush is much too thick to enter.")
      (WEST "The underbrush is much too thick to enter.")
      (SOUTH "The dragoons are unlikely to be sympathetic.")>

<ROOM KITCHEN
      (IN ROOMS)
      (DESC "Kitchen")
      (LDESC
"A firepit in the floor smokes badly, fogging up the depths of this large
kitchen, somehow not escaping through either the south or west doors.")
      ;(SYNONYM KITCHEN)
      (FLAGS ONBIT RLANDBIT NARTICLEBIT INDOORSBIT)
      (SOUTH PER KITCHEN-EXIT)
      (WEST PER KITCHEN-EXIT)
      (GLOBAL FIRE)
      (ACTION KITCHEN-F)>

;"IF LUCY IS THERE: Can't enter kitchen except as boy."
<ROUTINE KITCHEN-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,LUCY ,KITCHEN>>
		<COND (,BOY-DRESS?
		       <COND (<NOT <FSET? ,LUCY ,TOUCHBIT>>
			      <FSET ,LUCY ,TOUCHBIT>
			      <QUEUE I-LUCY 2>
			      <TELL ,INDENT
"The woman smiles uncertainly, then rushes over. \"Are you come from the
village, boy? Dost know Lord Dimsford?\" She sighs at your surprise.
\"So he sent you -- I am his Lucy. It's been so long since I've seen him.
Lafond caught me eavesdropping and now I can't leave the grounds.\"" CR>)>)
		      (<FSET? ,GOWN ,WORNBIT>
		       <TELL ,INDENT
"\"Milady,\" exclaims the woman. \"Lafond's guests are wisest not to stray.
Maybe you should stay at the ball.\" You find " D ,ME " ushered into
a hallway" ,PCR CR>
		       <GOTO ,HALL-W>) 
		      (T
		       <TELL ,INDENT 
"The woman shrieks, pushing you out the door. \"Has not the governor made
clear his position on light-skirts? Out, slattern, before I report you!\"
Her voice drops to a whisper, \"Sorry, but it's not safe around here.
Stay in the village.\" You find yourself outside" ,PCR CR>
		       <GOTO ,TRADE-ENTRANCE>)>)>>

<ROUTINE KITCHEN-EXIT ()
	 <COND (<AND <EQUAL? <META-LOC ,GARTER> ,HERE>
		     <NOT <HELD? ,GARTER>>
		     <IN? ,LUCY ,HERE>
		     <NOT <IN? ,DAD ,HERE>>>
		<REMOVE ,GARTER>
		;<REMOVE ,LUCY>
		<DEQUEUE I-LUCY>
		<TELL
"Lucy spits at you, \"Yes, desert a helpless woman. Tell Lafond
I'm a spy. Dimsford will avenge me, runt!\" She comes after you
with a rolling pin, pushing you out the door" ,PCR CR>
		<RETURN ,TRADE-ENTRANCE>)
	       (T
		<COND (<AND <IN? ,LUCY ,HERE>
			    <NOT <IN? ,DAD ,HERE>>
			    <FSET? ,GARTER ,TOUCHBIT>> 
		       <TELL
"\"Don't forget -- tell Dimsford,\"" T ,LUCY ,CALLS-AFTER>)>
		<COND (<EQUAL? ,P-WALK-DIR ,P?SOUTH>
		       <RETURN ,HALL-W>)
		      (T
		       <RETURN ,TRADE-ENTRANCE>)>)>>

<ROOM HALL-W
      (IN ROOMS)
      (DESC "Hall")
      (LDESC
"No expense has been spared to make this long dim hallway anything but a
servant's corridor. The foyer is east, a kitchen north of you."  
;"Music drifts into this narrow hallway through the south wall
and from a brightly lit area to the east. The kitchen is north of you.")
      (FLAGS ONBIT INDOORSBIT RLANDBIT NARTICLEBIT)
      (GLOBAL DOOR)
      (EAST TO FOYER)
      (NORTH TO KITCHEN)>

<ROUTINE BALLROOM-ENTRANCE ()
	 <COND (<AND <EQUAL? ,HERE ,VERANDA>
		     <NOT <FSET? ,VER-DOOR ,OPENBIT>>>
		<TELL CTHE ,DOOR ,IS-CLOSED ,PCR>
		<RFALSE>)
	       (,ENDGAME
		<COND (<RUNNING? ,I-DUEL>
		       <TELL ,YOU-CANT
"force " D ,ME " between the amazed spectators of the duel" ,PCR>
		       <RETURN ,FALSE>)
		      (T
		       <RETURN ,BALLROOM>)>)
	       (<NOT <FSET? ,GOWN ,WORNBIT>>
		<TELL
"Though you glimpse whirling bodies beyond,
the spectators fail to admit such a ">
		<COND (,BOY-DRESS?
		       <TELL "grubby youth">)
		      (T
		       <TELL "poorly dressed female">)>
		<TELL ".|">
		<RETURN ,FALSE>)
	       (T
		;<COND (<AND <HELD? ,HAT>
			    <NOT <EQUAL? ,HERE ,FOYER>>>
		       <WEARING-HAT>)>
		<TELL
"The sea of spectators parts to admit you, murmuring approval" ,PCR CR>
		<RETURN ,BALLROOM>)>>

;<CONSTANT FOLDS " in the folds of your skirts">

;<ROUTINE WEARING-HAT ()
	 <FCLEAR ,HAT ,WORNBIT>
	 <TELL "Remembering Lafond's hat, you ">
	 <COND (<FSET? ,HAT ,WORNBIT>
		<TELL "whip it off" T ,HEAD " and">)>
	 <TELL "hide it" ,FOLDS ". ">>

<ROOM FOYER                   ;"EVERYBIT: the butler missed you in I-SUMMONS" 
      (IN ROOMS)
      (DESC "Foyer")
      (LDESC "A grandiose staircase splits and twists up to the next
floor here, framing the entrance south to the ballroom. Long hallways
lead east and west; cool night air drifts in through the front door,
north of you.")
      (FLAGS ONBIT RLANDBIT NARTICLEBIT INDOORSBIT)
      (SOUTH PER FOYER-EXIT)
      (NORTH TO MAIN-ENTRANCE)
      (WEST PER FOYER-EXIT)
      (EAST PER FOYER-EXIT)
      (UP PER FOYER-EXIT)
      (ACTION FOYER-F)>

<GLOBAL BUTLER-POINTS "\" The butler points up the stairs.|">

<ROUTINE FOYER-F (RARG)
      <COND (<EQUAL? .RARG ,M-END>
	     <COND (<AND <NOT <FSET? ,BUTLER ,DEADBIT>>
			 <IN? ,BUTLER ,HERE>>
		    <COND (<FSET? ,GOWN ,WORNBIT>
			   <COND (<FSET? ,FOYER ,EVERYBIT>
				  <FCLEAR ,FOYER ,EVERYBIT>
				  <REMOVE ,BUTLER>
				  <TELL ,INDENT
"\"Miss, the master has been expecting you, up in his room.
I did look for you.\" " CTHE ,BUTLER " bows and leaves." CR>)
				 (<FSET? ,BUTLER ,MUNGBIT>
				  <TELL
,INDENT "\"" ,NO-LOITERING ,PUSHING-YOU-OUT CR>
				  <GOTO ,MAIN-ENTRANCE>)
				 (T
				  <RFALSE>)>) 
			  (,BOY-DRESS?
			   <KICKED-OUT>)
			  (T
			   ;<OR <FSET? ,DRESS ,WORNBIT>
			       <NOT <FSET? ,CHEMISE ,EVERYBIT>>>
			   <TELL ,INDENT
"\"You may not ply your wares here, Paphian. Leave before I have you
thrown off the cliff!\" You contemplate this pleasant prospect as you
are tossed onto the gravel drive." CR CR>
			   <GOTO ,MAIN-ENTRANCE>)>)
		   (,COOKIE-LOOKING
		    <I-COOKIE T>)
		   (T
		    <RTRUE>)>)
	    ;(<AND <EQUAL? .RARG ,M-BEG>
		  <NOT <FSET? ,BUTLER ,DEADBIT>>
		  <VERB? WEAR>
		  <PRSO? ,HAT>>
	     <TELL "That mayn't be wise." CR>)
	    (<AND <EQUAL? .RARG ,M-ENTER>
		  <NOT <FSET? ,BUTLER ,DEADBIT>>
		  <NOT <FSET? ,BUTLER ,INDOORSBIT>>>
	     <QUEUE I-BUTLER 3>)>>

<ROUTINE FOYER-EXIT ()
	 <COND (<FSET? ,BUTLER ,INDOORSBIT>      
		<COND (<EQUAL? ,P-WALK-DIR ,P?SOUTH>
		       <BALLROOM-ENTRANCE>)
		      (<EQUAL? ,P-WALK-DIR ,P?WEST>
		       <RETURN ,HALL-W>)
		      (<EQUAL? ,P-WALK-DIR ,P?UP>
		       <RETURN ,STAIRTOP>)
		      (<EQUAL? ,P-WALK-DIR ,P?EAST ,P?UP>
		       <COND (<IN? ,BUTLER ,HERE>
			      <TELL
"\"No, ma'am, that way's private.\" The butler stops you" ,PCR>
			      <RFALSE>)
			     (T
			      <RETURN ,HALL-E>)>)>)
	       (<RUNNING? ,I-BUTLER>
		<QUEUE I-BUTLER 2>
		<TELL
"\"Excuse me!\" The " D ,BUTLER " pushes you
back. \"Your invitation, please!\"" CR>
		<RFALSE>)
	       (T
		<QUEUE I-BUTLER 2>
		<SETG AWAITING-FAKE-ORPHAN T>
		<TELL
"The butler prevents you. \"Miss... your invitation?\"" CR>
		<RFALSE>)>>


<ROOM BALLROOM                       ;"EVERYBIT = crew is rounding up dancers"
      (IN ROOMS)
      (DESC "Ballroom")
      (SYNONYM FLOOR DANCE BALLRO)
      (ADJECTIVE DANCE)
      (FLAGS ONBIT RLANDBIT NARTICLEBIT INDOORSBIT)
      (NORTH PER BALLROOM-EXIT)
      (SOUTH PER BALLROOM-EXIT)
      (WEST PER BALLROOM-EXIT)
      (EAST PER BALLROOM-EXIT)
      (GLOBAL CHANDELIER VER-DOOR CREW DANCERS)
      (ACTION BALLROOM-F)>

<GLOBAL DANCED-WITH <>>  ;"Keeps track of your dances, with Nick, with Lafond"

<ROUTINE BALLROOM-F ("OPTIONAL" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (,ENDGAME
		       <COND (<QUEUED? ,I-ENDGAME>
			      <TELL
CTHE ,DANCERS "s stare amazed at Lafond's limp body,
some disbelieving, some hopeful, all stock still.
The pirates have fled to the darkness of the lawn">)
			     (T
			      <TELL
"All is chaos, screaming women fainting on terrified men.
Several of Jamison's scruffiest men round the dancers
into a huddle in the center of" ,DANCE-FLOOR>)>)
		      (T
		       <TELL
"Lafond's party is well attended: you can hardly move for the crush.
However, the room is oddly silent, no talk interrupting the musical
efforts of" T ,MUSICIANS " to the west. Despite the heat, no one ventures
south to the veranda, nor through the opening east.
The foyer is north of you">)>
		<TELL ".">)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		       <SETG HERO-CTR 1>
		       <QUEUE I-HDANCE -1>)
		      (<AND <NOT ,PARTNER>
			    <EQUAL? ,DANCED-WITH ,HERO>
			    <NOT ,ENDGAME>>
		       <SETG LAFOND-CTR 1>
		       <QUEUE I-LDANCE 1>
		       <RFALSE>)
		      (T
		       <RFALSE>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <EQUAL? ,CREW ,PRSO ,PRSI>
			    <NOT <NOUN-USED ,W?MAN ,CREW>>
			    <NOT <VERB? ASK-ABOUT>>
			    <NOT <PRSO? ,HERO ,LAFOND>>
			    <NOT <FSET? ,BALLROOM ,EVERYBIT>>>
		       <TELL ,YOU-CANT-SEE-ANY "of Jamison's crew here" ,PCR>
		       <STOP>)
		      (<AND <VERB? ASK-FOR>
			    <IN? ,PRSO ,HERE>
			    <PRSI? ,BALLROOM>>
		       <PERFORM ,V?DANCE ,PRSO>
		       <RTRUE>)
		      (<AND <VERB? PUT>
			    <PRSI? ,BALLROOM>>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)
		      (<AND <EQUAL? ,PARTNER ,HERO ,LAFOND>
			    <TOUCHING? ,VER-DOOR>>
		       <TELL D ,PARTNER " sweeps you past." CR>)
		      (T
		       <RFALSE>)>)
	       (<AND <EQUAL? .RARG ,M-END>
		     ,COOKIE-LOOKING>
		<I-COOKIE T>)>>

<ROUTINE BALLROOM-EXIT ()
	 <COND (<EQUAL? ,PARTNER ,HERO>
		<TELL "\"Would you rather not dance? ">
		<COND (<EQUAL? ,P-WALK-DIR ,P?SOUTH>
		       <TELL
"Apparently the guests have orders not to go outside.\" Instead" T ,HERO
" whirls and twirls you towards" TR ,MUSICIANS CR>
		       <RETURN ,ORCHESTRA>)
		      (<EQUAL? ,P-WALK-DIR ,P?EAST>
		       <TELL
"Hungry?\" He guides you into the supper room, then tsks in dismay.
\"They've cleared the food away already!\"" CR CR>
		       <RETURN ,SUPPER-ROOM>)
		      (<EQUAL? ,P-WALK-DIR ,P?WEST>
		       <TELL
"Let's listen to the music while we talk.\" He walks
you towards" TR ,MUSICIANS CR>
		       <RETURN ,ORCHESTRA>)
		      (T
		       <TELL
"It wouldn't be wise to put ourselves into the butler's sight, though.\"
He escorts you into the supper-room instead" ,PCR CR>
		       <RETURN ,SUPPER-ROOM>)>)
	       (<QUEUED? ,I-CKILLS-DAD>
		<TELL D ,LAFOND
" stops you. \"Stay until we hear the sad news.\"" CR>
		<RFALSE>) 
	       (<EQUAL? ,LAFOND ,PARTNER>
		;<SETG PARTNER <>>
		;<SETG DANCED-WITH ,BLOWN>
		;<DEQUEUE I-SUMMONS>
		;<REMOVE ,LAFOND>
		<TELL
"\"How dare you walk away!\" Lafond grips your arm,
so you may not leave the floor" ,PCR>
		<RFALSE>)
	       (<AND <RUNNING? ,I-LDANCE>
		     <EQUAL? <LOC ,LAFOND> ,HERE>
		     ;<NOT <EQUAL? ,PARTNER ,LAFOND>>>
		<SETG QUESTIONER ,LAFOND>
		<TELL
"\"Your answer, cherie?\" His twists your wrist mercilessly" ,PCR>
		<RFALSE>)>
	 <COND (<EQUAL? ,P-WALK-DIR ,P?NORTH>
		<RETURN ,FOYER>)
	       (<EQUAL? ,P-WALK-DIR ,P?SOUTH>
		<COND (<FSET? ,VER-DOOR ,OPENBIT>
		       <RETURN ,VERANDA>)
		      (T
		       <TELL CTHE ,DOOR ,IS-CLOSED ,PCR>
		       <RFALSE>)>)
	       (<EQUAL? ,P-WALK-DIR ,P?WEST>
		<RETURN ,ORCHESTRA>)
	       (<EQUAL? ,P-WALK-DIR ,P?EAST>
		<RETURN ,SUPPER-ROOM>)>>

<OBJECT MUSICIANS
	(IN LOCAL-GLOBALS)
	(DESC "musicians")
	(SYNONYM MUSICIANS ORCHESTRA)
	(FLAGS ACTORBIT)
	(ACTION MUSICIANS-F)>

<ROUTINE MUSICIANS-F ()
	 <COND (<VERB? EXAMINE LISTEN>
		<COND (,ENDGAME
		       <TELL
"The musicians are with" T ,DANCERS "s in the ballroom." CR>)
		      (T
		       <TELL "The small band is made up of a virginal,
bass and treble viols, and several recorders. They are playing \"I Want
to Kiss Your Hand,\" by J.S. Beatle." CR>)>)
	       (T
		<UNIMPORTANT-THING>
		<STOP>)>>

<ROOM ORCHESTRA
      (IN ROOMS)
      (DESC "Orchestra")
      (FLAGS ONBIT RLANDBIT NARTICLEBIT INDOORSBIT)
      (EAST TO BALLROOM)
      (SOUTH "The windows overlooking the veranda do not open.")
      (GLOBAL WINDOW DANCERS MUSICIANS)
      (ACTION ORCHESTRA-F)>

<ROUTINE ORCHESTRA-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (<AND ,ENDGAME
			    <NOT <QUEUED? ,I-ENDGAME>>>
		       <TELL "This end of the ballroom is empty of people.">)
		      (T
		       <TELL
"A few older women and young girls sit near the small orchestra
assembled at this end of the ballroom.">)>)
	       (<AND <EQUAL? .RARG ,M-END>
		     ,COOKIE-LOOKING>
		<I-COOKIE T>)>>

<ROOM SUPPER-ROOM
      (IN ROOMS)
      (DESC "Supper Room")
      (LDESC
"One long table set across the north entrance indicates that
supper was served here earlier. West of you is the ballroom.")
      (FLAGS INDOORSBIT ONBIT RLANDBIT NARTICLEBIT)
      (NORTH PER UNDER-TABLE)
      (WEST PER BALLROOM-ENTRANCE)
      (SOUTH "The windows overlooking the veranda do not open.")
      (GLOBAL LONG-TABLE WINDOW)
      (ACTION SUPPER-ROOM-F)>

<ROUTINE SUPPER-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<MOVE ,LONG-TABLE ,HERE>)
	       (<AND <EQUAL? .RARG ,M-END>
		     ,COOKIE-LOOKING>
		<I-COOKIE T>)>>

<ROUTINE UNDER-TABLE ()
	 <TELL
"You scuttle underneath" TR ,LONG-TABLE CR>
	 <COND (<EQUAL? ,HERE ,HALL-E>
		<RETURN ,SUPPER-ROOM>)
	       (T
		<RETURN ,HALL-E>)>>

<OBJECT LONG-TABLE
	(DESC "long table")
	(SYNONYM TABLE)
	(ADJECTIVE LONG)
	(CAPACITY 50)
	(FLAGS SURFACEBIT CONTBIT SEARCHBIT OPENBIT NDESCBIT)
	;(ACTION LONG-TABLE-F)>

;<ROUTINE LONG-TABLE-F ()
	 <COND (<>)>>

<ROOM HALL-E
      (IN ROOMS)
      (DESC "East Hallway")
      (LDESC
"The carpeted hallway turns from west to north here, extending into the
east wing. A long table blocks the way south.")
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      (NORTH TO LIBRARY)
      (SOUTH PER UNDER-TABLE)
      (WEST TO FOYER)
      (GLOBAL LONG-TABLE)
      (ACTION HALL-E-F)>

<ROUTINE HALL-E-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <NOT <FSET? ,BUTLER ,DEADBIT>>
		     <IN? ,BUTLER ,FOYER>>
		<COND (<NOT <FSET? ,GOWN ,WORNBIT>>
		       <KICKED-OUT>)
		      (<NOT <FSET? ,BUTLER ,INDOORSBIT>>
		       <TELL ,INDENT
"A " D ,BUTLER " takes your arm, pulling you
into the foyer. \"I have not seen your " D ,INVITE ", Miss.\"" CR CR>
		       <GOTO ,FOYER>)
		      (T
		       <RFALSE>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<MOVE ,LONG-TABLE ,HALL-E>)>>


<ROOM LIBRARY                    ;"EVERYBIT = Butler has seen open portrait."
      (IN ROOMS)
      (DESC "Library")
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      (SYNONYM LIBRARY)
      ;(EAST PER LWINDOW-EXIT)
      (EAST TO BY-HOUSE IF LIB-WINDOW IS OPEN)
      (SOUTH TO HALL-E)
      (IN PER PORTRAIT-EXIT)
      (NORTH PER PORTRAIT-EXIT)
      (GLOBAL PORTRAIT WINDOW DESK DRAPES)
      (ACTION LIBRARY-F)>

<ROUTINE LIBRARY-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Everything in this private office is larger than life. A huge " D ,PORTRAIT>
		<COND (<FSET? ,PORTRAIT ,OPENBIT>
		       <TELL ", slightly awry from the wall,">)>
		<TELL
" decorates the north side, and black drapes mask the east wall. Bookshelves
tower over a cherry desk, and a massive wooden globe squats in a corner.">
		<COND (<NOT ,ENDGAME>
		       <TELL
" Music wafts distantly from the ballroom across the hall to the south.">)>
		<COND (<NOT <FSET? ,KNOB ,DEADBIT>>
		       <TELL CR ,INDENT "A knob juts out of the wall.">)
		      (T
		       <RTRUE>)>)
	       (<AND <EQUAL? .RARG ,M-ENTER>
		     <IN? ,COOKIE ,HERE>
		     <NOT <FSET? ,COOKIE ,EVERYBIT>>>
		<FSET ,COOKIE ,EVERYBIT>
		<TELL
,SURPRISE D ,COOKIE " is here, studying the walls.
\"Cap'n said somethin' about a secret door, mebbe.\"" CR CR>)
	       (<EQUAL? .RARG ,M-END>
		<COND ;(<AND <FSET? ,LIBRARY ,EVERYBIT>   ;"can't get anymore"
			    <NOT <FSET? ,BUTLER ,DEADBIT>>>  
		       <TELL
"The butler stands nearby, \"I've been waiting for you">
		       <COND (<EQUAL? <LOC ,DAD> ,HERE>
			      <TELL " and the old man">)>
		       <TELL ", "> 
		       <COND (,BOY-DRESS?
			      <TELL "brat">)
			     (<FSET? ,GOWN ,WORNBIT>
			      <TELL "trollop">)
			     (T
			      <TELL "wench">)>
		       <TELL "!\" ">
		       <FWTD ,SOMETHING-HITS-YOU>)
		      (<IN? ,DAD ,HERE>
		       <COND (<AND <EQUAL? ,DANCED-WITH ,LAFOND>
				   <NOT ,HERO-ARRESTED>> 
			      <QUEUE I-HARRESTED 2>)>
		       <QUEUE I-CATCH-KISS 25>
		       <FSET ,FOREST ,EVERYBIT>
		       <FSET ,LIB-WINDOW ,OPENBIT>
		       <SETG SLAT-OPEN T>
		       <FCLEAR ,HOLE ,INVISIBLE>
		       <FSET ,SLAT ,NDESCBIT>
		       <REMOVE ,DAD>
		       <REMOVE ,LUCY>
		       <TELL ,INDENT
"\"A " D ,WINDOW "!\" your father exclaims. \"I shall creep out to the
kitchen. Get the Falcon.\" He climbs out" TR ,WINDOW>)
		      (<AND <IN? ,COOKIE ,HERE>
			    <RUNNING? ,I-DUEL>>
		       <MOVE ,COOKIE ,GALLERY>
		       <REMOVE ,CREW>       ;"get them out of ballroom"
		       <TELL ,INDENT
D ,COOKIE " cocks his head. \"What is that noise? Is Cap'n duelling
Lafond? There's no chance he could win as beaten as he is!\" Cookie races
out towards the ballroom" ,PCR>) 
		      (T
		       <RFALSE>)>)>>

;<ROUTINE LWINDOW-EXIT ()
	 <COND (<NOT <FSET? ,LIB-WINDOW ,OPENBIT>>
		<TELL CTHE ,WINDOW ,IS-CLOSED ,PCR>
		<RETURN ,FALSE>)
	       (T
		;<COND (<HELD? ,HAT>
		       <MOVE ,HAT ,LIBRARY>
		       <FCLEAR ,HAT ,WORNBIT>
		       <FSET ,HAT ,EVERYBIT>
		       <FCLEAR ,KNOB ,EVERYBIT>
		       <FSET ,KNOB ,DEADBIT>
		       <TELL
"For safety's sake, you leave" T ,HAT " on its knob.
Best not to show that you've been wandering" ,PCR CR>)>
		<COND (<EQUAL? ,P-DIRECTION ,P?EAST>
		       <RETURN ,BY-HOUSE>)
		      (T
		       <RETURN ,LIBRARY>)>)>>

<ROUTINE PORTRAIT-EXIT ()                            ; "EXIT-FCN"
	 <COND (<NOT <FSET? ,PORTRAIT ,MUNGBIT>>
		<TELL ,CANT-GO>
		<RFALSE>)
	       (<NOT <FSET? ,PORTRAIT ,OPENBIT>>
		<TELL CTHE ,PORTRAIT ,IS-CLOSED ,PCR>
		<RFALSE>)
	       (T
		<COND (<HELD? ,HAT>
		       <SAFETY-SAKE>
		       <TELL ,INDENT>)>
		<TELL "You move beyond" T ,PORTRAIT " into the ">
		<COND (<EQUAL? ,HERE ,STAIRWELL>
		       <TELL "library" ,PCR CR>
		       ;<COND (<HELD? ,CANDLE>
			       <MOVE ,CANDLE ,STAIRWELL>
			       <TELL
"deposit the candle back in its sconce and move">)>
		       <RETURN ,LIBRARY>)
		      (<EQUAL? ,HERE ,LIBRARY>
		       <TELL "flickering torchlight" ,PCR CR>
		       <RETURN ,STAIRWELL>)>)>>

<OBJECT DRAPES
	(IN LOCAL-GLOBALS)
	(DESC "drapes")
	(SYNONYM DRAPES CURTAIN)
	(ADJECTIVE BLACK VELVET PURPLE GOLD)
	(FLAGS PLURALBIT NDESCBIT DOORBIT BURNBIT)
	(ACTION DRAPES-F)>

<ROUTINE DRAPES-F ()
	 <COND (<VERB? LOOK-BEHIND>
		<COND (<EQUAL? ,HERE ,LAFS-ROOM>
		       <TELL ,THERES-NOTHING "interesting behind" TR ,DRAPES>)
		      (T
		     <TELL "In the dark behind" T ,DRAPES " is" AR ,WINDOW>)>)
	       (<VERB? OPEN PUSH MOVE>
		<TELL ,PULL-FABRIC CR>
		;<TELL "You pull" T ,DRAPES " aside momentarily" ,PCR>)
	       (<VERB? CLOSE>
		<COND (<EQUAL? ,HERE ,LIBRARY>
		       <TELL ,ALREADY-ARE>)
		      (T
		       <TELL ,BEAUTIFUL-NIGHT>)>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,LIBRARY>
		       <TELL
"Dark drapes cover an entire wall of the room" ,PCR>)
		      (T
		       <TELL
"The purple hangings are densely embroidered with gold" ,PCR>)>)>>

;<OBJECT CANDLE
	(IN STAIRWELL)
	(DESC "candle")
	(FDESC "A candle burns brightly from a sconce on the wall.")
	(SYNONYM CANDLE)
	(ADJECTIVE BURNING)
	(FLAGS TAKEBIT ONBIT LIGHTBIT)
	(ACTION CANDLE-F)>

;<ROUTINE CANDLE-F ()
	 <COND (<AND <VERB? ON BURN>
		     <PRSO? ,CANDLE>>
		<COND (<NOT ,PRSI>
		       <COND ;(<FSET? ,MATCH ,ONBIT>
			      <TELL "[with the match]" CR>
			      <PERFORM ,V?ON ,CANDLE ,MATCH>
			      <RTRUE>)
			     (<IN? ,FIRE ,HERE>
			      <TELL "[in the fire]" CR>
			      <PERFORM ,V?ON ,CANDLE ,FIRE>
			      <RTRUE>)
			     (T
			      <TELL 
"Please say what to light it with." CR>)>)
		      ;(<AND <EQUAL? ,PRSI ,MATCH>
			    <FSET? ,MATCH ,ONBIT>>
		       <TELL "The candle is ">
		       <COND (<FSET? ,CANDLE ,ONBIT>
			      <TELL "already ">)
			     (T
			      <FSET ,CANDLE ,ONBIT>)>
		       <TELL "lit" ,PCR>)
		      (T
		       <TELL
,YOULL-HAVE-TO "light it with something that's burning, you know." CR>)>)
	       (<AND <VERB? OFF>
		     <PRSO? ,CANDLE>>
		<COND (<FSET? ,CANDLE ,ONBIT>
		       <TELL "The flame is extinguished.">
		       <FCLEAR ,CANDLE ,ONBIT>
		       <SETG LIT <LIT? ,HERE>>
		       <COND (<NOT ,LIT>
			      <TELL " It's rather dark in here...">)>
		       <CRLF>
		       <RTRUE>)
		      (T <TELL "But" T ,CANDLE " isn't lit!" CR>)>)
	       (<AND <VERB? PUT WAVE POINT>
		     <PRSI? ,SHIP ,SHUTTERS>
		     <EQUAL? ,HERE ,LAFS-ROOM>>
		<COND (<AND <FSET? ,CANDLE ,ONBIT>
			    <FSET? ,SHUTTERS ,OPENBIT>>
		       <FCLEAR ,CANDLE ,ONBIT>
		       <TELL
"As you hold the candle up to the window a puff of breeze blows it out" ,PCR>)
		      (T
		       <TELL "You wave" T ,CANDLE>
		       <COND (<FSET? ,SHUTTERS ,OPENBIT>
			      <TELL " in the open window" ,PCR>)
			     (T
			      <TELL
" behind the closed " D ,SHUTTERS ,PCR>)>)>)
	       (<VERB? EXAMINE>
		<TELL "The candle is ">
		<COND (<FSET? ,CANDLE ,ONBIT>
		       <TELL "burning.">)
		      (T <TELL "out.">)>
		<CRLF>)>>

<OBJECT TORCH
	(IN LOCAL-GLOBALS)
	(DESC "torch")
	(SYNONYM  TORCH FLAME)
	(ADJECTIVE BURNING)
	(FLAGS TRYTAKEBIT ONBIT LIGHTBIT)
	(ACTION TORCH-F)>

<ROUTINE TORCH-F ()
	 <COND (<VERB? EXAMINE>
		<TELL CTHE ,TORCH " is flickering madly in the breeze." CR>)
	       (<AND <VERB? PUT PUT-ON>
		     <FSET? ,PRSI ,BURNBIT>>
		<TELL "Mama disapproved of pyromaniacs." CR>)
	       (<TOUCHING? ,TORCH>
		<TELL
,YOU-CANT "reach" T ,TORCH ". Ladies don't carry them anyway." CR>
		;<CANT-REACH ,TORCH>)>>

<GLOBAL COOKIE-HARRUMPHS " Cookie harrumphs, surprised.">

<OBJECT PORTRAIT                ;"MUNGBIT = Portrait has been opened once."
	(IN LOCAL-GLOBALS)
	(DESC "portrait")
	(SYNONYM PORTRAIT PICTUR PAINTING DOOR)
	(ADJECTIVE OPENING SECRET)
	(FLAGS NDESCBIT DOORBIT)
	(ACTION PORTRAIT-F)>
	
<ROUTINE PORTRAIT-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,LIBRARY>
		       <COND (<FSET? ,PORTRAIT ,OPENBIT>
			      <TELL "Cool air seeps out from" TR ,PORTRAIT>)
			     (T
			      <TELL
CTHE ,PORTRAIT " seems familiar, and you realize it is exactly the
picture on the front of" T ,BANKNOTE T ,LAFOND " sent you, same clothes,
same surroundings, same pose." CR>)>)
		      (T
		       <TELL ,YOU-SEE ,THE-BACK TR ,PORTRAIT>)>)
	       (<VERB? LOOK-BEHIND>
		<COND (<FSET? ,PORTRAIT ,OPENBIT>
		       <PERFORM ,V?EXAMINE ,PORTRAIT>
		       <RTRUE>)
		      (T
		       <TELL
CTHE ,PORTRAIT " is firmly fastened to the wall" ,PCR>)>)
	       ;(<VERB? READ>
		<TELL
"The scroll in the " D ,PORTRAIT " reads, \"Jean Lafond, King
of the West Indies.\"" CR>)
	       (<VERB? ENTER HIDE WALK>
		<COND (<NOT <FSET? ,PORTRAIT ,MUNGBIT>>
		       <TELL
"This is a " D ,PORTRAIT ", not a looking glass" ,PCR>)
		      (T
		       <DO-WALK ,P?IN>)>)
	       (<VERB? OPEN>
		<COND (<FSET? ,PORTRAIT ,OPENBIT>
		       <TELL ,ALREADY-IS>)
		      (<FSET? ,PORTRAIT ,MUNGBIT>
		       <FSET ,PORTRAIT ,OPENBIT>
		       <COND (<EQUAL? ,HERE ,LIBRARY>
			      <TELL
"Quickly you pull the book, joggle" T ,KNOB
" and touch" T ,GLOBE ", and" T ,PORTRAIT " pops open.">
			      <COND (<IN? ,COOKIE ,HERE>
				     <TELL ,COOKIE-HARRUMPHS>)>
			      <CRLF>) 
			     (T
			      <TELL
"You push outwards on the wall, opening" TR ,PORTRAIT>)>)
		      (T
		       <TELL "Open a " D ,PORTRAIT "?!" CR>)>)
	       (<VERB? CLOSE>
		<COND (<NOT <FSET? ,PORTRAIT ,MUNGBIT>>
		       <TELL ,HUH>)
		      (<FSET? ,PORTRAIT ,OPENBIT>
		       <FCLEAR ,PORTRAIT ,OPENBIT>
		       <FCLEAR ,POWER ,EVERYBIT>
		       <FCLEAR ,KNOB ,EVERYBIT>
		       <TELL
CTHE ,PORTRAIT " swings shut with a tiny snap." CR>)>)>>

<OBJECT GLOBE
	(IN LIBRARY)
	(DESC "globe")
	(SYNONYM GLOBE SINISTRA ISLAND)
	(ADJECTIVE WORLD ST WOODEN)
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION GLOBE-F)>

<ROUTINE GLOBE-F ()
	 <COND (<OR <VERB? TOUCH PUSH>
		    <AND <VERB? PUT-ON>
			 <PRSO? ,HANDS>>>
		<TELL "You press the ">
		<COND (<OR <NOUN-USED ,W?SINISTRA ,GLOBE>
			   <NOUN-USED ,W?ISLAND ,GLOBE>
			   <ADJ-USED ,A?ST>>
		       <TELL
"painted island, and it sinks into the wooden sea.">
		       <COND (<AND <FSET? ,KNOB ,EVERYBIT>
				   <FSET? ,POWER ,EVERYBIT>
				   <NOT <FSET? ,PORTRAIT ,OPENBIT>>>
			      <FSET ,PORTRAIT ,OPENBIT>
			      <COND (<NOT <FSET? ,PORTRAIT ,MUNGBIT>>
				     <FSET ,PORTRAIT ,MUNGBIT>
				     <SETG SCORE <+ ,SCORE 1>>)>
			      <TELL
" You hear a whirr and a click and" T ,PORTRAIT " pops open. A draft of
sea-scented air flows in from behind it.">
			      <COND (<IN? ,COOKIE ,HERE>
				     <TELL ,COOKIE-HARRUMPHS>)>)>)
		      (T
		       <TELL "globe at random.">)>
		<CRLF>)
	       (<VERB? TAKE SET>
		<TELL CTHE ,GLOBE " is solidly fastened to the floor." CR>)
	       (<AND <VERB? FIND>
		     <PRSI? ,GLOBE>
		     <OR <NOUN-USED ,W?SINISTRA ,GLOBE>
			 <NOUN-USED ,W?ISLAND ,GLOBE>
			 <ADJ-USED ,A?ST>>>
		<TELL "It is in the West Indies, surrounded by blue." CR>)  
	       (<VERB? EXAMINE>
		<COND (<OR <NOUN-USED ,W?SINISTRA ,GLOBE>
			   <NOUN-USED ,W?ISLAND ,GLOBE>
			   <ADJ-USED ,A?ST>>
		       <TELL
"A tiny replica of " D ,ISLAND " is painted on" T ,GLOBE " in greater detail
than any other country, showing even the road from Santa Ananas to Lafond's
mansion" ,PCR>)
		      (T
		       <TELL
"The massive wooden globe, painted in greens and blues and white,
describes the world as presently known" ,PCR>)>)>>

<OBJECT BOOKS-GLOBAL
	(IN LIBRARY)
	(DESC "books")
	(SYNONYM BOOK BOOKS)
	(GENERIC GENERIC-BOOK)
	(FLAGS TRYTAKEBIT NDESCBIT PLURALBIT)
	(ACTION BOOKS-GLOBAL-F)>

<ROUTINE BOOKS-GLOBAL-F ()
	  <COND (<VERB? LOOK-INSIDE READ TAKE OPEN>
		 <TELL
"You pick one at random. You always preferred horses to
reading, so you put it back" ,PCR>)
		(<VERB? EXAMINE SEARCH>
		 <TELL
"Most of the books appear unread, their pages uncut, the spines not yet
creased. All except one, \"Treatise of Power\" by Sir Michael Villiers" ,PCR>)
		(<VERB? MOVE PUSH>
		 <TELL ,HUH>)>>

<OBJECT BOOKCASE
	(IN LIBRARY)
	(DESC "bookcase")
	(SYNONYM BOOKCASE BOOKSHELF SHELF SHELVES)
	(ADJECTIVE BOOK CASE)
	(FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 99)
	(ACTION BOOKCASE-F)>

<ROUTINE BOOKCASE-F ()
	  <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		 <PERFORM ,V?EXAMINE ,BOOKS-GLOBAL>
		 <RTRUE>)
		(<VERB? MOVE PUSH SET>
		 <SETG AWAITING-REPLY 3>
		 <QUEUE I-REPLY 2>
		 <TELL
"Why tamper with a " D ,BOOKCASE "? Searching for a
secret door or some such?" CR>)
		(<VERB? OPEN CLOSE>
		 <WASTES>)>>

<OBJECT POWER              ;"EVERYBIT = Book is queued to open portrait."
	(IN BOOKCASE)      ;"MUNGBIT = point given for this move."
	(DESC "book")
	(SYNONYM BOOK POWER)
	(ADJECTIVE TREATISE WELL-READ)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(GENERIC GENERIC-BOOK)
	(ACTION POWER-F)>

<ROUTINE POWER-F ()
	 <COND (<VERB? READ TAKE OPEN MOVE FIDDLE>
		<TELL
"You half tip" T ,POWER " out of the shelf when
it snaps surprisingly back into place">
		<COND (<NOT <FSET? ,POWER ,MUNGBIT>>
		       <FSET ,POWER ,MUNGBIT>
		       <SETG SCORE <+ ,SCORE 1>>)>
		<COND (<NOT <FSET? ,POWER ,EVERYBIT>>
		       <FSET ,POWER ,EVERYBIT>
		       <TELL
". There is a mysterious scraping sound from inside the wall">)>
		<TELL ,PCR>)
	       (<VERB? EXAMINE>
		<TELL
"You gaze at \"Treatise of Power\" without taking it.
It seems to be the only book that has been read in the library,
the leather creased and dull with use." CR>)>>


<ROUTINE GENERIC-BOOK (X "OPTIONAL" Y)
	 <COND (<EQUAL? ,HERE ,LIBRARY>
		,BOOKS-GLOBAL)>>

<OBJECT KNOB              ;"EVERYBIT = knob is queued to open portrait."
	(IN LIBRARY)      ;"DEADBIT = knob unseeable/NDESCBIT by another name"
	(DESC "knob")
	(SYNONYM KNOB)
	(FLAGS NDESCBIT SURFACEBIT CONTBIT ;OPENBIT SEARCHBIT DEADBIT)
	(ACTION KNOB-F)>

<ROUTINE KNOB-F ()
	 <COND (<VERB? PUSH MOVE SET LOWER FIDDLE>
		<COND (<FSET? ,KNOB ,EVERYBIT>
		       <HACK-HACK "Fiddling with">)
		      (T
		       <FSET ,KNOB ,EVERYBIT>
		       <KNOB-CAUSES-TINGLE "As you fiddle with the">)>)
	       (<AND <VERB? PUT-ON PUT>
		     <PRSO? ,HAT>>
		<COND (<FSET? ,KNOB ,DEADBIT>
		       <TELL ,ALREADY-IS>)
		      (<NOT <HELD? ,HAT>>
		       <TELL ,YNH TR ,HAT>)
		      (T
		       <FSET ,HAT ,EVERYBIT>
		       <FSET ,KNOB ,DEADBIT>
		       <MOVE ,HAT ,LIBRARY>
		       <TELL "You prop" T ,HAT " back on" TR ,KNOB>)>)
	       (<AND <VERB? EXAMINE>
		     <FSET? ,KNOB ,DEADBIT>>
		<TELL CTHE ,HAT " is on" TR ,KNOB>)>>

<ROOM BEDROOM 
      (IN ROOMS)
      (DESC "Bedroom")
      (LDESC
"Lit only with moonlight through the open window, tonight this room
is serving as a ladies' dressing room. An exit lies to the north.")
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      ;(DOWN PER CLIMBING-VINE)
      (DOWN PER CLIMBING)
      (NORTH TO UPPER-HALL-W)
      (GLOBAL WINDOW VINE)>

<OBJECT GUEST-BED
	(IN BEDROOM)
	(DESC "bed")
	(SYNONYM BED)
	(FLAGS VEHBIT NDESCBIT CONTBIT SEARCHBIT SURFACEBIT OPENBIT)
	(CAPACITY 100)
	(ACTION BED-F)>

<ROOM UPPER-HALL-W 
      (IN ROOMS)
      (DESC "Upstairs Hall")
      (LDESC "You stand in a carpeted hallway, leading east
to a stair landing. Rooms lie north and south of you.")
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      (NORTH TO X-ROOM)
      (EAST TO STAIRTOP)
      (SOUTH TO BEDROOM)>

<ROOM STAIRTOP 
      (IN ROOMS)
      (DESC "Stair Landing")
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      (DOWN TO FOYER)
      (WEST TO UPPER-HALL-W)
      (EAST TO UPPER-HALL-E)
      (GLOBAL CHANDELIER RAILING)
      (ACTION STAIRTOP-F)>

<ROUTINE STAIRTOP-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The east-west hallway opens here to curve into a grand staircase sweeping
down to the foyer.">)>>

;<ROUTINE old-STAIRTOP-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The east-west hallway opens here to curve into a grand staircase sweeping
down to the foyer. A railing to the south overlooks the ballroom.">
		<DANCEFLOOR-DESC>)>>

<ROOM X-ROOM
      (IN ROOMS)
      (DESC "Parlour")
      (LDESC
"This room is exotically furnished with a Turkey divan and chairs.
The exit is south.")
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      (SOUTH TO UPPER-HALL-W)>

<OBJECT DIVAN
	(IN X-ROOM)
	(DESC "divan")
	(SYNONYM COUCH DIVAN)
	(ADJECTIVE TURKEY)
	(FLAGS NDESCBIT CONTBIT SEARCHBIT SURFACEBIT)
	(ACTION DIVAN-F)>

<ROUTINE DIVAN-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"Backless, upholstered in Oriental silk,"
T ,DIVAN " looks exotic and comfortable" ,PCR>)
	       (<VERB? BOARD CLIMB-ON ENTER>
		<TELL "You haven't time to relax now." CR>)
	       (T
		<UNIMPORTANT-THING>)
	       ;(<VERB? LOOK-INSIDE>
		<CANT-VERB-A-PRSO "look inside">
		;<TELL ,YOU-CANT "look inside" AR ,DIVAN>)>>

<OBJECT PAIR
	(IN X-ROOM)
	(DESC "pair of duelling pistols")
	(LDESC "A pair of duelling pistols is mounted high on one wall.")
	(SYNONYM PISTOL GUN)
	(ADJECTIVE DUELLI)
	(FLAGS PLURALBIT)
	(ACTION PAIR-F)>

<ROUTINE PAIR-F ()
	 <COND (<TOUCHING? ,PAIR>
		<TELL ,YOU-CANT
"reach them. Ladies don't carry " D ,PISTOL "s, anyway." CR>)>>

<ROOM UPPER-HALL-E 
      (IN ROOMS)
      (DESC "Upstairs Hall")
      (LDESC "You stand in a carpeted hallway, leading west
to a stair landing. To the north is an ornately carved door. From the
south comes the impression of light and air.")
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      (SOUTH TO GALLERY)
      (NORTH TO LAFS-ROOM IF LDOOR IS OPEN)
      (WEST TO STAIRTOP)
      (GLOBAL LDOOR)>

<OBJECT LDOOR
	(IN LOCAL-GLOBALS)
	(DESC "ornate door")
	(SYNONYM DOOR LOCK)
	(ADJECTIVE ORNATE)
	(FLAGS NDESCBIT LOCKEDBIT DOORBIT)
	(ACTION DOOR-F)>

<ROOM LAFS-ROOM
      (IN ROOMS)
      (DESC "Lafond's Bedroom")
      (FLAGS NARTICLEBIT ONBIT RLANDBIT INDOORSBIT)
      (SOUTH PER LAFS-EXIT)
      (GLOBAL LDOOR TABLE DRAPES SEA)
      (ACTION LAFS-ROOM-F)>

<ROUTINE LAFS-ROOM-F (RARG "AUX" THING)
	 <COND (<AND <EQUAL? .RARG ,M-BEG>
		     ,LAFOND-LOOKING>
		<COND (<AND <G? ,LAFOND-CTR <- ,HORNY 1>>  ;"(9)"
			    <NOT <PRSO? ,PINCH ,SPICES>>
			    <VERB? TAKE WEAR ;DROP>>
		       <COND (<VERB? TAKE WEAR>
			      <TELL D ,LAFOND " stops you" ,PCR>)
			     ;(<VERB? DROP>
			      <TELL ,THERES-NOTHING "to drop!" CR>
			      <STOP>)>
		       <RTRUE>)
		      (<OR <PRSI? ,BOTTLE ,LAUD>
			   <PRSO? ,BOTTLE ,LAUD>>
		       <SET THING ,BOTTLE>)
		      (<VERB? PUT WAVE POINT>
		       <COND (<EQUAL? ,MIRROR ,PRSO ,PRSI>
			      <SET THING ,MIRROR>)
			     (<EQUAL? ,TRAY ,PRSO ,PRSI>
			      <SET THING ,TRAY>)
			     (T
			      <RFALSE>)>)
		      (T
		       <RFALSE>)>
		<REMOVE .THING>
		<TELL
"Lafond bounds to your side, grabbing" T .THING " out of " D ,HANDS " before
you can use it. \"What have we here? Trying to ">
		<COND (<EQUAL? .THING ,BOTTLE>
		       <TELL "poison " D ,ME "? Or me?">)
		      (<EQUAL? .THING ,MIRROR ,TRAY>
		       <TELL "signal for help? You are beyond help.">)>
		<TELL "\" He throws it out" TR ,SHUTTERS>)
	       (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,LAFS-ROOM ,TOUCHBIT>>>
		<FSET ,LAFS-ROOM ,TOUCHBIT>
		<SETG SCORE <+ ,SCORE 1>>
		<SETG LAFOND-CTR 1>
		<QUEUE I-LSED 1>
		<TELL "\"Welcome, ma petite">
		<COND (<NOT <FSET? ,GOWN ,WORNBIT>>
		       <TELL
" -- but where is your " D ,GOWN "? Ah, chacun a son gout">)>
		<TELL ".\" Lafond bows you in" ,PCR CR>)
	       (<EQUAL? .RARG ,M-LOOK>
	        <TELL
D ,LAFOND "'s bedroom shows all the outpourings of his megalomania. Royal
hues of purple and gold weigh down the hangings on the bed and the eastward
window, as if trying to smother the moonbeam shining in.">)>>

<OBJECT CHAIR
	(IN LAFS-ROOM)
	(DESC "chair")
	(SYNONYM CHAIR)
	(FLAGS NDESCBIT VEHBIT CONTBIT SEARCHBIT SURFACEBIT OPENBIT)>

<ROUTINE LAFS-EXIT ()
	<COND (,LAFOND-LOOKING 
	       <TELL
"Lafond whirls you around. \"My pretty, you came here freely,
but you may not leave freely.\"" CR>
	       <RFALSE>)
	      (<AND <IN? ,BUTLER ,HERE>
		    <NOT <FSET? ,BUTLER ,DEADBIT>>>
	       <TELL CTHE ,BUTLER " stops you easily" ,PCR>
	       <RFALSE>)
	      (T
	       <TELL "You ">
	       <COND (<NOT <FSET? ,LDOOR ,OPENBIT>>
		      <FSET ,LDOOR ,OPENBIT>
		      <TELL "open the door and ">)>
	       <COND (<AND <FSET? ,BUTLER ,DEADBIT>
			   <NOT <EQUAL? <LOC ,LAFOND> ,HERE>>>
		      <TELL "creep over the prostrate butler" ,PCR CR>
		      <RETURN ,UPPER-HALL-E>)
		     (T
		      <TELL
"run out -- into" T ,BUTLER "'s barrel chest and leering grin.
You return to the bedroom">
		      <COND (<IN? ,LAFOND ,HERE>
			     <TELL
"." T ,LAFOND " acts as if nothing has happened" ,PCR>)
			    (T
			     <MOVE ,BUTLER ,LAFS-ROOM>
			     <TELL
"," T ,BUTLER " following. \"The governor said you
were not to leave this room.\"" CR>)>
		      <RFALSE>)>)>>

<OBJECT LAFS-BED
	(IN LAFS-ROOM)
	(DESC "bed")
	(SYNONYM BED)
	(FLAGS VEHBIT CONTBIT SEARCHBIT SURFACEBIT OPENBIT NDESCBIT)
	(CAPACITY 100)
	(ACTION BED-F)>

;<GLOBAL LAF-WINDOW-SEEN <>>

;<GLOBAL LAFOND-SEES-WINDOW "Lafond joins you at the window. \"Is it not
a beautiful view? I could not bear to glass it over
-- hurricanes are a natural occurence in this kingdom, and as king, I
must learn to conquer them.\"">

<OBJECT SHUTTERS
	(IN LAFS-ROOM)
	(DESC "shutters")
	(SYNONYM SHUTTERS SILL WINDOW)
	(ADJECTIVE WOODEN)
	(FLAGS NDESCBIT DOORBIT PLURALBIT OPENBIT)
	(ACTION SHUTTERS-F)>

<ROUTINE SHUTTERS-F ()
	 <COND (<VERB? ENTER EXIT DISEMBARK LEAP-OFF BOARD>
		<TELL
"One look at the sheer drop, from sill to hedge to
jagged rocks far below, is enough to dissuade you." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL
"The full moon is high in the night sky.
Some distance out from the shallow curve of the island, ">
		<COND ;(<G? ,SHIP-LOC 8>
		       <TELL
"a black empty hulk rests near black, sharp silhouetted reefs">)
		      (<FSET? ,SHIP ,MUNGBIT>
		       <TELL
"black reefs catch the full force of the sea">)
		      (T
		       <TELL
"you see the slow swelling of sails,
grey turning black turning grey, on" T ,SHIP>)>
		<TELL ".">
		;<COND (<AND <IN? ,LAFOND ,HERE>
			    <NOT ,LAF-WINDOW-SEEN>>
		       <SETG LAF-WINDOW-SEEN T>
		       <TELL CR ,INDENT ,LAFOND-SEES-WINDOW>)>
		<CRLF>)
	       (<VERB? EXAMINE>
		<TELL
"Old fashioned wooden " D ,SHUTTERS ", not glass, fill" T ,WINDOW " frame.
A dusty " D ,MOONBEAM " swirls in, setting alight threads of gold embroidered
in" TR ,DRAPES>
		;<COND (<FSET? ,SHUTTERS ,OPENBIT>
		       <TELL 
"A dusty " D ,MOONBEAM " swirls through" T ,SHUTTERS ", setting alight
threads of gold embroidered in" TR ,DRAPES>)
		      (T
		       <TELL CTHE ,SHUTTERS " are closed" ,PCR>)>
		;<COND (<AND <IN? ,LAFOND ,HERE>
			    <NOT ,LAF-WINDOW-SEEN>>
		       <SETG LAF-WINDOW-SEEN T>
		       <TELL ,INDENT ,LAFOND-SEES-WINDOW CR>)
		      (T
		       <RTRUE>)>)
	       (<AND <VERB? SPOINT>
		     <PRSO? ,SHIP>>
		<PROPOSE>)
	       (<VERB? CLOSE>
		<TELL ,BEAUTIFUL-NIGHT>)
	       (<VERB? PUT-THROUGH>
		<COND (<PRSO? ,HANDS>
		       <TELL ,HUH>)
		      (<AND <PRSO? ,FLAGON ,BLUE-GLASS ,GREEN-GLASS>
			    <IN? ,LAFOND ,HERE>>
		       <TELL D ,LAFOND " stops you." CR>)	
		      (T
		       <PUT-OBJ-THRU-WINDOW>)>)
	       ;(<VERB? OPEN CLOSE>
		<OPEN-CLOSE ,SHUTTERS <> "You close the shutters, blocking
out the night, moonlight, and fresh air. The room gets darker and closer">)>> 

<OBJECT TABLE
	(IN LAFS-ROOM)
	(DESC "table")
	(LDESC
"A lace-covered table crouches beside a wing-backed chair in one corner.")
	(SYNONYM TABLE)
	(ADJECTIVE LACE-COVERED LACE COVERED WOODEN)
	(FLAGS OPENBIT SURFACEBIT CONTBIT SEARCHBIT)
	(CAPACITY 14)
	;(ACTION TABLE-F)>

;<ROUTINE TABLE-F ("OPTIONAL" (OARG <>)) T>

<GLOBAL HOLDING-PINCH <>>

<OBJECT PINCH
	(IN SPICES)
	(DESC "pinch of spices")
	(SYNONYM PINCH SPICE SPICES PEPPER)
	(FLAGS TRYTAKEBIT TAKEBIT)
	(GENERIC GEN-SPICES)
	(SIZE 1)
	(ACTION SPICES-F)>

<ROUTINE GEN-SPICES ()
	 <COND (<HELD? ,PINCH>
		<RETURN ,PINCH>)
	       (T
		<RETURN ,SPICES>)>>

<OBJECT SPICES
	(IN WELL)
	(DESC "spices")
	(SYNONYM SPICE SPICES PEPPER)
	(ADJECTIVE PINCH)
	(FLAGS TAKEBIT NDESCBIT PLURALBIT ;NARTICLEBIT)
	(GENERIC GEN-SPICES)
	(SIZE 2)
	(ACTION SPICES-F)>

<ROUTINE SPICES-F ()
	 <COND (<VERB? TAKE>
		<COND (<IN? ,PINCH ,PROTAGONIST>
		       <TELL ,YOU-HAVE-ALREADY AR ,PINCH>)
		      (T
		       <MOVE ,PINCH ,PROTAGONIST>
		       <FSET ,PINCH ,TOUCHBIT>
		       <SETG HOLDING-PINCH T>
		       <QUEUE I-SPICE-DROP 3>
		       <TELL
"You take" A ,PINCH " between your thumb and forefinger" ,PCR>)>)
	       (<VERB? EXAMINE>
		<COND (<IN? ,PINCH ,PROTAGONIST>
		       <TELL
"You are holding" A ,PINCH ". ">
		       <COND (<AND <HELD? ,TRAY ,HERE>
				   <EQUAL? <LOC ,SPICES> ,WELL>>
			      <TELL "More is in" T ,WELL " of" TR ,TRAY>)>
		       <CRLF>)
		      (T
		       <PERFORM ,V?EXAMINE ,WELL>
		       <RTRUE>)>)
	       (<VERB? EAT>
		<MOVE ,PINCH ,SPICES>
		<TELL "Your eyes start to water" ,PCR>)
	       (<VERB? SMELL>
		<MOVE ,PINCH ,SPICES>
		<TELL 
"You take a sharp sniff of" T ,SPICES " and sneeze, until "
D ,EYES " fill with tears" ,PCR>)
	       ;(<AND <VERB? PUT PUT-ON>
		     <PRSI? ,LAFOND>
		     <NOT <FSET? ,LAFOND ,DEADBIT>>>
		<TELL "He brushes himself off" ,PCR>)
	       (<AND <VERB? THROW>
		     ,PRSI
		     <NOT <PRSI? ,SPICES>>>
		<PERFORM ,V?THROW-AT ,PRSO ,PRSI>
		<RTRUE>)
	       (<VERB? BLOW PUT-ON THROW-AT>
		<COND (<IN? ,PINCH ,PROTAGONIST>
		       <COND (<AND <PRSI? ,BUTLER>
				   ;<EQUAL? <LOC ,BUTLER> ,HERE>
				   <NOT <FSET? ,BUTLER ,DEADBIT>>>
			      <TELL
"You try to get close enough to" T ,BUTLER ", but
he backs off. \"That wouldn't be seemly, Miss.\"" CR>
			      <RTRUE>)
			     (<PRSI? ,ME>
			      <IMPOSSIBLES>
			      <RTRUE>)
			     (<PRSI? ,LUCY ,COOKIE ,DAD>
			      <TELL ,UNLADY>
			      <RTRUE>)
			     (<AND <PRSI? ,CRULLEY>
				   <EQUAL? <LOC ,CRULLEY> ,DUNGEON>>
			      <TELL
D ,CRULLEY " snaps the whip at your elbow. \"Keep away from me!\"" CR>
			      <RTRUE>)>
		       <TELL
"You blow" T ,SPICES " off your fingertips">
		       <MOVE ,PINCH ,SPICES>
		       <COND (<OR <NOT ,PRSI>
				  <FSET? ,PRSI ,DEADBIT>>
			      <TELL ,PCR>)
			     (<AND <EQUAL? ,PRSI ,LAFOND>
				   <EQUAL? ,HERE ,LAFS-ROOM>
				   ;<IN? ,LAFOND ,HERE>>
			      <SETG SCORE <+ ,SCORE 1>>
			      <MOVE ,PINCH ,SPICES>
			      <REMOVE ,LAFOND>
			      <SET LAFOND-LOOKING <>>
			      <DEQUEUE I-LSED>
			      <DEQUEUE I-WONT-DRINK>
			      <QUEUE I-LRETURNS 15>
			      <FSET ,LDOOR ,OPENBIT>
			      <REMOVE ,LAF-GLASS>
			      ;<COND (<HELD? ,BLUE-GLASS>
				     <REMOVE ,GREEN-GLASS>)
				    (T
				     <REMOVE ,BLUE-GLASS>)>
			      <TELL
", directly into Lafond's face. He sneezes, his eyes watering from the heat
of the peppers. Reaching blindly for some wine, he instead upsets the table,
shattering a glass. Lafond stumbles cursing out of the room, in search of
relief">
			      <COND (<G? ,LAFOND-CTR ,HORNY>
				     <MOVE ,PROTAGONIST ,HERE>
				     <MOVE ,RETICULE ,PROTAGONIST>
				     <MOVE ,CHEMISE ,PROTAGONIST>
				     <FCLEAR ,CHEMISE ,EVERYBIT>
				     <FSET ,CHEMISE ,WORNBIT>
				     <MOVE ,SHOES ,PROTAGONIST>
				     <FSET ,SHOES ,WORNBIT>
				     <TELL
". You stand up, quickly pulling on" T ,CHEMISE>)>
			      <TELL ,PCR>)
			     (T
			      <TELL " at" T ,PRSI ". " ,NOTHING-HAPPENS>)>)
		      (T
		       <TELL ,YNH " any " D ,SPICES ,PCR>)>)>>

<ROUTINE I-LRETURNS ()
	 <COND (<AND <OR <EQUAL? ,HERE ,UPPER-HALL-E ,LAFS-ROOM>
			 <FSET? ,SHIP ,MUNGBIT>>
		     <NOT <IN? ,COOKIE ,HERE>>> 
		<JIGS-UP 
"   Roaring anger and revenge, Lafond runs in, pouncing upon you.
Your death, when it comes, is wished for.">)
	       (T
		<RFALSE>)>>

<ROUTINE I-SPICE-DROP ()
	 <COND (<IN? ,PINCH ,PROTAGONIST>
		<MOVE ,PINCH ,SPICES>
		<TELL ,INDENT
"The spices dribble out from between your fingers" ,PCR>)
	       (T
		<RFALSE>)>>

<OBJECT TRAY
	(DESC "silver tray")
	(SYNONYM TRAY)
	(FLAGS TAKEBIT OPENBIT SURFACEBIT SEARCHBIT TRANSBIT)
	(ACTION TRAY-F)>

<ROUTINE TRAY-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"Cabbage leaves are etched onto the mirror-bright " D ,TRAY ", forming
a well in the center where the metallic stalks meet.">
		<COND (<EQUAL? <LOC ,CHICKEN> ,TRAY>
		       <TELL
" Some " D ,CHICKEN " is heaped around the dry spices filling" TR ,WELL>)
		      (T
		       <CRLF>)>)
	       (<AND <VERB? PUT POINT>
		     <PRSI? ,SHIP ,SHUTTERS ,MOONBEAM>>
		<SIGNAL-SHIP ,TRAY>)
	       (<VERB? EMPTY>
		<TELL "You have no other way of carrying" TR ,CHICKEN>)
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,TRAY>>
		<TELL
"Because of the metal work, nothing sits flat on" TR ,TRAY>)>>

<OBJECT WELL
	(IN TRAY)
	(DESC "well")
	(SYNONYM WELL)
	(ADJECTIVE SPICE SILVER)
	(GENERIC GEN-WELL)
	(FLAGS OPENBIT NDESCBIT CONTBIT SEARCHBIT)
	(ACTION WELL-F)>

<ROUTINE WELL-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<IN? ,SPICES ,WELL>
		       <TELL
CTHE ,WELL " in" T ,TRAY " is filled with a mixture of
salt and other spices, predominantly red and black pepper" ,PCR>)
		      (T
		       <TELL "It is empty." CR>)>)
	       (<VERB? TAKE>
		<TELL CTHE ,WELL " is part of the tray!" CR>)>>

<OBJECT CHICKEN
	(IN TRAY)
	(DESC "cold chicken")
	(SYNONYM FOOD CHICKEN VIANDS FOWL)
	(ADJECTIVE COLD PIECES)
	(FLAGS TRYTAKEBIT)
	(SIZE 3)
	(ACTION CHICKEN-F)>

<ROUTINE CHICKEN-F ()
	 <COND (<VERB? EAT TAKE> 
		<TELL
"You sprinkle some " D ,SPICES " on a wing and nibble at it. The peppery heat
hits you like a wave, leaving you gasping, eyes watering" ,PCR>)
	       (<VERB? EXAMINE>
		<COND (<IN? ,CHICKEN ,TRAY>
		       ;<TELL
"Mounds of " D ,CHICKEN " are heaped upon" TR ,TRAY>
		       <PERFORM ,V?EXAMINE ,TRAY>
		       <RTRUE>)
		      (T
		       <TELL CTHE ,CHICKEN " looks tasty" ,PCR>)>)
	       (<AND <VERB? PUT-ON>
		     <PRSO? ,SPICES ,PINCH>>
		<PERFORM ,V?EAT ,CHICKEN>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSO? ,CHICKEN>>
		<PERFORM ,V?EAT ,CHICKEN>
		<RTRUE>)>>

<OBJECT FLAGON
	(IN TABLE)
	(DESC "flagon")
	(SYNONYM FLAGON)
	;(ADJECTIVE SILVER)
	(FLAGS TRYTAKEBIT TAKEBIT CONTBIT SEARCHBIT OPENBIT)
	(CONTENTS 1)
	(SIZE 3)
	(ACTION FLAGON-F)>

<ROUTINE FLAGON-F ()          ;"Formerly CANTEEN-FCN"
	 <COND (<VERB? SHAKE LOOK-INSIDE EXAMINE>
		<TELL "Some wine sloshes around inside." CR>
		;<COND (<AND <IN? ,WINE ,FLAGON>
			    <G? ,WINE-LEFT 0>>
		       <TELL "Some wine sloshes around inside." CR>)
		      (T
		       <TELL CTHE ,FLAGON " is empty." CR>)>)
	       (<AND <VERB? TAKE>
		     <FSET? ,FLAGON ,TRYTAKEBIT>>
		<TELL
"Lafond takes it from you, setting it on" TR ,TABLE>)
	       (<AND <VERB? DROP>
		     <EQUAL? ,HERE ,LAFS-ROOM>>
		<MOVE ,FLAGON ,TABLE>
		<TELL "You set" T ,FLAGON " on" TR ,TABLE>) 
	       (<AND <VERB? EMPTY THROW>
		     <EQUAL? ,HERE ,LAFS-ROOM>
		     <IN? ,LAFOND ,HERE>>
		<FWTD ,SMACK-YOUR-FACE>)
	       (<VERB? DRINK-FROM>
		;<SETG AWAITING-REPLY 2>
		;<QUEUE I-REPLY 2>
		<TELL ,UNLADY>)>>

<OBJECT WINE
	(IN FLAGON)
	(DESC "quantity of wine")
	(SYNONYM WINE)
	(FLAGS TRYTAKEBIT NDESCBIT)
	(SIZE 1)
	(ACTION WINE-F)>

;<GLOBAL WINE-LEFT 10>

<ROUTINE WINE-F ()
	 <COND (<VERB? EAT DRINK GIVE SHOW>
		<COND (<HELD? ,BLUE-GLASS>
		       <IMBIBE-WINE ,BLUE-GLASS>)
		      (<HELD? ,GREEN-GLASS>
		       <IMBIBE-WINE ,GREEN-GLASS>)
		      (T
		       <TELL ,YNH " a goblet of wine!" CR>)>)
	       (<AND <PRSO? ,WINE> 
		     <VERB? POUR>>
		<COND ;(<L? ,WINE-LEFT 1>
		       <TELL "There's no wine left" ,PCR>)
		      (<NOT ,PRSI>
		       <COND (<AND <EQUAL? ,P-PRSA-WORD ,W?SPILL>
				   <EQUAL? ,HERE ,LAFS-ROOM>
				   <IN? ,LAFOND ,HERE>>
			      <FWTD ,SMACK-YOUR-FACE>)
			     (T
			      <SPECIFY-WHAT "pour" ,PRSO>)>)
		      (<PRSI? ,FLAGON>
		       <TELL
"It's not sanitary to pour wine back into" TR ,FLAGON>)
		      (<PRSI? ,BLUE-GLASS ,GREEN-GLASS>
		       <COND (<EQUAL? <GETP ,PRSI ,P?CONTENTS>
					     ,WINED ,W-P>
			      <TELL "It is already full!" CR>
			      <RTRUE>)
			     (T
			      <POUR-WINE ,PRSI>)>)
		      (T
		       <TELL ,POLITE-SOCIETY>)>)
	       (<AND <VERB? POUR-FROM WRING>
		     <PRSO? ,WINE>>
		<SPECIFY-WHAT "pour" ,PRSO>)
	       (<VERB? DROP THROW>
		<COND (<AND <EQUAL? ,HERE ,LAFS-ROOM>
			    <IN? ,LAFOND ,HERE>>
		       <LAFS-DROP>)
		      (<AND <HELD? ,BLUE-GLASS>
			    <G? <GETP ,BLUE-GLASS ,P?CONTENTS> 0>>
		       <PERFORM ,V?DROP ,BLUE-GLASS>
		       <RTRUE>)
		      (<AND <HELD? ,GREEN-GLASS>
			    <G? <GETP ,GREEN-GLASS ,P?CONTENTS> 0>>
		       <PERFORM ,V?DROP ,GREEN-GLASS>
		       <RTRUE>)
		      (T
		       <TELL ,YNH " any wine!" CR>)>)>>

<ROUTINE IMBIBE-WINE (VESSEL)
	  <COND (<EQUAL? <GETP .VESSEL ,P?CONTENTS> 0 ,POISONED>
		 <TELL "There is no wine in" TR .VESSEL>
		 <RTRUE>)
		(<VERB? GIVE SHOW>
		 <PERFORM ,V?GIVE .VESSEL ,PRSI>
		 <RTRUE>)
		(<AND <EQUAL? <GETP .VESSEL ,P?CONTENTS> ,W-P>
		      <NOT <QUEUED? ,I-SLEEP>>>
		 <QUEUE I-SLEEP 2>)>
	  <SETG REACTION ,REACTION-POSITIVE>
	  <PUTP .VESSEL ,P?CONTENTS 0>
	  <TELL "You empty" T .VESSEL " of wine" ,PCR>>

<ROUTINE POUR-WINE (VESSEL "OPTIONAL" (LAFOND-POURS <>))
	 <COND (<EQUAL? <GETP ,FLAGON ,P?CONTENTS> ,POISONED>
		<PUTP .VESSEL ,P?CONTENTS ,W-P>)
	       (T
		<PUTP .VESSEL ,P?CONTENTS <+ <GETP .VESSEL ,P?CONTENTS> 1>>)>
	 <COND (<NOT .LAFOND-POURS>
		<TELL "You fill" T .VESSEL " with wine" ,PCR>)
	       (T
		<RTRUE>)>>


<GLOBAL DRUGGEE <>>     ;"set to person who gets drugged"
<GLOBAL SLEEP-CTR 0>    ;"following you falling asleep"
<GLOBAL WATCH-CTR 0>    ;"watching someone else fall asleep"

<ROUTINE I-WATCH-SLEEP ()
	 <COND (<NOT ,DRUGGEE>
		<RFALSE>)
	       (<AND <EQUAL? ,DRUGGEE ,BUTLER>
		     <EQUAL? ,WATCH-CTR 2>>
		<SETG SCORE <+ ,SCORE 1>>
		<FSET ,BUTLER ,DEADBIT>
		<COND (<NOT <IN? ,BUTLER ,HERE>>
		       <TELL ,INDENT
"You hear a \"thump-phoosh,\" like someone slumping against a wall" ,PCR>)
		      (<EQUAL? ,HERE ,LAFS-ROOM>
		       <COND (<HELD? ,BOTTLE ,HERE>
			      <REMOVE ,BOTTLE>
			      <TELL ,INDENT
"With a grunt of anger, the butler realizes he has been drugged.
He grabs" T ,BOTTLE " and throws it out" TR ,SHUTTERS>)>
		       <TELL ,INDENT CTHE ,DRUGGEE
			     <GET ,WATCHING-SLEEPY ,WATCH-CTR> ,PCR>)>
		<SETG DRUGGEE <>>
		<RTRUE>)
	       (<IN? ,DRUGGEE ,HERE>
		<TELL ,INDENT CTHE ,DRUGGEE 
		      <GET ,WATCHING-SLEEPY ,WATCH-CTR> ,PCR>)>
	 <QUEUE I-WATCH-SLEEP 1>
	 <SETG WATCH-CTR <+ ,WATCH-CTR 1>>>

<ROUTINE I-CROC-SLEEPS ()
	  <COND (<EQUAL? ,HERE ,ANTEROOM>
		 <TELL
,INDENT "Without warning," T ,CROC " relaxes, eyes closed, asleep." CR>)>
	  <SETG SCORE <+ ,SCORE 1>>
	  <SETG CROC-SLEEP T>
	  <SETG MOUTH-SHUT T>
	  <RFALSE>>

<GLOBAL WATCHING-SLEEPY
	<TABLE
	 " seems to be having some problems stifling a yawn"
	 "'s eyes are getting heavier"
	 " collapses, head back, snoring loudly">>

<ROUTINE I-SLEEP ()
	 <TELL ,INDENT <GET ,GETTING-SLEEPY
			    <SETG SLEEP-CTR <+ ,SLEEP-CTR 1>>> CR>
	 <COND (<L? ,SLEEP-CTR 4>
		<QUEUE I-SLEEP 2>)
	       (<EQUAL? ,SLEEP-CTR 4>
		<TELL ,INDENT>
		<COND (<EQUAL? ,HERE ,ON-LADDER ,RIGGING-ROOM>
		       <JIGS-UP
"Too drugged to keep your grip on the ropes, you slip into the sea.">) 
		      (<AND <SHIP-BOARD ,HERE>
			    <OR <QUEUED? ,I-LOOK-SEA>
				<QUEUED? ,I-SHIP-EXPLODES>>>
		       <JIGS-UP
"You awake too late to save the ship -- or rather, you never wake at all.">)
		      (T
		       <TELL "You wake at sunrise">
		       <COND (<NOT <FSET? ,LAFS-ROOM ,TOUCHBIT>>
			      <TELL
", too late to save your father or his friend Jamison">)>
		       <FWTD
". The governor of St. Sinistra provides you with food and shelter;
at least, until he grows tired of your body and your presence.">)>)
	       (T
		<RFALSE>)>>      

<GLOBAL GETTING-SLEEPY
	<TABLE
	 0
	 "Your face convulses in a prodigious yawn."
	 "You stare into space for a long, thoughtless moment. It seems
very hard to think, you think, but you aren't sure."
	 "Your eyes are extraordinarily dry. You blink to moisten them,
and snort awake a minute later, drool dripping down your chin."
	 "Sleep overtakes you and you slump into unconsiousness.">>

<GLOBAL USED-LAUD <>>
;<GLOBAL FLAGON-POISONED <>>

<CONSTANT WINED 1>
<CONSTANT POISONED 2>
<CONSTANT W-P 3>

<GLOBAL LAF-GLASS GREEN-GLASS>
<GLOBAL YOUR-GLASS BLUE-GLASS>

<GLOBAL SPICED-WINE <>>

<OBJECT BLUE-GLASS
	(IN TABLE)
	(DESC "blue goblet")
	(SYNONYM CUP GLASS GOBLET)
	(ADJECTIVE BLUE MY)
	(CONTENTS 0)
	(FLAGS TAKEBIT CONTBIT OPENBIT)
	(SIZE 2)
	(CAPACITY 2)
	(ACTION GLASS-F)>

<OBJECT GREEN-GLASS
	(IN TABLE)
	(DESC "green goblet")
	(SYNONYM CUP GLASS GOBLET)
	(ADJECTIVE GREEN HIS)
	(CONTENTS 0)
	(FLAGS TAKEBIT CONTBIT OPENBIT)
	(SIZE 2)
	(CAPACITY 2) 
	(ACTION GLASS-F)>

<ROUTINE GLASS-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
CTHE ,PRSO <GET ,GLASS-DESC <GETP ,PRSO ,P?CONTENTS>> ,PCR>)
	       (<VERB? OPEN CLOSE>
		<IMPOSSIBLES>)
	       (<VERB? DRINK-FROM>
		<COND (,PRSI
		       <IMBIBE-WINE ,PRSI>)
		      (T
		       <IMBIBE-WINE ,PRSO>)>)
	       (<VERB? FILL>
		<PERFORM ,V?POUR ,WINE ,PRSO>
		<RTRUE>)
	       (<AND <VERB? DROP>
		     <EQUAL? ,HERE ,LAFS-ROOM>>
		<MOVE ,PRSO ,TABLE>
		<TELL "You set" T ,PRSO " on" TR ,TABLE>)
	       (<VERB? THROW MUNG THROW-AT>
		<LAFS-DROP>)
	       (<VERB? TAKE>
		<COND (<PRSO? ,LAUD>
		       <IMPOSSIBLES>)
		      (<AND <PRSO? ,GREEN-GLASS>
			    <L? ,LAFOND-CTR 3>
			    <EQUAL? ,HERE ,LAFS-ROOM>>
		       <TELL D ,LAFOND " stops you. \"That is mine.\"" CR>)   
		      (<OR <HELD? ,BLUE-GLASS>
			   <HELD? ,GREEN-GLASS>>
		       <TELL ,YOU-HAVE-ALREADY " a goblet" ,PCR>)
		      (T <RFALSE>)>)>>

<GLOBAL GLASS-DESC
	<TABLE
	 " is ornate and expensive"
	 " is brimming with wine"
         " has a small pool of liquid at the bottom"
	 " is brimming with wine">>

<ROUTINE LAFS-DROP ()
	 <COND (<PRSO? ,GREEN-GLASS ,BLUE-GLASS>
		<REMOVE ,PRSO>
		<PUTP ,PRSO ,P?CONTENTS 0>
		<TELL
"The delicate glass of" T ,PRSO " shatters into pieces." CR>)
	       (<PRSO? ,WINE>
		<TELL "You dash" T ,WINE " into Lafond's face." CR>)
	       (T
		<WASTES>)>
	 <COND (<AND <EQUAL? ,HERE ,LAFS-ROOM>
		     <IN? ,LAFOND ,HERE>>
		<FWTD ,SMACK-YOUR-FACE>)
	       (T
		<RTRUE>)>>

<ROOM GALLERY 
      (IN ROOMS)
      (DESC "Gallery")
      ;(SYNONYM BALCONY GALLERY)
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      (NORTH TO UPPER-HALL-E)
      (GLOBAL CHANDELIER RAILING)
      (ACTION GALLERY-F)>

<ROUTINE GALLERY-F (RARG "AUX" (GUY <>))
	 <COND (<EQUAL? .RARG ,M-BEG>
		<COND (<OR <TOUCHING? <SET GUY ,HERO>>
                           <TOUCHING? <SET GUY ,LAFOND>>
			   <TOUCHING? <SET GUY ,DAD>>
			   <TOUCHING? <SET GUY ,LUCY>>
			   <TOUCHING? <SET GUY ,COOKIE>>
			   <TOUCHING? <SET GUY ,RAPIER>>>
			;<OR <TOUCHING? ,HERO>
                           <TOUCHING? ,LAFOND>
			   <TOUCHING? ,DAD>
			   <TOUCHING? ,LUCY>
			   <TOUCHING? ,COOKIE>
			   <TOUCHING? ,RAPIER>>
		       <CANT-REACH .GUY>)
		      (<VERB? THROW-AT>
		       <TELL "You missed." CR>)
		      (<AND <PRSO? ,GALLERY>
			    <VERB? EXAMINE LOOK>>
		       <V-LOOK>)
		      (<PRSO? ,BALLROOM>
		       <COND (<VERB? EXAMINE>
			      <V-LOOK>)
			     (<VERB? ENTER LEAP>
			      <PERFORM ,V?SWING ,ROPE>
			      <RTRUE>)
			     (T
			      <RFALSE>)>)
		      (<VERB? LEAP-OFF>
		       <PERFORM ,V?SWING ,ROPE>
		       <RTRUE>) 
		      (<AND <VERB? SWING>
			    <PRSO? ,ROOMS>>
		       <PERFORM ,V?SWING ,ROPE>
		       <RTRUE>)
		      (<AND <VERB? ASK-ABOUT TELL TELL-ABOUT>
			    <RUNNING? ,I-DUEL>>
		       <TELL "No one is listening to you." CR>
		       <STOP>
		       <RTRUE>
		       ;<RFATAL>)
		      (T
		       <RFALSE>)>)
	       (<AND <EQUAL? .RARG ,M-ENTER>
		     <RUNNING? ,I-DUEL>>
		<FSET ,HERO ,NDESCBIT>
		<FSET ,LAFOND ,NDESCBIT>
		<FSET ,COOKIE ,NDESCBIT>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are on a wide balcony overlooking the ballroom.
A hallway lies to the north.|
   Down on" ,DANCE-FLOOR>
		<COND (<RUNNING? ,I-DUEL>
		       <TELL T ,DANCERS "s are pressed in a wide circle
around Nicholas and Lafond. Cookie stands anxiously in the door to
the veranda, near" T ,DAD " and Lucy">)
		      (<FSET? ,BALLROOM ,EVERYBIT>
		       <TELL
" a small number of Jamison's scruffiest men are corralling" T ,DANCERS
" into a screaming huddle in the center of the room">)
		      (T
		       <TELL
" you see myriad colors as the guests weave
the intricate steps of their dances">)>
		<TELL ".">
		;<DANCEFLOOR-DESC>)>>

;"Used by the Gallery and Stairtop."

;<ROUTINE old-DANCEFLOOR-DESC ()
	 <TELL CR ,INDENT "Down on the dance floor">
	 <COND (<RUNNING? ,I-DUEL>
		<TELL T ,DANCERS "s are pressed in a wide circle
around Nicholas and Lafond. Cookie stands anxiously in the door to
the veranda, near" T ,DAD " and Lucy">)
	       (<FSET? ,BALLROOM ,EVERYBIT>
		<TELL
" a small number of Jamison's scruffiest men are corralling" T ,DANCERS
" into a screaming huddle in the center of the room">)
	       (T
		<TELL
" you see myriad colors as the guests weave
the intricate steps of their dances">)>
	 <TELL ".">>

<OBJECT RAILING
	(IN LOCAL-GLOBALS)
	(DESC "railing")
	(SYNONYM RAILING)>


<OBJECT ROPE
	(IN GALLERY)               ;"EVERYBIT = rope is tied"
	(DESC "rope")              ;"MUNGBIT = tried to cut it once"
	(DESCFCN ROPE-F)
	(SYNONYM ROPE)
	(ADJECTIVE HEAVY)
	(FLAGS TRYTAKEBIT EVERYBIT BURNBIT)
	(ACTION ROPE-F)>

<ROUTINE ROPE-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-DESC?>
		       <RTRUE>)>
		<TELL ,INDENT>
		<DESC-ROPE>)
	       (<VERB? EXAMINE>
		<DESC-ROPE>)
	       (<VERB? SWING CLIMB-DOWN CLIMB-ON>
		<COND (<FSET? ,ROPE ,EVERYBIT>
		       <TELL CTHE ,ROPE
" is looped over the railing -- you'd hang " D ,ME ,PCR>)
		      (<AND <IN? ,COOKIE ,HERE>
			    <NOT <RUNNING? ,I-DUEL>>>
		       <TELL
D ,COOKIE " grabs hold of you, \"Ye lost yer mind, lass!\"" CR>) 
		      (T
		       <TELL
"\"Aaieeee!\" The cry comes uncalled to your lips
as you swoop down from the balcony">
		       <COND (<NOT ,BOY-DRESS?>
			      <TELL ", petticoats flying,">)>
		       <TELL " on the end of" TR ,ROPE ,INDENT>
		       <COND (<RUNNING? ,I-DUEL>
			      <COND (<L? ,HERO-CTR  15>
				     <DEQUEUE I-DUEL>
				     <FCLEAR ,RAPIER ,NDESCBIT>
				     <MOVE ,HERO ,BEACH>
				     <FCLEAR ,HERO ,NDESCBIT>
				     <MOVE ,LAFOND ,BALLROOM>
				     <FCLEAR ,LAFOND ,NDESCBIT>
				     <MOVE ,DAD ,BEACH>
				     <MOVE ,LUCY ,BEACH>
				     <MOVE ,COOKIE ,BEACH>
				     <FCLEAR ,COOKIE ,NDESCBIT>
				     <FCLEAR ,BALLROOM ,EVERYBIT>
				     <FSET ,VER-DOOR ,OPENBIT> 
				     <FSET ,LAFOND ,MUNGBIT>
				     <SETG SCORE <+ ,SCORE 1>>
				     <COND (<IN? ,BLUE-GLASS ,PROTAGONIST>
					    <REMOVE ,BLUE-GLASS>)
					   (<IN? ,GREEN-GLASS ,PROTAGONIST>
					    <REMOVE ,GREEN-GLASS>)>
				     <COND (<IN? ,PINCH ,PROTAGONIST>
					    <MOVE ,PINCH ,SPICES>)>
				     <ROB ,PROTAGONIST ,BALLROOM>
				     <SETG LAFOND-CTR 1>
				     <QUEUE I-ENDGAME 6>
				     <TELL
"Your timing is perfect: you slam into Lafond just as he steps into his
lunge. His rapier stabs wildly, piercing Nicholas's shoulder, missing his
heart. You and Lafond roll into a snowball of ">
				     <COND (<NOT ,BOY-DRESS?>
					    <TELL "petticoats">)
					   (T
					    <TELL "breeches">)>
				     <TELL
" and brocade, dropping everything between you.">
				     <CLEAR-SCREEN 15>
				     ;<QUEUE I-MOVE-GROUP -1>
				     <TELL ,INDENT
"Nicholas shouts, from far away, \"Let me go! Let me deliver Lafond
to a 'better' world.\"|
   \"A gentleman can't kill an unconscious man!\" That is Papa's voice.
\"And you're in no shape to continue, Nicholas. Rodney -- help my daughter.
I'll take Nick.\"|
   Cookie leans over you. \"We must get back to the ship, Miss. Dragoons
surround the house.\" Nicholas, injured but still arguing, is already on the
veranda, half-forced, half-supported by your father, shadowed by Lucy.
Cookie helps you to your feet and rushes after them, expecting you to
follow. Lafond lies nearby, apparently unconscious" ,PCR CR>
				     ;<TELL ,INDENT
"Cookie shakes you awake, \"We must speed away, Miss. Dragoons are surrounding
the house.\" Nicholas, supported by your father and Lucy, is already on the
veranda. Cookie helps you to your feet and rushes after them, expecting you
to follow. Lafond lies nearby, apparently unconscious" ,PCR CR>
				     <GOTO ,BALLROOM>)
				    (T
				     ;<CRLF>
				     <JIGS-UP
"Startled, Lafond raises his sword and you fly onto
the blade. You fall over your lover's body and expire, your
lips on his in a kiss outlasting death.">)>)
			     (<FSET? ,BALLROOM ,EVERYBIT>
			      <JIGS-UP 
"You sweep down into the ballroom, felling dancer and pirate alike.
Unfortunately, one of Jamison's crew, mistaking your shortcut for an
attack, greets you with a sharpened dagger.">) 
			     (T
			      ;<CRLF>
			      <FWTD
"Other cries rise to match yours as you sweep down the center of the
ballroom in an avalanche of dancers, knocking yourself unconscious
against the far wall. You awaken the next morning, in the village,
embarrassed and alone.">)>)>)
	       ;(<VERB? CUT>
		<COND (<AND <EQUAL? ,PRSI ,ROOMS>
			    <HELD? ,DAGGER>>
		       <TELL "[with the dagger]" CR>
		       <PERFORM ,V?CUT ,ROPE ,DAGGER>
		       <RTRUE>)
		      (<PRSI? ,DAGGER>
		       <TELL
CTHE ,DAGGER " is too dull to cut through" TR ,ROPE>
		       ;<COND (<FSET? ,ROPE ,EVERYBIT>
			      <COND (<NOT <FSET? ,ROPE ,MUNGBIT>>
				     <FSET ,ROPE ,MUNGBIT>
				     <TELL
"The dagger is very dull, so you saw away
at" T ,ROPE ". It frays a bit, after a time" ,PCR>)
				    (T
				     <FCLEAR ,ROPE ,TAKEBIT>
				     <FSET ,ROPE ,DEADBIT>
				     <FCLEAR ,ROPE ,EVERYBIT>
				     <FSET ,ROPE ,NDESCBIT>
				     <CHANDELIER-DROPS "cut">
				     <TELL ,INDENT
"The rest of the rope comes unknotted and
slips off the railing into the crowd below" ,PCR>)>)
			     (<FSET? ,ROPE ,DEADBIT>
			      <TELL
"What little rope remains is swinging from the
pulley on the ceiling over the ballroom, and out of reach" ,PCR>)>)>)
	       (<AND <VERB? TIE>
		     <PRSI? ,RAILING>>
		<COND (<FSET? ,ROPE ,EVERYBIT>
		       <TELL ,ALREADY-IS>)
		      (T
		       <FSET ,ROPE ,EVERYBIT>
		       <TELL "Tied." CR>)>)
	       (<VERB? UNTIE REMOVE>
		<COND (<FSET? ,ROPE ,EVERYBIT>
		       <FCLEAR ,ROPE ,EVERYBIT>
		       <TELL
"Untied. " CTHE ,CHANDELIER " swings slightly,
dribs of hot wax spilling to the floor." CR>
		       ;<CHANDELIER-DROPS>
		       ;<TELL ,INDENT
"A knot blocks the rest of the rope from passing through the pulley" ,PCR>)
		      (T
		       <WASTES>)>)
	       (<VERB? TAKE>
		<COND (<FSET? ,ROPE ,EVERYBIT>
		       <DO-FIRST "untie it">)
		      (<FSET? ,ROPE ,DEADBIT>
		       <CANT-REACH ,ROPE>)
		      (T
		       <TELL
"Pray describe what you intend to do with" TR ,ROPE>
		       ;<TELL
"If you want to pull on the rope, just say so. If you want to swing on the
rope, just say so. If you want to turn the rope into a cobra, just say so
(but it won't work)" ,PCR>)>)
	       (<VERB? MOVE RAISE FIDDLE>
		<TELL
CTHE ,CHANDELIER " swings, but is too heavy for you to pull up" ,PCR>)>>

<ROUTINE DESC-ROPE ()
	 <TELL
"A " D ,CHANDELIER " is held above" ,DANCE-FLOOR " by a rope and pulley
system, so that the servants can lower it to light and snuff its candles.
Several feet of " D ,ROPE " hang down from the pulley, the ">
		<COND (<FSET? ,ROPE ,EVERYBIT>
		       <TELL "excess tied around">)
		      (T
		       <TELL "end resting on">)>
		<TELL T ,RAILING ".">
	 <COND (<VERB? EXAMINE>
		<CRLF>)
	       (T
		<RTRUE>)>>

<OBJECT CHANDELIER
	(IN LOCAL-GLOBALS)
	(DESC "chandelier")
	(SYNONYM CHANDELIER PULLEY CANDLE)
	(FLAGS LIGHTBIT ONBIT)
	(ACTION CHAND-F)>

<ROUTINE CHAND-F ()
	 <COND (<VERB? OFF>
		<CANT-REACH ,CHANDELIER>)
	       (<VERB? EXAMINE>
		<TELL
"Held in place by a rope running through a pulley," T ,CHANDELIER
" gently swings its one hundred candles over" ,DANCE-FLOOR ,PCR>)
	       (<VERB? UNTIE SWING>
		<PERFORM-PRSA ,ROPE>)>>

;<ROUTINE CHANDELIER-DROPS ()
	 <TELL "You untie" T ,ROPE ". A loud squeal erupts from
the pulley above" T ,CHANDELIER " as the huge ring of candles plummets down,
whipping" T ,ROPE " up after. Suddenly the whole contraption jerks to a stop,
and" T ,CHANDELIER " swings, spilling hot wax, about ten feet above the floor
of the ballroom.">
	 <COND (<FSET? ,BALLROOM ,EVERYBIT>
		<TELL " In the general melee below, no one notices" ,PCR>
		<RTRUE>)>
	 <CRLF>
	 <COND (<NOT <RUNNING? ,I-DUEL>>
		<TELL ,INDENT
CTHE ,DANCERS "s try to stampede out of the way, a woman starts to scream,
a man curses loudly, once">
		<COND (<AND <NOT <QUEUED? ,I-SUMMONS>>
			    <NOT <FSET? ,LDOOR ,LOCKEDBIT>>>
		       <TELL
". Then a bewigged man appears in a doorway, surveying the crowd, and
immediately everything returns to normal, silent but for the music and
the frightened hush of" T ,DANCERS "s spinning over the floor">)>
		<TELL ,PCR>)
	       (<L? ,HERO-CTR 15>
		<TELL ,INDENT
"Neither duellist, concentrating on his opponent, takes any notice." CR>)
	       (T
		<RTRUE>)>> 

<ROOM STAIRWELL 
      (IN ROOMS)
      (DESC "Stairwell")
      (LDESC
"Cool salt air, blowing past a torch on a spiral staircase below you,
ruffles your hair and circles south into the library.")
      (FLAGS RLANDBIT INDOORSBIT ONBIT NARTICLEBIT)
      (OUT PER PORTRAIT-EXIT)
      (SOUTH PER PORTRAIT-EXIT)
      (DOWN TO BOTTOM-STAIRS)
      (GLOBAL STAIRS PORTRAIT TORCH)
      ;(ACTION STAIRWELL-F)>

;<ROUTINE STAIRWELL-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <FSET? ,DAD ,DEADBIT>
		     <QUEUED? I-CKILLS-DAD>>
		<JIGS-UP
"   Just inside the portrait stands Crulley, knife at
the ready. You don't even have time to scream.">)>>

<ROOM BOTTOM-STAIRS 
      (IN ROOMS)
      (DESC "Bottom of Stairwell")
      (LDESC
"Flickering torchlight lights the bottom of a spiral staircase. A
draft blows from the east; a passage leads south.")
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      (UP TO STAIRWELL)
      (EAST TO PASSAGE-1)
      (SOUTH TO ANTEROOM)
      (GLOBAL STAIRS TORCH)>

<ROOM PASSAGE-1 
      (IN ROOMS)
      (DESC "North Passage")
      (LDESC
"A strong wet breeze blows from a low doorway to the east. A circle of
light leads west. The passageway continues south.")
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      (EAST TO CELL-1)
      (WEST TO BOTTOM-STAIRS)
      (SOUTH TO PASSAGE-2)
      (GLOBAL CELL-OBJ)>

<OBJECT COT
	(IN CELL-1)
	(DESC "cot")
	(LDESC "A canvas cot is shoved against a wall.")
	(SYNONYM COT BED)
	(ADJECTIVE CANVAS)
	(FLAGS VEHBIT CONTBIT SEARCHBIT SURFACEBIT OPENBIT TRANSBIT)
	(CAPACITY 20)
	(ACTION BED-F)>

<OBJECT CRACK
	(IN CELL-1)
	(DESC "crack")
	(SYNONYM CRACK)
	(FLAGS NDESCBIT)
	(ACTION CRACK-F)>

<ROUTINE CRACK-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<PERFORM ,V?EXAMINE ,SHIP>
		<RTRUE>)
	       (<VERB? ENTER CLIMB-ON BOARD>
		<TELL CTHE ,CRACK " is too narrow." CR>)>>

<ROOM CELL-1
      (IN ROOMS)
      (DESC "Guard's Bunkroom")
      (LDESC
"Once a cell, now, with the door missing, made into a guard's bunkroom,
this room is distinctly uncomfortable. Gasps of air are forced through a
crack in the seaward wall of the room. The way out is west of you.")
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      (WEST TO PASSAGE-1)
      (GLOBAL CELL-OBJ)>

<GLOBAL PRIMED <>>

<OBJECT HORN
	(IN CELL-1)
	(DESC "powder horn")
	(FDESC "A powder horn hangs on a long strap from the wall.") 
	(SYNONYM HORN STRAP)
	(ADJECTIVE POWDER)
	(FLAGS TAKEBIT CONTBIT OPENBIT SEARCHBIT)
	(ACTION HORN-F)>

<ROUTINE HORN-F ()
	 <COND (<VERB? EMPTY>
		<TELL "You start to empty it, but reconsider." CR>)
	       (<AND <VERB? EMPTY-FROM>
		     <PRSI? ,HORN>>
		<PERFORM ,V?EMPTY ,HORN>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     <NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>
		     <NOT <FSET? ,HORN ,TOUCHBIT>>>
		<FCLEAR ,POWDER ,INVISIBLE>
		<TELL "Taken." CR>)
	       (<AND <VERB? FILL>
		     <PRSO? ,HORN>>
		<CANT-VERB-A-PRSO "put anything into">
		;<TELL ,YOU-CANT "put anything into" TR ,HORN>
		;<COND (<PRSI? ,HORN>
		       <PERFORM ,V?POUR ,PRSI ,PRSO>
		       <RTRUE>)
		       (T
			<TELL ,YOU-CANT "put anything into" TR ,HORN>)>)
	       (<AND <VERB? POUR PUT>
		     <PRSI? ,HORN>>
		<PERFORM ,V?FILL ,PRSI ,PRSO>
		<RTRUE>)
	       (<VERB? OPEN CLOSE>
		<TELL ,YOU-CANT-SEE-ANY ,WAY-TO-DO-THAT>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"Almost triangular, with a little spout on top," T ,HORN
" is similar to the one your father used to carry when hunting.
It is filled with a mixture of " D ,POWDER " and shot" ,PCR>)
	       (<AND <VERB? TAKE>
		     <NOUN-USED ,W?POWDER ,HORN>
		     <HELD? ,HORN>>
		<TELL
"You pour out some " D ,POWDER ". It blows away." CR>)>>

<OBJECT POWDER
	(IN HORN)
	(DESC "gunpowder")
	(SYNONYM POWDER GUNPOW SHOT)
	(FLAGS NARTICLEBIT NDESCBIT)>

<ROOM PASSAGE-2 
      (IN ROOMS)
      (DESC "South Passage")
      (LDESC
"You are at the far end of a dank passageway heading north.
A wooden door leads east.")
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      (NORTH TO PASSAGE-1)
      (EAST TO CELL-2 IF WOOD-CELL-DOOR IS OPEN)
      (GLOBAL WOOD-CELL-DOOR CELL-OBJ)>

<OBJECT WOOD-CELL-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "wooden door")
	(SYNONYM DOOR)
	(ADJECTIVE WOOD WOODEN)
	(FLAGS NDESCBIT DOORBIT)
	(ACTION DOOR-F)>

; "Mud is splashed ankle deep, filling a deep pit in the floor."

<ROOM CELL-2
      (IN ROOMS)
      (DESC "Cell")
      (LDESC
"This tiny cell is airless and shivering cold, entirely empty of
anything but darkness. A wooden door leads west.")
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      (WEST TO PASSAGE-2 IF WOOD-CELL-DOOR IS OPEN)
      (GLOBAL WOOD-CELL-DOOR CELL-OBJ)>

;<OBJECT MUDPIT
	(IN CELL-2)
	(DESC "muddy pit")
	(SYNONYM PIT HOLE)
	(ADJECTIVE MUD MUDDY)
	(FLAGS NDESCBIT)
	(ACTION MUDPIT-F)>

;<ROUTINE MUDPIT-F ()
	 <COND (<VERB? ENTER BOARD>
		<TELL "You'd get far too dirty" ,PCR>)
	       (T
		<UNIMPORTANT-THING>)>>

<ROOM ANTEROOM 
      (IN ROOMS)
      (DESC "Anteroom")
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      (NORTH TO BOTTOM-STAIRS)
      (SOUTH PER CROC-EXIT)
      (GLOBAL CHAIN)
      (ACTION ANTEROOM-F)>     

<ROUTINE ANTEROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Two exits lead from this cavernous room, north and south.
The walls drip with wet, forming a huge pool on the floor.">)
	       (<EQUAL? .RARG ,M-END>
		<COND (<AND <NOT ,CROC-FREE>
			    <IN? ,DAD ,HERE>>
		       <TELL ,INDENT
"Your father stops, smiling at" T ,CROC
", \"Hello, chum, how are you?\" He bends over the creature, and ">
		       <COND (,MUZZLED
			      <SETG AWAITING-REPLY 6>
			      <QUEUE I-REPLY 2>
			      <MOVE ,GARTER ,DAD>
			      <FCLEAR ,GARTER ,NDESCBIT>
			      <TELL
"laughs. \"That's my Lucy! Never one to shirk belling the cat. What a
woman! Have you been to the kitchen, dear?\" He slips off" T ,GARTER " and">)
			     (,CROC-SLEEP
			      <TELL
"scratches its bumpy snout, muttering, \"Never seen you
sleep like this before.\" It stirs to life as " D ,DAD>)>
		       <TELL
" walks over to you by the north entrance. The reptile">
		       <COND (,CROC-SLEEP
			      <TELL ", waking,">)>    ;"in MUZZLED case"
		       <SETG CROC-FREE T>
		       <SETG MOUTH-SHUT <>>
		       <SETG MUZZLED <>>
		       <SETG CROC-SLEEP <>>
		       <FCLEAR ,GARTER ,TRYTAKEBIT>  ;"stop implicit take"
		       <FSET ,GARTER ,TAKEBIT>
		       <TELL " lunges after him, choking on its chain." CR>)
		      (<AND <NOT ,COOKIE-FIGHTING-CROC>
			    <IN? ,COOKIE ,HERE>>
		       <SETG COOKIE-FIGHTING-CROC T>
		       <FSET ,CROC ,NDESCBIT>
		       <TELL ,INDENT
"Cookie rushes at" T ,CROC ", crying, \"I'll take care of this monster,
sweetheart. You run by and do what you must do.\" He dives headlong into"
T ,POOL>
		       <COND (<IN? ,RAPIER ,COOKIE>
			      <MOVE ,RAPIER ,HERE>
			      <TELL ", throwing free" T ,RAPIER>)>
		       <TELL ,PCR>)>)>>

<GLOBAL WHIPPING-SPEECH T>

<ROUTINE CROC-EXIT ()
	 <COND (,COOKIE-FIGHTING-CROC
		<DUNGEON-ENTRANCE>)
	       (<OR ,MUZZLED
		    ,CROC-SLEEP>
		<TELL "You edge past the reptile" ,PCR CR>
		<RETURN ,DUNGEON>)
	       (T
		<COND (<RUNNING? ,I-CROC-OPENS-MOUTH>
		       <DEQUEUE I-CROC-OPENS-MOUTH>)>
		<TELL
CTHE ,CROC " roars at you. You retreat to the north entrance
and the monster stills, waiting, chops open, almost smiling" ,PCR>
		<RFALSE>)>>

<ROUTINE DUNGEON-ENTRANCE ()           ;"EXIT-FCN"
	 <COND (,COOKIE-FIGHTING-CROC
		<FCLEAR ,DUNGEON ,TOUCHBIT>  ;"So there's a new room desc."
		<SETG VERBOSITY 1>
		<COND (<AND <NOT <FSET? ,CRULLEY ,MUNGBIT>>
			    <NOT ,CRULLEY-BACK>>   ;"before he goes down or"
		       <SETG CRULLEY-CTR 1>           ;"comes back up well"
		       <QUEUE I-CDUNG -1>
		       <TELL "A whip cracks ">
		       <COND (,WHIPPING-SPEECH
			      <SETG WHIPPING-SPEECH <>>
			      <TELL
"the air. \"Flogs me, will ye, Cap'n? Taste it "
D ,ME ", har.\" Jamison groans, half conscious">)
			     (T
			      <TELL "against flesh">)>
		       <TELL ". You rush in" ,PCR CR>)>)>
	 <RETURN ,DUNGEON>>
	       

<GLOBAL MUZZLED <>>
<GLOBAL MOUTH-SHUT <>>
<GLOBAL CROC-FREE <>>  ;"<> until Dad takes either the garter or wakes it"
<GLOBAL CROC-SLEEP <>>

<GLOBAL CROC-LUNGES
"The monster lunges at you, chain rattling, roaring and angry. ">

<GLOBAL SNORTS-IN-SLEEP ". The monster snorts in its sleep">

<OBJECT CROC
	(IN ANTEROOM)
	(DESC "crocodile")
	(DESCFCN CROC-F)
	(SYNONYM CROC CROCOD LEBS MOUTH)
	(ADJECTIVE CROC\'S JAWS REPTILE GATOR)
	(FLAGS CONTBIT OPENBIT ACTORBIT ;TRANSBIT SEARCHBIT)
	(ACTION CROC-F)>

<ROUTINE CROC-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-DESC?>
		       <RTRUE>)>
		<COND (<FSET? ,CROC ,TOUCHBIT>
		       <TELL ,INDENT CTHE ,CROC>)
		      (T
		       <FSET ,CROC ,TOUCHBIT>
		       <TELL ,INDENT "A " D ,CROC>)>
		<TELL " lies half in the pool, ">
		<COND (,CROC-SLEEP
		       <TELL "sleeping.">
		       <RTRUE>)>
	        <TELL "gazing at you,">
		<COND (,MUZZLED
		       <TELL A ,GARTER " around its snout.">)
		      (,MOUTH-SHUT
		       <TELL " mouth closed.">)
		      (T
		       <TELL
" with baleful eyes, jaws wide open.
Dagger-sharp teeth glint in" T ,TORCH "light.">)>)
	       (<AND <VERB? PUT-ON>
		     <PRSO? ,GARTER>>
		<COND (,CROC-FREE
		       <REMOVE ,PRSO>
		       <TELL ,CROC-LUNGES
"Screaming, you dash back, dropping" T ,GARTER " into" TR ,POOL>)
		      (,MOUTH-SHUT
		       <MOVE ,GARTER ,CROC>
		       <FSET ,GARTER ,NDESCBIT>
		       <SETG MUZZLED T>
		       <FSET ,GARTER ,TRYTAKEBIT>   ;"stop implicit take"
		       <FCLEAR ,GARTER ,TAKEBIT>
		       <COND (<NOT ,CROC-SLEEP>
			      <COND (<NOT <QUEUED? ,I-CROC-SLEEPS>>
				     <SETG SCORE <+ ,SCORE 1>>)>
			      <TELL
"With great daring and greater speed, you slip" T ,GARTER " around" T ,CROC
"'s snout. " CTHE ,CROC " thrashes about, unable to remove it." CR>)
			     (T
			      <TELL
CTHE ,GARTER " fits on its snout like a ring on a wedding finger" ,PCR>)>)
		      (T
		       <TELL
CTHE ,GARTER " won't fit around that open maw" ,PCR>)>)
	       (<AND ,CROC-SLEEP
		     <VERB? ALARM>>
		<TELL "That is the last thing you want to do!" CR>)
	       (<VERB? KISS EMBRACE>
		<TELL "The very thought makes you shiver." CR>)
	       (<VERB? PUT PUT-ON TOUCH ENTER>
		<TELL
"It would be safer to stay distant and throw things at" TR ,CROC>)
	       (<AND <NOUN-USED ,W?MOUTH ,CROC>
		     <ZERO? <GET ,P-ADJW 0>>
		     <ZERO? <GET ,P-ADJW 1>>>
		<RFALSE>)                           ;"OPEN/L AT/etc. MOUTH"
	       (<AND <VERB? MUZZLE>
		     <PRSI? ,GARTER>>
		<PERFORM ,V?PUT-ON ,GARTER ,CROC>
		<RTRUE>)
	       (<VERB? THROW GIVE THROW-TO THROW-AT>
		<COND (,COOKIE-FIGHTING-CROC
		       <TELL
CTHE ,CROC " is too busy fighting Cookie to notice." CR>)
		      (<PRSO? ,BOTTLE>
		       <TELL "You might need that later." CR>)
		      (<PRSO? ,RETICULE>
		       <RFALSE>)
		      (,CROC-SLEEP
		       <COND (<AND <PRSO? ,SALTS>
				   <VERB? GIVE>>
			      <PERFORM ,V?ALARM ,CROC ,SALTS>
			      <RTRUE>)
			     (T
			      <TELL "But" T ,CROC " is asleep." CR>)>)
		      (<AND <PRSO? ,SPICES ,PINCH>
			    <IN? ,PINCH ,PROTAGONIST>>
		       <MOVE ,PINCH ,SPICES>
		       <TELL
CTHE ,CROC " blinks its eyes once, but takes no other notice of" TR ,SPICES>)
		      (,CROC-FREE
		       <REMOVE ,PRSO>
		       <TELL
,CROC-LUNGES CTHE ,PRSO " drops ignored into" TR ,POOL>
		       <RTRUE>)
		      (,MUZZLED
		       <TELL CTHE ,CROC " is helpless! " ,MOTHER>)
		      (T
		       <REMOVE ,PRSO>
		       <SETG MOUTH-SHUT T>
		       <QUEUE I-CROC-OPENS-MOUTH 2>
		       <TELL CTHE ,CROC " snaps its jaws shut as" T ,PRSO>
		       <COND (<PRSO? ,SALTS ;,HOOPS ;,DAGGER>
			      <TELL " bounce">
			      ;<COND (<PRSO? ,DAGGER>
				     <TELL "s">)>
			      <TELL " off its hide, sinking into" TR ,POOL>)
			     (T
			      <TELL " disappear">
			      <COND (<NOT <PRSO? ,PANTS>>
				     <TELL "s">)>
			      <TELL " into"> 
			      <COND (<PRSO? ,PORK>
				     <COND (,PORK-DOPED
					    <QUEUE I-CROC-SLEEPS 3>)>
				     <TELL " its maw." CR>)
				    (T
				     <TELL TR ,POOL>)>)>)>)
	       (<VERB? LEAP>
		<TELL "You can't jump that far." CR>)
	       (<VERB? SGIVE STHROW THROW-AT>
		<PERFORM ,V?THROW-TO ,PRSI ,CROC>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<COND (,COOKIE-FIGHTING-CROC
		       <TELL CTHE ,POOL
" boils with the bodies of" T ,CROC " and" TR ,COOKIE>)
		      (,MUZZLED
		       <TELL CTHE ,CROC
"'s snout is pinned closed by" A ,GARTER>
		       <COND (,CROC-SLEEP
			      <TELL ,SNORTS-IN-SLEEP>)>
		       <TELL ,PCR>)
		      (,MOUTH-SHUT
		       <TELL
"Two gleaming teeth poke out of" T ,CROC "'s closed mouth">
		       <COND (,CROC-SLEEP
			      <TELL ,SNORTS-IN-SLEEP>)>
		       <TELL ,PCR>)
		      (T
		       <TELL
CTHE ,CROC " smiles at you invitingly, white
teeth shining in" T ,TORCH "light." CR>)>)
	       (<VERB? KILL MUNG KICK>
		<COND (,COOKIE-FIGHTING-CROC
		       <TELL D ,COOKIE " is seeing to" TR ,CROC>)
		      (,CROC-SLEEP
		       <TELL "Harm a sleeping animal! " ,MOTHER>)
		      (,MUZZLED
		       <TELL
"The tear welling up in" T ,CROC "'s eye is rather poignant.
You can't bear to hurt the beast in this state" ,PCR>)
		      (T
		       <TELL "You have no wish to get any closer to" TR ,CROC>
		       ;<TELL
"While the sight of " D ,CROC " teeth and " D ,CROC " tonsils at the back
of a " D ,CROC "'s open maw may not deter you, the thought of spending the
rest of your life in one-armed dresses does. You daren't go near the
open-mouthed reptile" ,PCR>)>)>> 

<ROUTINE I-CROC-OPENS-MOUTH ()
	 <COND (<AND <NOT ,MUZZLED>
		     <IN? ,CROC ,HERE>>
		<SETG MOUTH-SHUT <>>
		<TELL ,INDENT
"With an inaudible creak," T ,CROC "'s mouth opens again" ,PCR>)
	       (T
		<RFALSE>)>>

<OBJECT POOL
	(IN ANTEROOM)
	(DESC "pool")
	(SYNONYM POOL WATER)
	(ADJECTIVE BLACK)
	(FLAGS NDESCBIT)
	(ACTION POOL-F)>

<ROUTINE POOL-F ()
	 <COND (<VERB? ENTER CRAWL-UNDER SWIM>
		<TELL
"You splash around at the outskirts of" TR ,POOL>)
	       (<VERB? THROW THROW-TO THROW-AT>
		<COND (<AND <PRSO? ,PORK>
			    <NOT ,MOUTH-SHUT>
			    <NOT ,CROC-SLEEP>>
		       <TELL
"With a terrific splash," T ,CROC " throws itself after" T ,PRSO ". ">
		       <PERFORM ,V?THROW ,PORK ,CROC>
		       <RTRUE>)
		      (<PRSO? ,BOTTLE>
		       <PERFORM ,V?THROW ,BOTTLE ,CROC>
		       <RTRUE>)
		      (T
		       <REMOVE ,PRSO>
		       <TELL CTHE ,PRSO " splashes into" TR ,POOL>)>)
	       (<VERB? LOOK-INSIDE>
		<TELL "It's too murky to see anything" ,PCR>)
	       (<VERB? PUT>
		<REMOVE ,PRSO>
		<TELL CTHE ,PRSO " sinks from sight." CR>)
	       (<VERB? DRINK DRINK-FROM>
		<TELL "Yechh!" CR>)>>
	       
<ROOM DUNGEON 
      (IN ROOMS)
      (DESC "Dungeon")
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      (SYNONYM DUNGEON)
      (GLOBAL TORCH)
      (WEST PER DUNGEON-EXIT)
      (NORTH PER DUNGEON-EXIT)
      (ACTION DUNGEON-F)>

<ROUTINE DUNGEON-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You sense, rather than see, the rusty skeletons of old cages and torture
devices that line the walls of this cavernous room. One flaming torch,
high on a wall, casts mad licks of light into the darkness. Passages lead
north and west. Set deep in the rocky floor is a">
		<TELL-OPEN/CLOSED ,TRAP T>
		<TELL " " D ,TRAP ,PCR ,INDENT>
		;<COND (<FSET? ,DAD ,DEADBIT>
		       <TELL " with signs of a struggle around it">)>
		;<TELL ,PCR ,INDENT>
		<DESC-MANACLES>)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     ,ENDGAME
		     <IN? ,CRULLEY ,HERE>
		     <NOT <FSET? ,CRULLEY ,MUNGBIT>>>
		<COND (<OR <AND <EQUAL? ,HERO ,PRSO ,PRSI>
				<AFFIRMATIVE-ANSWER>>
			   <TOUCHING? ,HERO>
			   <TOUCHING? ,MANACLES>
			   ;<VERB? PUT>>
		       <TELL
D ,CRULLEY " growls, \"Keep away from 'im.\"" CR>)
		      (<AND <TOUCHING? ,TRAP>
			    <NOT <VERB? ENTER BOARD>>>
		                         ;<AND <VERB? CLOSE>
			                       <PRSO? ,TRAP>>
		       <TELL D ,CRULLEY " barks, \"Leave that alone.\"" CR>)
		      (T
		       <RFALSE>)>)
	       (<EQUAL? .RARG ,M-END>
		<COND (,CRULLEY-BACK
		       <TELL
,INDENT D ,CRULLEY " jumps out of the shadows at you.">
		       <JIGS-UP ,FALL-TO-BOTTOM>)
		      (T
		       <RFALSE>)>)>>

<ROUTINE DUNGEON-EXIT ()
	 <COND (<RUNNING? ,I-CDUNG>
		<DEQUEUE I-CDUNG>
		<FCLEAR ,CRULLEY ,EVERYBIT>
		<TELL
"\"Come back 'ere, wench!\"" T ,CRULLEY ,CALLS-AFTER>)>
	 <COND (<EQUAL? ,P-WALK-DIR ,P?WEST>
		<RETURN ,PASSAGE-4>)
	       (<EQUAL? ,P-WALK-DIR ,P?NORTH>
		<RETURN ,ANTEROOM>)>
	 ;<COND (<FSET? ,MANACLES ,MUNGBIT>
		 <TELL
"You are brought up short by" T ,MANACLES " locked on your wrists" ,PCR>
		 <RFALSE>)
		(T
		 <COND (<RUNNING? ,I-CDUNG>
			<DEQUEUE I-CDUNG>
			<TELL
"\"Come back 'ere, wench!\"" T ,CRULLEY ,CALLS-AFTER>)>
		 <COND (<EQUAL? ,P-WALK-DIR ,P?WEST>
			<RETURN ,PASSAGE-4>)
		       (<EQUAL? ,P-WALK-DIR ,P?NORTH>
			<RETURN ,ANTEROOM>)>)>>

<OBJECT MANACLES                 ;"MUNGBIT -- they're locked on you."
	(IN DUNGEON)
	(DESC "pair of manacles")
	(SYNONYM MANACLE CHAINS LOCK CHAIN)
	(ADJECTIVE IRON PAIR LOCKS FETTER)
	(FLAGS CONTBIT OPENBIT PLURALBIT TRANSBIT WEARBIT NDESCBIT SEARCHBIT)
	(ACTION MANACLES-F)>

<ROUTINE MANACLES-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<DESC-MANACLES>)
	       (<VERB? CLOSE>
		<COND (,PRSI
		       <PERFORM ,V?PUT-ON ,MANACLES ,PRSI>
		       <RTRUE>)
		      (T
		       <OPEN-CLOSE ,PRSO <> "They clamp shut">)>)
	       (<VERB? OPEN>
		<COND ;(<AND <EQUAL? ,P-PRSA-WORD ,W?PRY>
			    <NOT ,PRSI>>
		       <TELL ,YOULL-HAVE-TO "specify how" ,PCR>)
		      (<FSET? ,MANACLES ,OPENBIT>
		       <TELL "They are already open!" CR>)
		      (<PRSI? ,JEWEL>
		       <PROPOSE>)
		      (T
		       <TELL "It isn't that easy" ,PCR>)>)
	       (<AND <VERB? PICK UNLOCK>
		     <PRSI? ,JEWEL>>
		<TELL "You twist the pin of" T ,JEWEL " in the ">
		<COND ;(<FSET? ,MANACLES ,MUNGBIT>
		       <MOVE ,JEWEL ,HERE>
		       <QUEUE I-JIGS-UP-MANACLES 3>
		       <TELL
"As you scratch in one cuff with the pin of" T ,JEWEL ", it slips from
your fingers and skitters just out of reach" ,PCR>)
		       (<IN? ,HERO ,MANACLES>
			<MOVE ,HERO ,HERE>
			<SETG SCORE <+ ,SCORE 1>>
			<FSET ,MANACLES ,OPENBIT>
			<TELL "locks, quickly freeing Nicholas. ">
			<COND (<FSET? ,HERO ,DEADBIT>
			       <TELL "He falls in a faint at your feet" ,PCR>)
			      (T
			       <CRLF>
			       <NICK-RUNS-OFF>)>)
		       (T
			<FSET ,MANACLES ,OPENBIT>
			<FCLEAR ,MANACLES ,LOCKEDBIT>
			<TELL "manacles until they pop open" ,PCR>)>)
	       (<VERB? UNLOCK>
		<TELL "That key is much too large to fit in" TR ,MANACLES>
		;<COND (<PRSI? ,LARGE-KEY>
		       <TELL "large">)
		      ;(<PRSI? ,BENT-KEY>
		       <TELL "crooked">)>
		;<TELL " to fit in" TR ,MANACLES>)
	       (<VERB? REACH-IN WEAR>
		<PERFORM ,V?PUT-ON ,MANACLES ,ME>
		<RTRUE>)
	       (<VERB? PUT>
		<COND (<PRSO? ,ME>
		       <PERFORM ,V?PUT-ON ,MANACLES ,ME>
		       <RTRUE>)
		      (<PRSO? ;,BENT-KEY ,LARGE-KEY>
		       <PERFORM ,V?UNLOCK ,MANACLES>
		       <RTRUE>)
		      (T
		       <MOVE ,PRSO ,HERE>
		       <TELL CTHE ,PRSO " drops to the floor." CR>)>)
	       (<OR <VERB? PUT-ON WEAR>
		    <AND <VERB? TIE>
			 <EQUAL? ,P-PRSA-WORD ,W?FASTEN ,W?SECURE ,W?ATTACH>>>
		<COND (<PRSI? ,ME>
		       <TELL
"Mama would not have praised your intelligence" ,PCR>)
		      ;(<PRSI? ,ME>
		       <FCLEAR ,MANACLES ,OPENBIT>
		       <FSET ,MANACLES ,MUNGBIT>
		       <QUEUE I-JIGS-UP-MANACLES 10> 
		       <TELL
"You snap the cuffs onto your wrists.
Mama would not have praised your intelligence" ,PCR>)
		      (<PRSI? ,DAD>
		       <SETG AWAITING-REPLY 1>
		       <QUEUE I-REPLY 2>
		       <TELL
"He wanders off before you can get them on him. \"Oh dear, you have learned
atrocious manners these last few year in London!\"" CR>)
		      (<PRSI? ,HERO>
		       <TELL ,YOU-CANT "lift him high enough." CR>)
		      (T
		       <TELL ,YOU-CANT "put that in " D ,MANACLES "!" CR>)>)>>

;<ROUTINE I-JIGS-UP-MANACLES ()
	 <JIGS-UP
"When, some hours later, dragoons drag in the battered body of Jamison, you
are unable to help either him or yourself. Crulley quite enjoys the sight
of you pinned to the wall.">>

<ROUTINE DESC-MANACLES ()
	 <COND (<IN? ,HERO ,MANACLES>
		<TELL
"Nicholas is spread-eagled against
the wall, shackled in the " D ,MANACLES ".">)
	       (<IN? ,PROTAGONIST ,MANACLES>
		<TELL
"You lean against the wall, one arm
raised above " D ,HEAD ", cuffed in a manacle.">)
	       (T
		<TELL
"A " D ,MANACLES " hangs from iron chains attached high on the wall.">)>
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<CRLF>)
	       (T
		<RTRUE>)>> 

<ROUTINE GEN-WELL ()
	 <COND (<EQUAL? ,HERE ,DUNGEON>
		,TRAP)>>

<OBJECT TRAP
	(IN DUNGEON)
	(DESC "trapdoor")
	(SYNONYM DOOR WELL TRAPDO)
	(ADJECTIVE TRAP)
	(GENERIC GEN-WELL)
	(FLAGS DOORBIT NDESCBIT VEHBIT CONTBIT SEARCHBIT TRANSBIT)
	(ACTION TRAP-F)>

<ROUTINE TRAP-F ()
	 <COND (<OR <VERB? OPEN RAISE MOVE>
		    <VERB? CLOSE LOWER>>
		<OPEN-CLOSE ,TRAP
"The door creaks open to reveal a black well, water hushing deep within" <>>)
	       (<VERB? LOOK-UNDER LOOK-INSIDE> 
		<COND (<FSET? ,TRAP ,OPENBIT>
		       <COND (<IN? ,CRULLEY ,TRAP>
			      <TELL
D ,CRULLEY " is slowly climbing up the well." CR>)
			     (T
			      <TELL
"You smell salt water and mold, but you can see nothing" ,PCR>)>)
		      (T <TELL "It" ,IS-CLOSED ,PCR>)>)
	       (<VERB? ENTER BOARD STAND-ON>
		<COND (<FSET? ,TRAP ,OPENBIT>
		       <TELL
"You start to climb down the well,
but lose your footing on the slimy rock.">
		       <COND (<FSET? ,CRULLEY ,MUNGBIT>
			      <TELL
" At least you take" T ,CRULLEY " with you as you fall.">)>)
		      (T
		       <TELL
"As you stand on" T ,TRAP ", the rotted wood tears away.">)> 
		<JIGS-UP ,FALL-TO-BOTTOM>)
	       (<AND <VERB? PUT-ON>
		     <FSET? ,TRAP ,OPENBIT>>
		<PERFORM ,V?THROW ,PRSO ,TRAP>
		<RTRUE>)
	       (<VERB? THROW PUT PUT-THROUGH THROW-AT>
		<COND (<PRSO? ,RAPIER>
		       <TELL
D ,HERO " would not thank you for doing that." CR>)
		      (<PRSO? ,RETICULE>
		       <RFALSE>)
		      (<FSET? ,CRULLEY ,MUNGBIT>
		       <PERFORM ,V?THROW ,PRSO ,CRULLEY>
		       <RTRUE>)
		      (T
		       <REMOVE ,PRSO>
		       <TELL
"You drop" T ,PRSO " into the well.
Several seconds later you hear a tiny splash" ,PCR>)>)>>

<ROOM PASSAGE-4 
      (IN ROOMS)
      (DESC "Corner")
      (LDESC
"This short passage turns from east to north to
stop abruptly at an iron door.")
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      (NORTH TO CELL-4 IF IRON-CELL-DOOR IS OPEN)
      (EAST PER DUNGEON-ENTRANCE)
      (GLOBAL IRON-CELL-DOOR CELL-OBJ)
      ;(ACTION PASSAGE-4-F)>

<OBJECT IRON-CELL-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "iron door")
	(SYNONYM DOOR)
	(ADJECTIVE IRON CELL)
	(FLAGS NDESCBIT DOORBIT LOCKEDBIT)
	(ACTION DOOR-F)>

<ROOM CELL-4 
      (IN ROOMS)
      (DESC "Cell")
      (LDESC
"Hewn from dense rock, the cell is a stagnant burrow. Except for the tiniest
glow of light from the torch two rooms away, it is pitch black.")
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      (SOUTH TO PASSAGE-4 IF IRON-CELL-DOOR IS OPEN)
      (GLOBAL IRON-CELL-DOOR CELL-OBJ)
      (ACTION CELL-4-F)>

<ROUTINE CELL-4-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <NOT <FSET? ,DAD ,TOUCHBIT>>>
		<FSET ,DAD ,TOUCHBIT>
		<FCLEAR ,DAD ,NDESCBIT>
		<SETG SCORE <+ ,SCORE 1>>
		<COND (<EQUAL? ,DANCED-WITH ,LAFOND>
		       <QUEUE I-SUMMONS 15>)>
		<QUEUE I-DAD 2>
		<TELL ,INDENT
"As you enter, a tall bony man moves out of the darkness. \"Papa,\" you cry,
rushing into his arms.|
   \"Why, hullo, my dear.\" He hugs you tightly. \"Nick certainly took his
time about fetching you.">
		<COND (<OR ,BOY-DRESS?
			   <NOT <FSET? ,CHEMISE ,EVERYBIT>>>
		       <TELL
"\" He squints in horror at your clothes.
\"I have always found the London fashions quite abominable.">
		       <COND (<NOT <FSET? ,CHEMISE ,EVERYBIT>>
			      <SETG AWAITING-REPLY 2>
			      <QUEUE I-REPLY 2>
			      <TELL " Aren't you a trifle cold?">)>)>
		<TELL "\"" CR>) 
	       (.RARG
		<RFALSE>)>>

<OBJECT CELL-OBJ
	(IN LOCAL-GLOBALS)
	(DESC "cell")
	(SYNONYM CELL)
	(ACTION CELL-OBJ-F)>

<ROUTINE CELL-OBJ-F ()
	 <COND (<VERB? ENTER BOARD>
		<COND (<EQUAL? ,HERE ,CELL-1 ,CELL-2 ,CELL-4>
		       <TELL ,LOOK-AROUND>)
		      (<EQUAL? ,HERE ,PASSAGE-1 ,PASSAGE-2>
		       <DO-WALK ,P?EAST>)
		      (<EQUAL? ,HERE ,PASSAGE-4>
		       <DO-WALK ,P?NORTH>)>)
	       (<VERB? LOOK EXAMINE>
		<COND (<EQUAL? ,HERE ,CELL-1 ,CELL-2 ,CELL-4>
		       <V-LOOK>)
		      (T
		       <TELL "You would do better to enter it" ,PCR>)>)>> 
