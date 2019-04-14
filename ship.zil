"SHIP for
		        PLUNDERED HEARTS
        (c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<OBJECT SHIP
	(IN GLOBAL-OBJECTS)
	(DESC "Helena Louise")
	(SYNONYM BOAT SHIP LOUISE)
	(ADJECTIVE HELENA PIRATE)
	(GENERIC GEN-BOAT)
	(ACTION SHIP-F)>

<ROUTINE SHIP-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<SHIP-BOARD ,HERE>
		       ;<OR <SHIP-BOARD ,HERE>
			   ;<EQUAL? ,HERE ,CABIN ,DEUX-DECK>>
		       <V-LOOK>)
		      (<EQUAL? ,HERE ,CABIN ,DEUX-DECK>
			<COND (<OR <ADJ-USED ,A?HELENA>
				   <NOUN-USED ,W?LOUISE ,SHIP>>
			       <PERFORM ,V?LOOK-INSIDE ,WINDOW>
			       <RTRUE>)
			      (T
			       <V-LOOK>)>)
		      (<OR <EQUAL? ,HERE ,CELL-1 ,CELL-2>
			   <EQUAL? ,HERE ,LAFS-ROOM ,BEACH ,LAGOON ,SHALLOWS>>
		       <COND (<FSET? ,SHIP ,MUNGBIT>
			      <TELL ,YOU-CANT
"see" T ,SHIP " anywhere, but a lot of debris floats in the lagoon" ,PCR>)
			     (T
			      <TELL
CTHE ,SHIP " floats, silent
and serene, some distance out in the lagoon" ,PCR>)>)
		      (T
		       <TELL ,YOU-CANT "see" T ,SHIP " from here." CR>)>)
	       (<VERB? POINT>
		<COND (<NOT ,PRSI>
		       <PROPOSE>)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? PUT>
		     <PRSO? ,TRAY ,MIRROR>>
		<IMPOSSIBLES>)>>

<ROUTINE GEN-BOAT ()
	 <COND (<GLOBAL-IN? ,OBJ-QUARTERS ,HERE>
		<RETURN ,OBJ-QUARTERS>)
	       (<EQUAL? <LOC ,SKIFF> ,HERE>
		<RETURN ,SKIFF>)
	       (T
		<RETURN ,SHIP>)>>

<OBJECT DEBRIS
	(IN LOCAL-GLOBALS)
	(DESC "debris")
	(DESCFCN DEBRIS-F)
	(SYNONYM DEBRIS WOOD REMAINS SAIL)
	(ADJECTIVE PLANK HUMAN CANVAS FLESH)
	(FLAGS PLURALBIT NARTICLEBIT TRYTAKEBIT)
	(ACTION DEBRIS-F)>

<ROUTINE DEBRIS-F ()
	 <COND ;(.OARG
		<COND (<EQUAL? .OARG ,M-DESC?>
		       <RTRUE>)>
		<TELL ,INDENT <PICK-ONE ,DEBRIS-BITS>>
		<COND (<EQUAL? ,HERE ,BEACH ,SHALLOWS>
		       <TELL "bobs in the waves briefly.">)
		      (T
		       <TELL "floats by you.">)>)
	       (<NOT <FSET? ,SHIP ,MUNGBIT>>
		<TELL ,YOU-CANT-SEE-ANY D ,DEBRIS " here!" CR>)
	       (<VERB? EXAMINE SEARCH LOOK-INSIDE>
		<TELL ,INDENT <PICK-ONE ,DEBRIS-BITS>>
		<COND (<EQUAL? ,HERE ,BEACH ,SHALLOWS>
		       <TELL "bobs briefly in the waves.">)
		      (T
		       <TELL "floats by you.">)>
		<CRLF>
		;<TELL
"Large planks of wood, cloth, and human remains appear to
be all that is left of" TR ,SHIP>)
	       (<VERB? TAKE>
		<TELL
"You reconsider, thinking of" T ,SHIP " as it was, whole and proud." CR>)>>

<GLOBAL DEBRIS-BITS
	<LTABLE
	 0
	 "A plank of wood "
	 "Some bloodied flesh "
	 "A bit of canvas sail ">>

<ROUTINE SHIP-BOARD (RM)
	 <COND ;(<NOT <FSET? .RM ,LIGHTBIT>> <RTRUE>)
	       (<OR <EQUAL? .RM ,CAPT-QUARTERS ,LANDING ,SLEEPING-CUPBOARD>
		    <EQUAL? .RM ,AFT-HOLD ,HOLD ,CREWS-QUARTERS>
		    <EQUAL? .RM ,POOP ,QUARTERDECK ,MAIN-DECK>
		    <EQUAL? .RM ,FOCSLE ,GALLEY ,BOWSPRIT ,CROWS-NEST>
		    <EQUAL? .RM ,BY-SHIP ,ON-LADDER ,RIGGING-ROOM>>
		<RTRUE>)
	       (T <RFALSE>)>>  

<ROUTINE INNER-DECK (RM)          ;"All inner rooms of the ship"
	 <COND (<OR <EQUAL? .RM ,SLEEPING-CUPBOARD ,LANDING ,AFT-HOLD>
		    <EQUAL? .RM ,HOLD ,CREWS-QUARTERS ,GALLEY>>
		<RTRUE>)
	       (T <RFALSE>)>>
 
<ROOM CABIN
      (IN ROOMS)
      (DESC "Cabin")
      (LDESC
"You are in an officer's cabin, lit by the firelight glowing
through a porthole. A door is to starboard. Except for the built-in bed,
the room seems to have been emptied thoroughly, if hurriedly.")
      (EAST PER CABIN-EXIT)
      (OUT PER CABIN-EXIT)
      ;(SYNONYM LAFOND DEUX)
      (GLOBAL WINDOW DOOR OBJ-QUARTERS)
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)>

<OBJECT CABIN-BED
	(IN CABIN)
	(DESC "bed")
	(SYNONYM BED)
	(FLAGS VEHBIT NDESCBIT CONTBIT SEARCHBIT SURFACEBIT OPENBIT)
	(CAPACITY 100)
	(ACTION BED-F)>

<ROUTINE CABIN-EXIT ()
	 <COND (<IN? ,HERO ,HERE>
		<COND (<G? ,HERO-CTR 3>
		       <DEQUEUE I-MEET-HERO>
		       <DEQUEUE I-PIRATE-ATTACK>
		       <TELL
,CTHE-PIRATE-CAPTAIN "follows you through" TR ,DOOR CR>
		       <RETURN ,DEUX-DECK>)
		      (T
		       <TELL ,SINEWY-ARM CR>
		       <RFALSE>)>)
	       (<IN? ,HERO ,DEUX-DECK>
		<RETURN ,DEUX-DECK>)
	       (<IN? ,CRULLEY ,HERE>
		<TELL
"\"Not that way, me pretty,\" says" T ,CRULLEY ", blocking your way" ,PCR>
		;<COND (<NOT <FSET? ,CRULLEY ,DEADBIT>>
		       <TELL
"\"Not that way, me pretty,\" says" T ,CRULLEY>)
		      (T
		       <TELL
"You hesitate to step over the body">)>
		;<TELL " blocking your way" ,PCR>
		<RFALSE>)
	       (T
		<TELL CTHE ,DOOR ,IS-CLOSED ,PCR>
		<THIS-IS-IT ,DOOR>
		<RFALSE>)>>

<ROOM DEUX-DECK
      (IN ROOMS)
      (DESC "Deck")
      (IN "\"It's not safe down there,\" the Falcon calls.")
      (DOWN "\"It's not safe down there,\" the Falcon calls.")
      (NORTH "The Falcon follows a step behind.")
      (SOUTH "The Falcon follows a step behind.")
      (EAST "The Falcon follows a step behind.")
      (WEST "\"It's not safe down there,\" the Falcon calls.")
      (GLOBAL OBJ-QUARTERS CREW FIRE)
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (ACTION DEUX-DECK-F)>

<ROUTINE DEUX-DECK-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<MOVE ,HERO ,HERE>
		<TELL
"The deck is an avalanche of noise and blood. Lit by roaring fires,
silhouetted forms crash swords, dancing around the screaming wounded."
;"A flood of freed slaves is sweeping up from the hold, yelling in
savage tongues as their black bodies join the skirmish.">)
	       ;(<AND <EQUAL? .RARG ,M-BEG>
		     <VERB? EXAMINE>
		     <PRSO? ,SHIP>>
		<PERFORM ,V?LOOK>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-ENTER>
		<QUEUE I-END-PROLOGUE 1>)
	       (T <RFALSE>)>>

<OBJECT COFFER
	(IN CABIN)
	(DESC "coffer")
	(SYNONYM COFFER CHEST LOCK BOX)
	(ADJECTIVE SMALL METAL HEAVY)
	(CAPACITY 15)
	(SIZE 10)
	(FLAGS NDESCBIT CONTBIT SEARCHBIT LOCKEDBIT)
	(ACTION COFFER-F)>

<ROUTINE COFFER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "It is a small heavy chest, with a ">
		<COND (<FSET? ,COFFER ,MUNGBIT>
		       <TELL "smashed ">)>
		<TELL "lock. It is">
		<TELL-OPEN/CLOSED ,PRSO>
		<TELL ".|">)
	       (<VERB? TAKE>
		<COND (<PRSO? ,COFFER>
		       <COND (<NOT <FSET? ,COFFER ,NDESCBIT>>
			      <FSET ,COFFER ,TAKEBIT>
			      <DEQUEUE I-COFFER>
			      <MOVE ,COFFER ,PROTAGONIST>
			      <FCLEAR ,COFFER ,NDESCBIT>
			      <TELL "Taken." CR>)
			     (T
			      <TELL ,HUH>)>)
		      (T
		       <RFALSE>)>)
	       ;(<VERB? TAKE>
		<COND (<AND <NOT <FSET? ,COFFER ,NDESCBIT>>
			    <PRSO? ,COFFER>>
		       ;<FCLEAR ,COFFER ,TRYTAKEBIT>
		       <FSET ,COFFER ,TAKEBIT>
		       <DEQUEUE I-COFFER>
		       <MOVE ,COFFER ,PROTAGONIST>
		       <FCLEAR ,COFFER ,NDESCBIT>
		       <TELL "Taken." CR>)
		      (T
		       <TELL ,HUH>)>)
	       (<AND <VERB? MUNG>
		     <PRSO? ,WINDOW>>
		<PERFORM ,V?PUT-THROUGH ,COFFER ,WINDOW>
		<RTRUE>)
	       (<VERB? BOARD STAND-ON>
		<TELL CTHE ,COFFER " is too small to stand on." CR>)
	       (<AND <VERB? SHAKE>
		     <FSET? ,COFFER ,LOCKEDBIT>>
		<TELL "It seems to be full of small, heavy objects" ,PCR>)
	      ;(<VERB? LOOK-INSIDE SEARCH>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <PERFORM ,V?SEARCH ,DOCUMENTS>
		       <RTRUE>)>)>>

<OBJECT LETTER
	(DESC "missive" ;"letter")
	(SYNONYM PAPER LETTER MISSIVE)
	(FLAGS TAKEBIT)
	(ACTION LETTER-F)>

<ROUTINE LETTER-F ()
	 <COND (<VERB? READ EXAMINE>
		<TELL CTHE ,LETTER
" is in dear Papa's handwriting:|
|
\"Dearest child,|
   You are in gravest danger! Lafond is a viper with the smile of a
saint, my most particular enemy. I have only now learned the depth of
his deception. Should Lafond get you in his power... It is unspeakable!|
   I have sided with Nicholas Jamison, a sea captain and a gentleman,
whose circumstances have driven him to extreme measures, even branding
him a pirate. Nevertheless, I trust him and so may you.|
   You will be safe -- but there is another for whom I fear! My horse is
waiting and I ride to her rescue. Jamison will deliver this to you.
Should anything happen to me, you must rely on him. I remain,
with love," T ,DAD ".\"" CR CR>
		;<TELL
"The letter is in dear Papa's handwriting, addressed to " D ,ME ":|
|
   \"I have just learned that Lafond has sent for you, telling
you that I am ill. I am not, and you are sailing into great danger.
Despite his claim to be my 'good friend,' Lafond is no friend of
mine! He is a tyrant and a viper, running a vast fleet of
pirate ships.|
   I, with a young captain named Jamison, am outlawed for pirating the
demon's ships -- which is the only way to bleed his thieving organization
and return stolen goods to their rightful owners. Now he has you --
oh, my child, what have I done? He will hold you ransom for our lives!|
   My horse is waiting. I ride now to Lafond's mansion to demand he
free you. I give this missive to my ally.\"" CR CR>)>>

<OBJECT INVITE
	(IN COFFER)
	(DESC "invitation")
	(SYNONYM INVITE CARD INVITATION)
	(ADJECTIVE LARGE WHITE)
	(FLAGS TAKEBIT VOWELBIT)
	(ACTION INVITE-F)>

 ;["Similar to the card taken by" T ,HERO ","]
;<COND (<NOT <FSET? ,INVITE ,EVERYBIT>>
		       <FSET ,INVITE ,EVERYBIT>
		       <TELL ,INDENT
"Davis must have carried two, for some reason." CR>)
		      (T
		       <RTRUE>)>

<ROUTINE INVITE-F ()
	 <COND (<VERB? READ EXAMINE>
		<TELL
CTHE ,INVITE " is addressed to \"Davis\":||
       In Honor of Jean Lafond,|
         recently proclaimed|
       Governor of " D ,ISLAND "|
        A Dance at his Mansion|
      Ananas Road, " D ,ISLAND "|
Formal Dress and Invitation Required" ,PCR CR>
		<COND (<NOT <FSET? ,INVITE ,MUNGBIT>>
		       <FSET ,INVITE ,MUNGBIT>
		       <TELL
,INDENT "A ball! You haven't been to a ball in months!" CR>)
		      (T
		       <RFALSE>)>)
		;(<AND <VERB? SHOW GIVE>
		     <PRSI? ,BUTLER>>
		<I-BUTLER T>)
	       (<AND <VERB? SSHOW SGIVE>
		     <PRSO? ,BUTLER>>
		<PERFORM ,V?GIVE ,INVITE ,BUTLER>
		<RTRUE>)>>

<ROUTINE I-COFFER ()
	 <COND (<NOT <HELD? ,COFFER>>
		<FCLEAR ,COFFER ,NDESCBIT>
		<FSET ,COFFER ,TAKEBIT>
		<THIS-IS-IT ,COFFER>
		;<FCLEAR ,COFFER ,TRYTAKEBIT>
		<TELL ,INDENT 
"Suddenly, the ship lurches to one side, throwing you ">
		<COND (<EQUAL? <LOC ,PROTAGONIST> ,CABIN-BED>
		       <MOVE ,PROTAGONIST ,HERE>
		       <TELL "out of the bed. ">)
		      (T
		       <TELL "off balance. ">)>
		<COND (<FSET? ,COFFER ,TOUCHBIT>
		       <TELL CTHE ,COFFER>)
		      (T <TELL
"A " D ,COFFER " slides from under the bed and">)>
		<TELL " bumps against your foot." CR>)
	       (T
		<RFALSE>)>>


<ROOM CAPT-QUARTERS
      (IN ROOMS)                            ;"MUNGBIT = typed first look text"
      (DESC "Captain's Quarters")
      (UP PER CLIMBING)
      ;(DOWN PER CLIMBING)
      (NORTH PER CURTAIN-EXIT)
      (SOUTH PER WINDOW-EXIT)
      (GLOBAL CURTAIN WINDOW DESK DOOR SEA LADDER OBJ-QUARTERS)
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      (ACTION CAPT-QUARTERS-F)>

<ROUTINE CAPT-QUARTERS-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<COND (<IN? ,LEDGE ,ON-LADDER>
		       <MOVE ,LEDGE ,CAPT-QUARTERS>)
		      (<NOT <FSET? ,CAPT-QUARTERS ,TOUCHBIT>>
		       <MOVE ,PROTAGONIST ,CAPT-BED>
		       <SETG HERO-CTR 0>
		       <QUEUE I-HSHIP 2>
		       <TELL
"TWO DAYS LATER" ,ELLIPSIS>
		       <TELL ,INDENT
"You blear awake from a bored nap, focusing on something shiny. You
discern it to be" A ,HRING ", on a strong hand in the act of tying a ribbon
onto" AR ,RAPIER ,INDENT
   "The man with" T ,RAPIER " and the ring turns, \"Sorry, I tried not to
wake you.\" You sit up as if the bed had caught fire, for this is the
Falcon, changed from his rags to a finery all red velvet and white lace -- and
in your presence!" CR CR>)
		      (T
		       <RFALSE>)>)
	       (<EQUAL? .RARG ,M-LOOK>
		<COND (<NOT <FSET? ,HERE ,MUNGBIT>>
		       <FSET ,HERE ,MUNGBIT>
		       <TELL
"You are in the captain's " D ,OBJ-QUARTERS " of the " D ,SHIP ", where
you have been trapped these past days since your \"rescue\" from the
Lafond Deux. ">)>
		<TELL 
"The room has a masculine air, with ebony panelling, a large messy table,
and a rumpled bed">
		<COND (<EQUAL? <LOC ,PROTAGONIST> ,CAPT-BED>
		       <TELL " (upon which you lie)">)>
		<TELL ". A curtain masks the forward exit and ">
		<COND (<FSET? ,LEDGE ,MUNGBIT>
		       <TELL "air breezes in over the ledge">)
		      (T
		       <TELL 
"gilded woodwork decorates the sill of the tall window looking">)>
		<TELL " aft.">
		;<COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		       <TELL CR ,INDENT CTHE ,COFFER " from the other ship
sits on the table, smashed open and emptied of its valuable contents.
The pirates had, with much argument, divvied up the jewels found
inside just this afternoon.">)
		      (T
		       <RTRUE>)> 
		;<I-LOOK-SEA <>>)>>

<GLOBAL LADDER-HANGING <>>    ;"Is the ladder swinging from Poop?"

<ROUTINE I-HERO-TO-ISLAND ()
	 <COND (<EQUAL? ,HERE ,CAPT-QUARTERS>
	        <TELL ,INDENT
"Men clomp about overhead and a rope ladder unfurls itself past the window.
Jamison climbs down it, entering" T ,SKIFF " that awaits him below.
He rows to the island as the men above " D ,HEAD " disperse, calling
farewells to their captain" ,PCR>)>
	 <SETG SKIFF-LOC 1>
	 <SETG SKIFF-TIED <>>
	 <REMOVE ,HERO>
	 ;<MOVE ,LADDER ,CAPT-QUARTERS>
	 <SETG LADDER-HANGING T>
	 <QUEUE I-SEE-LADDER -1>>
	 
<ROUTINE I-SEE-LADDER ()
	 <COND (<EQUAL? ,HERE ,CAPT-QUARTERS>
	        <QUEUE I-SEE-LADDER -1>
		<COND (<PROB 40>
		       <TELL ,INDENT "The end of a rope ladder blows ">
		       <COND (<EQUAL? <LOC ,PROTAGONIST>
				      ,CAPT-BED ,CAPT-QUARTERS>
			      <TELL "past the window.">)
			     (T                         ;"(Not on the LEDGE)"
			      <TELL "by.">)>
		       <CRLF>)>)
	       (T 
		<DEQUEUE I-SEE-LADDER>)>>

<OBJECT DESK
	(IN LOCAL-GLOBALS)
	(DESC "desk")
	(SYNONYM DESK TABLE)
	(ADJECTIVE MESSY)
	(FLAGS NDESCBIT SURFACEBIT CONTBIT)
	(ACTION PAPERS-F)>

<ROUTINE PAPERS-F ()
	 <UNIMPORTANT-THING>>

<ROOM ON-LADDER 
	(IN ROOMS)
	(DESC "On the Ladder")
	(IN PER LADDER-EXIT)
	(NORTH PER LADDER-EXIT)
	;(UP PER CLIMBING-LADDER)
	(UP PER CLIMBING)
	;(DOWN PER CLIMBING-LADDER)
	(DOWN PER CLIMBING)
	(GLOBAL LADDER SEA OBJ-QUARTERS PSEUD-SKIFF)
	(FLAGS ONBIT NARTICLEBIT)
	(ACTION ON-LADDER-F)>

<ROUTINE ON-LADDER-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<MOVE ,LEDGE ,HERE>
		<DEQUEUE I-SEE-LADDER>) 
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <OR <VERB? LEAP LEAP-OFF>
			 <AND <VERB? DROP>
			      <PRSO? ,LADDER>>>>
		<DO-WALK ,P?DOWN>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are clinging to a slimy ladder,
tied to a rail of the poop deck above you. Not far from your feet,">
		<COND (,SKIFF-TIED
		       <TELL A ,SKIFF " bobs in the water">)
		      (T
		       <TELL " waves kiss the stern of the ship">)>
		<COND (<NOT <FSET? ,ON-LADDER ,TOUCHBIT>>
		       <TELL
". The ladder twists under your weight">)>
		<TELL ".">)>>

<OBJECT OBJ-QUARTERS
	(IN LOCAL-GLOBALS)
	(DESC "quarters")
	(SYNONYM QUARTE SHIP CABIN)
	(ADJECTIVE CAPTAIN)
	(GENERIC GEN-BOAT)
	;(FLAGS NDESCBIT)
	(ACTION OBJ-QUARTERS-F)>

<ROUTINE OBJ-QUARTERS-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<AND <NOUN-USED ,W?QUARTE ,OBJ-QUARTERS>
			    <EQUAL? ,HERE ,POOP ,LANDING>>
		       <TELL "Why don't you go there and look?" CR>)
		      (T
		       	<V-LOOK>)>)
		(<VERB? BOARD CLIMB ENTER>
		 <COND (<EQUAL? ,HERE ,DEUX-DECK ,ON-LADDER>
			<DO-WALK ,P?IN>)
		       (T
			<RFALSE>)>)>>

<GLOBAL BLOWING-LADDER-C 0>
<GLOBAL UP-CTR 0>
<GLOBAL SKIFF-TIED T>

;<ROUTINE ;CLIMBING-LADDER ()                   ;"This is an EXIT-FCN"
	 <COND (<EQUAL? ,P-WALK-DIR ,P?UP>
		<COND (<FSET? ,HOOPS ,WORNBIT>
		       <TELL ,YOU-CANT
"get a foothold because the hoops of
your dress keep pushing away" TR ,LADDER>
		       <RFALSE>)
		      (<AND <FSET? ,DRESS ,WORNBIT>
			    <NOT <FSET? ,HOOPS ,WORNBIT>>>
		       <TELL
"Every attempt you make to climb the ladder, you
end up tripping on your " D ,DRESS ,PCR>
		       <RFALSE>)
		      (<NOT ,LADDER-HANGING>
		       <TELL "There's no way to go up!" CR>
		       <RFALSE>)
		      (<NOT <FSET? ,POOP ,TOUCHBIT>>
		       <SETG UP-CTR <+ ,UP-CTR 1>>
		       <COND (<NOT <EQUAL? ,UP-CTR 5>>
			      <TELL "You climb up" T ,LADDER>
			      <COND (<EQUAL? ,UP-CTR 3>
				     <TELL ", passing the halfway point">)>
			      <TELL ,PCR>
			      <RFALSE>)
			     (T
			      <TELL ,INDENT
"You heave " D ,ME " over the stern rail
and sink breathlessly to the deck of" TR ,SHIP CR>
			      <DEQUEUE I-LADDER-BLOWS>
			      <RETURN ,POOP>)>)
		      (<EQUAL? ,HERE ,BY-SHIP>
		       <DEBARK-SKIFF>
		       <RFALSE>)
		      (T
		       <TELL
"This time, you find the climb to the deck quite easy" ,PCR CR>
		       <RETURN ,POOP>)>)
	       (<EQUAL? ,P-WALK-DIR ,P?DOWN>
		<COND (<EQUAL? ,HERE ,POOP>
		       <TELL
"You scamper down the ladder until you are opposite the ledge" ,PCR CR>
		       <RETURN ,ON-LADDER>)
		      (,SKIFF-TIED
		       <SETG SKIFF-TIED <>>
		       <TELL
"Freeing your feet from the rungs, you slide down
the wet rope to the skiff, and quickly untie it from the ship" ,PCR CR>
		       <RETURN ,BY-SHIP>)
		      (T
		       <TELL
"Letting loose your grip on your sanity as well
as on the rope ladder, you plummet into the sea. ">
		       <COND (,BOY-DRESS?
			      <JIGS-UP
"Flailing about in the water just tires you.">)
			     (T
			      <JIGS-UP
"Your skirts, until sodden, hold you above water.
Then they carry you down into the depths.">)>)>)>>

<ROUTINE I-LADDER-BLOWS ()
	 <SETG BLOWING-LADDER-C <+ ,BLOWING-LADDER-C 1>>
	 <COND (<L? ,BLOWING-LADDER-C 2>
		<RTRUE>)>
	 <TELL ,INDENT>           ;"here to avoid indent in SUPERBRIEF on 2"
	 <COND (<EQUAL? ,BLOWING-LADDER-C 2 5>
		<TELL
"All air is driven out of you as" T ,LADDER " slams into the stern." CR>)
	       (<EQUAL? ,BLOWING-LADDER-C 3 6>
		<TELL
"Rebounding," T ,LADDER " twists you around to face" TR ,SHIP>)
	       (<EQUAL? ,BLOWING-LADDER-C 4>
		<TELL "The ladder swings back towards" TR ,SHIP>)
	       (<EQUAL? ,BLOWING-LADDER-C 7>           ;"used to be 9"
	        <JIGS-UP
"Your battered hands can take no more. Your grip loosens
and the sea comes up to break your fall.">)>>

              ;(<EQUAL? ,BLOWING-LADDER-C 2 8>
		<TELL "You bang against the stern and bounce away again.">)
	      ;(<EQUAL? ,BLOWING-LADDER-C 4 8>
		<TELL
CTHE ,LADDER " swings out to one side,
granting you a brief glimpse of the island">)
              ;(<EQUAL? ,BLOWING-LADDER-C 5>
		<TELL CTHE ,LADDER " bounces out and away from ship again">)
              ;(<EQUAL? ,BLOWING-LADDER-C 5 10>
		<TELL
"You slide back behind the ship, scraping the backs of
" D ,HANDS "s against it as they grip the ladder">)

<ROUTINE LADDER-EXIT ("OPTIONAL" (CRUFTY-KLUDGE <>))
	 <DEQUEUE I-LADDER-BLOWS>
	 <TELL
"You pull " D ,ME " over" T ,LEDGE ", tumbling head over heels
into Jamison's " D ,OBJ-QUARTERS ,PCR CR>
	 <COND (.CRUFTY-KLUDGE
		<GOTO ,CAPT-QUARTERS>)
	       (T
		<RETURN ,CAPT-QUARTERS>)>>

<ROUTINE CURTAIN-EXIT ()          
	 <COND (<IN? ,HERO ,HERE>
		<TELL ,SINEWY-ARM CR>
		<RFALSE>)
	       (<EQUAL? <LOC ,PROTAGONIST> ,LEDGE>
		<RETURN ,CAPT-QUARTERS>)
	       (T
	        <COND (<NOT <FSET? ,LANDING ,TOUCHBIT>>
		       <TELL
CTHE ,CUPBOARD-OBJECT ,ISNT-FLUSH>)>
		<TELL "You">
		;<COND (<FSET? ,HOOPS ,WORNBIT>
		       <TELL
"Flattening" T ,HOOPS " from chin to heel, you manage to">)
		      (T
		       <TELL "You">)>
		<TELL ,SQUEEZE-THRU ,PCR CR>
		<COND (<EQUAL? ,P-WALK-DIR ,P?SOUTH>
		       <COND (,LADDER-HANGING
			      <QUEUE I-SEE-LADDER -1>)>
		       <FSET ,PILE-OF-CLOTHES ,NDESCBIT>
		       <MOVE ,CUPBOARD-OBJECT ,CAPT-QUARTERS>
		       <RETURN ,CAPT-QUARTERS>)
		      (T
		       <FCLEAR ,PILE-OF-CLOTHES ,NDESCBIT>
		       <MOVE ,CUPBOARD-OBJECT ,LANDING>
		       <DEQUEUE I-SEE-LADDER>
		       <RETURN ,LANDING>)>)>>


<ROUTINE WINDOW-EXIT ()
	 <PERFORM ,V?BOARD ,LEDGE>
	 <RFALSE>
	 ;<COND (<NOT <FSET? ,LEDGE ,MUNGBIT>>
		<TELL CTHE ,WINDOW " blocks your way." CR>
		<RFALSE>)
	       (T 
		<PERFORM ,V?BOARD ,LEDGE>
		<RFALSE>)>>

<OBJECT LEDGE
	(IN CAPT-QUARTERS)
	(DESC "ledge")
	(SYNONYM LEDGE SILL)
	(FLAGS NDESCBIT VEHBIT CONTBIT TRANSBIT SEARCHBIT OPENBIT)
	(ACTION LEDGE-F)>

<ROUTINE LEDGE-F ("OPTIONAL" (VARG <>))      
	  <COND (<EQUAL? .VARG ,M-BEG>
		 <COND (<AND <VERB? DISEMBARK CLIMB-DOWN TAKE-OFF>
			     <NOT <PRSO? ,LADDER ,DRESS ;,HOOPS>>>
		        <MOVE ,PROTAGONIST ,HERE>
		        <FSET ,LADDER ,TRYTAKEBIT>
		        <TELL "You clamber off the sill to safety." CR>)
		       (<OR <VERB? LEAP LEAP-OFF>
			    <AND <VERB? ENTER>
				 <PRSO? ,SEA>>>
			<TELL ,SUICIDE>)
		       (<VERB? WALK>
			<COND (<EQUAL? ,P-WALK-DIR ,P?NORTH>
			       <PERFORM ,V?DISEMBARK ,LEDGE>
			       <RTRUE>)
			      (<NOT <EQUAL? ,P-WALK-DIR ,P?UP>>
			       <DO-FIRST "get off" ,LEDGE>)
			      (T
			       <RFALSE>)>)
		       (T
			<RFALSE>)>)
		(.VARG
		 <RFALSE>)
		(<VERB? EXAMINE>
		 <COND (<FSET? ,LEDGE ,MUNGBIT>
		        <TELL "Glass shards decorate" TR ,LEDGE>)
		       (T
			<TELL
"Tall panes of glass are inset into" TR ,LEDGE>)>)
		(<AND <VERB? MUNG>
		      <NOT ,PRSI>>
		 <PROPOSE>)
		(<VERB? LEAP-OFF>
		 <COND (<FSET? ,LEDGE ,MUNGBIT>
		        <DO-FIRST "climb onto" ,LEDGE>)
		       (T
			<TELL ,SUICIDE>)>)
		(<VERB? BOARD CLIMB-ON DISEMBARK STAND-ON ENTER>
		 <COND (<EQUAL? ,HERE ,CAPT-QUARTERS>
			<COND (<NOT <FSET? ,LEDGE ,MUNGBIT>>
			       <TELL
"The available ledge on this side of the window is
hardly deep enough to sit on" ,PCR>)
			      ;(<FSET? ,HOOPS ,WORNBIT>
			      <TELL "Your hoops will not fit over" TR ,LEDGE>)
			      (T
			       <TELL "You climb onto the ledge. ">
			       ;<COND (<ANYTHING-HELD>
				      <ROB ,PROTAGONIST ,CAPT-BED>
				     <TELL "lay everything on the bed and ">)>
			       ;<TELL "climb onto the ledge. ">
			       <COND (<NOT <FSET? ,POOP ,TOUCHBIT>>
				      <FSET ,LADDER ,TAKEBIT>)>
			       <COND (,LADDER-HANGING
				      <QUEUE I-SEE-LADDER 2>
				 <TELL CTHE ,LADDER " drifts within reach.">)>
			       <CRLF>
			       <MOVE ,PROTAGONIST ,LEDGE>)>)
		       (<EQUAL? ,HERE ,ON-LADDER>
			<LADDER-EXIT T>
			<RTRUE>)>)>>

<ROUTINE GEN-BED ()
	 <RETURN ,CAPT-BED>>

<OBJECT CAPT-BED
	(IN CAPT-QUARTERS)
	(DESC "bed")
	(SYNONYM BED)
	(FLAGS VEHBIT NDESCBIT CONTBIT SEARCHBIT SURFACEBIT OPENBIT)
	(GENERIC GEN-BED)
	(CAPACITY 100)
	(ACTION BED-F)>

<ROOM LANDING
      (IN ROOMS)
      (DESC "Landing")
      (UP "The door at the top of the stairs won't open.")
      (OUT "The door at the top of the stairs won't open.")
      (IN PER CUPBOARD-EXIT)
      (SOUTH PER CURTAIN-EXIT)
      (DOWN TO AFT-HOLD)
      (GLOBAL DOOR CURTAIN STAIRS CUPBOARD-OBJECT)
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      (ACTION LANDING-F)>

<ROUTINE LANDING-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are on the landing of a steep stairway
heading up and down. A " D ,CUPBOARD-OBJECT " against the aft wall
blocks the doorway to the captain's " D ,OBJ-QUARTERS ".">)
	       ;(<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? TAKE WEAR>
			    <PRSO? ,SHIRT ,PANTS>
			    <NOT <FSET? ,PRSO ,TOUCHBIT>>>
		       <CANT-REACH ,PILE>)
		      (T
		       <RFALSE>)>)>>

<ROOM SLEEPING-CUPBOARD
      (IN ROOMS)
      (DESC "Sleeping Cupboard")
      (OUT PER CUPBOARD-EXIT)
      (NORTH PER CUPBOARD-EXIT)
      (FLAGS ONBIT RLANDBIT INDOORSBIT)
      (GLOBAL DOOR)
      (ACTION SLEEPING-CUPBOARD-F)>

<ROUTINE SLEEPING-CUPBOARD-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The bed is softer than it looks, plumped up with fresh straw.
A soft, if somewhat cramped, bunk for the tall bulk of Jamison.
The cupboard opens to the fore.">)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? DISEMBARK>
			    <PRSO? ,CUPBOARD-OBJECT>>
		       <DO-WALK ,P?OUT>)
		      (T
		       <RFALSE>)>)>>

<ROUTINE CUPBOARD-EXIT ()
	 <COND (<NOT <FSET? ,CUPBOARD-OBJECT ,OPENBIT>>
		<COND (<EQUAL? ,P-WALK-DIR ,P?IN>
		       <DO-FIRST "open" ,CUPBOARD-OBJECT>
		       <RFALSE>)
		      (T
		       <FSET ,CUPBOARD-OBJECT ,OPENBIT>
		       ;<FSET ,SLEEPING-CUPBOARD ,ONBIT>
		       <TELL
"You open" T ,CUPBOARD-OBJECT " and clamber out" ,PCR CR>
		       <MOVE ,CUPBOARD-OBJECT ,LANDING>
		       <RETURN ,LANDING>)>)
	       (T
		<COND (<EQUAL? ,P-WALK-DIR ,P?IN>
		       <COND (<IN? ,PILE-OF-CLOTHES ,CUPBOARD-OBJECT>
			      <MOVE ,PILE-OF-CLOTHES ,SLEEPING-CUPBOARD>)>
		       <MOVE ,CUPBOARD-OBJECT ,SLEEPING-CUPBOARD>
		       <RETURN ,SLEEPING-CUPBOARD>)
		      (T
		       <COND (<IN? ,PILE-OF-CLOTHES ,SLEEPING-CUPBOARD>
			      <MOVE ,PILE-OF-CLOTHES ,CUPBOARD-OBJECT>)>
		       <MOVE ,CUPBOARD-OBJECT ,LANDING>
		       <RETURN ,LANDING>)>)>>

<CONSTANT SQUEEZE-AROUND "You might be able to squeeze past it.|">

<OBJECT CUPBOARD-OBJECT
	(IN CAPT-QUARTERS)
	(DESC "large cupboard")
	(SYNONYM CUPBOARD BED DOOR)
	(FLAGS NDESCBIT DOORBIT CONTBIT SEARCHBIT INBIT)
	(GENERIC GEN-BED)
	(ACTION CUPBOARD-OBJECT-F)>

<ROUTINE CUPBOARD-OBJECT-F ()
	 <COND (<VERB? PUSH MOVE>
		<TELL
CTHE ,CUPBOARD-OBJECT ,ISNT-FLUSH ,SQUEEZE-AROUND 
;"It looks like you could squeeze around it.">)
	       (<AND <VERB? OPEN CLOSE>
		     <EQUAL? ,HERE ,CAPT-QUARTERS>>
	     <TELL CTHE ,DOOR " is on the other side of" TR ,CUPBOARD-OBJECT>)
	       (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<EQUAL? ,HERE ,SLEEPING-CUPBOARD>
		       <V-LOOK>)
		      (<EQUAL? ,HERE ,CAPT-QUARTERS>
		       <TELL
,YOU-SEE ,THE-BACK T ,CUPBOARD-OBJECT ". " ,SQUEEZE-AROUND>)
		      (<FSET? ,CUPBOARD-OBJECT ,OPENBIT>
		       <TELL
"It is a dark messy bed, set entirely within and filling" T ,CUPBOARD-OBJECT
". A cabin boy must sleep here when Jamison isn't using it.">
		       <COND (<NOT <FSET? ,PILE-OF-CLOTHES ,TOUCHBIT>>
			      <TELL " " <GETP ,PILE-OF-CLOTHES ,P?FDESC>>)>
		       <CRLF>)
		      (T
		       <TELL "It" ,IS-CLOSED ,PCR>)>)
	       (<VERB? ENTER BOARD>
		<COND (<EQUAL? ,HERE ,SLEEPING-CUPBOARD>
		       <TELL ,LOOK-AROUND>)
		      (<EQUAL? ,HERE ,CAPT-QUARTERS>
		       <TELL ,YOU-CANT-SEE-ANY ,WAY-TO-DO-THAT>)
		      (T
		       <DO-WALK ,P?IN>)>)
	       (<VERB? PUT>
		<TELL
,YOULL-HAVE-TO "get in the " D ,CUPBOARD-OBJECT " to do that" ,PCR>)>>

<ROOM AFT-HOLD
      (IN ROOMS)
      (DESC "Aft Hold")
      (LDESC
"This is a gloomy, damp area at the bottom of the Helena Louise. To the
fore there seems to be a little more light, or you can climb up some
steep stairs.")
      (UP TO LANDING)
      (NORTH TO HOLD)
      (GLOBAL STAIRS)
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)>

<ROOM HOLD
      (IN ROOMS)
      (DESC "Hold")
      (SYNONYM HOLD)
      (UP PER HATCH-ENTRANCE)
      (OUT PER HATCH-ENTRANCE)
      (NORTH TO CREWS-QUARTERS)
      (SOUTH TO AFT-HOLD)
      (GLOBAL HATCH STAIRS)
      (FLAGS ONBIT RLANDBIT NARTICLEBIT INDOORSBIT)
      (ACTION HOLD-F)>

<GLOBAL FUSE-LIT <>>

<ROUTINE HOLD-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,HERE ,TOUCHBIT>>
		     <NOT <FSET? ,POOP ,TOUCHBIT>>>
		<TELL
"You hear a scuffling noise ahead, and scraping up near the ceiling.
You would think it was caused by rats, but for the definite curse you heard
before all the movement" ,PCR CR>)
	       (<AND <EQUAL? .RARG ,M-END>
		     ,FUSE-LIT
		     <NOT <FSET? ,FUSE ,TOUCHBIT>>>
		<DEQUEUE I-SMELL-SMOKE>
		<I-SMELL-SMOKE>
		<RFALSE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<HATCH-DESC>
		<TELL 
" above. Rats' scratchings counterpoint the lullaby of bilge water sloshing
in the bulkheads, punctuated by footsteps slapping the deck overhead.
You may move fore or aft.|
   Behind a high fence, decorated by a sign, are stacked" T ,SUPPLIES ";
casks of rum, water, flour and salt meat interspersed with kegs of
gunpowder and shot. A closed gate is the only way in.">)>>

;"For the sailors unable to read the sign overhead, a high fence
guards the supplies. There is a closed mesh gate in the fence."

<OBJECT HATCH
	(IN LOCAL-GLOBALS)
	(DESC "canvas hatch")
	(SYNONYM HATCH FRAME)
	(ADJECTIVE CANVAS COVERED)
	(FLAGS DOORBIT)
	(ACTION HATCH-F)>

<ROUTINE HATCH-F ()
	 <COND (<VERB? EXAMINE>
		 <COND (<EQUAL? ,HERE ,HOLD>
			<HATCH-DESC>
			<TELL ,PCR>)
		       (T
			<COND (<FSET? ,HATCH ,OPENBIT> 
			       <TELL ,STEEP-STAIRS "into murky darkness." CR>)
			      (T
			       <TELL "Canvas stretches across" TR ,HATCH>)>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<FSET? ,HATCH ,OPENBIT>
		       <PERFORM ,V?EXAMINE ,HATCH>
		       <RTRUE>)
		      (T
		       <TELL CTHE ,HATCH ,IS-CLOSED ,PCR>)>)
		(<AND <VERB? OPEN>
		      <NOT <FSET? ,HATCH ,OPENBIT>>>
		 <COND (<EQUAL? ,HERE ,MAIN-DECK>
			<FSET ,HATCH ,OPENBIT>
			<TELL
"You pull a corner of canvas out of the frame. ">
			<PERFORM ,V?EXAMINE ,HATCH>
			<RTRUE>)
		       (T
			<TELL ,YOU-CANT-SEE-ANY ,WAY-TO-DO-THAT>)>)>>

<ROUTINE HATCH-DESC ()
	 <COND (<FSET? ,HATCH ,OPENBIT>
		<TELL
"Moonlight shines down the stairs through an open
corner of the canvas hatch">)
	       (T
		<TELL
"Steep stairs lead up in the dimness to a canvas hatch">)>>

<OBJECT FENCE
	(IN HOLD)
	(DESC "fence")
	(SYNONYM FENCE CAGE)
	(ADJECTIVE MESH WIRE)
	(FLAGS CONTBIT SEARCHBIT TRANSBIT NDESCBIT)
	(ACTION FENCE-F)> 

<ROUTINE FENCE-F ()
	 <COND (<VERB? LOOK-BEHIND LOOK-INSIDE>
		<TELL
CTHE ,SUPPLIES " are kept locked behind the fence. ">
		<COND (,FUSE-LIT
		       <PERFORM ,V?EXAMINE ,FUSE>
		       <RTRUE>)
		      (T
		       <CRLF>)>) 
	       (<VERB? EXAMINE>
		<TELL CTHE ,FENCE
" is made of thick, finely woven wire mesh, uncuttable and unclimbable.
Except for a gap of about 6 inches over the closed gate, the cage is
secure from ceiling to damp floorboards." CR>)
	       (<VERB? THROW-OVER>
		<TELL "You'd best throw" T ,PRSO " over" TR ,GATE>)
	       (<VERB? CLIMB>
		<TELL "You can't get a toehold in" TR ,FENCE>)
	       (<VERB? OPEN CLOSE>
		<TELL
,YOULL-HAVE-TO "do that to the gate in" TR ,FENCE>)>>

<ROUTINE GATE-MADE-SAME (STR)
	 <TELL
"The gate is made of the same " .STR " wire as" T ,FENCE>>

<OBJECT GATE
	(IN HOLD)
	(DESC "gate")
	(SYNONYM GATE GAP LOCK)
	(ADJECTIVE IRON MESH)
	(FLAGS LOCKEDBIT DOORBIT NDESCBIT)
	(ACTION GATE-F)>

<ROUTINE GATE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It has a huge iron lock. Between" T ,GATE " and the
ceiling, however, is a gap of about 6 inches." CR>)
	       (<AND <VERB? ENTER>
		     <NOUN-USED ,W?GAP ,GATE>>
		<PERFORM ,V?CLIMB ,GATE>
		<RTRUE>)
	       (<VERB? CLIMB CLIMB-OVER EXIT>
		<GATE-MADE-SAME "finely woven">
		<TELL ", and you cannot get a foothold" ,PCR>)
	       (<VERB? CUT>
		<GATE-MADE-SAME "thick">
		<TELL ,PCR>)
	       (<VERB? LOOK-BEHIND>
		<PERFORM-PRSA ,FENCE>)
	       (<VERB? THROW-OVER>
		;<COND (<PRSO? ,HOOPS>
		       <RFALSE>)>
		<TELL "You throw">
		<COND (<PRSO? ,RAG>
		       <REMOVE ,RAG>
		       <FCLEAR ,RAG ,TOUCHBIT>
		       <TELL T ,RAG " over the gate. ">
		       <COND (<NOT ,FUSE-LIT>
			      <TELL
"It falls to the floor amongst the food supplies" ,PCR>)
			     (<EQUAL? ,WET-RAG <>>
			      <TELL
"It flaps haplessly in the air, settling to the floor
not far from the burning fuse" ,PCR>
			      <RTRUE>)
			     (T
			      <TELL
"Luckily, it lands directly on the burning end of the fuse. ">
			      <COND (<EQUAL? ,WET-RAG ,RUM>
				     <QUEUE I-SHIP-EXPLODES 9>
				     <DEQUEUE I-TEAR-RAG>
				     <TELL
"Unluckily, it is soaked with flammable rum, and flares up, making the fuse
burn much faster. You have perhaps 3 minutes to live." CR>)
				    (<EQUAL? ,WET-RAG ,WATER>
				     <DEQUEUE I-SHIP-EXPLODES>
				     <DEQUEUE I-TEAR-RAG>
				     <SETG FUSE-LIT <>>
				     <FSET ,FUSE ,NDESCBIT>
				     ;<REMOVE ,FUSE>
				     <SETG SCORE <+ ,SCORE 1>>
				     <TELL
"With a sputter and a sigh, the flame dies." CR>)>
			      <SETG WET-RAG <>>
			      <RTRUE>)>)
		      (<PRSO? ,DRESS>
		       <TELL T ,DRESS " up, "> 
		       <COND (,WET-DRESS
			      ;<FSET ,DRESS ,TRYTAKEBIT>
			      ;<FSET ,DRESS ,NDESCBIT>
			      <MOVE ,DRESS ,HOLD>
			      <TELL
"its soaked skirt slapping " D ,HEAD ". Too heavy and bulky
to make it over the gate, it squelches to the floor nearby. A cold tear of "
D ,WET-DRESS " dribbles down the back of your neck" ,PCR>)
			     (T
			      <MOVE ,DRESS ,HERE>
			      <TELL
"but it billows out and catches on the
top of the gate. It floats to the floor near you" ,PCR>)>)
		      (T
		       <REMOVE ,PRSO>
		       <TELL T ,PRSO
" into the ammunition area. It skids into the darkness">
		       <COND (,FUSE-LIT
			      <TELL
", over the burning end of the fuse.
The fuse falters, spits and resumes burning">)>
		       <TELL ,PCR>)>)
	       (<AND <VERB? PUT PUT-THROUGH THROW>
		     <NOUN-USED ,W?GAP ,GATE>>
		<PERFORM ,V?THROW-OVER ,PRSO ,GATE>
		<RTRUE>)>>

<OBJECT SUPPLIES
	(IN FENCE)
	(DESC "food and ammunition supplies")
	(SYNONYM FOOD AMMUNI GUNPOW)
	(ADJECTIVE SUPPLIES)
	(FLAGS NDESCBIT PLURALBIT)
	(ACTION KEG-F)>

<OBJECT KEG
	(IN HOLD)
	(DESC "keg")
	(SYNONYM KEG KEGS CASK CASKS)
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION KEG-F)>

<ROUTINE KEG-F ()
	 <COND (<OR <TOUCHING? ,KEG>
		    <TOUCHING? ,SUPPLIES>>
	        <CANT-REACH ,SUPPLIES>)>> 

<OBJECT SIGN
	(IN HOLD)
	(DESC "sign")
	(SYNONYM SIGN)
	(FLAGS NDESCBIT)
	(ACTION SIGN-F)>

<ROUTINE SIGN-F ()
	 <COND (<VERB? READ EXAMINE>
		<TELL
"The sign proclaims \"Thieves be keel-hauled\" in uncertain lettering." CR>)>>

<ROUTINE I-SMELL-SMOKE ()
	 <COND (<NOT <QUEUED? I-SHIP-EXPLODES>>
		<SETG FUSE-LIT T>
		<FCLEAR ,FUSE ,NDESCBIT>
		<QUEUE I-TEAR-RAG 85>)>
	 <COND (<AND <NOT <FSET? ,FUSE ,TOUCHBIT>>
		     <OR <AND <EQUAL? ,HERE ,MAIN-DECK>
			      <FSET? ,HATCH ,OPENBIT>>
			 <EQUAL? ,HERE ,HOLD>>>
		<FSET ,FUSE ,TOUCHBIT>
		<FCLEAR ,FUSE ,INVISIBLE>
		<TELL ,INDENT
"You gradually notice a familiar, worrying smell,
sniff, and identify it as smoke. ">
		<COND (<EQUAL? ,HERE ,MAIN-DECK>
		       <TELL "It appears to come from below decks." CR>)
		      (<EQUAL? ,HERE ,HOLD>
		       <TELL ,TINY-GLOW ,PCR>)>)>
	 <RFALSE>>

<ROUTINE I-TEAR-RAG ()
	 <QUEUE I-SHIP-EXPLODES 15>
	 <COND (<AND <NOT <LOC ,RAG>>
		     ,FUSE-LIT>
		<COND (<OR <FSET? ,DRESS ,WORNBIT>
			   <IN? ,DRESS ,PROTAGONIST>>
		       <COND (,WET-DRESS
			      <SETG WET-RAG T>)>
		       <FSET ,DRESS ,MUNGBIT>
		       <TELL ,INDENT "Your frock">)
		      (<IN? ,SHIRT ,PROTAGONIST>
		       <FSET ,SHIRT ,MUNGBIT> 
		       <TELL ,INDENT "The tail of your shirt">)
		      (<NOT <FSET? ,CHEMISE ,EVERYBIT>>
		       <FSET ,CHEMISE ,MUNGBIT>
		       <TELL ,INDENT "Your chemise">)
		      (T
		       <RTRUE>)>
		<MOVE ,RAG <LOC ,PROTAGONIST>>
		<TELL
" suddenly catches on something, tearing the fabric.
A large scrap flutters to your feet." CR>)>>

<ROUTINE I-SHIP-EXPLODES ()
	 <COND (,FUSE-LIT
		<FSET ,SHIP ,MUNGBIT>
		<SETG SHIP-LOC 10>
		;<MOVE ,DEBRIS ,BEACH>
		;<MOVE ,DEBRIS ,LAGOON>
		<DEQUEUE I-SHIP-EXPLODES>
		<DEQUEUE I-TEAR-RAG>
		<COND (<OR <SHIP-BOARD ,HERE>
			   <EQUAL? ,HERE ,BY-SHIP>>
		       <JIGS-UP
"   Suddenly you appreciate what it is to be a ball in an exploding cannon.
The intense heat, the push of fire, and the sense of release when spit
from the cannon's mouth -- these you feel when the lighted fuse finally
burns up to the largest keg of gunpowder in the hold.">)
		      (<EQUAL? <LOC ,PROTAGONIST> ,SKIFF ,CASK ,BEACH>
		       <TELL ,INDENT "A huge wave ">
		       <COND (<EQUAL? ,HERE ,BEACH>
			      <TELL "rolls up the beach">)
			     (T
			      <TELL "rocks" T <LOC ,PROTAGONIST>>)>
		       <TELL 
" as" T ,SHIP " explodes into flames across the lagoon" ,PCR>)
		      (T
		       <TELL ,INDENT
"You hear a noise like a huge explosion in the distance, and the ground shakes
beneath your feet. There should be good beachcombing tomorrow" ,PCR>)>)
	       (T
		<RFALSE>)>>

;<OBJECT BENT-KEY
	(IN HOLD)
	(DESC "bent key")
	(FDESC
"At the foot of the gate lies a key, one end bent back on itself.")
	(SYNONYM KEY)
	(ADJECTIVE BENT)
	(FLAGS TAKEBIT)
	(SIZE 2)>

<OBJECT FUSE
	(IN HOLD)
	(DESC "fuse")
	(DESCFCN FUSE-F)
	(SYNONYM FUSE GLOW FIRE)
	(ADJECTIVE BURNING SLOW RED)
	(FLAGS INVISIBLE ONBIT NDESCBIT)
	(ACTION FUSE-F)>

<ROUTINE FUSE-F ("OPTIONAL" (OARG <>) "AUX" (C <>) (X <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-DESC?>
		       <RTRUE>)>
		<TELL ,INDENT ,TINY-GLOW ".">
		;<COND (<AND ,FUSE-LIT
			    <FSET? ,FUSE ,TOUCHBIT>>
		        <TELL ,INDENT ,TINY-GLOW ".">)
		       (T
		        <RTRUE>)>)
	       (<AND <VERB? POUR PUT-ON>
		     <PRSO? ,RAG ,DRESS>>
		<PROPOSE>)
	       (<VERB? MOVE TAKE>
		<CANT-REACH ,FUSE>)
	       (<OR <VERB? ON OFF POUR PUT-ON CUT>
		    <TOUCHING? ,FUSE>>
		<TELL ,YOU-ARENT "anywhere near" T ,FUSE "!" CR>)
	       (<VERB? EXAMINE>
		<COND (,FUSE-LIT
		       <TELL "The burning fuse is ">
		       <COND (<SET C <QUEUED? ,I-SHIP-EXPLODES>>
			      <SET X <- 15 <GET .C ,C-TICK>>>
			      <COND (<G? .X 12>
				     <TELL
"boring a hole through the largest powder keg" ,PCR>
				     <RTRUE>)
				    (<G? .X 7>
				     <TELL "mere inches">)
				    (T         ;<G? .X 85>
				     <TELL "only a foot">)>)
			     (T
			      <SET C <QUEUED? ,I-TEAR-RAG>>
			      <SET X <- 85 <GET .C ,C-TICK>>>
			      <COND (<G? .X 70>
				     <TELL "a few feet">)
				    (<G? .X 60>
				     <TELL "several feet">)
				    (<G? .X 45>
				     <TELL "a few yards">)
				    (T
				     <TELL
"quite near the fence, several yards">)>)>
		       <TELL
" from the pile of gunpowder kegs opposite" TR ,GATE>
		       ;<TELL "[X=" N .X ", TICK=" N ,C-TICK "]" CR>)
		      (T
		       <TELL ,YOU-SEE ,DARKNESS TR ,FENCE>
		       ;<TELL ,YOU-CANT
"see" T ,FUSE " in the darkness beyond" TR ,FENCE>)>) 
	       (<AND <VERB? THROW THROW-OVER THROW-AT>
		     <PRSO? ,RAG ,DRESS>>
		<PERFORM ,V?THROW-OVER ,PRSO ,GATE>
		<RTRUE>)>>

<ROOM CREWS-QUARTERS
      (IN ROOMS)
      (DESC "Crew's Quarters")
      (UP "A grate blocks your way.")
      (SOUTH TO HOLD)
      (FLAGS ONBIT RLANDBIT ;NARTICLEBIT INDOORSBIT)
      (GLOBAL GRATE)
      (ACTION CREWS-QUARTERS-F)>

<ROUTINE CREWS-QUARTERS-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT ,HEARD-CRULLEY>>
		<QUEUE I-OVERHEAR-CRULLEY 2>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The crew sleeps, in shifts, in this cramped space under the forecastle.
A breeze blows in on a moonbeam through a grate in the ceiling.
A low doorsill is abaft.|" ,INDENT>
		<COND (<NOT <FSET? ,MESS ,TOUCHBIT>>
		       <FSET ,MESS ,TOUCHBIT>
		       <TELL "This area must also serve as sickroom. ">)>
		<TELL
"Strewn about the floor are various powders and spills of malodorous potions.
In one corner, a large blood stain indicates an amputation; in another is the
smear of a leech, dropped off a bloodletting.">)>>

<OBJECT MESS
	(IN CREWS-QUARTERS)
	(DESC "mess")
	(SYNONYM MESS POWDER POTIONS STAINS)
	(FLAGS NDESCBIT)>



<OBJECT GRATE
	(IN LOCAL-GLOBALS)
	(DESC "grate")
	(SYNONYM GRATE HOLE)
	(ADJECTIVE AIR)
	(ACTION GRATE-F)>

<ROUTINE GRATE-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,CREWS-QUARTERS>
		       <PERFORM ,V?EXAMINE ,CEILING>
		       <RTRUE>)
		      (T
		       <TELL ,YOU-SEE ,DARKNESS TR ,GRATE>)>)>>

<OBJECT MIRROR
	(IN CREWS-QUARTERS)
	(DESC "bit of mirror")
	(FDESC
"A chipped piece of mirror sits propped on a shoulder-high timber.")
	(SYNONYM MIRROR)
	(ADJECTIVE CHIPPED PIECE BIT)
	(FLAGS TAKEBIT)
	(ACTION MIRROR-F)>

<ROUTINE MIRROR-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<TELL "You are aglow with excitement" ,PCR>)
	       (<AND <VERB? PUT POINT>
		     <PRSI? ,SHIP ,SHUTTERS ,MOONBEAM ,WINDOW>>
		<SIGNAL-SHIP ,MIRROR>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"Probably a remnant of a pirated lady's boudoir,"
T ,MIRROR "'s edges are dulled from use" ,PCR>)>>

<ROUTINE SIGNAL-SHIP (THING)
	 <COND (<AND <FSET? ,HERE ,INDOORSBIT>
		     <NOT <GLOBAL-IN? ,HERE ,WINDOW>>
		     <NOT <EQUAL? ,HERE ,LAFS-ROOM ,CAPT-QUARTERS>>>
		<TELL ,YOU-CANT-SEE-ANY ,WAY-TO-DO-THAT>)
	       (T
		<MOVE .THING ,PROTAGONIST>
		<COND (<IN? ,CHICKEN .THING>
		       <REMOVE ,CHICKEN>
		       <REMOVE ,SPICES>
		       <TELL
"You scrape everything off" T ,TRAY " into the bushes below. ">)>
		<COND (<EQUAL? ,HERE ,BEDROOM>
		       <TELL
,YOU-CANT "quite catch the moon, just peeking over the house,
in the little mirror" ,PCR>
		       <RTRUE>)>
		<TELL
"You roll" T .THING " around in the beam of
moonlight till it glows silver-white. ">
		;<COND (<NOT <EQUAL? ,HERE ,LAFS-ROOM>>
		       <CRLF>
		       <RTRUE>)>
		<COND (<EQUAL? ,HERE ,LAFS-ROOM>
		       <COND (<FSET? ,SHIP ,MUNGBIT>
			     <TELL "The breeze picks up, howling off" TR ,SEA>
			      <RTRUE>)
			     (<AND <NOT <QUEUED? ,I-PIRATE-RESCUE>>
				   <NOT ,ENDGAME>>
			      <SETG SCORE <+ ,SCORE 1>>
			      <COND (<IN? ,LAFOND ,HERE>
				     <QUEUE I-PIRATE-RESCUE 14>)
				    (T
				     <QUEUE I-PIRATE-RESCUE 6>)>
			      <TELL
"After a moment, a flash of light responds from" TR ,SHIP>)
			     (T
			      <CRLF>)>)
		      (T
		       <CRLF>
		       <RTRUE>)>)>>

<GLOBAL ENDGAME <>>
<GLOBAL COOKIE-LOOKING <>>

<ROUTINE I-PIRATE-RESCUE ()
	 <SETG ENDGAME T>
	 <SETG COOKIE-LOOKING T>
	 <FSET ,LUCY ,NDESCBIT>
	 <FSET ,DAD ,NDESCBIT>
	 <MOVE ,CRULLEY ,DUNGEON>
	 ;<MOVE ,COOKIE ,BALLROOM>
	 <FCLEAR ,COOKIE ,NDESCBIT>
	 <FSET ,BALLROOM ,EVERYBIT>      ;"the crew is rounding up prisoners"
	 <FSET ,SKIFF ,NDESCBIT>
	 <TELL ,INDENT>
	 <COND (<EQUAL? ,HERE ,LAWN ,VERANDA ,FOREST ,TRADE-ENTRANCE>
		<TELL
"Silently, a dozen ragged men creep in from the beach. Small groups move
in all " D ,INTDIR "s, surrounding the mansion, until, with a hair-raising
cry, they attack the house. Screams of terror come from the ballroom" ,PCR>)
	       (<AND <EQUAL? ,HERE ,LAFS-ROOM>
		     <IN? ,LAFOND ,HERE>>
		<TELL ,BATTLE-CRY
", and Lafond whirls around, every sinew taut. \"Damnation! Jamison somehow
called his men!\" Holding a knife to your throat, Lafond drags you downstairs
and away from rescue, as Cookie and the crew watch helpless.">
		<JIGS-UP " The blade bites less then you expected.">)
	       (<AND <EQUAL? ,HERE ,LAFS-ROOM>
			    <NOT <FSET? ,BUTLER ,DEADBIT>>>
		<TELL ,BATTLE-CRY
", as Jamison's men respond to your signal. " CTHE ,BUTLER ", looking scared,
grabs you and runs downstairs and out to the front drive.">
		<JIGS-UP " Lafond's dragoons deal with you quickly.">)
	       (<EQUAL? ,HERE ,GALLERY ,STAIRTOP ,FOYER ,BALLROOM
			,ORCHESTRA ,SUPPER-ROOM>
		<TELL ,BATTLE-CRY
", and Jamison's men stream in from all " D ,INTDIR "s,
huddling the dancers in the middle of the ballroom" ,PCR>)
	       (T
		<TELL ,BATTLE-CRY
". It is drowned out a few minutes later by screams of terror
from the dancers in the ballroom" ,PCR>
		<COND (<EQUAL? ,HERE ,FRONT-DRIVE>
		       <TELL ,INDENT
"The dragoons look alarmed, and confer among themselves." CR>)
		      (T
		       <RFALSE>)>)>>

<GLOBAL BATTLE-CRY
"An eerie battle cry arises on the wind, from all sides of the house">
 
<OBJECT DAGGER
	(IN GALLEY)
	(DESC "dagger")
	(FDESC "A dagger is driven into the wooden floorboards.")
	(SYNONYM DAGGER KNIFE)
	(FLAGS TAKEBIT)
	(ACTION DAGGER-F)>

<ROUTINE DAGGER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL CTHE ,DAGGER " is quite dull" ,PCR>)
	       (<VERB? CUT>
		<COND (<FSET? ,PRSO ,WEARBIT>
		       <PERFORM ,V?RIP ,PRSO>
		       <RTRUE>)
		      (<PRSO? ,LINE>
		       <RFALSE>)
		      (<PRSO? ,DAGGER>
		       <IMPOSSIBLES>)
		      (T
		       <TELL
CTHE ,DAGGER " is much too dull to cut" TR ,PRSO>)>)>> 
	 
<ROOM POOP
      (IN ROOMS)
      (DESC "Poop")
      ;(DOWN PER CLIMBING-LADDER)
      (DOWN PER CLIMBING)
      (NORTH TO QUARTERDECK)
      (SOUTH "You can't swim, and decide not to jump.")
      (EAST "You can't swim, and decide not to jump.")
      (WEST "You can't swim, and decide not to jump.")
      (GLOBAL LADDER SEA RAILING OBJ-QUARTERS)    ;"To cover L AT QUARTERDECK"
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (ACTION POOP-F)>

<ROUTINE POOP-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,POOP ,TOUCHBIT>>>
		<COND (<NOT ,HEARD-CRULLEY>
		       <SETG HEARD-CRULLEY T>
		       <FSET ,ANCHOR ,MUNGBIT>
		       <FSET ,LEVER ,MUNGBIT>
		       <QUEUE I-SEE-CRULLEY-ESCAPE 2>
		       <QUEUE I-LOOK-SEA 10>)>
		<SETG SCORE <+ ,SCORE 1>>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"From this platform deck you can see the whole of the two-masted ship,
shadowy forms moving about here and there. A railing protects
you from stepping off the deck in any " D ,INTDIR " but to the fore.">
		<COND (,LADDER-HANGING
		       <TELL
" A rope ladder is tied to the railing at the stern of the ship.">)>
		<I-LOOK-SEA <>>)>>

<ROOM QUARTERDECK
      (IN ROOMS)
      (DESC "Quarterdeck")
      (IN "The door is barred.")
      (DOWN "The door is barred.")
      (UP "If you wish to go to the Poop, go AFT.")
      (NORTH TO MAIN-DECK)
      (SOUTH TO POOP)
      (EAST "You can't swim, and decide not to jump.")
      (WEST "You can't swim, and decide not to jump.")
      (GLOBAL DOOR CREW SEA RAILING LINE)
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (ACTION QUARTERDECK-F)>

<ROUTINE QUARTERDECK-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"No torches are lit, or needed on this moonlit night, except in the deep
shadows cast by the huge navigation wheel. Men move about to the fore,
talking quietly. Under the stairs aft to the poop is a barred door.">
		<I-LOOK-SEA <>>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <NOT ,BOY-DRESS?>>
		<SAILOR-DEATH>)
	       (T <RFALSE>)>>

<OBJECT WHEEL
	(IN QUARTERDECK)
	(DESC "navigation wheel")
	(SYNONYM WHEEL)
	(ADJECTIVE NAVIGA)
	(FLAGS NDESCBIT)
	(ACTION WHEEL-F)>

<ROUTINE WHEEL-F ()
	 <COND (<TOUCHING? ,WHEEL>
		<TELL
"From the grumbling emitted as you near" T ,WHEEL ", you gather that
the sailors close by would not appreciate your action." CR>)>>

<OBJECT CANNON
	 (IN QUARTERDECK)
	 (DESC "cannon")
	 (LDESC
"Cannon line the deck, aimed at open sea and the island.")
	 (SYNONYM CANNON)
	 (FLAGS PLURALBIT)
	 (ACTION CANNON-F)>

<ROUTINE CANNON-F ()
	 <COND (<TOUCHING? ,CANNON>
		<TELL
"A crewman growls angrily, \"Boy! Get away from me guns --
they've killed better men than thee by just rollin' backwards.\"" CR>)
	       (<VERB? EXAMINE>
		<TELL
"Huge, old and blackened, these cannon have seen many battles" ,PCR>)
	       (<VERB? SHOOT SSHOOT>
		<REPERTOIRE "Firing cannon">)>>

<OBJECT CASK
	(IN QUARTERDECK)
	(DESC "cask")
	(DESCFCN CASK-F)
	(SYNONYM CASK KEG)
	(ADJECTIVE EMPTY RUM WARPED)
	(GENERIC GEN-CASK)
	(FLAGS VEHBIT CONTBIT SEARCHBIT INBIT OPENBIT NDESCBIT)
	(ACTION CASK-F)>

<ROUTINE CASK-F ("OPTIONAL" (VARG <>))
	 <COND (.VARG
		<COND (<EQUAL? .VARG ,M-BEG>
		       <COND (<VERB? ROW ROW-DIR ROW-TO>
			      <V-ROW>)
			     ;(<AND <VERB? WALK>
				   <EQUAL? ,P-DIRECTION ,P?OUT>>
			      <PERFORM ,V?DISEMBARK ,CASK>
			      <RFATAL>)
			     (<OR <AND <VERB? WALK>
				       <NOT <PRSO? ,P?OUT>>>
				  <TOUCHING? ,PYRAMID>>
			      <DO-FIRST "get out of" ,CASK>)>)
		      (<EQUAL? .VARG ,M-DESC?>
		       <RTRUE>)
		      (<AND <EQUAL? .VARG ,M-OBJDESC>
			    <EQUAL? ,HERE ,SHALLOWS ,LAGOON>>
		       <TELL ,INDENT "Waves lap at" T ,CASK ".">)
		      (T
		       <RFALSE>)>)
	       (<VERB? EXAMINE>
		<TELL
"This large, empty cask smells of salt and rancid meat.
The head of" T ,CASK " is missing" ,PCR>)
	       (<VERB? BOARD ENTER>
		<MOVE ,PROTAGONIST ,CASK>
		<TELL "You crawl into" T ,CASK>
		<COND (<NOT <FSET? ,PORK ,TOUCHBIT>>
		       <TELL
", feeling a slab of something stuck on the bottom">)>   
		<COND (<EQUAL? ,HERE ,QUARTERDECK>
		       <TELL 
". From this close, you can see" T ,LINE
" is getting frayed where it rubs against" TR ,CASK>)
		      (T
		       <TELL ,PCR>)>
		;<COND (<IN? ,HOOPS ,PROTAGONIST>
		       <TELL ,YOU-CANT "get" T ,HOOPS " into" TR ,CASK>)
		      (T
		       <MOVE ,PROTAGONIST ,CASK>
		       <TELL "You crawl into" T ,CASK>
		       <COND (<NOT <FSET? ,PORK ,TOUCHBIT>>
			      <TELL
", feeling a slab of something stuck on the bottom">)>   
		       <COND (<EQUAL? ,HERE ,QUARTERDECK>
			      <TELL 
". From this close, you can see" T ,LINE
" is getting frayed where it rubs against" TR ,CASK>)
			     (T
			      <TELL ,PCR>)>)>)
	       ;(<AND <VERB? LOOK-INSIDE>
		     <FSET? ,PORK ,NDESCBIT>>
		<TELL "A slab of something lies on the bottom" ,PCR>) 
	       (<VERB? OPEN CLOSE>
		<TELL
"One end of" T ,CASK " is missing, so it can't be opened or closed" ,PCR>)
	       (<VERB? LAUNCH>
		<COND (<EQUAL? ,HERE ,QUARTERDECK>
		       <TELL ,HUH>)
		      (T
		       <TELL ,ALREADY-IS>)>
		;<COND (<EQUAL? ,HERE ,BEACH>
		       <MOVE ,CASK ,SHALLOWS>
		       <TELL
"You shove" T ,CASK " off the sand and climb into
it as it bobs in the shallows" ,PCR CR>
		       <SETG CASK-LOC 1>
		       <GOTO ,CASK>)
		      (T
		       <TELL ,ALREADY-IS>)>)
	       ;(<OR <AND <VERB? RAISE PUSH>
			 <EQUAL? ,HERE ,SHALLOWS>>
		    <AND <VERB? PUSH-DIR>
			 <EQUAL? ,HERE ,SHALLOWS>
			 <OR <PRSI? ,P?EAST>
			     <PRSI? ,BEACH>>>>
		<MOVE ,CASK ,BEACH>
		<TELL
"You tip" T ,CASK " on its side and roll it onto the beach" ,PCR>
		<GOTO ,BEACH>)
	       (<VERB? DISEMBARK>
		<COND (<EQUAL? ,HERE ,LAGOON>
		       <TELL ,TOO-DEEP>)
		      (<EQUAL? ,HERE ,SHALLOWS>
		       <MOVE ,PROTAGONIST ,HERE>
		       <REMOVE ,CASK>
		       <TELL
"Free of your weight," T ,CASK " bobs and spins in the current,
pulled out into the lagoon. You splash after it, but it is gone" ,PCR>)
		      (T
		       <RFALSE>)>)>>
<GLOBAL PORK-DOPED <>>

<OBJECT PORK
	(IN CASK)
	(DESC "slab of pork")
	(SYNONYM PORK MEAT SOMETHING PORK)
	(ADJECTIVE SALT SLAB)
        (FLAGS ;TAKEBIT ;NDESCBIT)
	(ACTION PORK-F)>

<ROUTINE PORK-F ()
	 <COND (<VERB? EXAMINE>
		<TELL CTHE ,PORK ", caked white with salt, is rock-hard." CR>)
	       (<VERB? EAT ;TASTE>
		<TELL CTHE ,PORK " is too salty to eat." CR>)
	       (<AND <VERB? TAKE>
		     <IN? ,PORK ,CASK>
		     <NOT <FSET? ,PORK ,TAKEBIT>>>
		<COND (<IN? ,PROTAGONIST ,CASK>
		       <FSET ,PORK ,TAKEBIT>
		       <MOVE ,PORK ,PROTAGONIST>
		       <TELL "You peel it off" TR ,CASK>)
		      (T
		       <TELL
CTHE ,PORK " is beyond your reach at the bottom of" TR ,CASK> 
		       ;<TELL "You can't quite reach it from here" ,PCR>)>)>> 

<OBJECT LINE                                  ;"MUNGBIT = rope is cut"
	(IN QUARTERDECK)                ;"EVERYBIT = set if you try to leave"
	(DESC "line")                      ;"ship without putting out fuse"
	(SYNONYM ROPE LINE)
	(ADJECTIVE HEAVY)
	(FLAGS NDESCBIT)
	(ACTION LINE-F)>

<ROUTINE LINE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"Heavy-duty, hand-twisted rope is pulled taut around" T ,PYRAMID ". ">
		<COND (<NOT <FSET? ,LINE ,MUNGBIT>>
		       <TELL
"It runs directly over the open-ended cask. ">)>
		<TELL "A seaman calls over, \"Boy, take care">
		<COND (<FSET? ,LINE ,MUNGBIT>
		       <TELL " -- or I'll see you flogged">)
		      (T
		       <TELL
". Them casks ain't safe, they could push ye overboard">)>
		<TELL "!\"" CR>)
	       (<VERB? CUT>
		<COND (<AND <NOT ,PRSI>
			    <HELD? ,DAGGER>>
		       <TELL "[with the dagger]" CR>
		       <PERFORM ,V?CUT ,LINE ,DAGGER>
		       <RTRUE>)
		      (<PRSI? ,DAGGER>
		       <COND (<AND ,FUSE-LIT
				   <IN? ,PROTAGONIST ,CASK>
			           <NOT <FSET? ,LINE ,EVERYBIT>>>
			      <FSET ,LINE ,EVERYBIT>
			      <TELL
"You hesitate, thinking of the fates of
those left aboard this ship." CR>
			      <RTRUE>)>
		       <TELL
CTHE ,LINE " snaps, and the pyramid collapses
into dozens of tumbling casks. ">
		       <COND (<EQUAL? <LOC ,PROTAGONIST> ,CASK>
			      <FCLEAR ,CASK ,NDESCBIT>
			      <FSET ,LINE ,MUNGBIT>
			      <REMOVE ,DAGGER>
			      <SETG CASK-LOC <- ,SHIP-LOC 2>>
			      <SETG SCORE <+ ,SCORE 1>>
			      <TELL
"Your cask is thrust into the sea," T ,DAGGER " flying from " D ,HANDS ,PCR>
			      <COND (<FSET? ,ANCHOR ,MUNGBIT>
				     <FWTD
"   The tides are against you, however, and carry you out to sea. Days later
you collapse, exhausted, to wake in the heaven on earth of a Swedish
merchant marine. A midshipman, an ice-eyed blond with Viking physique and
no English, nurses you back to health; in a moment of weakness you thank
him in the only language all men and women share.">)
				    (T
				     <TELL ,INDENT
"Sputtering mouthfuls of salt water, you
first look around several minutes later" ,PCR CR>)>
			      <FCLEAR ,DOOR ,OPENBIT>
			      <FSET ,DOOR ,LOCKEDBIT>
			      <QUEUE I-CURRENT -1>
			      <MOVE ,CASK ,LAGOON>
			      <GOTO ,CASK>
			      <V-LOOK>)
			     (<EQUAL? <LOC ,PROTAGONIST> ,QUARTERDECK>
			      <JIGS-UP
"A large one rolls into you, stumbling you
through the railing into the sea.">)>)>)
	       (<VERB? UNTIE REMOVE>
		<TELL
,YOU-CANT-SEE-ANY "knots to untie, just line" ,PCR>)>>

<ROUTINE GEN-CASK ()
	 <COND (<IN? ,CASK ,HERE>
		<RETURN ,CASK>)
	       (T
		<RETURN ,PYRAMID>)>>

<GLOBAL PYRAMID-CTR 0>

<OBJECT PYRAMID
	(IN QUARTERDECK)
	(DESC "pyramid of casks")
	(DESCFCN PYRAMID-F)
	(SYNONYM PYRAMID CASKS CASK)
	(ADJECTIVE RUM)
	(GENERIC GEN-CASK)
        (ACTION PYRAMID-F)>

<GLOBAL GET-AWAY
". \"Hey, boy! Get away from those. It ain't safe!\" yells a sailor.">

<ROUTINE PYRAMID-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-DESC?>     
		       <RTRUE>)>                  
		<TELL ,INDENT "Abaft the wheel sits a ">
		<COND (<FSET? ,LINE ,MUNGBIT>
		       <TELL "small, hastily constructed">)
		      (T
		       <TELL "large">)>
		<TELL
" pyramid of casks, held in place by a heavy rope.">)
	       (<VERB? EXAMINE>
		<TELL
"Lying on their sides, the casks are stacked in a rather
shaky pyramid: perhaps that's why someone has tied the rope about them">
		<COND (<NOT <FSET? ,LINE ,MUNGBIT>>
		       <TELL ". A cask on one corner has lost its lid">)>
		<TELL ,GET-AWAY CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL "All of the casks seem empty">
		<COND (<NOT <FSET? ,LINE ,MUNGBIT>>
		       <TELL
", but the only one you can actually look in
is the open-ended cask.">
		       <COND (<IN? ,PORK ,CASK>
			      <TELL
" There appears to be" A ,PORK " dried to the bottom of that one.">)>)>
		<CRLF>) 
	       (<TOUCHING? ,PYRAMID>
		<COND (<FSET? ,LINE ,MUNGBIT>
		       <TELL
"A sailor swoops down on you from nowhere, whapping your backside painfully.
\"Boy!\" he booms, \"get away from those! We already had to clean up after
you once. Cap'n'll hear of this, I tell you.\"" CR>)
		      (T
		       <SETG PYRAMID-CTR <+ ,PYRAMID-CTR 1>>
		       <TELL "The pyramid wobbles">
		       <COND (<EQUAL? ,PYRAMID-CTR 3>
			      <JIGS-UP
" and collapses.|
   You were warned, of course, but did not listen.
A stray keg pushes you off the deck into the sea.">
			      <RTRUE>)
			     (T
			      <TELL ,GET-AWAY>)>
		       <CRLF>)>)>>

<ROOM MAIN-DECK
      (IN ROOMS)
      (DESC "Main Deck")
      (UP PER CLIMBING)
      ;(UP PER CLIMBING-RIGGING)
      (DOWN PER HATCH-ENTRANCE)
      (NORTH TO FOCSLE)
      (SOUTH TO QUARTERDECK)
      (EAST "You can't swim, and decide not to jump.")
      (WEST "You can't swim, and decide not to jump.")
      (GLOBAL HATCH STAIRS RAILING CREW SEA RIGGING-OBJECT)
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (ACTION MAIN-DECK-F)>

<ROUTINE MAIN-DECK-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"It is a deceptively quiet evening on the ship, the pirates singing
low shanties as they repair cannon, twist ropes and sharpen daggers. The
mainmast casts an inky shadow over the ">
		<COND (<FSET? ,HATCH ,OPENBIT>
		       <TELL
"open hatch and stairs leading down to the hold.">)
		      (T
		       <TELL "canvas screening the hatch.">)>
		<TELL ,TANGLED-RIGGING>	
		<I-LOOK-SEA <>>
		<TELL CR ,INDENT
"Two large barrels stand near the stair to the foredeck.">)
	       (<AND <EQUAL? .RARG ,M-ENTER>
		     ,FUSE-LIT
		     <NOT <FSET? ,FUSE ,TOUCHBIT>>>
		<DEQUEUE I-SMELL-SMOKE>
		<I-SMELL-SMOKE>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <NOT ,BOY-DRESS?>>
		<SAILOR-DEATH>)>>

<ROUTINE HATCH-ENTRANCE ()    ;"EXIT-FCN"
	 <COND (<NOT <FSET? ,HATCH ,OPENBIT>>
		<TELL CTHE ,HATCH ,IS-CLOSED ,PCR>
		<RFALSE>)
	       (<EQUAL? ,HERE ,MAIN-DECK>
		<TELL
"You glance around to see that no one is watching, and
duck through the open corner of" TR ,HATCH CR>
		<RETURN ,HOLD>)
	       (T
		<TELL "You slip lithely through" TR ,HATCH CR>
		<RETURN ,MAIN-DECK>)>>

<OBJECT RUM-BARREL
	(IN MAIN-DECK)
	(DESC "rum barrel")
	(SYNONYM BARREL CASK KEG STAINS)
	(ADJECTIVE RUM STAINED DARK)
	(FLAGS NDESCBIT CONTBIT SEARCHBIT OPENBIT)
	(GENERIC GEN-BARREL)
	(ACTION BARREL-F)>

<OBJECT RUM
	(IN RUM-BARREL)
	(DESC "rum")
	(SYNONYM RUM GROG)
	(FLAGS NDESCBIT)
	(ACTION RUM-F)>

<ROUTINE RUM-F ()
	 <COND (<VERB? PUT SOAK>
		<PERFORM ,V?PUT ,PRSO ,RUM-BARREL>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE LOOK-UNDER>
		<TELL "The rum is a dark brown color" ,PCR>)
	       (<VERB? REACH-IN>
		<TELL "Rum" ,DRIPS-OFF>)
	       (<VERB? DRINK ;TASTE>
		<TELL
"You take a sip and spit it out, coughing.
This is much stronger than ratafia!" CR>)>>

<OBJECT WATER-BARREL
	(IN MAIN-DECK)
	(DESC "water barrel")
	(SYNONYM BARREL CASK KEG)
	(ADJECTIVE FRESH WATER)
	(FLAGS NDESCBIT CONTBIT SEARCHBIT OPENBIT)
	(GENERIC GEN-BARREL)
	(ACTION BARREL-F)>

<ROUTINE GEN-BARREL ()
	 <COND (<VERB? EXAMINE>
		,WATER-BARREL)
	       (T
		<RFALSE>)>>

; "Routine for both water and rum barrels."

<ROUTINE BARREL-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<PRSO? ,WATER-BARREL>
		       <COND (<OR <ADJ-USED ,A?WATER>
				  <ADJ-USED ,A?FRESH>>
			      <TELL
"This large barrel is full of fresh water for the long sea voyage." CR>)
			     (T
			      <TELL
"The two open barrels contain rum and water, you can tell by the smell
of each. They are identical but for the dark stains around the
mouth of" TR ,RUM-BARREL>)>)
		      (<PRSO? ,RUM-BARREL>
		       <TELL
"Stained around the mouth by the spills of
over-eager sailors," T  ,RUM-BARREL " is nearly full." CR>)>)
	       (<VERB? DRINK-FROM>
		<COND (<PRSI? ,RUM-BARREL>
		       <PERFORM ,V?DRINK ,RUM>
		       <RTRUE>)
		      (<PRSI? ,WATER-BARREL>
		       <PERFORM ,V?DRINK ,WATER>
		       <RTRUE>)>)
	       (<VERB? ROLL PUSH PUSH-DIR>
		<COND (<EQUAL? ,P-PRSA-WORD ,W?TIP>
		       <TELL
"You notice a scrawl on the side, \"No tipping, please.\"" CR>)
		      (T
		       <TELL "The barrel is secured to the deck." CR>)>)
	       (<VERB? EMPTY EMPTY-FROM>
		<PROPOSE>)
	       (<VERB? REACH-IN>
		<COND (<PRSO? ,RUM-BARREL>
		       <TELL "Rum">)
		      (T
		       <TELL "Water">)>
		<TELL ,DRIPS-OFF>
		;<TELL
"Hesitant to wet your sleeve, you dip your fingers into" TR ,PRSO>)
	       (<VERB? CLOSE>
		<TELL "There is no lid." CR>)
	       (<VERB? PUT SOAK>
		<COND ;(<PRSO? ,HOOPS>
		       <RFALSE>)
		      (<PRSO? ,LAUD>
		       <TELL
"The few drops left would be too diluted to affect anyone." CR>)
		      (<NOT <FSET? ,PRSI ,OPENBIT>>
		       <TELL CTHE ,PRSI ,IS-CLOSED ,PCR>)
		      (<PRSO? ,INVITE ,LETTER>
		       <PERFORM ,V?PUT ,PRSO ,SEA>
		       <RTRUE>)
		      (<PRSO? ,DRESS ,RAG>
		       <DIP-DRESS>)
		      (T
		       <REMOVE ,PRSO>
		       <TELL
"You drop" T ,PRSO " into" T ,PRSI ". It sinks from sight" ,PCR>)>)
	       (<VERB? DRINK>
		<COND (<ZERO? <GET ,P-NAMW 0>>
		       <COND (<ADJ-USED ,A?WATER>
			      <PERFORM ,V?DRINK ,WATER>
			      <RTRUE>)
			     (<ADJ-USED ,A?RUM>
			      <PERFORM ,V?DRINK ,RUM>
			      <RTRUE>)>)
		      (T
		       <RFALSE>)>)>>

;<ROUTINE ;DIP-DRESS ()
	 <COND (<OR <AND ,WET-DRESS
			 <PRSO? ,DRESS>>
		    <AND ,WET-RAG
			 <PRSO? ,RAG>>>
		<TELL "That's already wet enough.">)
	       (T
		<TELL "Keeping hold on" T ,PRSO ", you soak it with ">
		<COND (<PRSI? ,RUM-BARREL>
		       <TELL "rum.">
		       <COND (<PRSO? ,DRESS>
			      <MOVE ,DRESS <LOC ,PROTAGONIST>>
			      <TELL
" It becomes so heavy, however, that you drop it."> 
			      <PUTP ,DRESS ,P?SIZE 10>
			      <SETG WET-DRESS ,RUM>)
			     (<PRSO? ,RAG>
			      ;<PUTP ,RAG ,P?SIZE 3>
			      <SETG WET-RAG ,RUM>)>
		       ;<TELL "rum.">)
		      (T
		       <COND (<PRSO? ,DRESS>
			      <PUTP ,DRESS ,P?SIZE 10>
			      <TELL
" It becomes so heavy, however, that you drop it.">
			      <SETG WET-DRESS ,SEA>)
			     (<PRSO? ,RAG>
			      <SETG WET-RAG ,SEA>)>
		       <TELL "water.">)>)>
	 <CRLF>>

<ROUTINE DIP-DRESS ("AUX" (LIQUID <>))
	 <COND (<NOT ,PRSI>
		<V-SOAK>
		<RTRUE>)
	       (<PRSI? ,RUM ,RUM-BARREL>
		<SET LIQUID ,RUM>)
	       (<OR <PRSI? ,SEA ,WATER ,WATER-BARREL ,POOL>
		    <EQUAL? ,HERE ,BY-SHIP ,LAGOON ,SHALLOWS ,BEACH>>
		<SET LIQUID ,WATER>)
	       (T
		<IMPOSSIBLES>)>
	 <COND (<OR <AND ,WET-DRESS
			 <PRSO? ,DRESS>>
		    <AND ,WET-RAG
			 <PRSO? ,RAG>>>
		<TELL "That's already wet enough." CR>
		<RTRUE>)>
	 <TELL "Keeping hold on" T ,PRSO ", you soak it with ">
	 <COND (<PRSO? ,DRESS>
		<MOVE ,DRESS <LOC ,PROTAGONIST>>
		<PUTP ,DRESS ,P?SIZE 10>
		<SETG WET-DRESS .LIQUID>
		<TELL D .LIQUID
". It becomes so heavy, however, that you drop it, with a loud squelch">)
	       (<PRSO? ,RAG>
		;<PUTP ,RAG ,P?SIZE 3>
		<SETG WET-RAG .LIQUID>
		<TELL D .LIQUID>)>
	 <TELL ,PCR>>

<ROOM FOCSLE
      (IN ROOMS)
      (DESC "Forecastle")
      (IN TO GALLEY)
      (UP PER CLIMBING)
      ;(UP PER CLIMBING-RIGGING)
      (DOWN "The grate is too small.")
      (NORTH PER BOWSPRIT-EXIT)
      (SOUTH TO MAIN-DECK)
      (EAST "You can't swim, and decide not to jump.")
      (WEST "You can't swim, and decide not to jump.")
      (GLOBAL CHAIN GRATE SEA RAILING RIGGING-OBJECT GALLEY-OBJECT)
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (ACTION FOCSLE-F)>

<ROUTINE FOCSLE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Higher than all but the poop deck, this end of the ship commands a good view
of the island; the \"crow's nest,\" swinging above in the heights of the
foremast, would command a better." ,TANGLED-RIGGING CR
"   Imbedded in the deck is a grated air hole to the crew's "
D ,OBJ-QUARTERS " below. You can go aft, or forward through a break in the
ubiquitous railing.|
   Odors of old grease and char waft from a little shack perched behind the
mast.">
		<I-LOOK-SEA <>>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <NOT ,BOY-DRESS?>>
		<SAILOR-DEATH>)>>

<OBJECT CHAIN
	(IN LOCAL-GLOBALS)
	(DESC "chain")
	(SYNONYM CHAIN)
	(ADJECTIVE ANCHOR)
	;(ACTION CHAIN-F)>

<OBJECT WINCH
	(IN FOCSLE)
	(DESC "mooring winch")
	(SYNONYM WINCH WINDLASS BARREL)
	(ADJECTIVE MOORING ANCHOR)
	(ACTION WINCH-F)>

<ROUTINE WINCH-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "Made of an old barrel turning on a pole," T
,WINCH " is used to coil in the anchor chain. A pair of metal teeth bite
the links to prevent it from dragging out; a lever is connected to the teeth.
Something is written on the lever" ,PCR>)
	       (<VERB? SET>
		<COND (<FSET? ,LEVER ,MUNGBIT>
		       <TELL
"The teeth are closed, so you can't move the chain" ,PCR>)
		      (T
		       <TELL ,NO-STRENGTH>)>)
	       (<VERB? OPEN CLOSE>
		<PROPOSE>)>>

<OBJECT LEVER
	(IN FOCSLE)
	(DESC "lever")
	(SYNONYM LEVER WRITING)
	(FLAGS NDESCBIT)
	(ACTION LEVER-F)>

<ROUTINE LEVER-F ()
	 <COND (<VERB? READ EXAMINE>
		<TELL
"On the lever is written \"Open Up, Close Down.\"
You notice the lever is pointed down." CR>)
	       (<VERB? RAISE>
		<COND (<FSET? ,ANCHOR ,MUNGBIT>
		       <SETG SCORE <+ ,SCORE 1>>
		       <FCLEAR ,ANCHOR ,MUNGBIT>
		       <REMOVE ,ANCHOR>
		       <DEQUEUE I-LOOK-SEA>
		       <QUEUE I-TIDES-TURN 3>
		       <TELL
"The metal teeth open as you raise up" T ,LEVER ". The anchor, released,
splashes down into the sea, dragging its clanking chain. After a moment,
you feel the ship pull slightly against the current. You lower the lever
to prevent any more chain from spooling out" ,PCR>)
		      (T
		       <TELL
"Raising" T ,LEVER " would release more chain and you might ">
		       <COND (<QUEUED? ,I-TIDES-TURN>
			      <TELL "cast" T ,SHIP " against the reefs!" CR>)
			     (T
			      <TELL "ground" TR ,SHIP>)>)>)
	       (<VERB? LOWER>
		<TELL ,ALREADY-IS>)
	       (<VERB? MOVE PUSH>
		<TELL
,YOULL-HAVE-TO "specify which way you want to move it" ,PCR>)>>

<ROUTINE I-TIDES-TURN ()
	 <TELL ,INDENT "With a heave and creak of timbers," T ,SHIP
" drifts a little way back towards the island. The tide has turned." CR>>

;<ROUTINE old-LEVER-F ()
	 <COND (<VERB? READ EXAMINE>
		<TELL
"On the lever is written \"Open Up, Close Down.\"
You notice the lever is pointed ">
		<COND (<FSET? ,LEVER ,MUNGBIT>
		       <TELL "down">)
		      (T
		       <TELL "up">)>
		<TELL ,PCR>)
	       (<VERB? RAISE>
		<COND (<FSET? ,LEVER ,MUNGBIT>
		       <FCLEAR ,LEVER ,MUNGBIT>
		       <TELL
"The metal teeth open as you raise up" T ,LEVER>
		       <COND (<FSET? ,ANCHOR ,MUNGBIT>
			      <SETG SCORE <+ ,SCORE 1>>
			      <FCLEAR ,ANCHOR ,MUNGBIT>
			      <REMOVE ,ANCHOR>
			      <DEQUEUE I-LOOK-SEA>
			      <TELL
". The anchor, released, splashes down into the sea, dragging its clanking
chain. After a second the chain slows, and you feel the ship pull slightly
against the current. You lower the lever to prevent any more chain from
spooling out">)>
		       <TELL ,PCR>)
		      (T
		       <TELL ,ALREADY-IS>)>)
	       (<VERB? LOWER>
		<COND (<FSET? ,LEVER ,MUNGBIT>
		       <TELL ,ALREADY-IS>)
		      (T
		       <FSET ,LEVER ,MUNGBIT>
		       <TELL
"The metal teeth close on the chain as you lower" TR ,LEVER>)>)
	       (<VERB? MOVE PUSH>
		<TELL
,YOULL-HAVE-TO "specify which way you want to move it" ,PCR>)>>

<ROOM GALLEY
      (IN ROOMS)
      (DESC "Galley")
      (LDESC
"This tiny kitchen smells of old stew and yeast.
A low door to starboard shows the way out.")
      (OUT TO FOCSLE)
      (EAST TO FOCSLE)
      (GLOBAL GALLEY-OBJECT FIRE)
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (ACTION GALLEY-F)>

<ROUTINE GALLEY-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <NOT <FSET? ,COOKIE ,TOUCHBIT>>>
		<FSET ,COOKIE ,TOUCHBIT>
		<TELL ,INDENT "The man looks you over sharply,">
		<COND (,BOY-DRESS?
		       <TELL
" then winks an eye. \"Hullo, boy -- Sam, I'll call you. N">)
		      (T
		       <TELL
"frowning. \"Tut, lass, you don't foller orders, do ye? 'Tain't safe to
go about dressed like that. Mayhap ye're n">)>
		<TELL
"ervous about Cap'n? He'll come to no harm. And if there is trouble, he only
has to signal from that seaward winder of the house -- ye can see it from the
crow's nest -- and we'll be there in a jiffy. Me and my peg are to stay
aboard and guard y">
		<COND (,BOY-DRESS?
		       <TELL "--, the Cap'n's">)
		      (T
		       <TELL "ou,">)>
		<TELL " young lady.\"" CR>)
	       (<EQUAL? .RARG ,M-ENTER>
		<THIS-IS-IT ,COOKIE>
		<THIS-IS-IT ,DAGGER>)>>

<OBJECT GALLEY-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "shack")
	(SYNONYM GALLEY HUT SHACK)
	(ADJECTIVE WOODEN)
	(FLAGS NDESCBIT CONTBIT OPENBIT)
	(ACTION GALLEY-OBJECT-F)>

<ROUTINE GALLEY-OBJECT-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "It's a tiny charred wooden shack" ,PCR>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<PERFORM-PRSA ,GALLEY>
		<RTRUE>)
	       (<VERB? ENTER>
		<GOTO ,GALLEY>)>>
<ROOM BOWSPRIT
      (IN ROOMS)
      (DESC "Bowsprit")
      (SOUTH TO FOCSLE)
      (NORTH "You can't swim, and decide not to jump.")
      (EAST "You can't swim, and decide not to jump.")
      (WEST "You can't swim, and decide not to jump.")
      (GLOBAL CHAIN SEA RAILING)
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (ACTION BOWSPRIT-F)>

<ROUTINE BOWSPRIT-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Hanging on the bowsprit, your arms and legs wrapped tightly around the
narrow spar, you can't see much beside an upside-down
view of the figurehead of the " D ,SHIP ", ">
		<COND (<FSET? ,ANCHOR ,MUNGBIT>
		       <TELL
"the barnacle encrusted main anchor dripping
from its chain, and the nauseous">)
		      (T
		       <TELL "and" T ,ANCHOR " chain descending into the">)>
		<TELL
" swelling and breaking waves over (under?) " D ,HEAD ".">)>>

<ROUTINE BOWSPRIT-EXIT ()
	 <COND (<EQUAL? ,HERE ,FOCSLE>
		<TELL "You">
		<COND (<ANYTHING-HELD>
		       <ROB ,PROTAGONIST ,HERE>
		       <TELL " drop all you are carrying and">)>
		<TELL " creep out over the waves" ,PCR CR>
		<RETURN ,BOWSPRIT>)
	       (T
		<TELL "You inch back down to" ,ELLIPSIS>
		<RETURN ,FOCSLE>)>>

<OBJECT STUB
	(IN BOWSPRIT)
	(DESC "stub of rope")
	(DESCFCN STUB-F)
	(SYNONYM ROPE HAWSER)
	(ADJECTIVE STUB)
	(FLAGS TRYTAKEBIT)
	(ACTION STUB-F)> 

<ROUTINE STUB-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-DESC?>
		       <RTRUE>)>
		<TELL ,INDENT
"A " D ,STUB ", roughly cut, swings rudely over the waves.">
		<COND (<FSET? ,ANCHOR ,MUNGBIT>
		       <TELL 
" The line holding the sea anchor has been cut!">)
		      (T
		       <RTRUE>)>)
	       (<TOUCHING? ,STUB>
		<TELL ,YOU-CANT "quite reach it." CR>)>> 
		      
<OBJECT ANCHOR
	(IN BOWSPRIT)
	(DESC "anchor")
	(SYNONYM ANCHOR)
	(FLAGS VOWELBIT NDESCBIT)
	(ACTION ANCHOR-F)>

<ROUTINE ANCHOR-F ()
	 <COND (<VERB? RAISE>
		<TELL ,NO-STRENGTH>)>>

<ROOM RIGGING-ROOM
      (IN ROOMS)
      (DESC "In the Rigging")
      (DOWN PER CLIMBING)
      (UP PER CLIMBING)
      (GLOBAL RIGGING-OBJECT SEA LADDER)
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (ACTION RIGGING-ROOM-F)>

<ROUTINE RIGGING-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The deck swings far below as you cling to" T ,RIGGING-OBJECT " in the wind."
,TANGLED-RIGGING>
		<COND (<EQUAL? ,WHICH-MAST? ,FOCSLE>
		       <TELL
" Farther up" T ,RIGGING-OBJECT " is a small platform.">)
		      (T
		       <RTRUE>)>)>>

<OBJECT RIGGING-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "rigging")
	(SYNONYM RIGGING MAST MAINMA FOREMA)
	(ADJECTIVE TANGLED)
	(FLAGS TRYTAKEBIT TRANSBIT OPENBIT SEARCHBIT CONTBIT)
	(ACTION RIGGING-OBJECT-F)>

<ROUTINE RIGGING-OBJECT-F ()
	 <COND (<VERB? TAKE>
		<TELL "The only thing rigging is good for is climbing." CR>)
	       (<VERB? CLIMB ;CLIMB-UP>
		<DO-WALK ,P?UP>
		<RTRUE>)
	       (<VERB? CLIMB-DOWN>
		<DO-WALK ,P?DOWN>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"The mast stands tall and powerful, shrouded in" TR ,RIGGING-OBJECT>)>> 

<GLOBAL WHICH-MAST? <>>

;<ROUTINE ;CLIMBING-RIGGING ()             ;"This is an EXIT-FCN"
	 <COND (<OR <FSET? ,DRESS ,WORNBIT>
		    <FSET? ,HOOPS ,WORNBIT>>
		<SETG AWAITING-REPLY 2>
		<QUEUE I-REPLY 2>
		<TELL "Don't be absurd: in these clothes?" CR>
		<RFALSE>)
	       (<EQUAL? ,P-WALK-DIR ,P?UP>
		<COND (<NOT <EQUAL? ,RIGGING-ROOM ,HERE>>
		       <SETG WHICH-MAST? ,HERE>
		       <COND (<EQUAL? <LOC ,DAGGER> ,PROTAGONIST>
			      <TELL 
"You bite down on" T ,DAGGER ", freeing " D ,HANDS "s to climb.
When you stop, you take it back again. ">)>
		       <TELL
"The wind, a mere breeze on the deck, blows more fiercely." CR CR>
		       <RETURN ,RIGGING-ROOM>)
		      (T
		       <COND (<EQUAL? ,WHICH-MAST? ,FOCSLE>
			      <TELL "You clamber up" TR ,RIGGING-OBJECT CR> 
			      <RETURN ,CROWS-NEST>)
			     (T
			      <TELL "Above you there appears to be only more
of the same, except higher, and you can not vouch for the effects on your
stomach" ,PCR>
			      <RFALSE>)>)>)
	       (<EQUAL? ,P-WALK-DIR ,P?DOWN>
		<TELL
"You climb quickly, practically falling, down to the deck" ,PCR CR>
		<RETURN ,WHICH-MAST?>)>>

<ROOM CROWS-NEST
      (IN ROOMS)
      (DESC "Crow's Nest")
      (LDESC
"You perch on a platform high above the deck, giving a view of the endless
sea and the southernmost cliffs of the island, where a house pokes out of
the vegetation. It gives off a general glow, but no lights can be seen in
any of the second story windows.
A tiny beach nestles into the base of the cliff.")
      (DOWN TO RIGGING-ROOM)
      (UP "Don't push your luck too far.")
      (GLOBAL RIGGING-OBJECT SEA)
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      ;(ACTION CROWS-NEST-F)>


;"I axed the object"
;<ROUTINE SPYGLASS-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,CROWS-NEST ,FOCSLE ,BOWSPRIT>
		       <TELL "You take a sweeping pan of the horizon through
the " D ,SPYGLASS ". The sea off the port side of the ship is made no clearer
by the instrument, and the moon only brighter. But as you gaze westward to
the island, you notice a flutter on the cliff face, something white and soft
against the gray rock, apparently stuck into one of the large cracks
decorating the crag" ,PCR>)
		      (T
		       <TELL "Everything looks closer" ,PCR>)>)>> 

;"If player hasn't gotten out by now, kill him/her off. On 25th move."
;<ROUTINE I-JIGS-UP-SNAFU ()    
	 <COND (<EQUAL? ,HERE ,CABIN>
		<QUEUE I-END-PROLOGUE 2>
		<JIGS-UP
"As the fires increase, so does the smoke. You pass out before you discover
your fate -- death by looting pirates or smoke inhalation. In both cases,
however, death is still death.">)
	       (T <RFALSE>)>>

<ROUTINE I-PIRATE-ATTACK ()
	 <COND (<PROB 40>
		<TELL ,INDENT <PICK-ONE ,PIRATE-NOISES> ,PCR>)>
	 <RFALSE>>	 

<GLOBAL PIRATE-NOISES
	<LTABLE
	 0
	 "\"Aaieeee!\" echoes a scream, followed by several grunts and thumps"
	 "\"Cap'n Jamison! We've got 'em!\" cries a rough voice"
	 "\"The Falcon! The Falcon conquers!\" yells someone"
	 "With a creak and a crash, somewhere a mast falls to the deck"
	 "You recognize a voice from far away, \"Don't take that! Look in the
cabin at the stern -- you'll find some fun there!\" It sounds like Davis"
	 ;"In a brief, unexpected silence, the sigh of some distant fire claws
at your stomach"
	 ;"All is illuminated for a sharp moment as a jagged bolt of
lightning cracks against the sea nearby"
	 ;"A cannon exploding on the pirate ship is echoed by a huge clap
of thunder"
	 ;"The wind howls and roars about like some fearsome cyclone"
	 ;"\"To the hold! To the hold! Free the slaves!\" Voices take up
the chant">>

<GLOBAL SKIFF-LOC 5>
<GLOBAL SHIP-LOC 5>
<GLOBAL CASK-LOC 10>

<ROUTINE I-LOOK-SEA ("OPTIONAL" (CALLED-BY-INTERRUPT T) "AUX" CANT-SEE-REEFS)
	 <COND (<INNER-DECK ,HERE>
		;<TELL CR
"[You are now one room closer to the reefs, and would get this desc. on deck:"
CR <GET ,REEF-DESC ,SHIP-LOC> ". Is this advancing every 15 moves, despite
where you look or are, etc? BUG #107. Please investigate and report.]" CR>
		<SET CANT-SEE-REEFS T>)>
	 <COND (.CALLED-BY-INTERRUPT
		<QUEUE I-LOOK-SEA 15>
		<SETG SHIP-LOC <+ ,SHIP-LOC 1>>
		<COND (<EQUAL? ,SHIP-LOC 10>
		       <TELL ,INDENT <GET ,REEF-DESC ,SHIP-LOC>>
		       <FWTD
". The next few minutes last forever as havoc breaks out. Grabbing a
plank, you manage to stay afloat, but you are washed out to sea. A
brig, Portuguese by its sails, rescues you. The sailors are brown skinned
and smooth, and the first mate, the ship's and yours, is gentle.
They leave you in Rio, alone and forgotten.">)
		      (.CANT-SEE-REEFS
		       <COND (<EQUAL? ,SHIP-LOC 8>
			      <TELL ,INDENT
"The crash of surf is increasing in volume.
You'd best find out what's going on!" CR>)
			     (T
			      <RFALSE>)>)
		      (T
		       <TELL ,INDENT <GET ,REEF-DESC ,SHIP-LOC> ,PCR>)>)
	       (<NOT <FSET? ,ANCHOR ,MUNGBIT>>
		<RTRUE>)
	       (<RUNNING? ,I-LOOK-SEA>   ;  "So it won't desc." 
		<QUEUE I-LOOK-SEA 2>    ;"more than once a turn" 
		<I-LOOK-SEA <>>)       ;"but it will advance next turn!"
	       (T
		<TELL CR ,INDENT <GET ,REEF-DESC ,SHIP-LOC> ".">)>>


<GLOBAL REEF-DESC
	<TABLE
	 0
	 0
	 0
	 0
	 0
	 "The ship is floating midway between the island and a line of reefs"
	 "The reefs seem a little larger than you thought before"
	 "The reefs are definitely getting larger"
	 "Bswish! Waves smash against the reefs nearby"
	 "You are misted in the spray of waves hitting the reefs. The island
is far away"
	 "The sound of splintering wood reverberates through the ship as it
drifts onto the reefs">>

<CONSTANT ROWWEST -3>
<CONSTANT ROWEAST 2>
<GLOBAL LOOKED-LAGOON? <>>
<GLOBAL ROWING 0>

<ROUTINE I-CURRENT ("AUX" (VENUE 0))    ;"Venue =  Cask-loc or Skiff-loc"
	 <SET VENUE <COND (<IN? ,PROTAGONIST ,CASK>
			   <+ ,CASK-LOC ,ROWING>)
			  (<IN? ,PROTAGONIST ,SKIFF>
			   <+ ,SKIFF-LOC ,ROWING>)>>
	 <COND (<EQUAL? ,ROWING -1>
		<TELL ,INDENT
"The current pulls you in towards the island.">
		<COND (<EQUAL? ,HERE ,BY-SHIP>
		       <CRLF> <CRLF>
		       <MOVE ,SKIFF ,LAGOON>
		       <GOTO ,SKIFF>
		       <V-LOOK>)
		      (<AND <L? .VENUE 2>
			    <NOT <EQUAL? ,HERE ,SHALLOWS>>>
		       <SET VENUE 1>
		       <DEQUEUE I-CURRENT>
		       <TELL
" With a scrape," T <LOC ,PROTAGONIST> " lodges in the sand" ,PCR CR>
		       <COND (<IN? ,PROTAGONIST ,CASK>
			      <MOVE ,CASK ,SHALLOWS>
			      <GOTO ,CASK>)
			     (<IN? ,PROTAGONIST ,SKIFF>
			      <MOVE ,SKIFF ,SHALLOWS>
			      <GOTO ,SKIFF>)>)
		      (<EQUAL? ,HERE ,LAGOON>
		       <CRLF>
		       <COND (<NOT ,LOOKED-LAGOON?>
			      <V-LOOK>)
			     (T
			      <SETG LOOKED-LAGOON? <>>)>)   ;"added 23.6.87"
		      (T
		       <RTRUE>)>)>
	 <SETG ROWING -1>
	 <COND (<IN? ,PROTAGONIST ,CASK>
		<SETG CASK-LOC .VENUE>)
	       (<IN? ,PROTAGONIST ,SKIFF>
		<SETG SKIFF-LOC .VENUE>)>
	 <RTRUE>>

;<ROUTINE ;I-CURRENT ("AUX" (VENUE 0))    ;"Venue =  Cask-loc or Skiff-loc"
	 <SET VENUE <COND (<IN? ,PROTAGONIST ,CASK>
			   <+ ,CASK-LOC ,ROWING>)
			  (<IN? ,PROTAGONIST ,SKIFF>
			   <+ ,SKIFF-LOC ,ROWING>)>>
	 <COND ;(<AND <EQUAL? ,CASK-LOC <- ,SHIP-LOC 1>>
		     <IN? ,PROTAGONIST ,CASK>>       ;"first turn: KLUDGE"
		<RTRUE>)
	       (<EQUAL? ,ROWING -1>
		<TELL ,INDENT
"The current pulls you in towards the island.">
		<COND (<EQUAL? ,HERE ,BY-SHIP>   ;"you can't be there except"
		       <CRLF> <CRLF>                ;"in the skiff"
		       <MOVE ,SKIFF ,LAGOON>
		       <GOTO ,SKIFF>)
		      (<AND <L? .VENUE 2>
			    <NOT <EQUAL? ,HERE ,SHALLOWS>>>
		       <SET VENUE 1>
		       <DEQUEUE I-CURRENT>
		       <TELL
" With a scrape," T <LOC ,PROTAGONIST> " lodges in the sand" ,PCR CR>  
		       <COND (<IN? ,PROTAGONIST ,CASK>
			      <MOVE ,CASK ,SHALLOWS>
			      <GOTO ,CASK>)
			     (<IN? ,PROTAGONIST ,SKIFF>
			      <MOVE ,SKIFF ,SHALLOWS>
			      <GOTO ,SKIFF>)>)
		      (T
		       <CRLF>)>)>
	 <SETG ROWING -1>
	 ;<COND ;(<OR <EQUAL? .VENUE ,SHIP-LOC>
		    <G? .VENUE ,SHIP-LOC>>     ;"in case rower overshoots"
		<MOVE ,SKIFF ,BY-SHIP>         ;"the mark."
		<CRLF>
		<CRLF>
		<GOTO ,SKIFF>)
	       ;(<AND <L? .VENUE 2>
		     <NOT <EQUAL? ,HERE ,SHALLOWS>>>
		<SET VENUE 1>
		<DEQUEUE I-CURRENT>
		<COND (<IN? ,PROTAGONIST ,CASK>
		       <MOVE ,CASK ,SHALLOWS>
		       <TELL
" With a scrape," T ,CASK " lodges in the sand" ,PCR CR> 
		       <GOTO ,CASK>)
		      (<IN? ,PROTAGONIST ,SKIFF>
		       <MOVE ,SKIFF ,SHALLOWS>
		       <CRLF>
		       <CRLF>
		       <GOTO ,SKIFF>)>)
	       ;(<G? .VENUE 7>
		<TELL
,INDENT "Suddenly, the skiff takes off with a mind
of its own, pulling you out and beyond">
		<COND (<EQUAL? ,SHIP-LOC 8 9>
		       <TELL TR ,SHIP>)
		      (T
		       <TELL TR ,REEFS>)>)
	       ;(<AND <EQUAL? .VENUE 2 3>
		     <VERB? ROW>>
		<MOVE ,SKIFF ,LAGOON>
		<SETG HERE ,LAGOON>)   
		;(T
		<COND (<NOT <EQUAL? ,VERBOSITY 0>>
		       <V-LOOK>)>)>
	 <COND (<IN? ,PROTAGONIST ,CASK>
		<SETG CASK-LOC .VENUE>)
	       (<IN? ,PROTAGONIST ,SKIFF>
		<SETG SKIFF-LOC .VENUE>)>
	 <RTRUE>>

<OBJECT SKIFF
	(IN SHALLOWS)
	(DESC "skiff")
	(DESCFCN SKIFF-F)
	(SYNONYM SKIFF BOAT)
	(CAPACITY 50)
	(FLAGS TRANSBIT VEHBIT CONTBIT SEARCHBIT INBIT OPENBIT)
	(GENERIC GEN-BOAT)
	(ACTION SKIFF-F)>

<ROUTINE SKIFF-F ("OPTIONAL" (VARG <>) "AUX" (STR <>))
	 <COND (.VARG
		<COND (<EQUAL? .VARG ,M-DESC?>
		       <RTRUE>)
		      (<EQUAL? .VARG ,M-OBJDESC>
		       <TELL ,INDENT>
		       <COND (<FSET? ,SKIFF ,TOUCHBIT>
			      <TELL CTHE ,SKIFF>)
			     (T
			      <FSET ,SKIFF ,TOUCHBIT>
			      <TELL "A " D ,SKIFF>)>
		       <TELL
" nods in the waves, its oars jerking around in the current.">)
		      (T
		       <RFALSE>)>)
	       (<VERB? EXAMINE>
		<TELL CTHE ,SKIFF
" is large enough to carry several men, but light
enough that you feel able to row it" ,PCR>)
	       (<VERB? LOOK-INSIDE>
		<FCLEAR ,OARS ,NDESCBIT>
		<COND (<IN? ,PROTAGONIST ,SKIFF>
		       <DESCRIBE-VEHICLE>)
		      (T
		       <TELL "In" T ,SKIFF " is">
		       <DESCRIBE-CONTENTS ,SKIFF>
		       <TELL ,PCR>)>
		<FSET ,OARS ,NDESCBIT>)
	       (<OR <VERB? LAUNCH>
		    <AND <VERB? PUSH>
			 <PRSI? ,SEA>>>
		<TELL ,ALREADY-IS>)
	       (<VERB? TIE>
		<COND (<EQUAL? ,HERE ,BY-SHIP>
		       <DEBARK-SKIFF>)
		      (T
		       <TELL ,THERES-NOTHING "to moor it to!" CR>)>)
	       (<VERB? ROW>
		<COND (<EQUAL? <LOC ,PROTAGONIST> ,SKIFF>
		       <COND (<EQUAL? ,HERE ,BEACH>
			      <DO-FIRST "launch" ,SKIFF>)
			     (T
			      <TELL
 ,YOULL-HAVE-TO "specify a " D ,INTDIR ,PCR>)>)
		      (T
		       <DO-FIRST "get in" ,SKIFF>)>)
	       (<VERB? DISEMBARK>
		<COND (<EQUAL? ,HERE ,LAGOON>
		       <TELL ,TOO-DEEP>)
		      (<EQUAL? ,HERE ,BY-SHIP>
		       <DEBARK-SKIFF>)>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,SKIFF>>
		<PERFORM ,V?PUT ,PRSO ,SKIFF>
		<RTRUE>)>>

;<ROUTINE ;SKIFF-F ("OPTIONAL" (VARG <>) "AUX" (STR <>))
	 <COND (.VARG
		<COND (<EQUAL? .VARG ,M-DESC?>
		       <RTRUE>)
		      (<EQUAL? .VARG ,M-OBJDESC>
		       <TELL ,INDENT>
		       <COND (<EQUAL? ,HERE ,BEACH>
			      <TELL
"A " D ,SKIFF " is shoved into the sand.">)
			     (T
			      <TELL
CTHE ,SKIFF " nods in the waves,
its oars jerking around in the current.">)>)
		      (T
		       <RFALSE>)>)
	       (<VERB? EXAMINE>
		<TELL CTHE ,SKIFF
" is large enough to carry nine men, but light
enough that you feel able to row it" ,PCR>)
	       (<VERB? LOOK-INSIDE>
		<FCLEAR ,OARS ,NDESCBIT>
		<COND (<IN? ,PROTAGONIST ,SKIFF>
		       <DESCRIBE-VEHICLE>)
		      (T
		       <TELL "In" T ,SKIFF " is">
		       <DESCRIBE-CONTENTS ,SKIFF>
		       <TELL ,PCR>)>
		<FSET ,OARS ,NDESCBIT>)
	       (<OR <VERB? LAUNCH>
		    <AND <VERB? PUSH>
			 <PRSI? ,SEA>>>
		<COND (<EQUAL? ,HERE ,BEACH>
		       <MOVE ,SKIFF ,SHALLOWS>
		       <TELL
"You shove" T ,SKIFF " off the sand and jump into
the bow as it nods in the shallows" ,PCR CR>
		       <SETG SKIFF-LOC 1>
		       <GOTO ,SKIFF>
		       ;<I-CURRENT>)
		      (T
		       <TELL ,ALREADY-IS>)>)
	       (<VERB? TIE>
		<COND (<EQUAL? ,HERE ,BY-SHIP>
		       <DEBARK-SKIFF>)
		      (T
		       <TELL ,THERES-NOTHING "to moor it to!" CR>)>)
	       (<VERB? ROW>
		<COND (<EQUAL? <LOC ,PROTAGONIST> ,SKIFF>
		       <COND (<EQUAL? ,HERE ,BEACH>
			      <DO-FIRST "launch" ,SKIFF>)
			     (T
			      <TELL
 ,YOULL-HAVE-TO "specify a " D ,INTDIR ,PCR>)>)
		      (T
		       <TELL
"You need to be in" T ,SKIFF " to row it" ,PCR>)>)
	       (<VERB? DISEMBARK>
		<COND (<EQUAL? ,HERE ,LAGOON>
		       <TELL ,TOO-DEEP>)
		      (<EQUAL? ,HERE ,BY-SHIP>
		       <DEBARK-SKIFF>)>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,SKIFF>>
		<PERFORM ,V?PUT ,PRSO ,SKIFF>
		<RTRUE>)>>

<OBJECT OARS
	(IN SKIFF)
	(DESC "pair of oars")
	(SYNONYM OARS OAR OARLOCK)
	(ADJECTIVE METAL)
	(FLAGS TRYTAKEBIT PLURALBIT NDESCBIT)
	(ACTION OARS-F)>

<ROUTINE OARS-F ()
	 <COND (<VERB? TAKE REMOVE>
		<TELL
"They are fastened to" T ,SKIFF " with metal oarlocks" ,PCR>)>>

<ROUTINE DEBARK-SKIFF ()
	 <DEQUEUE I-CURRENT>
	 <SETG SKIFF-TIED T>
	 ;<COND (<ANYTHING-HELD>
		<ROB ,PROTAGONIST ,SKIFF>
		<TELL "Putting all you carry in" T ,SKIFF ", y">)
	       (T
		<TELL "Y">)>
	 <TELL
"You tie" T ,SKIFF " to the end of" T ,LADDER 
", then climb partway up it" ,PCR CR>
	 <MOVE ,PROTAGONIST ,HERE>    ;"Get player off skiff before moving it"
	 <MOVE ,SKIFF ,BY-SHIP>
	 <GOTO ,ON-LADDER>>

<ROOM BY-SHIP
      (IN ROOMS)
      (DESC "By the Ship")
      (UP PER CLIMBING)
      ;(UP PER CLIMBING-LADDER)
      (WEST PER FLOATING)
      (EAST "You'll have to row that way.")
      (NORTH "You'll have to row that way.")
      (SOUTH "You'll have to row that way.")
      (GLOBAL LADDER SEA PSEUD-SKIFF)
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (ACTION BY-SHIP-F)>

<ROUTINE BY-SHIP-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<MOVE ,PROTAGONIST ,SKIFF>)
	       (<EQUAL? .RARG ,M-LOOK>
		;<COND (<G? ,SHIP-LOC 8>
		       <TELL "Bug #119" CR>
		       <RTRUE>)>
		<TELL
"You are floating in a small skiff ">
		<COND (<AND <G? ,SHIP-LOC 4>
			    <L? ,SHIP-LOC 9>>
		       <TELL "at the stern of" T ,SHIP ", ">
		       <COND (<EQUAL? ,SHIP-LOC 7 8>
			      <TELL "at the far edge of">)
			     (<EQUAL? ,SHIP-LOC 5 6>
			      <TELL "in the middle of">)>)
		      (T
		       <TELL "in">)>
		<TELL " the lagoon.">
		<COND (,LADDER-HANGING
		       <TELL
" A rope ladder, frayed ends dripping water,
hangs down from the poop deck." >)
		      (T
		       <RTRUE>)>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <NOT <RUNNING? ,I-CURRENT>>>
		<SETG ROWING 0>
		<QUEUE I-CURRENT -1>)>>

<ROOM LAGOON
      (IN ROOMS)
      (DESC "Lagoon")
      (WEST PER FLOATING)
      (EAST "You'll have to row that way.")
      (NORTH "You'll have to row that way.")
      (SOUTH "You'll have to row that way.")
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (GLOBAL SEA DEBRIS)
      (ACTION LAGOON-F)>

<ROUTINE LAGOON-F (RARG "AUX" (VENUE <>))
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are "> 
		<SET VENUE <COND (<EQUAL? <LOC ,PROTAGONIST> ,CASK>
				  <TELL "crouched in a cask">
				  ,CASK-LOC)
				 (T
				  <TELL "sitting in a skiff">
				  ,SKIFF-LOC)>>
		<TELL " on the lagoon of " D ,ISLAND>
		<COND (<L? <- ,SHIP-LOC .VENUE> 2>
		       <TELL ". You are quite near">
		       <COND (<FSET? ,SHIP ,MUNGBIT>
			      <TELL T ,REEFS>)
			     (T
			      <TELL T ,SHIP>)>)
		      (<L? <- 10 .VENUE> 5>
		       <TELL
". The crash of surf hitting" T ,REEFS " is quite loud">)
		      (<L? .VENUE 3>
		       <TELL
". Music floats down to the water,
mingling with the distant roar of the sea">) 
		      (T
		       <TELL
". The jungle looms gray-green in the light of the full moon">)>
		<TELL ".">)
	       (<AND <EQUAL? .RARG ,M-END>
		     <NOT <VERB? LOOK>>
		     ;<NOT <EQUAL? ,VERBOSITY 0>>>
		<SETG LOOKED-LAGOON? T>
		<RFALSE>)>>

<OBJECT STONE                    ;"TRYTAKEBIT = unreachable after slinged"
	(DESC "stone")
	(SYNONYM STONE ROCK)
	(ADJECTIVE POINTED SHARP)
	(FLAGS TAKEBIT)
	(SIZE 1)
	(ACTION STONE-F)>

<ROUTINE STONE-F ()
	 <COND (<VERB? SHOOT>
		<COND (<NOT ,PRSI>
		       <REMOVE ,STONE> 
		       <TELL
CTHE ,STONE ", unaimed, flies into the air, arcing up and into the sea" ,PCR>)
		      (<PRSO? ,GARTER>
		       <WASTES>)
		      (<L? <GETP ,PRSO ,P?SIZE> 5>
		       <TELL
"You don't trust your aim to hit something that small" ,PCR>)
		      (<NOT <IN? ,STONE ,GARTER>>
		       <TELL
,YOULL-HAVE-TO "put" T ,STONE " into" TR ,GARTER>)
		      (T
		       <COND (<FSET? ,PRSO ,DEADBIT>
			      <MAN-IS-DOWN>)
			     (<PRSO? ,ME>
			      <TELL ,SUICIDE>)
			     (<PRSO? ,LUCY>
			      <TELL ,UNLADY>)
			     (<PRSO? ,PISTOL>
			      <PERFORM-PRSA ,CRULLEY ,PRSI>
			      <RTRUE>)
			     (<PRSO? ,SHIP ,HOUSE>
			      <TELL "That is too far away." CR>)
			     (<PRSO? ,HERO>
			      <MOVE ,GARTER ,HERE>
			      <TELL
"You falter, dropping the makeshift sling. Your heart rules too well" ,PCR>)
			     (T
			      <TELL
"You pull" T ,GARTER " taut, aim, and let fly" T ,STONE ". ">
			      <FSET ,STONE ,TRYTAKEBIT>
			      <MOVE ,STONE ,HERE>
			      <COND (<OR <AND <PRSO? ,LAFOND>
					      <L? ,LAFOND-CTR ,FIGHTING>>
					 <AND <PRSO? ,CRULLEY>
					      <L? ,LAFOND-CTR ,DEAD>>>
				     <TELL
"It clatters onto the rocks, short of the mark" ,PCR>)

                            ;"Dad, Crull, Laf only"

				    (<FSET? ,PRSO ,ACTORBIT>
				     <TELL
CR ,INDENT "He ducks as it whirs past his ear">
				     <COND (<PRSO? ,CRULLEY>
					    ;<FSET ,CRULLEY ,DEADBIT>
                    ;"need for check"       <FSET ,DAD ,DEADBIT>
					    <SETG SCORE <+ ,SCORE 1>>
					    <TELL
". Papa, creeping unnoticed up the stairs, leaps and wrests the gun from
his grip, toppling all three, father, pirate and gun, off the cliff. Lucy
screams as the struggling pair fall to the rocks below.|
   You run to Nicholas. You have lost" T ,DAD ", but Nicholas's embrace
remains, comforting, shielding, a world of love" ,PCR>
					    
;"With a quiet thud, it hits D ,PRSI square between the eyes.
He crumples to the ground"
					    <FINALE>)
					   (T
					    <TELL
" to disappear with a quiet thud into the sand">
					    <COND (<PRSO? ,DAD>
						   <TELL
". He looks a bit surprised, but nods encouragingly">)>
					    <TELL ,PCR>)>)
				    (T
				     <TELL "It bounces off" TR ,PRSO>)>)>)>)
	       (<AND <VERB? TAKE>
		     <FSET? ,STONE ,TRYTAKEBIT>>
		<CANT-REACH ,STONE>)
	       (<AND <VERB? THROW THROW-AT>
		     <PRSO? ,STONE>>
		<COND (<NOT ,PRSI>
		       <PERFORM ,V?SHOOT ,STONE>
		       <RTRUE>)
		      (<HELD? ,PRSI>
		       <WASTES>)
		      (T
		       <COND (<FSET? ,PRSI ,DEADBIT>
			      <MAN-IS-DOWN>
			      <RTRUE>)>
		       <MOVE ,STONE ,HERE>
		       <TELL
"You hurl" T ,STONE ", but it falls far short of" TR ,PRSI>)>)
	       (<VERB? KILL>
		<COND (<NOT <IN? ,STONE ,GARTER>>
		       <PROPOSE>)
		      (T
		       <PERFORM ,V?SHOOT ,PRSO ,STONE>
		       <RTRUE>)>)
	       (<VERB? EXAMINE>
		<TELL "It is a pretty little stone" ,PCR>)>>

<ROOM SHALLOWS
      (IN ROOMS)
      (DESC "Shallows")
      (EAST PER FLOATING)
      (WEST PER FLOATING)
      (SYNONYM SHALLOWS)
      (NORTH "You stop at a steep cliff-face.")
      (SOUTH "You stop at a steep cliff-face.")
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (GLOBAL SEA ;PSEUD-SKIFF DEBRIS)
      (ACTION SHALLOWS-F)>

<ROUTINE SHALLOWS-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are ">
		<COND (<EQUAL? <LOC ,PROTAGONIST> ,HERE>
		       <COND (,BOY-DRESS?
			      <TELL "soaking your shoes and stockings in">)
			     (<NOT <FSET? ,CHEMISE ,EVERYBIT>>
			      <TELL "soaking the hem of your chemise in">)
			     (T
			      <TELL "holding your skirts high over">)>)
		      (T
		       <COND (<EQUAL? <LOC ,PROTAGONIST> ,CASK>
			      <TELL "crouched in" T ,CASK>)
			     (T
			      <TELL "sitting in" T ,SKIFF>)>
		       <TELL " in">)>
		<TELL
" the warm, lapping waves of the shallows.
A white sand beach is west of you.">)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <VERB? SHOOT SSHOOT>
		     <OR <NOT <EQUAL? <META-LOC ,PRSO> ,HERE ,GLOBAL-OBJECTS>>
			 <NOT <EQUAL? <META-LOC ,PRSI>
				      ,HERE ,GLOBAL-OBJECTS>>>>
		<TELL
"Your aim is too unsure from this distance. Go to the beach." CR>)>>

<ROUTINE FLOATING ()                               ;"EXIT-FCN"
	 <COND (<EQUAL? ,HERE ,SHALLOWS>
		<COND (<IN? ,PROTAGONIST ,SKIFF>
		       <COND (<EQUAL? ,P-WALK-DIR ,P?WEST>
			      <DO-FIRST "get out of" ,SKIFF>
			      <RFALSE>)
			     (<EQUAL? ,P-WALK-DIR ,P?EAST>
			      <TELL ,YOULL-HAVE-TO "row that way" ,PCR>
			      <RFALSE>)>)
		      (T
		       <COND (<EQUAL? ,P-WALK-DIR ,P?WEST>
			      <RETURN ,BEACH>)
			     (T
			      <TELL
"You wade in the shallow water, unable to swim" ,PCR>
			      <RFALSE>)>)>)
	       (<EQUAL? ,P-WALK-DIR ,P?WEST>
		<TELL "You're going that way anyway" ,PCR>
		<RFALSE>)
	       (T
		<TELL ,YOULL-HAVE-TO "row that way" ,PCR>
		<RFALSE>)>>

<OBJECT REEFS
	(IN GLOBAL-OBJECTS)
	(DESC "reefs")
	(SYNONYM REEFS REEF)
	(ACTION REEFS-F)>

<ROUTINE REEFS-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<INNER-DECK ,HERE>
		       <TELL ,YOU-CANT-SEE-ANY D ,REEFS " from here" ,PCR>)
		      (T
		       <TELL
"A line of reefs separates the lagoon from the sea beyond" ,PCR>)>)>> 
 
;<TELL "[You're in Room #" N .VENUE ".]" CR CR>