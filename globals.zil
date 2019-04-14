"GLOBALS for
		      PLUNDERED HEARTS
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<DIRECTIONS ;"Do not change the order of the first 8 without consulting MARC!"
 	    NORTH NE EAST SE SOUTH SW WEST NW UP DOWN IN OUT>

;<ADJ-SYNONYM LARGE LARGER HUGE HUGER BIG BIGGER GIANT GIGANTIC TREMENDOUS
	     MIGHTY MIGHTIER MASSIVE>

;<ADJ-SYNONYM WIDE BROAD>

;<ADJ-SYNONYM SMALL SMALLER TINY TINIER LITTLE PETITE TEENSY WEENSY>

;<ADJ-SYNONYM MY MINE>

<GLOBAL LIT T>

;<GLOBAL RANK 0>

<GLOBAL MOVES 0>

<GLOBAL SCORE 0>

<GLOBAL HERE:OBJECT FRONTISPIECE ;CABIN>

;"INBIT = set on object/vehicle one gets into."
<OBJECT GLOBAL-OBJECTS
	(SYNONYM ZZMGCK) ;"No, this synonym doesn't need to exist... sigh"
	(DESC "it")
	(FLAGS INVISIBLE TOUCHBIT SURFACEBIT TRYTAKEBIT OPENBIT SEARCHBIT
	       TRANSBIT WEARBIT WORNBIT MUNGBIT ONBIT LIGHTBIT RLANDBIT
	       VEHBIT INDOORSBIT CONTBIT VOWELBIT LOCKEDBIT NDESCBIT DOORBIT
	       ACTORBIT ;BURNBIT INBIT FEMALEBIT EVERYBIT DEADBIT)>

;<BIT-SYNONYM EVERYBIT ;RESCUEBIT ;TIEDBIT>

<OBJECT LOCAL-GLOBALS
	(IN GLOBAL-OBJECTS)
	(DESC "it")
	(SYNONYM ZZMGCK) ;"Yes, this synonym needs to exist... sigh"
	;(DESCFCN 0)
        ;(GLOBAL GLOBAL-OBJECTS)
	;(FDESC "F")
	;(LDESC "F")
	;(SIZE 0)
	;(TEXT "")
	;(CAPACITY 0)
	;(THINGS <PSEUDO (ZZMGCK ZZMGCK ME-F)>)>

<OBJECT ROOMS
	(IN TO ROOMS)
	(DESC "it")>

<GLOBAL DIPPING-OARS
"You dip the oars and pull them towards you. The ">

<OBJECT INTDIR
	(IN GLOBAL-OBJECTS)
	(DESC "direction")
	(SYNONYM DIRECT)
	(ADJECTIVE NORTH SOUTH EAST WEST NW NE SW SE)
	(ACTION INTDIR-F)>

<ROUTINE INTDIR-F ()
	 <COND (<AND <VERB? ROW-DIR ROW ROW-TO>
		     <IN? ,PROTAGONIST ,SKIFF>>
		<COND (<EQUAL? ,P-DIRECTION ,P?EAST>
		       <COND (<EQUAL? ,HERE ,BY-SHIP>
			      <TELL
"That would take you past" T ,SHIP " into the open sea!" CR>
			      <RTRUE>)>
		       <SETG ROWING ,ROWEAST>
		       <TELL
,DIPPING-OARS D ,SKIFF " plows through the lagoon.">
		       <COND (<EQUAL? ,HERE ,SHALLOWS>
			      <QUEUE I-CURRENT -1>
			      <SETG ROWING 1>    ;"Kludge for SHALLOWS/EAST"
			      <MOVE ,SKIFF ,LAGOON>
			      <CRLF>
			      <GOTO ,SKIFF>)
			     (<EQUAL? <+ ,SKIFF-LOC ,ROWING> 
				      ,SHIP-LOC <+ ,SHIP-LOC 1>>
			      <COND (<FSET? ,SHIP ,MUNGBIT>
				     <JIGS-UP
" Suddenly, an offshore current pulls you past the reefs into the open sea.
You haven't the strength to row back.">)
				    (T
				     <TELL
" You glide into the shadow of" TR ,SHIP CR>
				     <SETG SKIFF-LOC ,SHIP-LOC>
				     <SETG ROWING 0>
				     <MOVE ,SKIFF ,BY-SHIP>
				     <GOTO ,SKIFF>)>)
			     (T
			      <CRLF>)>)
		      (<EQUAL? ,P-DIRECTION ,P?WEST>
		       <SETG ROWING ,ROWWEST>
		       <COND (<EQUAL? ,HERE ,SHALLOWS>
			      <TELL
"You can row" T ,SKIFF " no farther west" ,PCR>)
			     (<L? <+ ,SKIFF-LOC ,ROWING> 2>
			      <TELL ,DIPPING-OARS D ,SKIFF
" noses into the sand of the shallows. You get out" ,PCR CR>
			      <DEQUEUE I-CURRENT>
			      <SETG SKIFF-LOC 1>
			      <MOVE ,SKIFF ,SHALLOWS>
			      <GOTO ,SHALLOWS>)
			     (T
			      <TELL
,DIPPING-OARS D ,SKIFF " shoots over the waves" ,PCR>
			      <COND (<EQUAL? ,HERE ,BY-SHIP>
				     <MOVE ,SKIFF ,LAGOON>
				     <GOTO ,SKIFF>)>)>
		       <RTRUE>)
		      (<OR <EQUAL? ,P-DIRECTION ,P?NORTH ,P?NW ,P?NE>
			   <EQUAL? ,P-DIRECTION ,P?SOUTH ,P?SW ,P?SE>>
		       <TELL
"You can barely row back and forth, much less side to side!" CR>)>)>>

;<ROUTINE ;INTDIR-F ()
	 <COND (<AND <VERB? ROW-DIR ROW>
		     <IN? ,PROTAGONIST ,SKIFF>>
		<COND (<EQUAL? ,HERE ,BEACH>
		       <DO-FIRST "launch" ,SKIFF>)
		      (<EQUAL? ,P-DIRECTION ,P?EAST>
		       <COND (<EQUAL? ,HERE ,BY-SHIP>
			      <TELL
"That would take you past" T ,SHIP " into the open sea!" CR>
			      <RTRUE>)>
		       <SETG ROWING ,ROWEAST>
		       <TELL
,DIPPING-OARS D ,SKIFF " plows through the lagoon.">
		       <COND (<EQUAL? ,HERE ,SHALLOWS>
			      <QUEUE I-CURRENT 2>
			      <MOVE ,SKIFF ,LAGOON>
			      <SETG ROWING 1>
			      <CRLF> <CRLF>
			      <GOTO ,SKIFF>)
			     (<EQUAL? <+ ,SKIFF-LOC ,ROWING> ,SHIP-LOC>
			      <COND (<FSET? ,SHIP ,MUNGBIT>
				     <JIGS-UP
"With surprising force the current pulls you past the
reefs into the open sea. You haven't the strength to row back.">
				     <RTRUE>)>
			      <TELL
" You glide into the shadow of" TR ,SHIP CR>
			      <MOVE ,SKIFF ,BY-SHIP>
			      <GOTO ,SKIFF>)
			     (T
			      <RTRUE>)>)
		      (<EQUAL? ,P-DIRECTION ,P?WEST>
		       <SETG ROWING ,ROWWEST>
		       <TELL
,DIPPING-OARS D ,SKIFF " shoots over the lagoon">
		       <COND (<OR <EQUAL? ,HERE ,SHALLOWS>
				  <L? <+ ,SKIFF-LOC ,ROWING> 2>>
			      <TELL
", ramming into the sand of the beach. You stand up" ,PCR CR>
			      <DEQUEUE I-CURRENT>
			      <SETG ROWING 0>
			      <MOVE ,SKIFF ,BEACH>
			      <GOTO ,BEACH>)
			     (T
			      <TELL ,PCR CR>)>
		       <RTRUE>)
		      (<OR <EQUAL? ,P-DIRECTION ,P?NORTH ,P?NW ,P?NE>
			   <EQUAL? ,P-DIRECTION ,P?SOUTH ,P?SW ,P?SE>>
		       <TELL
"You can barely row back and forth, much less side to side!" CR>)>)>>

<OBJECT INTNUM
	(IN GLOBAL-OBJECTS)
	(DESC "number")
	(SYNONYM NUMBER)
	;(ADJECTIVE WIFE HUSBAND \#) ;"for things like WIFE # 375"
	;(ACTION INTNUM-F)>
 

<OBJECT PSEUDO-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "pseudo")	;"DESC must be 6 characters long! --pdl 3/4/86"
	(ACTION ME-F)>

<OBJECT IT
	(IN GLOBAL-OBJECTS)
	(SYNONYM IT THEM)
	(DESC "it")
	(FLAGS VOWELBIT NARTICLEBIT TOUCHBIT)>

<OBJECT HIM
	(IN GLOBAL-OBJECTS)
	(SYNONYM HIM HIMSELF)
	(DESC "him")
	(FLAGS NARTICLEBIT TOUCHBIT)>

<OBJECT HER
	(IN GLOBAL-OBJECTS)
	(SYNONYM HER HERSELF)
	(DESC "her")
	(FLAGS NARTICLEBIT TOUCHBIT)>

;<OBJECT EACH-OTHER
	(IN GLOBAL-OBJECTS)
	(DESC "it")
	(SYNONYM OTHER ITSELF)
	(ADJECTIVE EACH)
	(ACTION EACH-OTHER-F)>

;<ROUTINE EACH-OTHER-F ()
	 <COND (<PRSI? ,EACH-OTHER>
		<PERFORM-PRSA ,PRSO ,PRSO>
		<RTRUE>)
	       (<NOT <NOUN-USED ,W?ITSELF ,EACH-OTHER>>
		<SETG P-WON <>>
		<COND (<ADJ-USED ,A?EACH>
		       <CANT-USE ,A?EACH T>)
		      (T
		       <CANT-USE ,W?OTHER T>)>
		<RTRUE>)>>

<OBJECT MAN
	(IN GLOBAL-OBJECTS)
	(DESC "man")
	(SYNONYM MAN MEN YOU SAILOR)
	(ADJECTIVE SIR BEWIGGED SIRRAH GENTLEMAN)
	;(FLAGS ACTORBIT)
	(ACTION MAN-F)>

<ROUTINE MAN-F ("AUX" PERSON)
	 <COND ;(<VERB? FOLLOW> ;"for YOUNG WOMAN"
		<COND (<EQUAL? ,FOLLOW-FLAG 4>
		       <TELL ,DONT-WANT-TO>)
		      (<EQUAL? ,FOLLOW-FLAG 5>
		       <DO-WALK ,P?NORTH>)
		      (<EQUAL? ,FOLLOW-FLAG 6>
		       <DO-WALK ,P?EAST>)
		      (T
		       <V-WALK-AROUND>)>)
	       (<AND <PRSO? ,ME>
		     <VERB? TAKE-WITH>>
	        <RECOGNIZE>)
	       (<AND <NOUN-USED ,W?SAILOR ,MAN>
		     <VERB? HELLO>>
		<COND (<GLOBAL-IN? ,CREW ,HERE>
		       <PERFORM ,V?HELLO ,CREW>
		       <RTRUE>)
		      (T
		       <TELL "Nothing happens here." CR>)>)
	       (<AND <EQUAL? <GET ,P-NAMW 0> ,W?MAN> ;"MAN is the PRSO"
		     <PRSO? ,MAN> ;"in case PRSI is also MAN or WOMAN">
		<COND (<ADJ-USED ,A?BEWIGGED>
		       <PERFORM-PRSA ,LAFOND ,PRSI>)
		      (<AND <NOUN-USED ,W?MEN ,MAN>
			    <NOT <EQUAL? ,HERE ,BALLROOM
					 ,ORCHESTRA ,SUPPER-ROOM>>>
		       <MORE-SPECIFIC>) 
		      (<SET PERSON <FIND-MAN>>
		       <PERFORM-PRSA .PERSON ,PRSI>
		       <RTRUE>)
		      (T
		       <CANT-SEE ,MAN>)>)
	       (<AND <EQUAL? <GET ,P-NAMW 1> ,W?MAN> ;"MAN is the PRSI"
		     <PRSI? ,MAN> ;"in case PRSO is also MAN or WOMAN">
		<COND (<ADJ-USED ,A?BEWIGGED>
		       <PERFORM-PRSA ,PRSO ,LAFOND>)
		      (<AND <NOUN-USED ,W?MEN ,MAN>
			    <NOT <EQUAL? ,HERE ,BALLROOM
					 ,ORCHESTRA ,SUPPER-ROOM>>>
		       <MORE-SPECIFIC>)
		      (<SET PERSON <FIND-MAN>>
		       <PERFORM-PRSA ,PRSO .PERSON>
		       <RTRUE>)
		      (T
		       <CANT-SEE ,MAN>)>)>>

<ROUTINE FIND-MAN ()
	 <COND (<IN? ,HERO ,HERE>
		<RETURN ,HERO>)
	       (<IN? ,LAFOND ,HERE>
		<RETURN ,LAFOND>)
	       (<IN? ,DAD ,HERE>
		<RETURN ,DAD>)
	       (<IN? ,CRULLEY ,HERE>
		<RETURN ,CRULLEY>)
	       (<IN? ,COOKIE ,HERE>
		<RETURN ,COOKIE>)
	       (<IN? ,BUTLER ,HERE>
		<RETURN ,BUTLER>)
	       (<GLOBAL-IN? ,DANCERS ,HERE>
		<RETURN ,DANCERS>)
	       (<GLOBAL-IN? ,CREW ,HERE>
		<RETURN ,CREW>)
	       (<IN? ,CROC ,HERE>
		<RETURN ,CROC>)
	       (T
		<RFALSE>)>>


<OBJECT NOT-HERE-OBJECT
	(DESC "it")
	(FLAGS NARTICLEBIT)
	(ACTION NOT-HERE-OBJECT-F)>

<ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ (X <>))
	 <COND (<AND <PRSO? ,NOT-HERE-OBJECT>
		     <PRSI? ,NOT-HERE-OBJECT>>
		<TELL "Those things aren't here!" CR>
		<RTRUE>)
	       (<AND <EQUAL? ,P-XNAM ,W?MOUTH ,W?EYES>
		     <EQUAL? ,P-XADJN ,W?LAFOND <>>>
		<COND (<PRSO? ,NOT-HERE-OBJECT>
		       <SETG PRSO ,LAFOND>)
		      (T
		       <SETG PRSI ,LAFOND>)>
		<RFALSE>)
	       (<AND <EQUAL? ,P-XADJN ,W?POWDER>
		     <HELD? ,HORN>>
		<COND (<PRSO? ,NOT-HERE-OBJECT>
		       <SETG PRSO ,POWDER>)
		      (T
		       <SETG PRSI ,POWDER>)>)
	       ;(<AND <EQUAL? ,P-XNAM ,W?HAND ,W?HANDS>
		     <EQUAL? ,P-XADJN ,W?MITRE ,W?KING\'S>
		     <VERB? SHAKE TAKE>>
		<PERFORM ,V?SHAKE-WITH ,HANDS ,MITRE>
		<RTRUE>)
	       (<AND <OR <EQUAL? ,P-XNAM ,W?HANDS ,W?HAND>
			 <EQUAL? ,P-XNAM ,W?FINGER ,W?EYE ,W?EYES>
			 <EQUAL? ,P-XNAM ,W?HEAD ,W?JAMISON>
			 <EQUAL? ,P-XNAM ,W?LIP ,W?LIPS ,W?MOUTH>>
		     <OR <EQUAL? ,P-XADJN ,W?NICK ,W?NICHOLAS ,W?CROC\'S>
			 <EQUAL? ,P-XADJN ,W?DAD ,W?FATHER ,W?PAPA>
			 <EQUAL? ,P-XADJN ,W?WOMAN ,W?LUCY>
			 <EQUAL? ,P-XADJN ,W?JEAN ,W?LAFOND>>>
		<TELL
"[Sadly, we haven't the space to handle everything. Try to
refer only to characters in the story, not individual body parts or
possessions. For example, you can EXAMINE PIRATE but you can't
EXAMINE PIRATE'S EYEPATCH.]" CR>
		<RTRUE>)
	       (<PRSO? ,NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>)
	       (T
		<SET TBL ,P-PRSI>
		<SET PRSO? <>>)>
	 <COND (<AND .PRSO?
		     <PRSO-MOBY-VERB?>>
		<SET X T>)
	       (<AND <NOT .PRSO?>
		     <PRSI-MOBY-VERB?>>
		<SET X T>)>
	 <COND (.X ;"the verb is a moby-find verb"
		<COND (<SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
		       <COND (<NOT <EQUAL? .OBJ ,NOT-HERE-OBJECT>>
			      <RTRUE>)>)
		      (T
		       <RFALSE>)>
		<COND (<VERB? WALK-TO FOLLOW>
		       <V-WALK-AROUND>)
		      (T
		       <MORE-SPECIFIC>
		       ;<TELL "[" ,YOULL-HAVE-TO "be more specific.]" CR>)>)
	       (T
		<COND (<EQUAL? ,WINNER ,PROTAGONIST>
		       <TELL "You">)
		      (<FSET? ,WINNER ,DEADBIT>
		       <TELL ,DOESNT-RESPOND>
		       <RFATAL>)
		      (T
		       <TELL "Looking confused," T ,WINNER " says, \"I">)>
		<TELL " can't see">
		<COND (<AND <NOT <ADJNAME? ,P-XADJ>>	;"adj.number"
			    <NOT <NAME? ,P-XNAM>>>
		       <TELL " any">)> 
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!">
		<COND (<NOT <EQUAL? ,WINNER ,PROTAGONIST>>
		       <TELL "\"">)>
		<CRLF>)>
	 <STOP>>

<ROUTINE PRSO-MOBY-VERB? ()
	 <COND (<OR <EQUAL? ,PRSA ,V?WHAT ,V?WHERE ,V?SHOOT ,V?SSHOOT>
		    <EQUAL? ,PRSA ,V?WALK-TO ;,V?MAKE>
		    <EQUAL? ,PRSA ;,V?CALL ;,V?SAY ,V?I-LOVE-YOU>
		    <EQUAL? ,PRSA ,V?FIND ,V?FOLLOW ,V?SAVE-SOMETHING>
		    <EQUAL? ,PRSA ;,V?USE-QUOTES ,V?ANSWER-KLUDGE>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PRSI-MOBY-VERB? ()
	 <COND (<EQUAL? ,PRSA ,V?ASK-ABOUT ,V?ASK-FOR 
			,V?TELL-ABOUT ,V?I-LOVE-YOU>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE FIND-NOT-HERE (TBL PRSO? "AUX" M-F OBJ)
;"Protocol: return T if case was handled and msg TELLed, NOT-HERE-OBJECT
  if 'can't see' msg TELLed, <> if PRSO/PRSI ready to use"
;"Special-case code goes here. <MOBY-FIND .TBL> returns # of matches. If 1,
then P-MOBY-FOUND is it. You can treat the 0 and >1 cases alike or differently.
Always return RFALSE (not handled) if you have resolved the problem."
	<SET M-F <MOBY-FIND .TBL>>
        ;<COND (,DEBUG
	       <TELL "[Found " N .M-F " obj]" CR>)>
	<COND (<EQUAL? 1 .M-F>
	       ;<COND (,DEBUG
		      <TELL "[Namely: " D ,P-MOBY-FOUND "]" CR>)>
	       <COND (.PRSO?
		      <SETG PRSO ,P-MOBY-FOUND>
		      <THIS-IS-IT ,PRSO>)
		     (T
		      <SETG PRSI ,P-MOBY-FOUND>)>
	       <RFALSE>)
	      (<AND <L? 1 .M-F>
		    <SET OBJ <APPLY <GETP <SET OBJ <GET/B .TBL 1>> ,P?GENERIC>>>>
;"Protocol: returns .OBJ if that's the one to use
  		    ,NOT-HERE-OBJECT if case was handled and msg TELLed
		    <> if WHICH-PRINT should be called"
	       ;<COND (,DEBUG
		      <TELL "[Generic: " D .OBJ "]" CR>)>
	       <COND (<EQUAL? .OBJ ,NOT-HERE-OBJECT>
		      <RTRUE>)
		     (.PRSO?
		      <SETG PRSO .OBJ>
		      <THIS-IS-IT ,PRSO>)
		     (T
		      <SETG PRSI .OBJ>)>
	       <RFALSE>)
	      (T
	       ,NOT-HERE-OBJECT)>>

<ROUTINE NOT-HERE-PRINT (PRSO?)
	 <COND (,P-OFLAG
	        <COND (,P-XADJ
		       <TELL " ">
		       <PRINTB ,P-XADJN>)>
	        <COND (,P-XNAM
		       <TELL " ">
		       <PRINTB ,P-XNAM>)>)
               (.PRSO?
	        <BUFFER-PRINT <GET ,P-ITBL ,P-NC1> <GET ,P-ITBL ,P-NC1L> <>>)
               (T
	        <BUFFER-PRINT <GET ,P-ITBL ,P-NC2> <GET ,P-ITBL ,P-NC2L> <>>)>>

<OBJECT LADDER                    ;"TAKE ROPE = should get ladder."
	(IN LOCAL-GLOBALS)
	(DESC "ladder")
	(SYNONYM LADDER ROPE)
	(ADJECTIVE ROPE)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION LADDER-F)>

<ROUTINE LADDER-F ()
	 <COND (<NOT ,LADDER-HANGING>
		<CANT-SEE ,LADDER>)
	       (<VERB? TAKE CLIMB BOARD>
		<COND (<EQUAL? <LOC ,PROTAGONIST> ,CAPT-QUARTERS>
		       <COND (<FSET? ,LEDGE ,MUNGBIT>
			      <TELL
"You lean over" T ,LEDGE ", but" T ,LADDER
" is too far out to reach" ,PCR>)
			     (T
			      <TELL
"It's on the other side of the window" ,PCR>)>)
		      (<EQUAL? <LOC ,PROTAGONIST> ,LEDGE>
		       <TELL "You ">
		       <COND (<ANYTHING-HELD>
			      <ROB ,PROTAGONIST ,RETICULE>
			      <TELL
"put everything in" T ,RETICULE " and ">)> 
		       <COND (<FSET? ,POOP ,TOUCHBIT>
			      <TELL "hop out, catching the">) ;"TR ,LADDER CR"
			     (T
			      <QUEUE I-LADDER-BLOWS -1>
			      <TELL
"reach out for" T ,LADDER " and over-balance, tumbling from your perch.
Your hand closes on a slimy hemp rung as you fly out over the waves, clinging
tenuously, feet free, to the">)>                           ;"TR ,LADDER CR"
		       <PRSO-PRINT>
		       <TELL ,PCR CR>
		       <GOTO ,ON-LADDER>)
		      (<AND <EQUAL? ,HERE ,ON-LADDER>
			    <VERB? TAKE>>
		       <TELL ,HOLDING-IT>)
		      (<EQUAL? <LOC ,PROTAGONIST> ,SKIFF>
		       <DEBARK-SKIFF>)      
		      (<EQUAL? ,HERE ,POOP>
		       <TELL
"If you wish to climb down" T ,LADDER ", say so" ,PCR>)
		      (T
		       <DO-WALK ,P?UP>)>)
	       (<VERB? CUT>
		<COND (<HELD? ,DAGGER>
		       <TELL CTHE ,DAGGER
" isn't sharp enough to cut through" TR ,LADDER>)
		      (T
		       <PROPOSE>)>)
	       (<VERB? UNTIE>
		<TELL CTHE ,ROPE " is tied in too complex a knot" ,PCR>)
	       ;(<AND ,END-GAME
		     <EQUAL? ,HERE ,RING ,PLATFORM-1>
		     <NOT <EQUAL? <LOC ,PROTAGONIST> ,STAND>>	              
		     <NOT <VERB? UNTIE>>>
		     <COND (<TOUCHING? ,LADDER>
			    <DO-WALK ,P?UP>)
		           (<VERB? EXAMINE>
			    <TANGLED-ROPE T>)>)			   
	       (<VERB? CLIMB-DOWN>
		<COND ;(<EQUAL? ,HERE ,POOP>
		       <DO-WALK ,P?DOWN>)    ;"semi-d out cause of ELSE below"
		      (<EQUAL? ,HERE ,CAPT-QUARTERS>
		       <DO-FIRST "get on" ,LADDER>)
		      (T
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,CAPT-QUARTERS ,ON-LADDER ,POOP>>
		<TELL ,COMMON-LOOKING "rope " D ,LADDER ,PCR>)
	       ;(<VERB? CLIMB-UP>
		<DO-WALK ,P?UP>)>>

<ROUTINE I-END-PROLOGUE ()
	 <TELL ,INDENT
"Davis leaps across the deck to your side, \"Free me or she dies!\"
he yells, jabbing a knife up to your throat. In one smooth motion," T, HERO
" draws his rapier, pulls you free and stabs.
Davis slumps into a bloody heap.|
   Swooning, you fall into the Falcon's arms. You are dimly aware of being
carried to the other ship, down a short flight of stairs, and laid gently
on a soft bed. When you gather strength to look around, the Falcon has left
you in peace.|
   You remain confined to this room, a large cupboard blocking the door.
Meals are brought by a peg-legged old man and eaten in silence.
Of your handsome rescuer you see nothing. Slowly the days pass.|">
	 ;<CLEAR-SCREEN 10>
	 <TELL CR ,HIT-RETURN "continue.]" CR>
	 <READ ,P-INBUF ,P-LEXV>
	 <CLEAR-SCREEN 10>
	 <GOTO ,CAPT-QUARTERS>
	 <FCLEAR ,CRULLEY ,DEADBIT>
	 <FCLEAR ,DOOR ,MUNGBIT>
	 <MOVE ,HERO ,CAPT-QUARTERS>
	 <FCLEAR ,HERO ,NDESCBIT>
	 <REMOVE ,COFFER>
	 <FSET ,COFFER ,MUNGBIT>
	 <FCLEAR ,COFFER ,LOCKEDBIT> 
	 <FSET ,RAPIER ,NDESCBIT>
	 <FCLEAR ,DOOR ,OPENBIT>
	 ;<DEQUEUE I-MEET-HERO>	
	 ;<DEQUEUE I-COFFER>
	 ;<DEQUEUE I-JIGS-UP-SNAFU>>

;<OBJECT LOVE ;"for I LOVE someone -- made a preposition word 7/15/87"
	(IN GLOBAL-OBJECTS)
	(DESC "love")
	(SYNONYM LOVE)
	(FLAGS NARTICLEBIT)
	;(ACTION LOVE-F)>

;<ROUTINE LOVE-F ("AUX" LOVER)
	 <COND (<VERB? MAKE>
		<COND (<SET LOVER <FIND-IN ,HERE ,ACTORBIT "to">>
		       <PERFORM ,V?FUCK .LOVER>
		       <RTRUE>)
		      (T
		       <TELL "Alone? How odd." CR>)>)>>

<OBJECT GLOBAL-SLEEP
	(IN GLOBAL-OBJECTS)
	(DESC "sleep")
	(SYNONYM SLEEP NAP SNOOZE)
	(FLAGS NARTICLEBIT)
	(ACTION GLOBAL-SLEEP-F)>

<ROUTINE GLOBAL-SLEEP-F ()
	 <COND (<VERB? WALK-TO TAKE>
		<PERFORM ,V?SLEEP>
		<RTRUE>)
	       ;(<AND <VERB? PUT-TO>
		     <PRSI? ,GLOBAL-SLEEP>>
		<TELL "A lady is never that boring." CR>)>>

<OBJECT GROUND
	(IN GLOBAL-OBJECTS)
	(SYNONYM FLOOR GROUND DECK)
	(DESC "ground")
	(ACTION GROUND-F)>

<ROUTINE GROUND-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,RIGGING-ROOM ,CROWS-NEST>
		       <TELL
"Looking down at the distant deck is a mistake. Your stomach flips over">)
		      (<SHIP-BOARD ,HERE>
		       <TELL
"Well scrubbed and smoothed floorboards make up the deck">)
		      (<EQUAL? ,HERE ,BY-SHIP ,LAGOON ,SHALLOWS>
		       <TELL "A sandy bottom shifts under the waves">)
		      (<EQUAL? ,HERE ,CELL-1 ,CELL-4>
		       <TELL "Like the walls and ceiling, rock">)
		      (<EQUAL? ,HERE ,CELL-2>
		       <TELL "The floor is ankle deep in mud">)
		      (T
		       <NOTHING-INTERESTING>
		       <TELL "about ">
		       <COND (<FSET? ,HERE ,INDOORSBIT>
			      <TELL "the floor">)
			     (T
			      <TELL T ,GROUND>)>)>
		<TELL ,PCR>)
	       ;(<AND <VERB? TOUCH>
		     <EQUAL? ,HERE ,CELL ,OTHER-CELL>>
		<PERFORM ,V?EXAMINE ,GROUND>
		<RTRUE>)
	       (<VERB? ;CLIMB-UP CLIMB-ON CLIMB BOARD>
		<WASTES>)
	       (<VERB? LOOK-UNDER>
		<IMPOSSIBLES>)
	       (<VERB? LEAVE>
		<DO-WALK ,P?UP>)
	       (<AND <VERB? WALK-TO>
		     <NOUN-USED ,W?DECK ,GROUND>>
		<COND (<EQUAL? ,HERE ,CABIN ,LANDING ,HOLD ,GALLEY>
		       <DO-WALK ,P?OUT>)
		      (<EQUAL? ,HERE ,DEUX-DECK ,POOP ,QUARTERDECK
			       ,MAIN-DECK ,FOCSLE>
		       <TELL ,LOOK-AROUND>)
		      (<EQUAL? ,HERE ,CROWS-NEST ,RIGGING-ROOM>
		       <DO-WALK ,P?DOWN>)
		      (<SHIP-BOARD ,HERE>
		       <V-WALK-AROUND>)
		      (T
		       <WASTES>)>)
	       ;(<AND <VERB? LEAP STAND-ON>
		     <EQUAL? ,HERE ,ROOF>>
		<PERFORM ,V?LEAP ,ROOMS> ;"V-LEAP handles it"
		<RTRUE>)>>

<OBJECT LARGE-KEY
	(IN COT)
	(DESC "large key")
	;(FDESC
"Lying on the cot, probably fallen out of a pocket, is a large key.")
	(SYNONYM KEY)
	(ADJECTIVE LARGE)
	(FLAGS TAKEBIT TRYTAKEBIT)
	(SIZE 2)
	(ACTION KEY-F)>

<ROUTINE KEY-F ()
	 <COND (<AND <VERB? TAKE>
		     ;<NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>
		     <FSET? ,LARGE-KEY ,TRYTAKEBIT>>
		<MOVE ,LARGE-KEY ,PROTAGONIST>
		<FCLEAR ,LARGE-KEY ,TRYTAKEBIT>
		<SETG SCORE <+ ,SCORE 1>>
		<TELL "Taken." CR>)>>

	  ;<GLOBAL CLOSED-DOOR "The door is closed.|">

<ROUTINE GEN-LOCK ()
	 <COND (<NOT <FSET? ,COFFER ,NDESCBIT>>
		,DOOR)
	       (T
		<RFALSE>)>>

<OBJECT DOOR
	(IN LOCAL-GLOBALS)
	(DESC "door")
	(SYNONYM DOOR LOCK)
	(FLAGS NDESCBIT LOCKEDBIT DOORBIT)
	(GENERIC GEN-LOCK)
	(ACTION DOOR-F)>

;"There are several different door-objects, all using DOOR-F as their
action routine:
WOOD-CELL-DOOR -- in CELL-2 and adjoining PASSAGE-2. Never locked.
IRON-CELL-DOOR -- in CELL-4 and its PASSAGE-4 -- needs LARGE-KEY to open.
VER-DOOR -- in VERANDA and BALLROOM. Needs to be opened from inside.
LDOOR -- in LAFS-ROOM and UPPER-HALL-E. Un-unlockable. 
DOOR -- in CABIN (Lafond Deux), LANDING, QUARTERDECK (both Helena Louise),
        and (not) BEDROOM, (not) UPPER-HALL-W (St. Sinistra)." 

<ROUTINE DOOR-F ()
	 <COND (<EQUAL? ,HERE ,CAPT-QUARTERS>
		<PERFORM-PRSA ,CURTAIN>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<NOUN-USED ,W?LOCK ,LDOOR>
		       <TELL "Ladies do not look through keyholes!" CR>)
		      (<FSET? ,PRSO ,OPENBIT>
		       <TELL "It is open">)
		      (T
		       <TELL "It" ,IS-CLOSED>
		       <COND (<EQUAL? ,HERE ,QUARTERDECK>
			      <TELL " and barred">)
			     (<FSET? ,DOOR ,MUNGBIT>
			      <TELL ". Or, what remains of it is">)>)>
		<THIS-IS-IT ,PRSO>
		<TELL ,PCR>)
	       (<AND <VERB? PICK>
		     <PRSO? ,LDOOR>>
		<TELL "The mechanism is too complex to pick." CR>)
	       (<VERB? UNLOCK>
		<COND (<EQUAL? ,HERE ,UPPER-HALL-E>
		       <TELL
"Only one man has the key to this room: Jean Lafond" ,PCR>)
		      (<EQUAL? ,HERE ,QUARTERDECK>
		       <PERFORM ,V?OPEN ,DOOR>
		       <RTRUE>)
		      (<PRSO? ,WOOD-CELL-DOOR>
		       <TELL "But" T ,DOOR " isn't locked" ,PCR>)
		      (<PRSI? ,LARGE-KEY>
		       <COND (<EQUAL? ,PRSO ,IRON-CELL-DOOR>
			      <FCLEAR ,PRSO ,LOCKEDBIT>
			      <TELL "Unlocked" ,PCR>)
			     (T
			      <TELL
"That key does not unlock this door" ,PCR>)>)
		      (T
		       <TELL "You are unable to unlock" TR ,DOOR>) 
		      ;(<PRSI? ,BENT-KEY>
		       <TELL
CTHE ,BENT-KEY " will never fit in any lock again" ,PCR>)>)
	       (<VERB? LOCK>
		<COND (<AND <PRSO? ,IRON-CELL-DOOR>
			    <PRSI? ,LARGE-KEY>>
		       <FSET ,PRSO ,LOCKEDBIT>
		       <TELL "You "> 
		       <COND (<FSET? ,PRSO ,OPENBIT>
			      <FCLEAR ,PRSO ,OPENBIT>
			      <TELL "close and ">)>
		       <TELL "lock" TR ,DOOR>)
		      (<PRSI? ,LARGE-KEY ;,BENT-KEY>
		       <TELL "That key won't work here" ,PCR>)
		      (<PRSO? ,VER-DOOR>
		       <TELL ,YOU-CANT "lock that" ,PCR>)
		      (T
		       <PROPOSE>)>)
	       (<VERB? KNOCK>
		<COND (<AND <EQUAL? ,HERE ,UPPER-HALL-E>  
			    <NOT <FSET? ,LDOOR ,LOCKEDBIT>>
			    <IN? ,LAFOND ,LAFS-ROOM>>
		       <TELL D ,LAFOND " calls, \"Come.\"" CR>)
		      (T
		       <TELL "Silence answers back." CR>)>)
	       (<VERB? OPEN>
		<COND ;(<PRSO? ,DOOR>
		       <DO-WALK ,P?EAST>)
		      (<EQUAL? ,HERE ,CABIN>
		       <TELL "It appears to be locked." CR>) 
		      (<EQUAL? ,HERE ,LANDING>
		       <TELL CTHE ,DOOR " won't open" ,PCR>)
		      (<EQUAL? ,HERE ,QUARTERDECK>
		       <TELL
"Someone yells from ahead, \"Cap'n 'll have your hide if you go down there!\"
You haven't the strength to lift the bar anyway" ,PCR>)
		      (<AND <EQUAL? ,HERE ,VERANDA>
			    <NOT <FSET? ,DOOR ,OPENBIT>>>
		       <TELL ,YOU-CANT-SEE-ANY ,WAY-TO-DO-THAT>)
		      (T
		       <RFALSE>)>)>>

<OBJECT WALLS
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "wall")
	(SYNONYM WALL WALLS)
	;(ACTION WALLS-F)>

;<ROUTINE WALLS-F ()
	 <COND (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,HOLD>
		     <EQUAL? ,SIDEKICK-EXPLODED 1>>
		<SPLATTERED-DESC>
		<CRLF>)>>

<OBJECT CEILING
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "ceiling")
	(SYNONYM CEILIN ROOF)
	(ADJECTIVE LOW)
	(ACTION CEILING-F)>

<ROUTINE CEILING-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,CREWS-QUARTERS>
		       <TELL ,YOU-SEE
" a sail rippling against the night sky through" TR ,GRATE>)
		      (<NOT <FSET? ,HERE ,INDOORSBIT>>
		       <CANT-SEE ,CEILING>)
		      (T
		       <RFALSE>)>)
	       ;(<VERB? LOOK-UNDER>
		<PERFORM ,V?LOOK>
		<RTRUE>)>>

;<OBJECT ODOR
	(IN LOCAL-GLOBALS)
	(DESC "odor")
	(SYNONYM SMELL ODOR SCENT AROMA)
	(ADJECTIVE STRONG FAMILIAR FOUL HEADY PLEASANT)
	(FLAGS VOWELBIT)
	;(ACTION ODOR-F)>


<OBJECT WATER
	(IN WATER-BARREL)
	(DESC "water")
	(SYNONYM WATER)
	(ADJECTIVE FRESH)
	;(GENERIC GEN-WATER)
	(FLAGS ;NARTICLEBIT NDESCBIT)
	(ACTION WATER-F)>

<OBJECT SEA
	(IN LOCAL-GLOBALS)
	(DESC "sea")
	(SYNONYM WATER OCEAN LAGOON SHALLOWS)
	(ADJECTIVE SEA DARK COLD)
	;(FLAGS NARTICLEBIT)
	;(GENERIC GEN-WATER)
	(ACTION WATER-F)>

;<ROUTINE GEN-WATER ()
	 <COND (<EQUAL? ,HERE ,MAIN-DECK>
		<RETURN ,WATER>)
	       (T
		<RFALSE>)>>

<GLOBAL DRIPS-OFF " drips off your fingers.|">

<ROUTINE WATER-F ()
	 <COND (<AND <OR <EQUAL? ,HERE ,LAFS-ROOM ,RIGGING-ROOM>
			 <EQUAL? ,HERE ,BOWSPRIT ,CROWS-NEST>>
		     <NOT <VERB? THROW PUT PUT-ON>>>
		<COND (<VERB? ENTER>
		       <TELL ,SUICIDE>)
		      (T
		       <CANT-REACH ,SEA>)>)
	       (<NOT <OR <GLOBAL-IN? ,SEA ,HERE>
			 <HELD? ,WATER ,HERE>>>
		<TELL "There's no water here." CR>)
	       (<VERB? LOOK-INSIDE LOOK-UNDER EXAMINE>
		<TELL "The water is sparkling clear" ,PCR>)
	       (<VERB? REACH-IN>
		<TELL "Water" ,DRIPS-OFF>)
	       (<VERB? DRINK DRINK-FROM ;TASTE>
		<COND (<PRSO? ,WATER>
		       <TELL
"You take a long draft. It is quite refreshing" ,PCR>)
		      (T
		       <TELL "This water is much too salty to drink" ,PCR>)>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,SEA>>
		<PERFORM ,V?PUT ,PRSO ,SEA>
		<RTRUE>)
	       (<VERB? THROW>
		<COND (<AND <EQUAL? ,HERE ,CAPT-QUARTERS>
			    <NOT <FSET? ,LEDGE ,MUNGBIT>>>
		       <TELL "But" T ,WINDOW ,IS-CLOSED "!" CR>)
		      (T
		       <REMOVE ,PRSO>
		       <TELL "You toss" T ,PRSO " into" TR ,SEA>)>) 
	       (<VERB? PUT SOAK>
		<COND (<PRSO? ,INVITE ,LETTER>
		       <REMOVE ,PRSO>
		       <TELL
"It disintegrates quickly into nothing" ,PCR>)
		      (<EQUAL? ,HERE ,POOP ,QUARTERDECK ,FOCSLE
			             ,BOWSPRIT ,CAPT-QUARTERS>
		       <PERFORM ,V?THROW ,PRSO ,SEA>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,MAIN-DECK>
		       <COND (<PRSI? ,SEA>
			      <PERFORM ,V?THROW ,PRSO ,SEA>
			      <RTRUE>)
			     (T
			      <PERFORM ,V?PUT ,PRSO ,WATER-BARREL>
			      <RTRUE>)>)
		      (<EQUAL? ,HERE ,BEACH ,SHALLOWS ,LAGOON ,BY-SHIP>
		       <COND (<PRSO? ,DRESS ,RAG>
			      <DIP-DRESS>)
			     (T
			      <TELL
"You dip" T ,PRSO " into the water" ,PCR>)>)
		      (T
		       <TELL ,YOU-CANT "reach any water" ,PCR>)>)
	       (<VERB? BOARD ENTER SWIM>
		<COND (<EQUAL? ,HERE ,BEACH>
		       <DO-WALK ,P?EAST>)
		      (T
		       <V-SWIM>)>)
	       (<TOUCHING? ,SEA>
		<TELL "The cool water runs through your fingers" ,PCR>)>>

<OBJECT SKY
	(IN GLOBAL-OBJECTS)
	(DESC "sky")
	(SYNONYM SKY)
	(ACTION SKY-F)>

<ROUTINE SKY-F ()
	 <COND (<FSET? ,HERE ,INDOORSBIT>
		<CANT-SEE ,SKY>)>>

<OBJECT MOONBEAM
	(IN GLOBAL-OBJECTS)
	(DESC "moonbeam")
	(SYNONYM MOONLIGHT MOONBEAM BEAM LIGHT)
	(ADJECTIVE MOON)
	(FLAGS NDESCBIT)
	(ACTION MOON-F)>

<ROUTINE MOON-F ()
	 <COND (<AND <FSET? ,HERE ,INDOORSBIT>
		     <NOT <EQUAL? ,HERE ,CREWS-QUARTERS ,CAPT-QUARTERS
				  ,BEDROOM ,LAFS-ROOM>> 
		     <NOT <VERB? ASK-ABOUT TELL-ABOUT>>>
		<TELL ,YOU-CANT "see the moon from here" ,PCR>)
	       (<VERB? EXAMINE>
		<TELL "A dusty moonbeam swirls down from the sky." CR>)>>

<OBJECT HANDS
	(IN GLOBAL-OBJECTS)
	(DESC "your hand")
	(SYNONYM HANDS HAND FINGER NAILS)
	(ADJECTIVE BARE MY YOUR)
	(FLAGS NDESCBIT TOUCHBIT NARTICLEBIT BODYBIT)
	(ACTION HANDS-F)>

<ROUTINE HANDS-F ("AUX" ACTOR)
	 <COND (<VERB? APPLAUD>
		<SETG PRSO <>>
		<V-APPLAUD>)  
	       (<VERB? SHAKE>
		<COND ;(<EQUAL? ,HERE ,THRONE-ROOM>
		       <PERFORM ,V?SHAKE-WITH ,HANDS ,MITRE>
		       <RTRUE>)
		      (<SET ACTOR <FIND-IN ,HERE ,ACTORBIT "with">>
		       <PERFORM ,V?SHAKE-WITH ,HANDS .ACTOR>
		       <RTRUE>)
		      (T
		       <TELL "Pleased to meet you." CR>)>)
	       (<VERB? CLEAN>
		<TELL "Done." CR>)
	       (<AND <VERB? TAKE-WITH>
		     <PRSI? ,HANDS>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>


;<ROUTINE ITEMS-CARRIED ("AUX" X (CNT 0))
	 <SET X <FIRST? ,PROTAGONIST>>
	 <REPEAT ()
		 <COND (<NOT .X>
			<RETURN>)
		       (<AND <NOT <FSET? .X ,WORNBIT>>
			     <NOT <EQUAL? .X ,RETICULE>>>
			<SET CNT <+ .CNT 1>>)>
		 <SET X <NEXT? .X>>>
	 <RETURN .CNT>>

;<GLOBAL HAND-COVER <>>

<OBJECT HEAD
	(IN GLOBAL-OBJECTS)
	(DESC "your head")
	(SYNONYM HEAD)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT BODYBIT)>


<OBJECT EYES
	(IN GLOBAL-OBJECTS)
	(DESC "your eyes")
	(SYNONYM EYE EYES)
	(ADJECTIVE YOUR MY HIS LAFOND)
	(FLAGS NARTICLEBIT PLURALBIT BODYBIT)
	(ACTION EYES-F)>

<ROUTINE EYES-F ()     
	 <COND (<VERB? CLOSE>
		<TELL "You blink" ,PCR>)
	       (<VERB? OPEN>
		<TELL "They are open!" CR>)
	       (<AND <VERB? EXAMINE LOOK-INSIDE>
		     <ADJ-USED ,A?HIS>
		     <IN? ,HERO ,HERE>>
		<TELL <GET ,MANNERISMS 3> CR>)>>

<OBJECT MOUTH
	(IN GLOBAL-OBJECTS)
	(DESC "your mouth")
	(SYNONYM MOUTH LIP LIPS SNOUT)
	(ADJECTIVE YOUR MY CROC\'S CROCOD LAFOND)
	(FLAGS NARTICLEBIT BODYBIT)
	(ACTION MOUTH-F)>

<ROUTINE MOUTH-F ()
	 <COND (<VERB? PUT-ON ENTER OPEN WRING POUR EXAMINE PUT>
		<COND (<OR <ADJ-USED ,A?CROC\'S>
			   <ADJ-USED ,A?CROCOD>
			   <NOUN-USED ,W?SNOUT ,MOUTH>>
		       <PERFORM-PRSA ,PRSO ,CROC>
		       <RTRUE>)
		      (<ADJ-USED ,A?LAFOND>
		       <PERFORM-PRSA ,PRSO ,LAFOND>)
		      (<PRSI? ,MOUTH>
		       <PERFORM ,V?EAT ,PRSO>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<VERB? OPEN>
		<COND (<RUNNING? ,I-HFOLLY>
		       <TELL "Jamison will do that for you." CR>)
		      (T 
		       <TELL "You fail to stifle a yawn." CR>)>)>>


<OBJECT PROTAGONIST
	(IN CABIN-BED)
	(SYNONYM PROTAG)
	(DESC "it")
	(FLAGS NDESCBIT INVISIBLE ACTORBIT)
	(ACTION PROTAGONIST-F)>

<GLOBAL REACTION <>>
<GLOBAL QUESTIONER <>>

<CONSTANT REACTION-NEGATIVE -1>
<CONSTANT REACTION-NEUTRAL 0>
<CONSTANT REACTION-POSITIVE 1>

<ROUTINE PROTAGONIST-F ()
	 <COND (,QUESTIONER
		<COND (<GAME-COMMANDS>
		       <RFALSE>)
		      (<OR <VERB? NO>
			   <AND <NEGATIVE-ANSWER>
				<EQUAL? ,QUESTIONER ,PRSO ,PRSI>>>
		       <SETG REACTION ,REACTION-NEGATIVE>)
		      (<OR <VERB? YES>
			   <AFFIRMATIVE-ANSWER>>
		       <SETG REACTION ,REACTION-POSITIVE>)
		      (T
		       <SETG REACTION ,REACTION-NEUTRAL>)>
		;<TELL
"[Debug: going thru PROTAG-F. REACTION is " N ,REACTION ".]" CR>
		<SETG QUESTIONER <>>)>
	 <RFALSE>>

<ROUTINE AFFIRMATIVE-ANSWER ()
	 <COND (<OR <VERB? APPLAUD ;CALL CLIMB-ON>
		    <VERB? DANCE FOLLOW GIVE SGIVE>
		    <VERB? HELLO KISS CURTSEY LAUGH>
		    <VERB? EMBRACE I-LOVE-YOU MARRY TOUCH>
		    <VERB? THANK WALK-TO SAVE-SOMETHING>
		    <VERB? ;SRUB SHOW SSHOW>
		    <VERB? MAKE-LOVE MAKE-OUT ;LOVE>
		    <AND <VERB? TELL ;SAY>
			 <YES-WORD <GET ,P-LEXV ,P-CONT>>>
		    ;<AND <EQUAL? ,QUESTIONER ,PRSO ,PRSI>
			 <VERB? UNTIE>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE NEGATIVE-ANSWER ()
	 <COND (<OR <VERB? KILL BITE BURN>
		    <VERB? MUNG KICK RAPE>
		    <VERB? SHAKE SWING YELL>
		    <AND <VERB? TELL ;SAY>
			 <NO-WORD <GET ,P-LEXV ,P-CONT>>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE GAME-COMMANDS ()
	 <COND (<OR <VERB? SAVE RESTORE QUIT>
		    <VERB? VERBOSE BRIEF SUPER-BRIEF>
		    ;<VERB? ;DIAGNOSE INVENTORY>
		    <VERB? SCRIPT UNSCRIPT VERSION>
		    <VERB? $RANDOM $COMMAND $RECORD $UNRECORD>
		    <VERB? $VERIFY ;$DEBUG>
		    <VERB? HELP SCORE>> 
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT ME
	(IN GLOBAL-OBJECTS)
	(SYNONYM I ME MYSELF SELF)
	(SIZE 10)
	(DESC "yourself")
        (CONTENTS 0)
	(FLAGS ;ACTORBIT TOUCHBIT NARTICLEBIT BODYBIT)
	(ACTION ME-F)>

<ROUTINE ME-F () 
	 <COND (<VERB? TELL>
		<TELL
"You'll end up in Bedlam, talking to " D ,ME " that way." CR>
		<STOP>)
	       (<AND <VERB? GIVE>
		     <PRSI? ,ME>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<AND <VERB? TAKE-WITH>
		     <PRSI? ,MAN>>
		<RECOGNIZE>)
	       (<AND <VERB? SHOW>
		     <PRSI? ,ME>>
		<PERFORM ,V?EXAMINE ,PRSO>
		<RTRUE>)
	       (<VERB? MOVE>
		<V-WALK-AROUND>)
	       (<VERB? SEARCH>
		<V-INVENTORY>
		<RTRUE>)
	       (<AND <VERB? ALARM>
		     <HELD? ,SALTS>>
		<PERFORM ,V?SMELL ,SALTS>
		<RTRUE>)
	       (<VERB? DRESS>
		<PERFORM ,V?GET-DRESSED ,ROOMS>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<COND (<AND <RUNNING? ,I-LSED>
			    <G? ,LAFOND-CTR ,HORNY>>
		       <V-INVENTORY>
		       ;<TELL "You blush to look at your naked body">)
		      (T
		       <TELL "You are wearing">
		       <COND (,BOY-DRESS?
			      <TELL A ,SHIRT " and " D ,PANTS>
			      <TELL
". Mama herself would think you a plump boy." CR>
			      ;<COND (<FSET? ,HOOPS ,WORNBIT>
				     <TELL
" under " D ,HOOPS ". You look rather ridiculous." CR>)
				    (T
				     <TELL
". Mama herself would think you a plump boy." CR>)>)
			     (<FSET? ,DRESS ,WORNBIT>
			      <TELL
A ,DRESS ", very pretty, if a tad outmoded for today's fashions." CR>)
			     (<FSET? ,GOWN ,WORNBIT>
			      <TELL A ,GOWN " of creamy watered silk." CR>)
			      
		;"in a shirt OR pants OR hoops: half-dressed"
			     (<FSET? ,SHIRT ,WORNBIT>
			      <TELL A ,SHIRT ,BROTHEL>)
			     (<FSET? ,PANTS ,WORNBIT>
			      <TELL A ,PANTS ,BROTHEL>)
			     ;(<FSET? ,HOOPS ,WORNBIT>
			      <TELL " " D ,HOOPS ,BROTHEL>)
			     (<NOT <FSET? ,CHEMISE ,EVERYBIT>>
			      <TELL
" absolutely nothing besides" A ,CHEMISE ", " D ,SHOES
" and a few layers of " D ,UNMENTIONABLES ". " ,MOTHER>)>)>)  
	       (<VERB? KILL MUNG SHOOT SSHOOT>
		<TELL ,SUICIDE>)
	       (<VERB? FIND WHERE>
		<TELL "You're in" TR ,HERE>)
	       (<VERB? FOLLOW>
		<TELL
"Next time, please specify who you wish to follow." CR>)
	       (<VERB? KISS EMBRACE>
		<TELL "Mama warned you of the dangers of onanism" ,PCR>)>>

<OBJECT GLOBAL-ROOM
	(IN GLOBAL-OBJECTS)
	(DESC "room")
	(SYNONYM ROOM PLACE LOCATI AREA)
	(ACTION GLOBAL-ROOM-F)>

<ROUTINE GLOBAL-ROOM-F ()
	 <COND (<VERB? LOOK LOOK-INSIDE EXAMINE>
		<V-LOOK>)
	       (<VERB? ENTER WALK-TO>
		<V-WALK-AROUND>)
	       (<VERB? LEAVE EXIT DISEMBARK>
		<DO-WALK ,P?OUT>)
	       (<VERB? SEARCH>
		<COND (<AND <EQUAL? ,HERE ,CABIN>
			    <NOT <RUNNING? ,I-COFFER>>
			    <NOT <HELD? ,COFFER>>> 
		       <PERFORM ,V?LOOK-UNDER ,CABIN-BED>
		       <RTRUE>)
		      (T
		       <TELL ,NOTHING-NEW>)>)
	       ;(<VERB? WALK-AROUND>
                <TELL "Walking around here">
		<HO-HUM>
		<TELL " To move elsewhere, type the desired " D ,INTDIR ,PCR>)
	       (<AND <VERB? PUT>
		     <PRSI? ,GLOBAL-ROOM>>
		<COND (<EQUAL? ,P-PRSA-WORD ,W?THROW>
		       <PERFORM ,V?THROW ,PRSO>
		       <RTRUE>)
		      (T
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>)>>

<OBJECT HOUSE
	(IN GLOBAL-OBJECTS)
	(DESC "mansion")
	(SYNONYM HOUSE MANSION LIBRARY)
	(ADJECTIVE HUGE STONE)
	(ACTION HOUSE-F)>

<ROUTINE HOUSE-F ()
	 <COND (<VERB? ENTER WALK-TO BOARD>
		<COND (<EQUAL? ,HERE ,MAIN-ENTRANCE>
		       <DO-WALK ,P?SOUTH>)
		      (<EQUAL? ,HERE ,TRADE-ENTRANCE>
		       <DO-WALK ,P?EAST>)
		      (<EQUAL? ,HERE ,VERANDA ,LAWN>
		       <DO-WALK ,P?NORTH>)
		      (<EQUAL? ,HERE ,BY-HOUSE>
		       <DO-WALK ,P?WEST>)
		      (T
		       <TELL ,YOU-CANT "do that from here."
			      CR>)>)
	       (<VERB? EXIT LEAVE DISEMBARK>
		<COND (<EQUAL? ,HERE ,KITCHEN>
		       <DO-WALK ,P?WEST>)
		      (<EQUAL? ,HERE ,FOYER>
		       <DO-WALK ,P?NORTH>)
		      (<EQUAL? ,HERE ,BALLROOM>
		       <DO-WALK ,P?SOUTH>)
		      (<EQUAL? ,HERE ,LIBRARY>
		       <DO-WALK ,P?EAST>)
		      (<EQUAL? ,HERE ,BEDROOM>
		       <DO-WALK ,P?DOWN>)
		      ;(<OR <EQUAL? ,HERE ,HALL-E ,HALL-W ,LIBRARY>
			   <EQUAL? ,HERE ,UPPER-HALL-W ,UPPER-HALL-E>
			   <EQUAL? ,HERE ,LAFS-ROOM ,GALLERY>>
		       <TELL ,CANT-FROM-HERE>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,MAIN-ENTRANCE ,TRADE-ENTRANCE
			             ,LAWN ,BY-HOUSE>
		       <TELL ,CANT-FROM-HERE>)
		      (T
		       <V-LOOK>)>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,CREWS-QUARTERS>
		       <TELL
"Bathed in moonbeams and candlelight, the house squats at the crest
of a cliff. The upstairs window is dark" ,PCR>)
		      (<OR <AND <SHIP-BOARD ,HERE>
				<NOT <INNER-DECK ,HERE>>>
			   <EQUAL? ,HERE ,BEACH>>
			   
		       <TELL ,YOU-CANT
"make out much of the house from this angle" ,PCR>)
		      (<OR <INNER-DECK ,HERE>
			   <BELOW-GROUND ,HERE>
			   <EQUAL? ,HERE ,FOREST ,FOLLY ,IN-HEDGE>>
		       <TELL ,YOU-CANT-SEE-ANY "house here" ,PCR>)
		      (<OR <EQUAL? ,HERE ,FRONT-DRIVE ,MAIN-ENTRANCE ,LAWN>
			   <EQUAL? ,HERE ,TRADE-ENTRANCE ,CLEARING ,VERANDA>>
		       <TELL
"An entrance to" T ,HOUSE " is nearby" ,PCR>)
		      (T
		       <V-LOOK>)>)>>

<ROUTINE CLIMBING ()
	 <COND ;(<FSET? ,HOOPS ,WORNBIT>
		<TELL ,YOU-CANT
"get a foothold because the hoops of
your dress keep pushing away">
		<COND (<EQUAL? ,HERE ,CLEARING ,BEDROOM>
		       <TELL TR ,VINE>)
		      (<EQUAL? ,HERE ,MAIN-DECK ,FOCSLE
			             ,RIGGING-ROOM ,CROWS-NEST>
		       <TELL TR ,RIGGING-OBJECT>)
		      (T
		       <TELL TR ,LADDER>)>
		<RFALSE>)
	       (<OR <FSET? ,DRESS ,WORNBIT>
		    <FSET? ,GOWN ,WORNBIT>>
		<SETG AWAITING-REPLY 2>
		<QUEUE I-REPLY 2>
		<TELL "In these clothes? You jest" ,PCR>
		<RFALSE>)
	       (<EQUAL? ,P-WALK-DIR ,P?UP>
		<COND (<EQUAL? ,HERE ,CLEARING>
		       <TELL
"You take a firm grasp on a particularly thick tendril, jerk once to secure
it, and scamper up the wall like some huge tropical spider. It is easy to
climb through the window" ,PCR CR>
		       <RETURN ,BEDROOM>)
		      (<EQUAL? ,HERE ,CAPT-QUARTERS>
		       <COND (<NOT ,LADDER-HANGING>
			      <TELL ,CANT-GO>
			      <RFALSE>)
			     (<NOT <FSET? ,POOP ,TOUCHBIT>>
			      <COND (<EQUAL? <LOC ,PROTAGONIST> ,LEDGE>
				     <DO-FIRST "be holding" ,LADDER>)
				    (T
				     <DO-FIRST "get on" ,LEDGE>)>
			      <RFALSE>)
			     (T
			      <TELL "You dash up" TR ,LADDER CR>
			      <RETURN ,POOP>)>)
		      (<EQUAL? ,HERE ,MAIN-DECK ,FOCSLE>
		       <SETG WHICH-MAST? ,HERE>
		       <COND (<EQUAL? <LOC ,DAGGER> ,PROTAGONIST>
			      <TELL 
"You bite down on" T ,DAGGER ", freeing " D ,HANDS "s to climb.
When you stop, you take it back again. ">)>
		       <TELL
"The wind, a mere breeze on the deck, blows more fiercely" ,PCR CR>
		       <RETURN ,RIGGING-ROOM>)
		      (<EQUAL? ,RIGGING-ROOM ,HERE>
		       <COND (<EQUAL? ,WHICH-MAST? ,FOCSLE>
			      <TELL "You clamber up" TR ,RIGGING-OBJECT CR> 
			      <RETURN ,CROWS-NEST>)
			     (T
			      <TELL
"Above you there only appears to be more of the same, except higher, and
you can not vouch for the effects on your stomach" ,PCR>
			      <RFALSE>)>)
		      (<EQUAL? ,HERE ,ON-LADDER>
		       <COND (<NOT <FSET? ,POOP ,TOUCHBIT>>
			      <SETG UP-CTR <+ ,UP-CTR 1>>
			      <COND (<NOT <EQUAL? ,UP-CTR 4>>
				     <TELL "You climb up" T ,LADDER>
				     <COND (<EQUAL? ,UP-CTR 2>
					<TELL ", passing the halfway point">)>
				     <TELL ,PCR>
				     <RFALSE>)
				    (T
				     <TELL
"You heave " D ,ME " over the stern rail
and sink breathless to the deck of" TR ,SHIP CR>
				     <DEQUEUE I-LADDER-BLOWS>
				     <RETURN ,POOP>)>)
			     (T
			      <TELL "You dash up" TR ,LADDER CR>
			      <RETURN ,POOP>)>)
		      (<EQUAL? ,HERE ,BY-SHIP>
		       <DEBARK-SKIFF>
		       <RFALSE>)>)
	       (<EQUAL? ,P-WALK-DIR ,P?DOWN>
		<COND (<EQUAL? ,HERE ,BEDROOM>
		       <TELL
"Absently, you slide down" T ,VINE ". You're getting quite adept at
clambering about" ,PCR CR>
		       <RETURN ,CLEARING>)
		      (<EQUAL? ,HERE ,CROWS-NEST ,RIGGING-ROOM>
		       <TELL
"You half-climb, half-fall, down to the deck" ,PCR CR>
		       <RETURN ,WHICH-MAST?>)
		      (<EQUAL? ,HERE ,POOP>
		       ;<COND (<IN? ,HOOPS ,PROTAGONIST>
			      <TELL
,YOU-CANT "carry" T ,HOOPS " as you climb!">
			      <RFALSE>)>
		       ;<COND (<ANYTHING-HELD>
			      <ROB ,PROTAGONIST ,HERE>
			      <TELL
"You drop all you carry on the deck, and">)
			     (T
			      <TELL "You">)>
		       <TELL "You climb down to opposite" TR ,LEDGE CR> 
		       <RETURN ,ON-LADDER>)
		      (<EQUAL? ,HERE ,ON-LADDER>
		       <COND (,SKIFF-TIED
			      <SETG SKIFF-TIED <>>
			      <TELL
"Freeing your feet from the rungs, you slide down
the wet rope to the skiff, and quickly untie it from the ship" ,PCR CR>
			      <RETURN ,BY-SHIP>)
			     (T
			      <TELL "A watery grave awaits you that way." CR>
			      <RFALSE>)
			     ;(T
			      <TELL
"Letting loose your grip on your sanity as well
as on the rope ladder, you plummet into the sea" ,PCR>
			      <COND (,BOY-DRESS?
				     <JIGS-UP
"Flailing about in the water just tires you.">)
				    (T
				     <JIGS-UP
"Your skirts, until sodden, hold you above water.
Then they carry you down into the depths.">)>
			      <RFALSE>)>)>)>>

<OBJECT FIRE
	(IN LOCAL-GLOBALS)
	(DESC "fire")
	(SYNONYM FIRE FIREPIT PIT)
	(ADJECTIVE WARM SMOKY)
	(FLAGS ;BURNBIT ONBIT)
	(ACTION FIRE-F)>

<ROUTINE FIRE-F ()
	 <COND (<VERB? OFF>
		<IMPOSSIBLES>)
	       (<VERB? ON PUT PUT-ON THROW>
		<PERFORM ,V?BURN ,PRSO ,FIRE>
		<RTRUE>
		
		;<COND (<PRSO? ,CANDLE>
		       <COND (<FSET? ,CANDLE ,ONBIT>
			      <TELL "The candle is already lit" ,PCR>)
			     (T
			      <FSET ,CANDLE ,ONBIT>
			      <TELL
"You tip the end of the candle into the heat
until with a small burst it flames up" ,PCR>)>)>)
	       (<VERB? TELL-ABOUT>
		<RFALSE>)
	       (T
		<UNIMPORTANT-THING>)>>

<OBJECT STAIRS
	(IN LOCAL-GLOBALS)
	(DESC "stair")
	(SYNONYM STAIR STAIRS STAIRW STEP)
	(ADJECTIVE WOOD ROCK WET)
	(ACTION STAIRS-F)>

<ROUTINE STAIRS-F ()
	 <COND (<VERB? CLIMB ;CLIMB-UP>
		<COND (<EQUAL? ,HERE ,MAIN-DECK>
		       <DO-WALK ,P?NORTH>)
		      (T
		       <DO-WALK ,P?UP>)>)
	       (<VERB? CLIMB-DOWN>
		<DO-WALK ,P?DOWN>)
	       (<AND <VERB? THROW>
		     <PRSI? ,STAIRS>>
		<WASTES>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,HOLD>
		       <TELL "Steep stairs mount up to" TR ,HATCH>)
		      (<EQUAL? ,HERE ,MAIN-DECK>
		       <COND (<FSET? ,HATCH ,OPENBIT>
			      <TELL
,STEEP-STAIRS "down from " T ,HATCH ". Another leads">)
			     (T
			      <TELL CTHE ,STAIRS " lead">)>
		       <TELL " to the foredeck" ,PCR>)
		      (T <RFALSE>)>)>>

;"LAFS-BED, CAPT-BED, CABIN-BED, COT, GUEST-BED = all use BED-F"

<ROUTINE BED-F ("OPTIONAL" (VARG <>) "AUX" THIS-BED)
	 <COND (.VARG
		<COND (<AND <EQUAL? .VARG ,M-BEG>
			    <OR <VERB? WALK>
				<AND ,PRSO
				     <VERB? TAKE>
				     <NOT <PRSO? ,HRING ,LRING>>
				     <NOT <IN? ,PRSO ,GLOBAL-OBJECTS>>
				     <NOT <EQUAL? <LOC ,PROTAGONIST>
						  <LOC ,PRSO>>>>>>
		       <DO-FIRST "stand up">
		       <RFATAL>)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? DISEMBARK STAND>
		     <IN? ,LAFOND ,LAFS-BED>>
		<TELL
"Lafond slams you back into the feather mattress" ,PCR>)
	       (<AND <VERB? ENTER BOARD>
		     <EQUAL? <LOC ,PROTAGONIST> ,LAFS-ROOM>
		     <IN? ,LAFOND ,HERE>>
		<TELL D ,LAFOND
" stops you. \"I'll tell you when to do that.\"" CR>)  
	       ;(<VERB? MAKE>
		<V-CLEAN>)
	       (<VERB? EXAMINE> 
	        <COND (<AND <SET THIS-BED <COND (<EQUAL? ,HERE ,CABIN>
						 ,CABIN-BED)
						(<EQUAL? ,HERE ,CAPT-QUARTERS>
						 ,CAPT-BED)>>
			    <NOT <FIRST? .THIS-BED>>>
		       <TELL 
"Someone appears to have tumbled out of it in a hurry">)
		      (<EQUAL? ,HERE ,LAFS-ROOM>
		       <TELL
"You gaze at the purple and gold bed, fearing it is your destiny">)
		      (<EQUAL? ,HERE ,CELL-1>
		       <TELL
"It is an uncomfortable canvas cot, old and torn">)
		      (T
		       <RFALSE>)>
		<TELL ,PCR>)
	       (<VERB? LOOK-UNDER>
		<COND (<QUEUED? ,I-COFFER>     ;"which would only be in CABIN"
		       <TELL ,YOU-SEE A ,COFFER " ">
		       <FCLEAR ,COFFER ,NDESCBIT>
		       <FSET ,COFFER ,TOUCHBIT>)
		      (T <TELL ,THERES-NOTHING>)>
		<TELL "under" TR ,PRSO>)
	       (<VERB? MOVE PUSH>
		<TELL "It is nailed to the floor" ,PCR>)
	       (<AND <VERB? PUT-UNDER>
		     <EQUAL? ,HERE ,CAPT-QUARTERS ,CABIN>>
		<COND (<PRSO? ,ME>
		       <PERFORM ,V?CRAWL-UNDER ,CABIN-BED>
		       <RTRUE>)
		      (<PRSO? ,RETICULE>
		       <RFALSE>
		       ;<PERFORM ,V?DROP ,PRSO>
		       ;<RTRUE>)
		      (T
		       <TELL
"You do so, but the ship rolls to one side and" T ,PRSO " rolls out" ,PCR>
		       <MOVE ,PRSO ,HERE>)>)>>


<OBJECT CURTAIN                 ;"in CAPT-QUARTERS and LANDING"
	(IN LOCAL-GLOBALS)
	(DESC "curtain")
	(SYNONYM CURTAIN)
	(FLAGS DOORBIT)
	(ACTION CURTAIN-F)>

<ROUTINE CURTAIN-F ()
	 <COND (<VERB? OPEN MOVE FIDDLE LOOK-BEHIND>
		<TELL ,PULL-FABRIC
" Behind it," A ,CUPBOARD-OBJECT " mostly blocks the doorway." CR>
		;<TELL
"You push" T ,CURTAIN " aside momentarily.
Behind it," A ,CUPBOARD-OBJECT " mostly blocks the doorway." CR>)
	       (<VERB? CLOSE>
		<TELL ,ALREADY-IS>)
	       (<VERB? WALK WALK-TO>
		<TELL "Please indicate a " D ,INTDIR ,PCR>)
	       ;(<VERB? LOOK-BEHIND>
		<PERFORM ,V?PUSH ,CUPBOARD-OBJECT>
		<RTRUE>)>>

;"Windows in CABIN, CAPT-QUARTERS, BEDROOM"
;"LIB-WINDOW in Library and By-house"
<OBJECT WINDOW
	(IN LOCAL-GLOBALS)
	(DESC "window")
	(SYNONYM GLASS WINDOW PORTHOLE)
	(ADJECTIVE LARGE GLASS SMALL PANE PANES)
	(ACTION WINDOW-F)>

<ROUTINE WINDOW-F ()
	 <COND (<VERB? OPEN>
		<COND (<NOT <FSET? ,WINDOW ,OPENBIT>>
		       <COND (<EQUAL? ,HERE ,CABIN>
			      <TELL
"This isn't the opening kind of porthole" ,PCR>)
			     (<EQUAL? ,HERE ,CAPT-QUARTERS>
			      <TELL "These windows don't open" ,PCR>)
			     (<EQUAL? ,HERE ,LIBRARY ,BY-HOUSE>
			      <OPEN-CLOSE ,LIB-WINDOW>)
			     (T
			      <TELL "That's not necessary" ,PCR>)>)
		      (T
		       <TELL "It's already open" ,PCR>)>) 
	       (<VERB? CLOSE>
		<COND (<EQUAL? ,HERE ,LIBRARY ,BY-HOUSE>
		       <OPEN-CLOSE ,LIB-WINDOW>)
		      (T
		       <TELL ,BEAUTIFUL-NIGHT>)>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,CABIN>
		       <TELL
"Through the porthole you see the bow of the pirate ship bucking in
the high seas, lit by the fires burning on deck. It is called the \""
D ,SHIP ".\" Odd, that was your mother's name" ,PCR>)
		      (<EQUAL? ,HERE ,CAPT-QUARTERS>
		       <PERFORM ,V?EXAMINE ,LEDGE>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,LIBRARY ,BY-HOUSE>
		       <TELL ,YOU-SEE ,DARKNESS TR ,WINDOW>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,CABIN ,HERE>
		       <PERFORM ,V?EXAMINE ,WINDOW>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,CAPT-QUARTERS>
		       <COND (,LADDER-HANGING
			      <QUEUE I-SEE-LADDER 2>
			      <TELL
"A rope " D ,LADDER " twists by in the breeze, and the">)
			     (T
			      <TELL "The">)>
		       <TELL " moon beckons across the lagoon to " D ,ISLAND>
		       <COND (,SKIFF-TIED
			      <TELL ". Moored to the stern is" A ,SKIFF>)>
		       <TELL ".">
		       <I-LOOK-SEA <>>
		       <CRLF>)
		      (<EQUAL? ,HERE ,LIBRARY ,BY-HOUSE>
		       <PERFORM ,V?EXAMINE ,LIB-WINDOW>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,BEDROOM>
		       <TELL
"It has a lovely view of grey-green palm trees extending for miles" ,PCR>)
		      (T
		       <TELL ,YOU-SEE ,DARKNESS TR ,WINDOW>)>)
	       (<VERB? MUNG>
		<COND (<NOT ,PRSI>
		       <PROPOSE>)
		      (<PRSI? ,COFFER>
		       <PERFORM ,V?PUT-THROUGH ,COFFER ,WINDOW>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,CAPT-QUARTERS>
		       <TELL ,YOULL-HAVE-TO
"find something else to break" T ,WINDOW " with" ,PCR>)
		      (T
		       <TELL "Then again, a lady would just open it." CR>)>)
	       (<VERB? KILL>
		<COND (<NOT ,PRSI>
		       <TELL "You haven't the strength to damage" TR ,WINDOW>)
		      (T
		       <PERFORM ,V?MUNG ,PRSO ,PRSI>
		       <RTRUE>)>)
	       (<VERB? THROW PUT-THROUGH PUT>
		<COND (<EQUAL? ,HERE ,CABIN>
		       <COND (<VERB? THROW>
			      <V-THROW>)
			     (T
			      <TELL
"It doesn't fit through the porthole" ,PCR>)>) 
		      (<PRSO? ,COFFER>
		       <COND (<IN? ,HERO ,HERE>
			      <TELL
"Jamison stops you, \"Nay, lady, glass is expensive.\"" CR>
			      <RTRUE>)>
		       <REMOVE ,PRSO>
		       <FSET ,LEDGE ,MUNGBIT>
		       <SETG SCORE <+ ,SCORE 1>>
		       <TELL
"You hurl" T ,COFFER " through" T ,WINDOW ", sending it and a shower of glass
into the sea. " CTHE ,LEDGE " now looks deep enough to sit upon" ,PCR>)
		      (<AND <NOT <FSET? ,LEDGE ,MUNGBIT>>
			    <EQUAL? ,HERE ,CAPT-QUARTERS>>
		       <TELL CTHE ,WINDOW " isn't open" ,PCR>)
		      (<PRSO? ,HANDS>
		       <TELL ,HUH>)
		      ;(<PRSO? ,HOOPS>
		       <RFALSE>)
		      (T
		       <PUT-OBJ-THRU-WINDOW>)>)
	       (<VERB? ENTER EXIT DISEMBARK LEAP-OFF BOARD>
		<COND (<EQUAL? ,HERE ,CABIN>
		       <IMPOSSIBLES>)
		      (<EQUAL? <LOC ,PROTAGONIST> ,CAPT-QUARTERS>
		       <PERFORM-PRSA ,LEDGE>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,LIBRARY>
		       <DO-WALK ,P?EAST>)
		      (<EQUAL? ,HERE ,BY-HOUSE>
		       <DO-WALK ,P?WEST>)
		      (<EQUAL? ,HERE ,BEDROOM>
		       <DO-WALK ,P?DOWN>)
		      (T
	               <WASTES>)>)>>

<ROUTINE PUT-OBJ-THRU-WINDOW ()
	 <COND (<AND <EQUAL? ,HERE ,CAPT-QUARTERS>
		     <NOT <FSET? ,LEDGE ,MUNGBIT>>>
		<TELL "The window isn't open" ,PCR>)
	       (<PRSO? ,RETICULE>
		<RFALSE>
		;<TELL "You daren't drop" TR ,PRSO>)
	       (T
		<PRONOUN>
		<TELL " fall">
		<COND (<NOT <FSET? ,PRSO ,PLURALBIT>>
		       <TELL "s">)>
		<COND (<EQUAL? ,HERE ,CAPT-QUARTERS>
		       <REMOVE ,PRSO>
		       <TELL " into the seas below">)
		      (<EQUAL? ,HERE ,BEDROOM>
		       <MOVE ,PRSO ,CLEARING>
		       <TELL " onto the forest floor">)
		      (<EQUAL? ,HERE ,LIBRARY ,LAFS-ROOM>
		       <MOVE ,PRSO ,BY-HOUSE>
		       <TELL " into the darkness of the hedge">)
		      (<EQUAL? ,HERE ,BY-HOUSE>
		       <MOVE ,PRSO ,LIBRARY>
		       <TELL
" with a thunk over",THE-EDGE T ,LIB-WINDOW>)>
		<TELL ,PCR>)>>


<ROUTINE OPEN-CLOSE (OBJ "OPTIONAL" (OPETELL <>) (CLOSETELL <>))
	 <COND (<VERB? OPEN RAISE MOVE>
		<COND (<FSET? .OBJ ,OPENBIT>
		       <COND (<FSET? .OBJ ,PLURALBIT>
			      <TELL "They are">)
			     (T
			      <TELL "It is">)>
		       <TELL " already open.">)
		      (T
		       <FSET .OBJ ,OPENBIT>
		       <FSET .OBJ ,TOUCHBIT>
		       <COND (.OPETELL
			      <TELL .OPETELL ".">)
			     (<AND <EQUAL? .OBJ ,CUPBOARD-OBJECT>
				   <NOT <EQUAL? ,HERE ,SLEEPING-CUPBOARD>>>
			      <TELL "Opened. ">
			      <PERFORM ,V?LOOK-INSIDE ,CUPBOARD-OBJECT>
			      <RTRUE>)
			     (<OR <NOT <FIRST? .OBJ>>
				  <FSET? .OBJ ,TRANSBIT>
				  <FSET? .OBJ ,DOORBIT>>
			      <TELL "Opened.">)
			     (T
			      <TELL "Opening" T .OBJ " reveals">
			      <COND (<NOT <DESCRIBE-NOTHING>>
				     <TELL ".">)>
			      ;<NOW-LIT?>
			      <RTRUE>)>)>
		;<COND (<EQUAL? ,SLEEPING-CUPBOARD ,HERE>
		       <TELL " " ,YOU-SEE " better now.">)>
		<CRLF>)
	       (<VERB? CLOSE>
		<COND (<NOT <FSET? .OBJ ,OPENBIT>>
		       <COND (<FSET? .OBJ ,PLURALBIT>
			      <TELL "They are">)
			     (T
			      <TELL "It is">)>
		       <TELL " already closed" ,PCR>)
		      (T
		       <FCLEAR .OBJ ,OPENBIT>
		       <COND (<EQUAL? .OBJ ,MANACLES>
			      <FSET .OBJ ,LOCKEDBIT>)>
		       <COND (.CLOSETELL
			      <TELL .CLOSETELL ".">)
			     (T
			      <TELL "Shut.">
			      <COND (<PRSO? ,CUPBOARD-OBJECT>
				     ;<FCLEAR ,SLEEPING-CUPBOARD ,ONBIT>
				     <COND (<EQUAL? ,SLEEPING-CUPBOARD ,HERE>
					    <TELL
" You imagine Jamison being lulled to sleep by
the waves lapping against the ship.">)>)
				    ;(T
				     <NOW-DARK?>)>)>
		       <CRLF>)>)
	       ;(T
		<TELL
"You are the proud owner of Bug #119. Please report circumstances" ,PCR>)>>

<OBJECT TREE
	(IN LOCAL-GLOBALS)
	(DESC "tree")
	(SYNONYM TREE TREES)
	(ACTION TREE-F)>

<ROUTINE TREE-F ()
	 <COND (<VERB? CLIMB ;CLIMB-UP>
		<TELL "The trees are all unclimbable." CR>)>>

<ROUTINE TOUCHING? (THING)
	 <COND (<AND <PRSO? .THING>
		     <OR <EQUAL? ,PRSA ,V?ALARM ,V?BITE ,V?BOARD> 
			 <EQUAL? ,PRSA ,V?CLEAN ,V?CLIMB-OVER ,V?CRAWL-UNDER>
			 <EQUAL? ,PRSA ,V?CLIMB ,V?CLIMB-DOWN ,V?CLIMB-ON>
			 <EQUAL? ,PRSA ,V?CUT ,V?DANCE ,V?EMBRACE>
			 <EQUAL? ,PRSA ,V?ENTER ;,V?FEED ,V?FIDDLE> 
			 <EQUAL? ,PRSA ,V?KICK ,V?KILL ,V?KISS> 
			 <EQUAL? ,PRSA ,V?KNOCK ,V?LOOK-UNDER ,V?LOOK-INSIDE>
			 <EQUAL? ,PRSA ,V?MOVE ,V?MUNG ,V?WRING> 
			 <EQUAL? ,PRSA ,V?ON ,V?OFF ,V?OPEN ,V?CLOSE>
			 <EQUAL? ,PRSA ,V?PICK ,V?PUSH ,V?RAISE>
			 <EQUAL? ,PRSA ,V?SET ,V?STAND-ON ,V?SWIM ,V?TIE>
			 <EQUAL? ,PRSA ;,V?TASTE ,V?THROW ,V?RAPE>
			 <EQUAL? ,PRSA ,V?TAKE ,V?TOUCH ,V?SHAKE>
			 <EQUAL? ,PRSA ,V?UNLOCK ,V?LOCK ,V?UNTIE>>>
		<RTRUE>)
	       (<AND <PRSI? .THING>
		     <VERB? GIVE PUT PUT-ON PUT-UNDER>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE CANT-SEE (OBJ "AUX" (WRD <>))
	 <SET WRD <GET ,P-NAMW <COND (<PRSO? .OBJ> 0)
				     (T 1)>>>
	 <COND (<NOT .WRD>
		<SET WRD <GET ,P-ADJW <COND (<PRSO? .OBJ> 0)
				     	    (T 1)>>>)>
	 <SETG P-WON <>>
	 <TELL ,YOU-CANT>
	 <TELL "see">
	 <COND (<AND .OBJ
		     <NOT <NAME? .WRD>>>
		<TELL " any">)>
	 <COND ;(<NOT .OBJ>
		<TELL " " .STRING>)
	       (<EQUAL? .OBJ ,PRSI>
		<PRSI-PRINT>)
	       (T
		<PRSO-PRINT>)>
	 <TELL " here." CR>
	 <STOP>>

<ROUTINE CANT-VERB-A-PRSO (STRING)
	 <TELL ,YOU-CANT .STRING A ,PRSO "!" CR>>

<ROUTINE TELL-HIT-HEAD ()
	 <TELL
"You knock your brow against" T ,PRSO " as you attempt this." CR>>

<ROUTINE NOUN-USED (TEST-NOUN OBJ)
	 <COND (<AND <PRSO? .OBJ>
		     <EQUAL? <GET ,P-NAMW 0> .TEST-NOUN>>
		<RTRUE>)
	       (<AND <PRSI? .OBJ>
		     <EQUAL? <GET ,P-NAMW 1> .TEST-NOUN>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ADJ-USED (TEST-ADJ)
	 <COND (<EQUAL? .TEST-ADJ <GET ,P-ADJW 0> <GET ,P-ADJW 1>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE OFF-VEHICLE? (OBJ) ;"tells to print GET OFF versus GET OUT OF"
	 <COND (<EQUAL? .OBJ ,LEDGE>
		<RTRUE>)
	       (<EQUAL? .OBJ ,BENCH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TELL-OPEN/CLOSED (OBJ "OPTIONAL" (AN? <>))
	 <COND (<FSET? .OBJ ,OPENBIT>
		<COND (.AN?
		       <TELL "n">)>
		<TELL " open">)
	       (T
		<TELL " closed">)>>

<ROUTINE WHEE ()
	 <SETG AWAITING-REPLY 2>
	 <QUEUE I-REPLY 2>
	 <TELL "Wasn't that fun?" CR>>

;<ROUTINE IN-YOUR-PACKAGE (STRING)
	 <TELL "This is the " .STRING>
	 <IN-PACKAGE>>

<ROUTINE IN-PACKAGE ()
	 <TELL " that came in your game package.|">>

;<ROUTINE HIS-HER ("OPTIONAL" (CAP-H <>))
	 <COND (.CAP-H
		<TELL "H">)
	       (T
		<TELL "h">)>
	 <COND (,MALE
		<TELL "is">)
	       (T
		<TELL "er">)>>

;<ROUTINE HER-HIS ("OPTIONAL" (CAP-H <>))
	 <COND (.CAP-H
		<TELL "H">)
	       (T
		<TELL "h">)>
	 <COND (,MALE
		<TELL "er">)
	       (T
		<TELL "is">)>>

;<ROUTINE HIM-HER ()
	 <COND (<FSET? ,PRSO ,FEMALEBIT>
		<TELL "her">)
	       (T
		<TELL "him">)>>

;<ROUTINE HER-HIM ()
	 <COND (,MALE
		<TELL "her">)
	       (T
		<TELL "him">)>>

;<ROUTINE HE-SHE ("OPTIONAL" (CAP <>))
	 <COND (,MALE
		<COND (.CAP
		       <TELL "H">)
		      (T
		       <TELL "h">)>)
	       (T
		<COND (.CAP
		       <TELL "Sh">)
		      (T
		       <TELL "sh">)>)>
	 <TELL "e">>

;<ROUTINE SHE-HE ("OPTIONAL" (CAP <>))
	 <COND (,MALE
		<COND (.CAP
		       <TELL "Sh">)
		      (T
		       <TELL "sh">)>)
	       (T
		<COND (.CAP
		       <TELL "H">)
		      (T
		       <TELL "h">)>)>
	 <TELL "e">>

<ROUTINE CANT-REACH (OBJ)
	 <TELL ,YOU-CANT "reach" T .OBJ>
	 <COND (<NOT <IN? ,PROTAGONIST ,HERE>>
		<TELL " from" T <LOC ,PROTAGONIST>>)>
	 <TELL ,PCR>>

;<ROUTINE EAGERLY-ACCEPTS ()
	 <MOVE ,PRSO ,PRSI>
	 <TELL "Eagerly," T ,PRSI " accepts" T ,PRSO>>

;<ROUTINE NOT-ON-GROUND (VEHICLE)
	 <TELL "But" T .VEHICLE " isn't on the ground!" CR>>

;<ROUTINE AND-SIDEKICK ("OPTIONAL" (NEW-SIDEKICK-LOC <>))
	 <COND (<VISIBLE? ,SIDEKICK>
		<COND (.NEW-SIDEKICK-LOC
		       <MOVE ,SIDEKICK .NEW-SIDEKICK-LOC>)>
		<TELL " and " D ,SIDEKICK>)>>

;<ROUTINE PLAYER-CANT-SEE ()
	 <COND (<NOT ,LIT>
		<TELL ,TOO-DARK CR>)
	       (T
		<RFALSE>)>>

<ROUTINE DO-FIRST (STRING "OPTIONAL" (OBJ <>))
	 <TELL ,YOULL-HAVE-TO .STRING>
	 <COND (.OBJ
		<TPRINT .OBJ>)>
	 <TELL " first." CR>>

<ROUTINE NOT-IN ()
	 <TELL "But" T ,PRSO " isn't ">
	 <COND (<FSET? ,PRSI ,ACTORBIT>
		<TELL "being held by">)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<TELL "on">)
	       (T
		<TELL "in">)>
	 <TELL TR ,PRSI>>

;<ROUTINE NO-LID ()
	 <TELL CTHE ,PRSO " has no lid." CR>>

<ROUTINE SORE (STRING)
	 <TELL "You begin to get a sore " .STRING ,PCR>>

<ROUTINE CANT-USE-THAT-WAY (STRING)
	 <TELL "[" ,YOU-CANT "use " .STRING " that way.]" CR>>

<ROUTINE RECOGNIZE ()
	 <SETG P-WON <>>
	 <TELL "[That sentence isn't one I recognize.]|">>

;<ROUTINE EXPLETIVE ()
	 <TELL " \"Oh ">
	 <COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		<TELL "shucks">)
	       (<EQUAL? ,NAUGHTY-LEVEL 1>
		<TELL "damn">)
	       (T
		<TELL "shit">)>
	 <TELL "! ">>

<ROUTINE PRONOUN ()
	 <COND (<PRSO? ,ME>
		<TELL "You">)
	       (<FSET? ,PRSO ,PLURALBIT>
		<TELL "They">)
	       (<PRSO? ,LUCY>
		<TELL "She">)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL "He">)
	       (T
		<TELL "It">)>>


<ROUTINE REFERRING ("OPTIONAL" (HIM-HER <>))
	 <TELL "I don't see wh">
	 <COND (.HIM-HER
		<TELL "o">)
	       (T
		<TELL "at">)>
	 <TELL " you're referring to." CR>>

<ROUTINE NO-ONE-HERE (STRING)
	 <TELL "There's no one here to " .STRING ,PCR>>

<ROUTINE SEE-MANUAL (STRING)
	 <TELL
"[See the instruction manual section entitled \"Communicating
With Infocom's Interactive Fiction.\" to properly " .STRING "]" CR>>

<ROUTINE UNIMPORTANT-THING ()
	 <TELL "You have no need for that, milady." CR>
	 ;<TELL "That's not important; leave it alone." CR>>

<ROUTINE PROPOSE ()
	 <SETG AWAITING-REPLY 1>
	 <QUEUE I-REPLY 2>
	 <TELL "And how do you propose to do that?" CR>>

<ROUTINE STOP-QUEUES ()
	 <COND (<RUNNING? ,I-HDANCE>
		<SETG PARTNER <>>
		<DEQUEUE I-HDANCE>)
	       (<RUNNING? ,I-HFOLLY>
		<DEQUEUE I-HFOLLY>)>>

<GLOBAL TANGLED-RIGGING " A tangled mass of rigging hangs down from the mast,
like many rope ladders woven together.">

<GLOBAL COMMON-LOOKING "Completely common looking ">

<GLOBAL DARKNESS " only darkness beyond">

<GLOBAL DOESNT-RESPOND "He doesn't respond.|">

<GLOBAL IS-CLOSED " is closed">

<GLOBAL STEEP-STAIRS "Steep stairs descend ">

<GLOBAL TINY-GLOW "A tiny glow of fire creeps across a stretch of floor
-- inside the cage full of ammunition">

<GLOBAL TOO-DARK "It's too dark to see a thing.">

<CONSTANT TOO-DEEP
"Although the lagoon is warm and clear, it is much too deep.|">

<GLOBAL ISNT-FLUSH " is not flush against the doorsill. ">

<CONSTANT UNLADY "That is thoroughly unladylike behavior.|">

<GLOBAL THOROUGHLY-UNLADYLIKE "It is thoroughly unladylike to ">

<GLOBAL HALFWAY " halfway up the cliff stairs.">

<ROUTINE REPERTOIRE (ACT)
	  <TELL .ACT
" is not in the repertoire of well-bred young ladies." CR>>

<ROUTINE MAN-IS-DOWN ()
	 <TELL
,THOROUGHLY-UNLADYLIKE "hit a man when he's down!" CR>>

<GLOBAL YNH "You're not holding">

<CONSTANT PACE "You pace out the steps.|">

<GLOBAL THERES-NOTHING "There's nothing ">

<GLOBAL IT-SEEMS-THAT "It seems that">

<GLOBAL YOU-SEE "You can see">

<GLOBAL YOU-CANT-SEE-ANY "You can't see any ">

<GLOBAL WAY-TO-DO-THAT "way to do that.|">

<GLOBAL YOU-CANT "You can't ">

<GLOBAL YOU-ARENT "You aren't ">

<GLOBAL YOULL-HAVE-TO "You'll have to ">

<GLOBAL YOU-HAVE-ALREADY "You already have">
 
<ROUTINE NO-TIME-FOR (STR)
	 <TELL "This is no time to " .STR "!|">>

<GLOBAL PULL-FABRIC "You pull the cloth aside momentarily.">

<GLOBAL THE-BACK " only the back of">

<CONSTANT THE-EDGE " the edge of">

<CONSTANT SURPRISE "To your surprise, ">

<GLOBAL THE-BALLROOM "The ballroom is a ">

<GLOBAL YOU-ARE-ALREADY "You're already ">

<ROUTINE MORE-SPECIFIC ()
	 <TELL ,YOULL-HAVE-TO "be more specific." CR>>

<ROUTINE CANT-HURT (STR)
	 <TELL "Your " .STR " could not hurt" TR ,CRULLEY>>

<GLOBAL OVER-HEAD " over the head with">

<CONSTANT DANCE-FLOOR " the dance floor">

<CONSTANT DOESNT-LOOK "It doesn't look like">

<GLOBAL RIEF-DESC "rief descriptions.|">   

;         "The next four are globals (one routine) for various JIGS-UP"

<GLOBAL SMACK-YOUR-FACE 
"   Lafond smacks you hard across the face with the back of his hand,
\"Fool.\" He casts aside all formalities.">

<GLOBAL FALL-TO-BOTTOM " The fall to the bottom of the well is endless;
you've lost consciousness by the time the water overtakes you.">

<ROUTINE SAILOR-DEATH ()
	 <TELL ,INDENT "A sailor notices ">
	 <COND (<FSET? ,PANTS ,WORNBIT>
		<TELL
"the roundness of your body through the lace of your chemise">)
	       (T
		<TELL "the \"swish\" of your petticoats">)>
	 <TELL ". \"A woman,\" he gasps, \"free, aboard this ship!\"" CR>
	 <JIGS-UP
"   It's been rather a long time since any of the crew have dealt with the
fairer sex, and they are a bit rough, despite Rodney Quick's exhortations.">>

<GLOBAL SOMETHING-HITS-YOU "Something cracks over your head,
knocking you unconscious.|
   You awaken, cuddled in a huge purple and gold curtained bed, with a
shocking migraine. The man lying next to you pays no heed to your complaints,
and commands you in French when you try to defend yourself. He tires of
you within a few weeks, but lets you work the streets of Santa Ananas.">

<CONSTANT DRAGOONS-SURROUND "Dragoons surround you. ">

;<GLOBAL SPECIFY "specify ">

<ROUTINE LADY-MUST (STRING)
	 <TELL
"A lady must obtain her father's permission before " .STRING " anyone." CR>>
	 
<ROUTINE FIGURE-IT-OUT ()
	 <TELL ,YOULL-HAVE-TO "figure that out " D, ME ,PCR>>

<GLOBAL SPEECHLESS "You find yourself speechless with dread.|">

<GLOBAL GAME-CAPS "PLUNDERED HEARTS">

<GLOBAL HIT-RETURN "[Press RETURN or ENTER to ">

<GLOBAL POLITE-SOCIETY "That's not done in polite society.|">

<GLOBAL POLITE "That wouldn't be polite.|">

<GLOBAL MOTHER "Mama would have been shocked.|">

<GLOBAL NO-LOITERING "Sorry, no loitering,\" says the butler">

<GLOBAL NO-STRENGTH "You haven't the strength.|">

<GLOBAL PUSHING-YOU-OUT ", pushing you out of the house.|">

<GLOBAL SINEWY-ARM
"A sinewy arm encircles you, \"Stay, my lady.\"">

<GLOBAL SQUEEZE-THRU " squeeze through the opening between cupboard and
wall">

<GLOBAL SUICIDE "Suicide is not the answer.|">

<ROUTINE KICKED-OUT ()
	 <TELL ,INDENT>
	 <COND (<EQUAL? ,HERE ,HALL-E>
		<TELL "A black-garbed " D ,BUTLER>)
	       (T
		<TELL CTHE ,BUTLER>)>
	 <TELL 
" marches up to you, \"It was made clear at the whippings that villagers
are not admitted in this house.\" He grasps you by the scruff of the neck
and propels you headfirst out the front door" ,PCR CR>
	 <GOTO ,MAIN-ENTRANCE>>

<GLOBAL LOOK-AROUND "Look around you.|">

<GLOBAL LAUGHS "He laughs triumphantly and pulls you into the dance.|">

<GLOBAL CANT-FROM-HERE "You can't do that from here.|">

<GLOBAL CANT-GO "You can't go that way.|">

<GLOBAL HOLDING-IT "You're holding it!|">

;<GLOBAL CANT-SMELL "You can't smell any odor here.|">

<ROUTINE NICK-RUNS-OFF ()
	 <COND (<AND <RUNNING? ,I-CCLIMBS-UP>
		     <EQUAL? ,CRULLEY-CTR 10>>
		<QUEUE I-CCLIMBS-UP 2>)>
	 <MOVE ,HERO ,GALLERY>
	 <MOVE ,LAFOND ,GALLERY>
	 <MOVE ,DAD ,GALLERY>
	 <MOVE ,LUCY ,GALLERY>
	 <SETG HERO-CTR 1>
	 <QUEUE I-DUEL -1>
	 <FSET ,RAPIER ,NDESCBIT>
	 <FCLEAR ,BALLROOM ,EVERYBIT>        ;"getting rid of crew"
	 <TELL ,INDENT
"Nick kisses you briefly, a butterfly touching your lips,">
	 <COND (<EQUAL? <META-LOC ,RAPIER> ,HERE ,PASSAGE-4 ,CELL-4>
		;<OR <VISIBLE? ,RAPIER>
		    <IN? ,RAPIER ,PASSAGE-4>
		    <IN? ,RAPIER ,CELL-4>>
		;<OR <HELD? ,RAPIER ,HERE>
		    <HELD? ,RAPIER ,PASSAGE-4>
		    <HELD? ,RAPIER ,CELL-4>>
		<MOVE ,RAPIER ,HERO>
		<TELL " then seizes his rapier">)>
	 <TELL " and runs off to the north. Cookie calls a
breathless \"Hullo, Cap'n\" to him as he races past" ,PCR>>

<GLOBAL NOUN-MISSING "[There seems to be a noun missing in that sentence.]|">

;<GLOBAL ONLY-BLACKNESS "You see only blackness.|">

;<GLOBAL SENILITY-STRIKES "You already did that. Senility strikes again!|">

<GLOBAL INDENT "   ">

<GLOBAL PCR ".|">

<GLOBAL ELLIPSIS "...||">

<GLOBAL NOTHING-HAPPENS "Nothing happens.|">

;<GLOBAL NOT-ENOUGH "There's not enough liquid to drink.|">

<GLOBAL FAILED "Failed.|">

<GLOBAL OK "Aye-aye.|">

<GLOBAL HUH "Pardon?|">

<GLOBAL ALREADY-IS "It already is.|">

<CONSTANT ALREADY-ARE "They already are.|">

<CONSTANT DO-YOU-WANT " do you want to ">

<GLOBAL BEAUTIFUL-NIGHT "But it's such a beautiful night!|">
	
<GLOBAL BROTHEL " over your white linen chemise. Mama would say
you belonged in a brothel.|">

<GLOBAL BUTLER-SUMMONS " walks up to you. \"M. Lafond
requests your presence in his room immediately, Miss.\" He points ">

<CONSTANT CALLS-AFTER " calls after you.||">

<GLOBAL NOTHING-NEW "This reveals nothing new.|">

<GLOBAL NO-VERB "[There was no verb in that sentence!]|">

;<GLOBAL NOT-APPROPRIATE "This is not the appropriate time or place.|">