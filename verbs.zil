"VERBS for
		      PLUNDERED HEARTS
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

;"subtitle game commands"

<GLOBAL VERBOSITY 1> ;"0 = super-brief, 1 = brief, 2 = verbose"

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSITY 2>
	 <TELL "Maximum verbosity." CR CR>
	 <V-LOOK>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSITY 1>
	 <TELL "B" ,RIEF-DESC>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG VERBOSITY 0>
	 <TELL "Superb" ,RIEF-DESC>>

<ROUTINE V-SAVE ()
	 <SETG P-CONT <>> ;"flush anything on input line after SAVE"
	 <SETG QUOTE-FLAG <>>
	 <COND (<SAVE>
	        <TELL ,OK>)
	       (T
		<TELL ,FAILED>)>>

<ROUTINE V-RESTORE ()
	 <COND (<RESTORE>
	        <TELL ,OK>)
	       (T
		<TELL ,FAILED>)>>

<ROUTINE V-SCRIPT ()
	<PUT 0 8 <BOR <GET 0 8> 1>>
	<CORP-NOTICE "begins">
	<V-VERSION>>

<ROUTINE V-UNSCRIPT ()
	<CORP-NOTICE "ends">
	<V-VERSION>
	<PUT 0 8 <BAND <GET 0 8> -2>>
	<RTRUE>>

<ROUTINE CORP-NOTICE (STRING)
	 <TELL
"Here " .STRING " a transcript of interaction with" CR>>

;<ROUTINE V-DIAGNOSE ()
	 <COND (<EQUAL? ,HERE ,ROAD>
		<TELL
"Your ankle is swelling painfully. It's probably broken." CR>)
	       (T
		<TELL "You are in good health" ,PCR>)>>

<ROUTINE V-INVENTORY ()
	 <COND (<AND <RUNNING? ,I-LSED>
		     <G? ,LAFOND-CTR ,HORNY>>
		<COND (<HELD? ,PINCH>
		       <TELL CTHE ,PINCH " is not enough to cover">)
		      (T
		       <TELL "You blush to look at">)>
		<TELL " your naked body." CR>
		<RTRUE>)>
	 <SETG D-BIT <- ,WORNBIT>>
	 <DESCRIBE-CONTENTS ,WINNER <> <+ ,D-ALL? ,D-PARA?>>
	 ;<COND (<NOT <DESCRIBE-CONTENTS ,WINNER <> <+ ,D-ALL? ,D-PARA?>>>
		<TELL "You are empty-handed.">)>
	 <SETG D-BIT ,WORNBIT>
	 <DESCRIBE-CONTENTS ,WINNER <> <+ ,D-ALL? ,D-PARA?>>
	 <SETG D-BIT <>>
	 <CRLF>>

;<ROUTINE V-INVENTORY ()
	 <DESCRIBE-CONTENTS ,PROTAGONIST <>> ;"you can't have nothing"
	 <CRLF>>

<ROUTINE V-QUIT ()
	 <V-SCORE>
	 <DO-YOU-WISH "leave the game">
	 <COND (<YES?>
		<QUIT>)
	       (T
		<TELL ,OK>)>>

<ROUTINE V-RESTART ()
	 <V-SCORE>
	 <DO-YOU-WISH "restart">
	 <COND (<YES?>
		<TELL "Restarting." CR>
		<RESTART>
		<TELL ,FAILED>)>>

<ROUTINE DO-YOU-WISH (STRING)
	 <TELL ,INDENT "Do you wish to " .STRING "? (Y is affirmative): ">>

<ROUTINE YES? ()
	 <PRINTI ">">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<YES-WORD <GET ,P-LEXV 1>>
		<RTRUE>)
	       (<OR <NO-WORD <GET ,P-LEXV 1>>
		    <EQUAL? <GET ,P-LEXV 1> ,W?N>>
		<RFALSE>)
	       (T
		<TELL "This is important: please answer YES or NO. ">
		<AGAIN>)>>

<ROUTINE FINISH (;"OPTIONAL" ;(END-OF-GAME <>) "AUX" (REPEATING <>) (CNT 0))
	 <PROG ()
	       <CRLF>
	       <COND (<NOT .REPEATING>
		      <SET REPEATING T>
		      <TELL ,INDENT>
		      <V-SCORE>)>
	       <COND (<G? ,SCORE 24>  ;".END-OF-GAME"
		      <TELL ,INDENT
"Thus you have finished the story of " ,GAME-CAPS ",
earning the title, \"" <GET ,WINNING-RANKS ,FINAL-RANK> ".\"">
		      <COND (<L? ,FINAL-RANK 4>
			     <TELL
" There are other, perhaps more satisfying, conclusions.">)>
		      <CRLF>)>
	       <TELL ,INDENT
"You may start over, restore a saved position, or end
this session of the game. (Type RESTART, RESTORE, or QUIT):|
>">
	       <PUTB ,P-LEXV 0 10>
	       <READ ,P-INBUF ,P-LEXV>
	       <PUTB ,P-LEXV 0 60>
	       <SET CNT <+ .CNT 1>>
	       <COND (<EQUAL? <GET ,P-LEXV 1> ,W?RESTAR>
	              <RESTART>
		      <TELL ,FAILED>
		      <AGAIN>)
	       	     (<AND <EQUAL? <GET ,P-LEXV 1> ,W?RESTOR>
		      	   <NOT <RESTORE>>>
		      <TELL ,FAILED>
		      <AGAIN>)
	       	     (<OR <EQUAL? <GET ,P-LEXV 1> ,W?QUIT ,W?Q>
			  <G? .CNT 10>>
		      <QUIT>)>
	       <AGAIN>>>

<ROUTINE V-VERSION ("AUX" (CNT 17) V)
	 <SET V <BAND <GET 0 1> *3777*>>
	 <TELL ,GAME-CAPS CR
"Infocom interactive fiction|
Copyright (c) 1987 by Infocom, Inc. All rights reserved.|"
,GAME-CAPS " is a trademark of Infocom, Inc.|
Release " N .V " / Serial number ">
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> 23>
			<RETURN>)
		       (T
			<PRINTC <GETB 0 .CNT>>)>>
	 <CRLF>>

<CONSTANT D-RECORD-ON 4>
<CONSTANT D-RECORD-OFF -4>

<ROUTINE V-$COMMAND ()
	 <DIRIN 1>
	 <RTRUE>>

<ROUTINE V-$RANDOM ()
	 <COND (<NOT <PRSO? ,INTNUM>>
		<TELL "ILLEGAL." CR>)
	       (T
		<RANDOM <- 0 ,P-NUMBER>>
		<RTRUE>)>>

<ROUTINE V-$RECORD ()  ;"all READS and INPUTS get sent to command file"
	 <DIROUT ,D-RECORD-ON>
	 <RTRUE>>

<ROUTINE V-$UNRECORD ()
	 <DIROUT ,D-RECORD-OFF>
	 <RTRUE>>

<ROUTINE V-$VERIFY ()
	 <COND (<AND <PRSO? ,INTNUM>
		     <EQUAL? ,P-NUMBER 25>>
		<TELL N ,SERIAL CR>)
	       (T
		<TELL "Verifying." CR>
	 	<COND (<VERIFY>
		       <TELL ,OK>)
	       	      (T
		       <TELL CR "** Bad **" CR>)>)>>

<CONSTANT SERIAL 0>

;<GLOBAL DEBUG <>>

;<ROUTINE V-$DEBUG ()
	 <TELL "O">
	 <COND (,DEBUG
		<SETG DEBUG <>>
		<TELL "ff">)
	       (T
		<SETG DEBUG T>
		<TELL "n">)>
	 <TELL ,PCR>>



;"subtitle real verbs"

<ROUTINE V-ALARM ()
	 <COND (<PRSO? ,ROOMS>
		<PERFORM-PRSA ,ME>
		<RTRUE>)
	       (<PRSO? ,ME>
		<TELL "You pinch yourself. " ,YOU-ARENT " dreaming" ,PCR>)
	       (<AND <NOT <FSET? ,PRSO ,DEADBIT>>
		     <OR <FSET? ,PRSO ,ACTORBIT>
			 <PRSO? ,CROC>>>
		<PRONOUN>
		<TELL " isn't asleep." CR>)
	       (T
		<IMPOSSIBLES>)>>

;<ROUTINE V-ANSWER ()
	 <COND (<AND ,AWAITING-REPLY
		     <YES-WORD <GET ,P-LEXV ,P-CONT>>>
	        <V-YES>
		<STOP>)
	       (<AND ,AWAITING-REPLY
		     <NO-WORD <GET ,P-LEXV ,P-CONT>>>
		<V-NO>
		<STOP>)
	       (T
		<TELL "Nobody is awaiting your answer." CR>
	        <STOP>)>>

<ROUTINE V-ANSWER-KLUDGE ()
	 <COND (<NOUN-USED ,W?I ,ME>
		<V-INVENTORY>)
	       (T
	 	<SETG P-WON <>>
		<TELL ,NO-VERB>
		<STOP>)>>

<GLOBAL AWAITING-FAKE-ORPHAN <>>

;<ROUTINE ORPHAN-VERB ()
	 ;<COND (<NOT <EQUAL? ,HERE ,AUDIENCE-CHAMBER ,BEDROOM>>
		<SETG AWAITING-FAKE-ORPHAN <>>
		<RFALSE>)>
	 <PUT ,P-VTBL 0 ,W?ZZMGCK>
	 ;<PUT ,P-OVTBL 0 ,W?ANSWER>	;"maybe fix 'what do you want to'"
	 <PUT ,P-OTBL ,P-VERB ,ACT?ZZMGCK>
	 <PUT ,P-OTBL ,P-VERBN ,P-VTBL>
	 <PUT ,P-OTBL ,P-PREP1 0>
	 <PUT ,P-OTBL ,P-PREP1N 0>
	 <PUT ,P-OTBL ,P-PREP2 0>
	 <PUT ,P-OTBL 5 0>
	 <PUT ,P-OTBL ,P-NC1 1>
	 <PUT ,P-OTBL ,P-NC1L 0>
	 <PUT ,P-OTBL ,P-NC2 0>
	 <PUT ,P-OTBL ,P-NC2L 0>
	 <SETG P-OFLAG T>>

<ROUTINE V-APPLAUD ()
	 <TELL "Clap." CR>>

;<ROUTINE V-APPLY ()
	 <COND (<FSET? ,PRSO ,WEARBIT>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (T
		<SETG AWAITING-REPLY 2>
		<QUEUE I-REPLY 2>
		<TELL "Apply" T ,PRSO " for what? A job?" CR>)>> 


<ROUTINE V-ASK-ABOUT ("AUX" OWINNER)
	 <COND (<PRSO? ,ME>
		<PERFORM ,V?TELL ,ME>
		<RTRUE>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<SET OWINNER ,WINNER>
		<SETG WINNER ,PRSO>
		<PERFORM ,V?TELL-ABOUT ,ME ,PRSI>
		<SETG WINNER .OWINNER>
		<THIS-IS-IT ,PRSI>
		<THIS-IS-IT ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)>>

<ROUTINE V-ASK-FOR ()
	 <TELL "Naturally," T ,PRSO " doesn't oblige." CR>>

<ROUTINE V-ASK-NO-ONE-FOR ("AUX" ACTOR)
	 <COND (<SET ACTOR <FIND-IN ,HERE ,ACTORBIT>>
		<PERFORM ,V?ASK-FOR .ACTOR ,PRSO>
		<RTRUE>)
	       (T
		<NO-ONE-HERE "ask">)>>

;<ROUTINE V-BARTER-WITH ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "But" T ,PRSO " has nothing worth trading for." CR>)
	       (T
		<IMPOSSIBLES>)>>

;<ROUTINE V-BARTER-FOR ()
	 <IMPOSSIBLES>>


<ROUTINE V-BITE ()
	 <HACK-HACK "Biting">>

<ROUTINE V-BLOW ()
	  <CANT-VERB-A-PRSO "blow">>

<ROUTINE PRE-BOARD ()
	 <COND (<IN? ,PROTAGONIST ,PRSO>
		<TELL ,LOOK-AROUND>)
	       (<HELD? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (<UNTOUCHABLE? ,PRSO>
		<CANT-REACH ,PRSO>)>>

<ROUTINE V-BOARD ("AUX" (AV <LOC ,PROTAGONIST>))
	 <COND (<FSET? ,PRSO ,VEHBIT>
		;<COND (<NOT <EQUAL? <LOC ,PRSO> ,HERE ,LOCAL-GLOBALS>>
		       <TELL ,YOU-CANT "board" T ,PRSO " when it's ">
		       <COND (<FSET? <LOC ,PRSO> ,SURFACEBIT>
			      <TELL "on">)
			     (T
			      <TELL "in">)>
		       <TELL TR <LOC ,PRSO>>
		       <RTRUE>)>
		<MOVE ,PROTAGONIST ,PRSO>
		<TELL "You are now ">
		<COND (<FSET? ,PRSO ,INBIT>
		       <TELL "i">)
		      (T
		       <TELL "o">)>
		<TELL "n" T ,PRSO ".">
		<APPLY <GETP <LOC ,PROTAGONIST> ,P?ACTION> ,M-ENTER>
		<CRLF>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL ,POLITE-SOCIETY>)
	       (<EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?IN>
		<CANT-VERB-A-PRSO "get into">)
	       (T
		<CANT-VERB-A-PRSO "get onto">)>>

<ROUTINE V-BRIBE ()
	 <COND (<NOT ,PRSI>
		<COND (<HELD? ,BANKNOTE>
		       <PERFORM ,V?GIVE ,BANKNOTE ,PRSO>
		       <RTRUE>)
		      (T
		       <TELL "A lady bribes only with money" ,PCR>)>)
	       (T
		<PERFORM ,V?GIVE ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-BURN ()
	 <COND (<AND <NOT ,PRSI>
		     <NOT <OR <GLOBAL-IN? ,FIRE ,HERE>
			      <GLOBAL-IN? ,TORCH ,HERE>>>>
		<TELL "You have no source of fire." CR>)
	       (T
		<TELL "Ladies do not play with fire." CR>
		<RTRUE>)>
	 <COND ;(<IN? ,PROTAGONIST ,PRSO>
		<DO-FIRST "leave" ,PRSO>)
	       (<FSET? ,PRSO ,WORNBIT>
		<TELL
"Unless you relish a fiery death, you had best remove" TR ,PRSO>)
	       (<PRSO? ,POWDER>
		<TELL
"Papa says never put " D ,POWDER " near a flame." CR>)
	       (<HELD? ,PRSO>
		<DO-FIRST "drop" ,PRSO>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL ,UNLADY>)
	       (<FSET? ,PRSO ,BURNBIT>
		<REMOVE ,PRSO>
		<TELL
"In an instant," T ,PRSO " is consumed by fire." CR>)
	       (T
		<CANT-VERB-A-PRSO "burn">)>>

;<ROUTINE V-BUY ()
	 <TELL "Sorry, there aren't any on sale here." CR>>

;<ROUTINE V-BUY-WITH ()
	 <COND (<PRSI? ,ONE-MARSMID-COIN ,TEN-MARSMID-COIN>
		<PERFORM ,V?BUY ,PRSO>
		<RTRUE>)
	       (T
		<TELL
"That must be a queer planet you come from, where" A ,PRSI
" is a unit of money." CR>)>>

;<ROUTINE V-CALL ()
	 <COND (<FSET? ,PRSO ,RLANDBIT>
		<V-SCREAM>)
	       (<NOT <VISIBLE? ,PRSO>>
	        <CANT-SEE ,PRSO>)
	       (T
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)>>

;<ROUTINE V-CAST-OFF ()
	 <COND (<PRSO? ,ROOMS>
		<PERFORM ,V?LAUNCH <LOC ,PROTAGONIST>>
		<RTRUE>)
	       (T
		<PERFORM ,V?TAKE-OFF ,PRSO>
		<RTRUE>)>>

;<ROUTINE V-CATCH ()
	 <TELL "The only thing you're good at catching is a cold." CR>>

<GLOBAL CHASTISED? <>>

<ROUTINE V-CHASTISE ()
	 <COND (<PRSO? ,INTDIR>
		<TELL
,YOULL-HAVE-TO "go in that " D ,INTDIR " to see what's there." CR>)
	       (T
		<COND (<NOT ,CHASTISED?>
		       <TELL
"You may use prepositions to indicate precisely what you want to do: LOOK AT
the object, LOOK INSIDE it, LOOK UNDER it, etc. In this case I'll take you
to mean LOOK AT the object." CR ,INDENT>
		       <SETG CHASTISED? T>)>
		<COND (<PRSO? ,ROOMS>
		       <PERFORM ,V?LOOK>)
		      (T
		       <PERFORM ,V?EXAMINE ,PRSO>)>
		<RTRUE>)>>

<ROUTINE V-CLEAN ()
	 <SETG AWAITING-REPLY 2>
	 <QUEUE I-REPLY 2>
	 <TELL "Do you also do windows?" CR>>


<ROUTINE V-CLIMB ()
	 <COND (<AND <EQUAL? ,PRSO ,INTDIR>
		     <EQUAL? ,P-PRSA-WORD ,W?CRAWL>>
		<DO-WALK ,P-DIRECTION>
		<RTRUE>) 
	       (<PRSO? ,ROOMS>
		<DO-WALK ,P?UP>)
	       (<HELD? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (T
		<IMPOSSIBLES>)>>


<ROUTINE V-CLIMB-DOWN ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?DOWN>)
	       (<HELD? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<OR <FSET? ,PRSO ,VEHBIT>
		    <FSET? ,PRSO ,ACTORBIT>>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (<HELD? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (<EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?IN ;,PR?INSIDE>
		<CANT-VERB-A-PRSO "climb into">)
	       (T
		<CANT-VERB-A-PRSO "climb onto">)>>


<ROUTINE V-CLIMB-OVER ()
	 <COND (<HELD? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (T
	 	<IMPOSSIBLES>)>>

;<ROUTINE V-CLIMB-UP ()             ;"Used in GO UP, CLIMB UP and WALK UP."
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?UP>)
	       (<HELD? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CLOSE ()
	 <COND (<AND <OR <FSET? ,PRSO ,DOORBIT>
			 <FSET? ,PRSO ,CONTBIT>>
		     <NOT <FSET? ,PRSO ,SURFACEBIT>>
		     <NOT <FSET? ,PRSO ,ACTORBIT>>
		     <NOT <PRSO? ,CROC ,GARTER ,RIGGING-OBJECT>>>
		<OPEN-CLOSE ,PRSO>)
	       (T
		<CANT-VERB-A-PRSO "close">)>>


;<ROUTINE V-COUNT ()
	 <IMPOSSIBLES>>

<ROUTINE V-CRAWL-UNDER ()
	 <COND (<NOT <FSET? ,PRSO ,TAKEBIT>>
	        <TELL-HIT-HEAD>)
	       (T
		<IMPOSSIBLES>)>>

;<ROUTINE V-CROSS ()
	 <V-WALK-AROUND>>

<ROUTINE V-CRY ()
	 <NO-TIME-FOR "have hysterics">>

<ROUTINE V-CUT ()
	 <COND (<OR <NOT ,PRSI>
		    <EQUAL? ,PRSI ,ROOMS>>
		<COND (<HELD? ,DAGGER>
		       <PERFORM ,V?CUT ,PRSO ,DAGGER>
		       <RTRUE>)
		      (<FSET? ,PRSO ,ACTORBIT>
		       <PERFORM ,V?KILL ,PRSO>
		       <RTRUE>)
		      (T
		       <TELL "Your fingernails aren't that sharp!" CR>)>)
	       (T
		<TELL
"To put it bluntly, neither" T ,PRSI " nor you are very sharp" ,PCR>)>>

<ROUTINE V-DANCE ("AUX" OW)
	 <COND (<AND <NOT <EQUAL? ,WINNER ,PROTAGONIST>>
		     <EQUAL? ,PRSO <> ,ME ,PROTAGONIST>>
		<SET OW ,WINNER>
		<SETG WINNER ,PROTAGONIST>
		<PERFORM ,V?DANCE .OW>
		<SETG WINNER .OW>
		<RTRUE>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<COND (<NOT <EQUAL? ,HERE ,BALLROOM ,ORCHESTRA>>
		       <TELL "This isn't a good place to dance" ,PCR>)
		      (T
		       <TELL
"It is unlikely" T ,PRSO " would want to dance just now." CR>)>)
	       (<PRSO? ,ME ,ROOMS>
		<COND (,PARTNER
		       <TELL ,PACE>)
		      (T		    
		       <TELL "One cannot dance the minuet alone." CR>)>)
	       (T
		<TELL
"Dancing with" A ,PRSO " is an early symptom of the plague." CR>)>>

;<ROUTINE V-DEFLATE ()
	 <IMPOSSIBLES>>

;<ROUTINE V-DIG ()
	 <WASTES>>

<ROUTINE V-DISEMBARK ()
	 <COND (<NOT ,PRSO>
		<COND (<NOT <IN? ,PROTAGONIST ,HERE>>
		       <PERFORM-PRSA <LOC ,PROTAGONIST>>
		       <RTRUE>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	  ;"And since GET OUT is also TAKE OUT"
	       (<EQUAL? ,P-PRSA-WORD ,W?TAKE>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<AND <EQUAL? ,PRSO ,LEDGE>
		     <EQUAL? ,HERE ,CABIN>>
		<PERFORM ,V?CLIMB-ON ,PRSO>
		<RTRUE>)
	       (<NOT <IN? ,PROTAGONIST ,PRSO>>
		<TELL ,LOOK-AROUND>
		<RFATAL>)
	       (<EQUAL? ,HERE ,BY-SHIP ,LAGOON>
		<V-SWIM>)
	       (T
		<MOVE ,PROTAGONIST ,HERE>
		<TELL "You">
		<COND (<IN? ,HERO ,PRSO>
		       <MOVE ,HERO ,HERE>
		       <TELL " and " D ,HERO>)>
		<TELL " get o">
		<COND (<OFF-VEHICLE? ,PRSO>
		       <TELL "ff">)
		      (T
		       <TELL "ut of">)>
		<TELL T ,PRSO ".">
		<CRLF>)>>

<ROUTINE V-DRESS ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "There's no need for that." CR>
		       ;<PRONOUN>
		       ;<COND (<FSET? ,PRSO ,FEMALEBIT>
			      <TELL "Sh">)
			     (T
			      <TELL "H">)>
		       ;<TELL " is dressed!" CR>)
		      (T
		       <IMPOSSIBLES>)>)
	       (T
		<SETG PRSO ,ROOMS>
		<V-GET-DRESSED>)>>

<ROUTINE V-DRINK ()
	 <CANT-VERB-A-PRSO "drink">>

<ROUTINE V-DRINK-FROM ()
	 <CANT-VERB-A-PRSO "drink from">>

<ROUTINE V-DROP ()
	 <COND (<NOT <SPECIAL-DROP>>
		<COND (<EQUAL? <LOC ,PROTAGONIST> ,SKIFF ,CASK>
		       <MOVE ,PRSO <LOC ,PROTAGONIST>>)
		      (T
		       <MOVE ,PRSO ,HERE>)>
		<TELL "Dropped." CR>)>>

<ROUTINE SPECIAL-DROP () ;"used by drop and throw"
	 <COND (<EQUAL? ,HERE ,BOWSPRIT ,ON-LADDER>
		<REMOVE ,PRSO>
		<TELL "With a splash," T ,PRSO " is lost forever." CR>)
	       (<EQUAL? <LOC ,PROTAGONIST> ,SHALLOWS>
		<REMOVE ,PRSO>
		<TELL "With a plop," T ,PRSO " is dragged out by a wave." CR>)
	       (<OR <EQUAL? ,HERE ,RIGGING-ROOM>
		    <AND <EQUAL? ,HERE ,CROWS-NEST>
			 <VERB? THROW>>>
		<COND (<AND <FSET? ,PRSO ,WEARBIT>
			    <NOT <FSET? ,PRSO ,WORNBIT>>>
		       <MOVE ,PRSO ,HERE>
		       <TELL "Billowing out," T ,PRSO " catch">
		       <COND (<NOT <FSET? ,PRSO ,PLURALBIT>>
			      <TELL "es">)>
		       <TELL " in" T ,RIGGING-OBJECT " nearby." CR>)
		      (T
		       <MOVE ,PRSO ,WHICH-MAST?>
		       <TELL CTHE ,PRSO " falls to the deck below." CR>)>)>>

<ROUTINE V-EAT ()
	 <TELL
"A lady is trained to eat anything, but this is absurd" ,PCR>>

<ROUTINE V-EMBRACE ()
	 <COND (<TOUCHING? ,PRSO>
		<TELL "You give" T ,PRSO " a brief embrace">
		<COND (<NOT <FSET? ,PRSO ,ACTORBIT>>
		       <TELL
" and are not surprised when it doesn't respond">)>
		<TELL ,PCR>)
	       (<IN? ,PRSO ,GLOBAL-OBJECTS>
		<IMPOSSIBLES>)
	       (T
		<CANT-REACH ,PRSO>)>>

<ROUTINE V-EMPTY ("AUX" OBJ NXT)
	 <COND (<NOT ,PRSI>
		<SETG PRSI ,GROUND>)>
	 <COND (<NOT <FSET? ,PRSO ,CONTBIT>>
		<TELL ,HUH>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL "But" T ,PRSO " isn't open." CR>)
	       (<NOT <FIRST? ,PRSO>>
		<TELL "But" T ,PRSO " is already empty!" CR>)
	       (<AND <PRSI? <FIRST? ,PRSO>>
		     <NOT <NEXT? ,PRSI>>>
		<TELL ,THERES-NOTHING "in" T ,PRSO " but" TR ,PRSI>)
	       (T
		<SET OBJ <FIRST? ,PRSO>>
		<REPEAT ()
			<SET NXT <NEXT? .OBJ>>
			<COND (<NOT <EQUAL? .OBJ ,PROTAGONIST>>
			       <TELL D .OBJ ": ">
			       <COND (<FSET? .OBJ ,TAKEBIT>
				      <MOVE .OBJ ,PROTAGONIST>
				      <COND (<PRSI? ,HANDS>
					     <TELL "Taken." CR>)
					    (<PRSI? ,GROUND>
					     <PERFORM ,V?DROP .OBJ>)
					    (<FSET? ,PRSI ,SURFACEBIT>
					     <PERFORM ,V?PUT-ON .OBJ ,PRSI>)
					    (T
					     <PERFORM ,V?PUT .OBJ ,PRSI>)>)
				     (T
				      <WASTES>)>)>
			<COND (.NXT
			       <SET OBJ .NXT>)
			      (T
			       <RETURN>)>>)>>

<ROUTINE V-EMPTY-FROM ()
	 <COND (<IN? ,PRSO ,PRSI>
		<COND (<FSET? ,PRSO ,TAKEBIT>
		       <MOVE ,PRSO ,PROTAGONIST>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)
		      (T
		       <WASTES>)>)
	       (T
		<NOT-IN>)>>

<ROUTINE V-ENTER ()
	<COND (<FSET? ,PRSO ,DOORBIT>
	       <DO-WALK <OTHER-SIDE ,PRSO>>
	       <RTRUE>)
	      (<FSET? ,PRSO ,VEHBIT>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<FSET? ,PRSO ,ACTORBIT>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<IN? ,PRSO ,LOCAL-GLOBALS>
	       <IMPOSSIBLES>)
	      (<NOT <FSET? ,PRSO ,TAKEBIT>>
	       <TELL-HIT-HEAD>)
	      (<HELD? ,PRSO>
	       <TELL ,HOLDING-IT>
	       <RTRUE>)
	      (T
	       <IMPOSSIBLES>)>>

<ROUTINE V-EXAMINE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND (<FIRST? ,PRSO>
		       <PERFORM ,V?LOOK-INSIDE ,PRSO>
		       <RTRUE>)
		      (T
		       <NOTHING-INTERESTING>
		       <TELL "about" TR ,PRSO>)>)
	       (<OR <FSET? ,PRSO ,DOORBIT>
		    <FSET? ,PRSO ,SURFACEBIT>>
		<V-LOOK-INSIDE>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <V-LOOK-INSIDE>)
		      (T
		       <TELL "It" ,IS-CLOSED ,PCR>)>)
	       (<FSET? ,PRSO ,LIGHTBIT>
		<TELL "It's o">
		<COND (<FSET? ,PRSO ,ONBIT>
		       <TELL "n">)
		      (T
		       <TELL "ff">)>
		<TELL ,PCR>)
	       (<FSET? ,PRSO ,NARTICLEBIT>
		<SENSE-OBJECT "look">)
	       (<OR <PROB 25>
		    <PRSO? ,PSEUDO-OBJECT>>
		<TELL ,COMMON-LOOKING D ,PRSO ,PCR>)
	       (<PROB 60>
		<NOTHING-INTERESTING>
		<TELL "about" TR ,PRSO>)
	       (T
	        <PRONOUN>
		<TELL " look">
		<COND (<NOT <OR <FSET? ,PRSO ,PLURALBIT>
			        <PRSO? ,ME>>>
		       <TELL "s">)>
		<TELL " like every other " D ,PRSO " you've ever seen." CR>)>>

<ROUTINE NOTHING-INTERESTING ()
	 <TELL ,THERES-NOTHING>
	 <COND (<PROB 25>
		<TELL "unusual">)
	       (<PROB 33>
		<TELL "noteworthy">)
	       (<PROB 50>
		<TELL "extraordinary">)
	       (T
		<TELL "special">)>
	 <TELL " ">>

<ROUTINE V-EXIT ()
	 <COND (<AND ,PRSO
		     <FSET? ,PRSO ,VEHBIT>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (<NOT <IN-EXITABLE-VEHICLE?>>
		<DO-WALK ,P?OUT>)>>

<ROUTINE IN-EXITABLE-VEHICLE? ("AUX" AV)
	 <SET AV <LOC ,PROTAGONIST>>
	 <COND (<OR <EQUAL? .AV ,CASK ,SKIFF ,LEDGE>
		    <EQUAL? .AV ,LAFS-BED ,CAPT-BED ,COT>
		    <EQUAL? .AV ,CABIN-BED>>
		<PERFORM ,V?DISEMBARK <LOC ,PROTAGONIST>>
		<RTRUE>)
	       (T
		<RFALSE>)>
	 <RFALSE>>

<ROUTINE V-FEED ()
	 <MORE-SPECIFIC>>

<ROUTINE V-FIDDLE ()
	 <HACK-HACK "Fiddling with">>

<ROUTINE V-FILL ()
	 <COND (<NOT ,PRSI>
		<TELL ,THERES-NOTHING "to fill it with." CR>)
	       (T 
		<IMPOSSIBLES>)>>

<ROUTINE V-SFILL ()
	 <PERFORM ,V?FILL ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-FIND ("OPTIONAL" (WHERE <>) "AUX" (L <LOC ,PRSO>))
	 <COND (<NOT .L>
		<PRONOUN>
		<TELL " could be anywhere!" CR>)
	       (<IN? ,PRSO ,PROTAGONIST>
		<TELL "You have it!" CR>)
	       (<IN? ,PRSO ,HERE>
		<TELL "Right in front of you." CR>)
	       (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
		    <GLOBAL-IN? ,PRSO ,HERE>
		    <PRSO? ,PSEUDO-OBJECT>>
		<FIGURE-IT-OUT>)
	       (<AND <FSET? .L ,ACTORBIT>
		     <VISIBLE? .L>>
		<TELL "Looks as if" T .L " has it." CR>)
	       (<AND <FSET? .L ,CONTBIT>
		     <VISIBLE? ,PRSO>
		     <NOT <IN? .L ,GLOBAL-OBJECTS>>>
		<COND (<FSET? .L ,SURFACEBIT>
		       <TELL "O">)
		      (<AND <FSET? .L ,VEHBIT>
			    <NOT <FSET? .L ,INBIT>>>
		       <TELL "O">)
		      (T
		       <TELL "I">)>
		<TELL "n" TR .L>)
	       (.WHERE
		<TELL "Beats me." CR>)
	       (T
		<FIGURE-IT-OUT>)>>

<ROUTINE V-FOLLOW ()
	 <COND (<VISIBLE? ,PRSO>
		<TELL "But" T ,PRSO " is right here!" CR>)
	       (<NOT <FSET? ,PRSO ,ACTORBIT>>
		<IMPOSSIBLES>)
	       (T
		<TELL "You have no idea where" T ,PRSO " is." CR>)>>

;<GLOBAL FOLLOW-FLAG <>>

;<ROUTINE I-FOLLOW ()
	 <SETG FOLLOW-FLAG <>>
	 <RFALSE>>

<ROUTINE PRE-GIVE ("AUX" (GLASS <>))
	 <COND (<AND <FSET? ,PRSO ,DEADBIT>
		     <NOT <PRSI? ,SALTS>>>
		<TELL "It's unlikely" T ,PRSO " will want that." CR>)
	       (<AND <VERB? GIVE>
		     <PRSO? ,HANDS>>
		<PERFORM ,V?SHAKE-WITH ,PRSI>
		<RTRUE>)
	       (<AND <PRSO? ,WINE>
		     <OR <HELD? ,BLUE-GLASS>
			 <HELD? ,GREEN-GLASS>>>
		<COND (<HELD? ,BLUE-GLASS>
		       <SET GLASS ,BLUE-GLASS>)
		      (<HELD? ,GREEN-GLASS>
		       <SET GLASS ,GREEN-GLASS>)>
		<PERFORM-PRSA .GLASS ,PRSI>
		<RTRUE>)
	       (<IDROP>
		<RTRUE>)>>

<ROUTINE V-GET-DRESSED ()
	 <COND (<PRSO? ,ROOMS>
		<MORE-SPECIFIC>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-GET-DRUNK ()
	 <COND (<NOT <PRSO? ,ROOMS>>
		<RECOGNIZE>)
	       ;(<EQUAL? ,HERE ,CAPT-QUARTERS>
		<PERFORM ,V?BUY ,BEER>
		<RTRUE>)
	       (T
		<SETG AWAITING-REPLY 2>
		<QUEUE I-REPLY 2>
		<TELL "Here?" CR>)>>

<ROUTINE V-GET-UNDRESSED ()
	 <COND (<PRSO? ,ROOMS>
		<REMOVE-CLOTHES T>
		;<COND (<CHECK-STRIP>
		       <RTRUE>)
		      (T
		       <REMOVE-CLOTHES T>)>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE REMOVE-CLOTHES ("OPTIONAL" (CALLED-BY-GET-UNDRESSED <>) "AUX" X N)
	 <COND (.CALLED-BY-GET-UNDRESSED
		<COND (<LAF-DOFF-CHECK>
		       <RTRUE>)
		      (T
		       <TELL "You">
		       <COND (<AND <NOT <FSET? ,CHEMISE ,EVERYBIT>>
				   <NOT <FSET? ,PANTS ,WORNBIT>>
				   <NOT <FSET? ,SHIRT ,WORNBIT>>>
			      <TELL "'re already stripped!" CR>
			      <RTRUE>)
			     (T
			      <TELL " strip down to your chemise" ,PCR>)>)>)>
	 <SET X <FIRST? ,PROTAGONIST>>
	 <REPEAT ()
		 <COND (<NOT .X>
			<RETURN>)
		       (<FSET? .X ,WORNBIT>
			<FCLEAR .X ,WORNBIT>)>
		 <SET N <NEXT? .X>>
		 <SET X .N>>
	 <MOVE ,RETICULE ,PROTAGONIST>
	 <FSET ,SHOES ,WORNBIT>
	 <FSET ,CHEMISE ,WORNBIT>
	 <FCLEAR ,CHEMISE ,EVERYBIT>
	 <SETG BOY-DRESS? <>>
	 T>

;<ROUTINE REMOVE-CLOTHES ("OPTIONAL" (CALLED-BY-GET-UNDRESSED <>) "AUX" X N)
	 <COND (.CALLED-BY-GET-UNDRESSED
		<COND (<AND <EQUAL? ,HERE ,LAFS-ROOM>
			    <IN? ,LAFOND ,HERE>>
		       <COND (<G? ,LAFOND-CTR ,HORNY>
			      <TELL ,THERES-NOTHING "to remove!" CR>)
			     (T
			      <TELL
D ,LAFOND " chuckles. \"No, ma cherie, ">
			      <COND (<L? ,LAFOND-CTR 3>
				     <TELL "have some wine first.\"" CR>
				     <RTRUE>)
				    (T
				     <TELL "I'll do that.\"" CR>
				     <SETG LAFOND-CTR ,HORNY>
				     <QUEUE I-LSED -1>)>)>
		       <RTRUE>)
		      (T
		       <TELL "You">
		       <COND (<AND <NOT <FSET? ,CHEMISE ,EVERYBIT>>
				   <NOT <FSET? ,PANTS ,WORNBIT>>
				   <NOT <FSET? ,SHIRT ,WORNBIT>>>
			      <TELL "'re already stripped!" CR>
			      <RTRUE>)
			     (T
			      <TELL " strip down to your chemise" ,PCR>)>)>)>
	 <SET X <FIRST? ,PROTAGONIST>>
	 <REPEAT ()
		 <COND (<NOT .X>
			<RETURN>)
		       (<FSET? .X ,WORNBIT>
			<FCLEAR .X ,WORNBIT>)>
		 <SET N <NEXT? .X>>
		 <SET X .N>>
	 <MOVE ,RETICULE ,PROTAGONIST>
	 <FSET ,SHOES ,WORNBIT>
	 <FSET ,CHEMISE ,WORNBIT>
	 <FCLEAR ,CHEMISE ,EVERYBIT>
	 <SETG BOY-DRESS? <>>
	 T>

<ROUTINE V-UNDRESS ()
	 <COND (,PRSO
		<COND (<PRSO? ,DAD>
		       <SETG AWAITING-REPLY 2>
		       <QUEUE I-REPLY 2> 
		       <TELL "Undress your father?!" CR>)
		      (<PRSO? ,ME>
		       <PERFORM ,V?GET-UNDRESSED ,ROOMS>
		       <RTRUE>)
		      (<AND <FSET? ,PRSO ,ACTORBIT>
			    <NOT <FSET? ,PRSO ,FEMALEBIT>>>
		       <TELL ,MOTHER>
		       ;<TELL
"You've got it backwards -- he's supposed to do that to you" ,PCR>)
		      (T <IMPOSSIBLES>)>)
	       (T
		<SETG PRSO ,ROOMS>
		<V-GET-UNDRESSED>)>>

<ROUTINE V-GIVE ()
	 <COND (<FSET? ,PRSI ,ACTORBIT>
		<COND (<FSET? ,PRSI ,DEADBIT>
		       <TELL ,DOESNT-RESPOND>)
		      (T
		       <TELL "Briskly," T ,PRSI " refuses your offer." CR>)>)
	       (T
		<TELL ,YOU-CANT "give" A ,PRSO " to" A ,PRSI "!" CR>)>>

;<ROUTINE V-GIVE-UP ()
	 <COND (<PRSO? ,ROOMS>
		<V-QUIT>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-HELLO ()
       <COND (,PRSO
	      <COND (<EQUAL? ,PRSO ,W?SAILOR>
		     <TELL "Nothing happens" ,PCR>)
		    (T 
		     <TELL
"[The proper way to talk to characters in the story is PERSON, HELLO.]" CR>)>)
	     (<AND <EQUAL? ,HERE ,CABIN>
		   <IN? ,HERO ,HERE>>
	      <PERFORM ,V?HELLO ,HERO>
	      <RTRUE>)
	     (T
	      <PERFORM ,V?TELL ,ME>
	      <RTRUE>)>>

<ROUTINE V-HALT ()
	 <COND (<PRSO? ,ROOMS>
		<TELL "You haven't started" ,PCR>)
	       (T
		<PROPOSE>)>>

<ROUTINE V-HELP ()
	 <TELL
"If you're feeling pillaged, maps and hint booklets are available from your
dealer, or via mail order with the form">
	 <IN-PACKAGE>>

<ROUTINE V-HIDE ()
	 <TELL ,YOU-CANT "hide ">
	 <COND (,PRSO
		<TELL "t">)>
	 <TELL "here." CR>>

<ROUTINE V-I-LOVE-YOU ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?I>
		<TELL "[Why... I'm speechless! Thank you.]" CR>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-IN ("AUX" VEHICLE)
	 <DO-WALK ,P?IN>>

;<ROUTINE V-INFLATE ()
	 <IMPOSSIBLES>>

;<ROUTINE V-INHALE ()
	 <COND (<NOT ,PRSO>
		<COND (<EQUAL? ,P-PRSA-WORD ,W?GASP>
		       <PERFORM ,V?INHALE ,ROOMS>
		       <RTRUE>)
		      (T
		       <TELL ,OK>)>)
	       (<PRSO? ,ROOMS>
		<TELL "You get light-headed." CR>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-KICK ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND (<FSET? ,PRSO ,DEADBIT>
		       <TELL ,DOESNT-RESPOND>)
		      (T
		       <TELL "\"Hey! Cut that out!\"" CR>)>)
	       (T
		<HACK-HACK "Kicking">)>>

<ROUTINE V-KILL ()
	 <TELL "Relax." CR>>

<ROUTINE V-KISS ()
	 <TELL "\"Smooch!\"" CR>>

;<ROUTINE V-KISS-ON ()
	 <V-KISS>>

<ROUTINE V-CURTSEY ()
	 <TELL "You curtsey gracefully." CR>>

<ROUTINE V-KNOCK ()
	 <HACK-HACK "Knocking on">
	 ;<COND (<AND <PRSO? ,LDOOR>
		     <NOT <FSET? ,LDOOR ,LOCKEDBIT>>
		     <IN? ,LAFOND ,LAFS-ROOM>>
		<TELL "Lafond calls, \"Come.\"" CR>)
	       (<FSET? ,PRSO ,DOORBIT>
		<TELL "Silence answers back." CR>)
	       (T
		<HACK-HACK "Knocking on">)>>

;<ROUTINE V-LAND ()
	 <COND (<NOT ,PRSO>
		<PERFORM-PRSA <LOC ,PROTAGONIST>>
		<RTRUE>)
	       (T
	 	<TELL ,HUH>)>>

<ROUTINE V-LAUGH ()
	 <TELL "\"Ha-ha.\"" CR>>

<ROUTINE V-LAUNCH ()
	 <TELL "Your brain is out to launch." CR>>

<ROUTINE V-LEAP ()
	 <COND (<OR <NOT ,PRSO>
		    <PRSO? ,ROOMS>>
		<COND (<AND <EQUAL? ,HERE ,DUNGEON>
			    <FSET? ,TRAP ,OPENBIT>>
		       <PERFORM ,V?ENTER ,TRAP>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,RIGGING-ROOM ,CROWS-NEST ,BOWSPRIT>
		       <TELL ,SUICIDE>)
		      (T
		       <WHEE>)>)
	       (<NOT <IN? ,PRSO ,HERE>>
		<IMPOSSIBLES>)
	       (T
		<WHEE>)>>

<ROUTINE V-LEAP-OFF ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (<SHIP-BOARD ,HERE>
		<TELL ,SUICIDE>)
	       (T
		<PERFORM ,V?LEAP ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LEAP-OVERBOARD ()
	 <COND (<SHIP-BOARD ,HERE>
		<TELL ,SUICIDE>)
	       (T
		<IMPOSSIBLES>)>>
		      

<ROUTINE V-LEAVE ()
	 <COND (<NOT ,PRSO>
		<SETG PRSO ,ROOMS>)>
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?OUT>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)>>


<ROUTINE V-LIE-DOWN ()
	 ;<COND (<AND <EQUAL? ,HERE ,BEDROOM>
		     <PRSO? ,ROOMS>>
		<SETG PRSO ,BED>)>
	 <COND (<OR <FSET? ,PRSO ,VEHBIT>
		    <FSET? ,PRSO ,ACTORBIT>>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (T
	        <WASTES>)>>

;<ROUTINE V-LIMBER ()
	 <TELL "Ahhh. Nothing like a little muscle-loosening." CR>>


<ROUTINE V-LISTEN ()
	 <COND ;(<RUNNING? ,I-OVERHEAR-CRULLEY>
		<TELL D ,CRULLEY " is muttering to himself" ,PCR>)
	       (<RUNNING? ,I-LUCY>
		<PERFORM ,V?LISTEN ,LUCY>
		<RTRUE>)
	       (<OR <IN? ,HERO ,HERE>
		    <IN? ,DAD ,HERE>
		    <IN? ,LAFOND ,HERE>
		    <IN? ,COOKIE ,HERE>>
		<TELL "You listen intently" ,PCR>)
	       (<PRSO? ,PATROL>
		<TELL CTHE ,PATROL " confers quietly." CR>)
	       (<RUNNING? ,I-PIRATE-RESCUE>
		<TELL ,THE-BALLROOM "tumult of screams." CR>)
	       (<AND <EQUAL? ,HERE ,ORCHESTRA ,BALLROOM ,SUPPER-ROOM>
		     <NOT ,ENDGAME>>
		<TELL "The orchestra plays a sprightly dance tune." CR>)
	       (,PRSO
		<SENSE-OBJECT "sound">) 
	       (T
		<TELL "You hear nothing of interest." CR>)>>

<ROUTINE PRE-LOCK ()
	 <COND (<AND <EQUAL? ,HERE ,QUARTERDECK ,LANDING>
		     <EQUAL? ,P-PRSA-WORD ,W?UNBAR>>
		<RFALSE>)
	       (<AND <PRSO? ,FLOWER>
		     <VERB? PICK>>
		<PERFORM ,V?TAKE ,FLOWER>
		<RTRUE>)
	       (<AND <PRSO? ,HERO>
		     <EQUAL? ,HERE ,DUNGEON>>
		<COND (,PRSI
		       <PERFORM ,V?UNLOCK ,MANACLES ,PRSI>
		       <RTRUE>)
		      (T
		       <PROPOSE>)>)
	       (<OR <AND <NOT <FSET? ,PRSO ,LOCKEDBIT>>
			 <VERB? UNLOCK PICK>>
		    <AND <FSET? ,PRSO ,LOCKEDBIT>
			 <VERB? LOCK>>>
		<COND (<PRSO? ,MANACLES>
		       <TELL ,ALREADY-ARE>)
		      (T
		       <TELL ,ALREADY-IS>)>)
	       (<NOT ,PRSI>
		<COND (<AND <VERB? PICK>
			    <HELD? ,JEWEL>>
		       <TELL "[with" T ,JEWEL "]" CR>
		       <PERFORM-PRSA ,PRSO ,JEWEL>)
		      (<HELD? ,LARGE-KEY>
		       <TELL "[with" T ,LARGE-KEY "]" CR>
		       <PERFORM-PRSA ,PRSO ,LARGE-KEY>)
		      ;(<HELD? ,BENT-KEY>
		       <TELL "[with" T ,BENT-KEY "]" CR>
		       <PERFORM-PRSA ,PRSO ,BENT-KEY>)
		      (T
		       <PROPOSE>
		       <RTRUE>)>)
	       (T
		<RFALSE>)>> 

;<ROUTINE V-LOCK ()
	 <WASTES>>

;<ROUTINE PRE-LOOK ()
	 <COND (<PLAYER-CANT-SEE>
		<RTRUE>)>>

<ROUTINE V-LOOK ()
	 <COND (<DESCRIBE-ROOM T>
	 	<DESCRIBE-OBJECTS>)>
	 <RTRUE>>

<ROUTINE V-LOOK-BEHIND ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>
	 <TELL "There is nothing behind" TR ,PRSO>>

<ROUTINE V-LOOK-DOWN ()
	 <COND (<PRSO? ,ROOMS>
		<PERFORM ,V?EXAMINE ,GROUND>
		<RTRUE>)
	       (T
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL ,IT-SEEMS-THAT>
		<COND (<FSET? ,PRSO ,FEMALEBIT>
		       <TELL " sh">)
		      (T
		       <TELL " h">)>
		<TELL "e has">
		<COND (<NOT <DESCRIBE-NOTHING>>
		       <TELL ,PCR>)>
		<RTRUE>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<DESCRIBE-VEHICLE>)
	       (<FSET? ,PRSO ,SURFACEBIT>
		<TELL ,YOU-SEE>
		<COND (<NOT <DESCRIBE-NOTHING>>
		       <TELL " on" TR ,PRSO>)>
		<RTRUE>)
	       (<FSET? ,PRSO ,DOORBIT>
		<TELL "You can only tell that" T ,PRSO " is">
		<TELL-OPEN/CLOSED ,PRSO>
		<TELL ".|">)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<SEE-INSIDE? ,PRSO>
		       <TELL ,YOU-SEE>
		       <COND (<NOT <DESCRIBE-NOTHING>>
			      <TELL " in" TR ,PRSO>)>
		       <RTRUE>)
		      (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
			    <FIRST? ,PRSO>>
		       <COND (<PRE-TOUCH>
			      <RTRUE>)>
		       <PERFORM ,V?OPEN ,PRSO>
		       <RTRUE>)
		      (T
		       <DO-FIRST "open" ,PRSO>)>)
	       (<EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?IN ;,PR?INSIDE>
		<CANT-VERB-A-PRSO "look inside">)
	       (T
		<TELL
"Even if Queen Augusta commanded it, you couldn't see through that" ,PCR>)>>

;<ROUTINE V-LOOK-OVER ()
	 <V-EXAMINE>>

<ROUTINE V-LOOK-UNDER ()
	 <COND (<HELD? ,PRSO>
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL "You're wearing it!" CR>)
		      (T
		       <TELL ,HOLDING-IT>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<TELL "The space is too narrow to see anything." CR>)
	       (T
		<NOTHING-INTERESTING>
		<TELL "under" TR ,PRSO>)>>

<ROUTINE V-LOOK-UP ()
	 <COND (<PRSO? ,ROOMS>
		<COND (<EQUAL? ,HERE ,RIGGING-ROOM ,CROWS-NEST>
		       <TELL ,YOU-SEE " a mess of sails and rope." CR>)
		      (<FSET? ,HERE ,INDOORSBIT>
		       <PERFORM ,V?EXAMINE ,CEILING>
		       <RTRUE>)
		      (T      
		       <TELL
"The midnight sky is clear of all but a full moon." CR>)>)
	       (T
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>>

;<ROUTINE V-LOVE ()
	 <COND (<PRSO? ,LAFOND ,CRULLEY>
		<TELL "Never!" CR>)
	       (T
		<LADY-MUST "loving">
		;<TELL
"A lady must obtain her father's permission before loving anyone." CR>
		;<TELL "Not difficult, considering how lovable" T ,PRSO " ">
		;<COND (<FSET? ,PRSO ,PLURALBIT>
		       <TELL "are">)
		      (T
		       <TELL "is">)>
		;<TELL ,PCR>)>>

;<ROUTINE V-LOWER ()
	 <V-RAISE>>

;<ROUTINE V-MAKE ()
	 <CANT-VERB-A-PRSO "make">>

;<ROUTINE V-MAKE-LOVE ()
	 ;<COND (<PRSO? ,LOVE>
		<PERFORM ,V?MAKE-OUT ,PRSI>
		<RTRUE>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-MAKE-OUT ("AUX" KISSEE)
	 <COND (<NOT <PRSO? ,ROOMS>>
		<SET KISSEE ,PRSO>)
	       (<NOT <SET KISSEE <FIND-IN ,HERE ,ACTORBIT "with">>>
		<SET KISSEE ,ME>)>
	 <PERFORM ,V?KISS .KISSEE>
	 <RTRUE>>

;<ROUTINE V-MAKE-WITH ()
	 <V-MAKE>>

<ROUTINE V-MARRY ()
	 <COND (<PRSO? ,LAFOND ,CRULLEY ,COOKIE>
	        <TELL "I doubt that" T ,PRSO " is the marrying type." CR>)
	       (<PRSO? ,DAD>
		<TELL "Don't be absurd." CR>)
	       (<PRSO? ,HERO>
		<LADY-MUST "marrying">
		;<TELL
"A lady must obtain her father's permission before marrying anyone." CR>)
	       (T
		<WASTES>)>>

;<ROUTINE V-MOAN ()
	 <TELL "\"Ohhhh...\"" CR>>

<ROUTINE V-MOVE ()
	 <COND (<HELD? ,PRSO>
		<WASTES>)
	       (<LOC-CLOSED>
		<RTRUE>)
	       (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Moving" T ,PRSO " reveals nothing." CR>)
	       (<EQUAL? ,P-PRSA-WORD ,W?PULL>
		<HACK-HACK "Pulling">)
	       (T
		<CANT-VERB-A-PRSO "move">)>>

<ROUTINE V-MUNG ()
	 <HACK-HACK "Trying to destroy">>

<ROUTINE V-MUZZLE ()
	 <HACK-HACK "Trying to muzzle">>

<CONSTANT SHAKE-HEAD "You shake your head">

;"3 - secret door.
  4 - hero, leave me alone.
  5 - I-MEET-HERO
  6 - Dad and garter.
  ;7 - Kitchen, Lucy and ballgown. 
  8 - do you really want to fight the croc?
  9 - Jump to interrupt Lafond.
 10 - Cookie: do you know where hero is?
 11 - Hero: will you go with Lafond?
 12 - Lafond seduction, drink wine"
<ROUTINE V-NO ()
	 <COND (<EQUAL? ,AWAITING-REPLY 1 2>
		<V-YES>)
	       (<EQUAL? ,AWAITING-REPLY 3>
		<TELL
"One should hope not! Lafond is too
respectable to harbour such secrets" ,PCR>)
	       (<EQUAL? ,AWAITING-REPLY 4>
		<TELL
"\"Foolish of me to have thought you were serious,\"
he smiles, relieved" ,PCR>)
	       (<EQUAL? ,AWAITING-REPLY 5>
		<TELL "\"No!\" you say pertly" ,PCR>)
	       (<EQUAL? ,AWAITING-REPLY 6>
		<TELL
"Papa clucks. \"Pity. I'll introduce you to Lucy
after we're out of this mess.\"" CR>)
	       (<EQUAL? ,AWAITING-REPLY 9>
		<TELL ,SHAKE-HEAD " firmly, \"No.\"" CR>)
	       (<EQUAL? ,AWAITING-REPLY 10>
		<TELL ,SHAKE-HEAD ,PCR>)
	       (<EQUAL? ,AWAITING-REPLY 11>
		<TELL "\"No,\" you say, chin trembling" ,PCR>)
	       (<EQUAL? ,AWAITING-REPLY 12>
		<TELL ,SHAKE-HEAD ", teeth clenched." CR>)
	       (<EQUAL? ,AWAITING-REPLY 13>
		<TELL
"\"God's blood! We'll have to find some other way.\"" CR>)
	       (<EQUAL? ,AWAITING-REPLY 14>
		<TELL
"\"Sorry, but I'm enjoying this dance too much to just let you go.\" Jamison
tightens his grip on " D ,HANDS " as you circle each other" ,PCR>)
	       (<EQUAL? ,AWAITING-REPLY 15>
		<TELL ,SHAKE-HEAD " breathlessly." CR>)
	       (<EQUAL? ,AWAITING-REPLY 16>
		<TELL "\"'Tis a pity. I was hoping...\"" CR>)
	       (<EQUAL? ,AWAITING-REPLY 17>
	        <TELL "\"I'll do the hittin' 'ere.\"" CR>)
	       (T
		<YOU-SOUND "nega">)>>

<ROUTINE NO-WORD (WRD)
	 <COND (<OR <EQUAL? .WRD ,W?NO ,W?NOPE>
		    <EQUAL? .WRD ,W?NAY ,W?NEVER>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-OFF ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <FCLEAR ,PRSO ,ONBIT>
		       <TELL "Okay," T ,PRSO " is now off." CR>
		       ;<NOW-DARK?>)
		      (T
		       <TELL "It isn't on!" CR>)>)
	       (T
		<CANT-VERB-A-PRSO "extinguish">
		;<TELL ,YOU-CANT "extinguish that" ,PCR>)>>

<ROUTINE V-ON ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL ,HUH>)
	       (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <TELL ,ALREADY-IS>)
		      (T
		       <FSET ,PRSO ,ONBIT>
		       <TELL "Okay," T ,PRSO " is now on." CR>
		       ;<NOW-LIT?>)>)
	       (T
		<CANT-VERB-A-PRSO "light">
		;<TELL ,YOU-CANT "light that" ,PCR>)>>

;<ROUTINE CANT-TURN (STRING)
	 <TELL ,YOU-CANT "turn that o" .STRING ,PCR>>

<ROUTINE V-OPEN ()
	 <COND (<FSET? ,PRSO ,LOCKEDBIT>
		<TELL  "It's quite locked." CR>
		<RTRUE>)
	       (<AND <OR <FSET? ,PRSO ,DOORBIT>
			 <FSET? ,PRSO ,CONTBIT>>
		     <NOT <FSET? ,PRSO ,SURFACEBIT>>
		     <NOT <FSET? ,PRSO ,ACTORBIT>>>
		<OPEN-CLOSE ,PRSO>)
	       (T
		<CANT-VERB-A-PRSO "open">)>>

;<ROUTINE V-PAY ()
	 <COND (<HELD? ,ONE-MARSMID-COIN>
		<PERFORM ,V?GIVE ,ONE-MARSMID-COIN ,PRSO>
		<RTRUE>)
	       (<HELD? ,TEN-MARSMID-COIN>
		<PERFORM ,V?GIVE ,TEN-MARSMID-COIN ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You have no money!" CR>)>>

<ROUTINE V-PICK ()
	 <COND (<AND <FSET? ,PRSO ,DOORBIT>
		     <HELD? ,JEWEL>>
		<TELL "That doesn't work here" ,PCR>)
	       (T
		<CANT-VERB-A-PRSO "pick">)>>

<ROUTINE V-POINT ()
	 <TELL "That would be pointless." CR>>

<ROUTINE V-SPOINT ()
	 <PERFORM ,V?POINT ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE SPECIFY-WHAT (ACTION-STRING OBJ)
	 <TELL
,YOULL-HAVE-TO "specify what you want to "
.ACTION-STRING T .OBJ " in" ,PCR>>

<ROUTINE PRE-POUR ()
	 <COND (<AND <PRSO? ,WINE>
		     <NOT ,PRSI>
		     <NOT <EQUAL? ,P-PRSA-WORD ,W?SPILL>>>
		<SPECIFY-WHAT "pour" ,PRSO>)
	       (<PRSO? ,BOTTLE ,LAUD>
		<COND (<NOT <HELD? ,PRSO>>
		       <TELL ,YNH TR ,BOTTLE>)
		      (<EQUAL? ,LAUD-LEFT 0>
		       <TELL "There's no " D ,LAUD " left." CR>)
		      (<NOT ,PRSI>
		       <MOVE ,BOTTLE ,PROTAGONIST>
		       <TELL
"A bubble of " D ,LAUD " forms on the tip of"
T ,BOTTLE " then slurps back in." CR>)
		      ;(<NOT ,PRSI>
		       <RFALSE>)
		      (<PRSI? ,WINE>
		       <TELL
,YOULL-HAVE-TO "specify which glass you want to put" T ,LAUD " into." CR>)
		      (<EQUAL? <GETP ,PRSI ,P?CONTENTS> ,POISONED ,W-P>
		       <TELL ,YOU-HAVE-ALREADY
" dosed" T ,PRSI ". Any more might be dangerous" ,PCR>)
		      (T
		       <RFALSE>)>)
	       ;(<PRSI? ,MOUTH>
		<RFALSE>)
	       ;(<NOT ,PRSI>
		 <RFALSE>)>>
 
;<ROUTINE V-POUR ()
	 <IMPOSSIBLES>>

;<ROUTINE V-POUR-FROM ()
	 <PERFORM ,V?EMPTY-FROM ,PRSO ,PRSI>
	 <RTRUE>>

<ROUTINE V-PUSH ()
	 <HACK-HACK "Pushing">>

<ROUTINE V-PUSH-DIR ()
	 <COND (<PRSI? ,INTDIR>
		<V-PUSH>)
	       (T
		<RECOGNIZE>)>>

;<ROUTINE V-PUSH-OFF ()
	 <COND (<AND <PRSO? ,ROOMS ,DOCK-OBJECT ,RAFT ,BARGE>
		     <NOT <IN? ,PROTAGONIST ,HERE>>>
		<PERFORM ,V?LAUNCH <LOC ,PROTAGONIST>>
		<RTRUE>)
	       (T
		<TELL ,HUH>)>>

<ROUTINE PRE-PUT ()
	 <COND (<PRSI? ,GROUND>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<PRSO? ,WINE ,LAUD>
		<PERFORM ,V?POUR ,PRSO ,PRSI>
		<RTRUE>)
	       (<PRSO? ,HANDS>
		<COND (<VERB? PUT>
		       <PERFORM ,V?REACH-IN ,PRSI>
		       <RTRUE>)
		      (T
		       <WASTES>)>)
	       (<AND <PRSI? ,SEA>
		     <EQUAL? ,HERE ,RIGGING-ROOM ,CROWS-NEST ,BOWSPRIT
			     ,POOP ,QUARTERDECK ,MAIN-DECK ,FOCSLE>
		     <VERB? THROW DROP PUT-ON PUT>>
		<RFALSE>)
	       (<AND <FSET? ,PRSI ,ACTORBIT>
		     <NOT <VERB? PUT-ON>>
		     ;<NOT <PRSI? ,CROC>>>
		<WASTES>) 
	       ;(<AND <NOT <FSET? ,PRSI ,BODYBIT>>
		     <PLAYER-CANT-SEE>>		     
		<RTRUE>)
	       (<HELD? ,PRSI ,PRSO>
		<TELL ,YOU-CANT "put" T ,PRSO>
		<COND (<EQUAL? <GET ,P-ITBL ,P-PREP2> ,PR?ON>
		       <TELL " on">)
		      (T
		       <TELL " in">)>
		<TELL T ,PRSI " when" T ,PRSI " is already ">
		<COND (<FSET? ,PRSO ,SURFACEBIT>
		       <TELL "on">)
		      (T
		       <TELL "in">)>
		<TELL T ,PRSO "!" CR>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <NOT <PRSO? ,MANACLES>>>
		<TELL ,YNH TR ,PRSO>)
	       (<UNTOUCHABLE? ,PRSI>
		<CANT-REACH ,PRSI>)
	       (<IDROP>
		<RTRUE>)>>

<ROUTINE V-PUT ()
	 <COND ;(<NOT <OR <FSET? ,PRSI ,OPENBIT>
			 <FSET? ,PRSI ,CONTBIT>
			 <FSET? ,PRSI ,SURFACEBIT>
			 <FSET? ,PRSI ,VEHBIT>>>
		<TELL ,YOU-CANT "put" T ,PRSO " in" A ,PRSI "!" CR>)
	       (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,CONTBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>
		     <NOT <FSET? ,PRSI ,VEHBIT>>>
		<TELL ,YOU-CANT "put" T ,PRSO " in" A ,PRSI "!" CR>)
	       (<OR <PRSI? ,PRSO>
		    <AND <HELD? ,PRSO>
			 <NOT <FSET? ,PRSO ,TAKEBIT>>>>
		<WASTES>
		;<PROPOSE>)
	       (<FSET? ,PRSI ,DOORBIT>
		<TELL ,CANT-FROM-HERE>)
	       (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>>
		<THIS-IS-IT ,PRSI>
		<DO-FIRST "open" ,PRSI>)
	       (<IN? ,PRSO ,PRSI>
		<TELL "But" T ,PRSO " is already in" TR ,PRSI>)
	       (<AND <G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
			    <GETP ,PRSI ,P?SIZE>>
		    	 <GETP ,PRSI ,P?CAPACITY>>
		     <NOT <HELD? ,PRSO ,PRSI>>>
		<TELL "There's no room ">
		<COND (<FSET? ,PRSI ,SURFACEBIT>
		       <TELL "on">)
		      (T
		       <TELL "in">)>
		<TELL T ,PRSI " for" TR ,PRSO>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <EQUAL? <ITAKE <>> ,M-FATAL <>>>
		<RTRUE>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL "Done." CR>)>>

;<ROUTINE V-PUT-AGAINST ()
	 <WASTES>>

;<ROUTINE V-PUT-BEHIND ()
	 <WASTES>>

;<ROUTINE V-PUT-NEAR ()
	 <WASTES>>

<ROUTINE V-PUT-ON ()
	 <COND (<PRSI? ,ME>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>)
	       (T
		<TELL "There's no good surface on" TR ,PRSI>)>>

<ROUTINE V-PUT-THROUGH ()
	 <COND (<FSET? ,PRSI ,DOORBIT>
		<COND (<FSET? ,PRSI ,OPENBIT>
		       <V-THROW>)
		      (T
		       <DO-FIRST "open" ,PRSI>)>)
	       (<AND <PRSI? <LOC ,PROTAGONIST>>
		     <EQUAL? ,P-PRSA-WORD ,W?THROW ,W?TOSS ,W?HURL>>
		<SETG PRSI <>>
		<V-THROW>)
	       (T
	 	<IMPOSSIBLES>)>>

;<ROUTINE V-PUT-TO ()
	 <RECOGNIZE>>

;<ROUTINE V-PUT-UNDER ()
         <WASTES>>

<ROUTINE V-RAISE ()
	 <HACK-HACK "Playing in this way with">>

<ROUTINE V-RAPE ()
	 <TELL ,UNLADY>>

<ROUTINE V-REACH-IN ("AUX" OBJ)
	 <SET OBJ <FIRST? ,PRSO>>
	 <COND (<OR <FSET? ,PRSO ,ACTORBIT>
		    <FSET? ,PRSO ,SURFACEBIT>
		    <NOT <FSET? ,PRSO ,CONTBIT>>>
		<WASTES>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<DO-FIRST "open" ,PRSO>)
	       (<OR <NOT .OBJ>
		    <FSET? .OBJ ,INVISIBLE>
		    <NOT <FSET? .OBJ ,TAKEBIT>>>
		<TELL ,THERES-NOTHING "in" TR ,PRSO>)
	       (T
		<TELL "You feel something inside" TR ,PRSO>)>>

<ROUTINE V-READ ()
	  ;<COND (<FSET? ,PRSO ,READBIT>
		 <TELL <GETP ,PRSO ,P?TEXT> CR>)>
	  <CANT-VERB-A-PRSO "read">>

<ROUTINE V-REFLECT ()
	 <COND (<AND <PRSO? ,MOONBEAM>
		     <PRSI? ,MIRROR ,TRAY>
		     <EQUAL? ,HERE ,LAFS-ROOM>>
		<PERFORM ,V?SPOINT ,SHIP ,PRSI>
		<RTRUE>)
	       (T
		<WASTES>)>>

<ROUTINE V-REMOVE ()
	 <COND (<AND <FSET? ,PRSO ,WEARBIT>
		     <IN? ,PRSO ,PROTAGONIST>>
		<COND (<NOT <FSET? ,PRSO ,WORNBIT>>
		       <TELL ,YOU-ARENT "wearing that!" CR>)
		      (<NOT <LAF-DOFF-CHECK>>
		       <FCLEAR ,PRSO ,WORNBIT>
		       <TELL "You remove" TR ,PRSO>)>)
	       (T
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>

<ROUTINE LAF-DOFF-CHECK ()
	 <COND (<AND <EQUAL? ,HERE ,LAFS-ROOM>
		     <IN? ,LAFOND ,HERE>>
		<COND (<G? ,LAFOND-CTR ,HORNY>
		       <TELL ,THERES-NOTHING "to remove!" CR>)
		      (T
		       <TELL D ,LAFOND " chuckles. \"No, ma cherie, ">
		       <COND (<L? ,LAFOND-CTR 3>
			      <TELL "have some wine first.\"" CR>)
			     (T
			      <TELL "I'll do that.\"" CR>
			      <SETG LAFOND-CTR ,HORNY>
			      <QUEUE I-LSED -1>)>)>
		<RTRUE>)>>

<ROUTINE V-RETURN ("AUX" ACTOR)
	 <COND (<NOT ,PRSI>
		<COND (<SET ACTOR <FIND-IN ,HERE ,ACTORBIT "to">>
		       <PERFORM ,V?GIVE ,PRSO .ACTOR>
		       <RTRUE>)
		      (T
		       <NO-ONE-HERE "return it to">)>)
	       (<FSET? ,PRSI ,ACTORBIT>
		<PERFORM ,V?GIVE ,PRSO ,PRSI>
		<RTRUE>)
	       (T
		<PERFORM ,V?PUT ,PRSO ,PRSI>
		<RTRUE>)>>

<ROUTINE V-RIP ()
	 <COND (<PRSO? ,INVITE ,LETTER>
		<TELL "There's no reason to be so destructive" ,PCR>)
	       (T
	 	<TELL "It doesn't tear." CR>)>>

<ROUTINE V-ROLL ()
	 <COND ;(<PRSO? ,HOOPS>
		<TELL "Mere child's play" ,PCR>)
	       (<PRSO? ,EYES>
		<TELL "You ARE exasperated." CR>)
	       (<UNTOUCHABLE? ,PRSO>
		<CANT-REACH ,PRSO>)
	       (<EQUAL? ,P-PRSA-WORD ,W?TIP>
		<COND (<PRSO? ,HEAD>
		       <V-YES>)
		      (T
		       <PRONOUN>
		       <TELL " can't take tips!" CR>)>) 
	       (T
		<TELL "A rolling " D ,PRSO " gathers no moss." CR>)>>

<ROUTINE V-ROW ()
	<TELL "You haven't any oars!" CR>>

<ROUTINE V-ROW-DIR ()
	 <COND (<PRSI? ,INTDIR>
		<V-ROW>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-ROW-TO ()
	 <COND (<OR <PRSO? ,ISLAND>
		    <AND <PRSO? ,SKIFF>
			 <PRSI? ,ISLAND>>>
		<SETG P-DIRECTION ,P?WEST>
		<PERFORM ,V?ROW-DIR ,SKIFF ,INTDIR>
		<RTRUE>)
	       (<OR <PRSO? ,SHIP ,REEFS>
		    <AND <PRSO? ,SKIFF>
			 <PRSI? ,SHIP ,REEFS>>>
		<SETG P-DIRECTION ,P?EAST>
		<PERFORM ,V?ROW-DIR ,SKIFF ,INTDIR>
		<RTRUE>)
	       ;(<OR <PRSO? ,SKIFF>
		    <AND <PRSO? ,SKIFF>
			 <PRSI? ,SKIFF>>>
		<TELL ,YOU-CANT "row" T ,SKIFF " to" TR ,SKIFF>)
	       (T
	        <COND (<EQUAL? <LOC ,PROTAGONIST> ,SKIFF>
		       <WASTES>)
		      (T
		       <DO-FIRST "get in" ,SKIFF>)>)>>

;<ROUTINE V-RUB ()
	 <PERFORM ,V?TOUCH ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SAVE-SOMETHING ()
	 <PROPOSE>
	 ;<COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Sorry, but" T ,PRSO " will have to save ">
		<HIM-HER>
		<TELL "self" ,PCR>)
	       (T
		<TELL "Sorry, but" T ,PRSO " is beyond help." CR>)>>

;<ROUTINE V-SAY ("AUX" V)
	 <COND (<AND ,AWAITING-REPLY
		     <YES-WORD <GET ,P-LEXV ,P-CONT>>>
		<V-YES>
		<STOP>)
	       (<AND ,AWAITING-REPLY
		     <NO-WORD <GET ,P-LEXV ,P-CONT>>>
		<V-NO>
		<STOP>)
	       (<SET V <FIND-IN ,HERE ,ACTORBIT>>
		<V-USE-QUOTES>
		<RTRUE>
		;<TELL "You must address" T .V " directly." CR>
		;<STOP>)
	       (T
		<PERFORM ,V?TELL ,ME>
		<STOP>)>>

<GLOBAL FINAL-RANK 0>

<ROUTINE V-SCORE () 
	 <TELL "In " N ,MOVES " turn">
	 <COND (<NOT <EQUAL? ,MOVES 1>>
		<TELL "s">)>
	 <TELL ", you have achieved a score of " N ,SCORE " out of 25 points">
	 <COND (<L? ,SCORE 25>
		<TELL ". This gives you the rank of ">
		<COND (<L? ,SCORE 5>
		       <TELL "Damsel in Distress">)
		      (<L? ,SCORE 10>
		       <TELL "Missish Minx">)
		      (<L? ,SCORE 15>
		       <TELL "Plucky Lass">)
		      (<L? ,SCORE 20>
		       <TELL "Daring Demoiselle">)
		      (<L? ,SCORE 25>
		       <TELL "Lady Leman">)>)>
	 <TELL ,PCR>>

;"Broken Hearted - final-rank when Nick dies - 0. Is no more."

<GLOBAL WINNING-RANKS
	<TABLE
	 0
	 "Orphan"                        ;"Dad dies"
	 "Love Transcending Death"       ;"You die"
	;"Femme Fatale"                  ;"You desert -- Lafond dead"
	 "Pirate Queen"                  ;"You desert"
	 "Happily Ever After"            ;"Ideal ending">>

<ROUTINE V-SEARCH ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<V-SHAKE>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<DESCRIBE-VEHICLE>)
	       (<AND <FSET? ,PRSO ,CONTBIT>
		     <NOT <FSET? ,PRSO ,OPENBIT>>>
		<DO-FIRST "open" ,PRSO>)
	       (<FSET? ,PRSO ,CONTBIT>
		<TELL "You find">
		<COND (<NOT <DESCRIBE-NOTHING>>
		       <TELL ,PCR>)>
		<RTRUE>)
	       (T
		<CANT-VERB-A-PRSO "search">)>>

<ROUTINE V-SET ()
	 <COND (<PRSO? ,ROOMS>
		<WHEE>)
	       ;(<AND <PRSO? ,INTDIR>
		     <EQUAL? <LOC ,PROTAGONIST> ,BARGE ,RAFT>>
		<PERFORM-PRSA <LOC ,PROTAGONIST> ,INTNUM>
		<RTRUE>)
	       (<NOT ,PRSI>
		<COND (<FSET? ,PRSO ,TAKEBIT>
		       <HACK-HACK "Turning">)
		      (T
		       <TELL ,YNH TR ,PRSO>)>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SHAKE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL ,POLITE>)
	       (T
		<HACK-HACK "Shaking">)>>

<ROUTINE V-SHAKE-WITH ()
	 <COND (<NOT <PRSO? ,HANDS>>
		<RECOGNIZE>)
	       (<NOT <FSET? ,PRSI ,ACTORBIT>>
		<TELL "I don't think" T ,PRSI " even has hands." CR>)
	       (T
		<PERFORM ,V?THANK ,PRSI>
		<RTRUE>)>>

<ROUTINE V-SHOOT ()
	 <COND (<NOT ,PRSI>
		<COND (<HELD? ,PISTOL>
		       <PERFORM ,V?SHOOT ,PRSO ,PISTOL>
		       <RTRUE>)
		      ;(<PRSO? ,PISTOL ,STONE ,GARTER>
		       <TELL
,YOULL-HAVE-TO "specify what you are aiming for." CR>)
		      ;(<AND <HELD? ,GARTER>
			    <IN? ,STONE ,GARTER>>
		       <PERFORM ,V?SHOOT ,PRSO ,STONE>
		       <RTRUE>)
		      (T
		       <PROPOSE>)>)
	       (T
		<TELL
"Don't ever bother applying for a job as a gunswoman." CR>)>>

<ROUTINE PRE-SSHOOT ()
	 <COND (<OR <PRSO? ,CANNON>
		    <HELD? ,PRSO>>
		<RFALSE>)
	       (<NOT ,PRSI>
		<COND (<NOT <HELD? ,PISTOL>>
		       <PROPOSE>)
		      (T
		       <PERFORM ,V?SHOOT ,PRSO>
		       <RTRUE>)>)
	       (T
		<TELL ,YNH TR ,PRSO>)>> 

<ROUTINE V-SSHOOT ()
	 <PERFORM ,V?SHOOT ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SHOW ()
	 <TELL ,DOESNT-LOOK T ,PRSI " is interested." CR>>

<ROUTINE V-SHUT-UP ()
	 <COND (<PRSO? ,ROOMS>
		<TELL "[I hope you're not addressing me...]" CR>)
	       (T
		<PERFORM ,V?CLOSE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SIGH ()
	 <TELL "You sigh contentedly, smiling." CR>>

;<ROUTINE V-SINK ()
	 <IMPOSSIBLES>>

<ROUTINE V-SIT ("AUX" VEHICLE)
	 <COND (<SET VEHICLE <FIND-IN ,HERE ,VEHBIT>>
		<PERFORM ,V?BOARD .VEHICLE>
		<RTRUE>)
               (T
		<WASTES>)>>

;<ROUTINE V-SKIP ()
	 <WHEE>>

<ROUTINE V-SLEEP ()
	 <COND (<QUEUED? ,I-SLEEP>
		<I-SLEEP>)
	       (T
		<TELL "You're not tired." CR>)>>

<ROUTINE V-SMELL ()
	 <COND (,PRSO
		<TELL "Smells like any other " D ,PRSO ,PCR>)
	       (<EQUAL? <LOC ,PROTAGONIST> ,CASK>
		<TELL "You recoil from the taint of rancid meat" ,PCR>)
	       (<EQUAL? ,HERE ,FOCSLE ,GALLEY>
		<TELL
"The odor of old grease and char does not improve your appetite." CR>)
	       (<EQUAL? ,HERE ,CABIN>
		<TELL
"The odors of charred wood, sea salt and blood burn your nose" ,PCR>)
	       (<EQUAL? ,HERE ,CREWS-QUARTERS>
		<TELL "Close quarters, indeed." CR>) 
	       (T
		<TELL "Nothing smells unusual" ,PCR>)>>

<ROUTINE V-SOAK ()
	 <COND (<NOT ,PRSI>
		<SPECIFY-WHAT "soak" ,PRSO>
		;<TELL "Please specify what to soak" T ,PRSO " in" ,PCR>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE SENSE-OBJECT (STRING)
	 <PRONOUN>
	 <TELL " " .STRING>
	 <COND (<AND <NOT <FSET? ,PRSO ,PLURALBIT>>
		     <NOT <PRSO? ,ME>>>
		<TELL "s">)>
	 <TELL " just like" AR ,PRSO>>

<ROUTINE V-SPUT-ON ()
         <PERFORM ,V?PUT-ON ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SSHOW ()
	 <PERFORM ,V?SHOW ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-STAND ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?HOLD> ;"for HOLD UP OBJECT"
		<WASTES>)
	       (<FSET? <LOC ,PROTAGONIST> ,VEHBIT>
		<PERFORM ,V?DISEMBARK <LOC ,PROTAGONIST>>
		<RTRUE>)
	       (<AND ,PRSO
		     <FSET? ,PRSO ,TAKEBIT>>
		<WASTES>)
	       (<EQUAL? ,HERE ,IN-HEDGE ,BY-HOUSE ,SLEEPING-CUPBOARD>
		<TELL 
"There's not enough room for even your petite frame to stand straight." CR>)
	       (T
		<TELL ,YOU-ARE-ALREADY "standing." CR>)>>

;<ROUTINE V-STAND-ON ()
	 <WASTES>>

<ROUTINE V-STELL ()
	 <PERFORM ,V?TELL ,PRSI>
	 <RTRUE>>

<ROUTINE V-STHROW ()
	 <PERFORM ,V?THROW-TO ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-FIX ()
	 <COND ;(<PRSO? ,BENT-KEY>
		<REMOVE ,BENT-KEY>
		<TELL "Using all your strength you unbend" T ,PRSO ". Suddenly
it snaps in two pieces. In your surprise you drop them, disappearing ">
		<COND (<OR <EQUAL? ,HERE ,BEACH ,LAWN ,TRADE-ENTRANCE>
			   <EQUAL? ,HERE ,CLEARING ,IN-HEDGE ,BY-HOUSE>
			   <EQUAL? ,HERE ,MAIN-ENTRANCE ,FOREST ,FRONT-DRIVE>>
		       <TELL "into the grass">)
		      (<BELOW-GROUND ,HERE>
		       <TELL "into the darkness">)
		      (<EQUAL? ,HERE ,BY-SHIP ,LAGOON ,SHALLOWS>
		       <TELL "into the sea">)
		      (T
		       <TELL "between the floorboards">)>
		<TELL ,PCR>)
	       (<PRSO? ,DAGGER>
		<REPERTOIRE "Dagger sharpening">) 
	       (T
		<TELL "But" T ,PRSO " isn't ">
		<COND (<EQUAL? ,P-PRSA-WORD ,W?SHARPEN ,W?WHET>
		       <TELL "dull">)
		      (T
		       <TELL "broken">)>
		<TELL "!" CR>
		<RTRUE>)>>

;<ROUTINE V-SWHIP ()
	 <PERFORM ,V?WHIP ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SWIM ()
	 <COND (<OR <PRSO? ,SEA>
		    <AND <NOT ,PRSO>
		    	 <GLOBAL-IN? ,SEA ,HERE>>>
		<REPERTOIRE "Swimming">
		;<TELL "You don't know how to swim." CR>)
	       (T
		<TELL "Your head must be swimming." CR>)>>

<ROUTINE V-SWING ()
	 <COND (,PRSI
		<PERFORM ,V?KILL ,PRSI ,PRSO>
		<RTRUE>)
	       (<AND <PRSO? ,ROOMS>
		     <EQUAL? ,HERE ,GALLERY>>
		<PERFORM ,V?SWING ,ROPE>
		<RTRUE>)
	       (T
		<WHEE>
		;<TELL "\"Whoosh.\"" CR>)>>

<ROUTINE V-SWOON ()
	 <TELL "You've never been missish enough to faint on demand" ,PCR>>
		       

<ROUTINE V-SWRAP ()
	 <PERFORM ,V?WRAP ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE PRE-TAKE ()
	 <COND ;(<AND <NOT <FSET? ,PRSO ,BODYBIT>>
		     <PLAYER-CANT-SEE>>
		<RTRUE>)
	       (<LOC-CLOSED>
		<RTRUE>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<TELL "You're ">
		<COND (<FSET? ,PRSO ,INBIT>
		       <TELL "i">)
		      (T
		       <TELL "o">)>
		<TELL "n it!" CR>)
	       (<AND <G? ,LAFOND-CTR ,HORNY>
		     <EQUAL? ,HERE ,LAFS-ROOM>
		     <IN? ,HERE ,LAFOND>>
		<RFALSE>)
	       (<OR <IN? ,PRSO ,PROTAGONIST>
		    <AND <HELD? ,PRSO>
			 <NOT <FSET? ,PRSO ,TAKEBIT>>>>
		<COND ;(<AND <PRSO? ,CANDLE>
			    <PRSI? ,SHUTTERS>>
		       <RFALSE>)
		      (<FSET? ,PRSO ,WORNBIT>
		       <TELL ,YOU-ARE-ALREADY "wearing">)
		      (T
		       <TELL ,YOU-HAVE-ALREADY>)>
		<TELL TR ,PRSO>)
	       (<AND <PRSO? ,LAUD>
		     <NOT <PRSI? ,BOTTLE>>>
		<WASTES>)
	       (<NOT ,PRSI>
		<RFALSE>)
	       (<IN? ,PRSO ,PRSI>
		<RFALSE>)
	       (<NOT <IN? ,PRSO ,PRSI>>
		<NOT-IN>)
	       (<PRSO? ,ME>
		<PERFORM ,V?DROP ,PRSI>
		<RTRUE>)
	       (T
		<SETG PRSI <>>
		<RFALSE>)>>

<ROUTINE V-TAKE ()
	 <COND (<EQUAL? <ITAKE> T>
		<TELL "Taken." CR>)>>

<ROUTINE V-TAKE-OFF ()
	 <COND ;(<PRSO? ,ROOMS>
		<COND (<EQUAL? ,P-PRSA-WORD ,W?GET>
		       <COND (<FSET? <LOC ,PROTAGONIST> ,VEHBIT>
			      <TELL "[of" T <LOC ,PROTAGONIST> "]" CR>
			      <PERFORM ,V?DISEMBARK <LOC ,PROTAGONIST>>
			      <RTRUE>)>)
		      (T
		       <MORE-SPECIFIC>
		       <RTRUE>)>)
	       (<FSET? ,PRSO ,WORNBIT>
		<PERFORM ,V?REMOVE ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (T
		<TELL ,YOU-ARENT "wearing" TR ,PRSO>)>>

<ROUTINE V-TAKE-WITH ()
	 <TELL "Sorry," T ,PRSI " is no help in getting" TR ,PRSO>>

;<ROUTINE V-TASTE ()
	 <SENSE-OBJECT "taste">>

<ROUTINE V-TELL ()
	 <COND (<AND <FSET? ,PRSO ,ACTORBIT>
		     <NOT <PRSO? ,CROC>>>
	        <COND (<FSET? ,PRSO ,DEADBIT>
		       <TELL ,DOESNT-RESPOND>
		       <STOP>)
		      (,P-CONT
	               <SETG WINNER ,PRSO>
	               <SETG CLOCK-WAIT T>
	               <RTRUE>)
		      (T
	               <TELL
"Hmmm ..." T ,PRSO " looks at you expectantly,
as if you seemed to be about to talk." CR>)>)
	       (T
	         <CANT-VERB-A-PRSO "talk to">
	         <STOP>)>>

<ROUTINE V-TELL-ABOUT ()
	 <COND (<PRSO? ,ME>
		<PERFORM ,V?WHAT ,PRSI>
		<RTRUE>)
	       (T
		<PERFORM ,V?SHOW ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-THANK ()
	 <COND (<NOT ,PRSO>
		<TELL "[Just doing my job.]" CR>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL "\"You're welcome.\"" CR>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-THROW-AT ()
	 <PERFORM ,V?MUNG ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-THROW ()
	 <COND (<NOT <SPECIAL-DROP>>
		<COND (<EQUAL? ,HERE ,LAGOON ,BY-SHIP ,SHALLOWS>
		       <PERFORM ,V?PUT ,PRSO ,SEA>
		       <RTRUE>)
		      (,PRSI
		       <MOVE ,PRSO ,HERE>
		       <TELL "You missed." CR>)
		      (T
		       <MOVE ,PRSO ,HERE>
		       <TELL "Thrown." CR>)>)>>

<ROUTINE V-THROW-OVER ()
	 <MOVE ,PRSO ,HERE>
	 <TELL "You missed." CR>> 

<ROUTINE V-THROW-OVERBOARD ()
	 <COND (<OR <EQUAL? ,HERE ,LAGOON ,SHALLOWS>
		    <SHIP-BOARD ,HERE>>
		<PERFORM ,V?PUT ,PRSO ,SEA>
		<RTRUE>)
	       (T
		<TELL "One normally tries this on a boat." CR>)>>

<ROUTINE V-THROW-TO ()
	 <COND (<FSET? ,PRSI ,ACTORBIT>
		<PERFORM ,V?GIVE ,PRSO ,PRSI>
		<RTRUE>)
	       (T
		<PERFORM ,V?THROW ,PRSO ,PRSI>
		<RTRUE>)>>

<ROUTINE V-TIE-WITH ()
	 <PERFORM ,V?TIE ,PRSI ,PRSO>
	 <RTRUE>>
		 
;<ROUTINE V-TIE ()
	 <WASTES>
	 ;<TELL ,YOU-CANT "tie" A ,PRSO " to anything" ,PCR>
	 ;<COND (<OR <FSET? ,PRSO ,ACTORBIT>
		    <FSET? ,PRSI ,ACTORBIT>>
		<TELL "Kinky!" CR>
		<RTRUE>)
	       (T
		<TELL ,YOU-CANT "tie" A ,PRSO " to anything" ,PCR>)>>

;<ROUTINE V-TIE-TOGETHER ()
	 <IMPOSSIBLES>>

<ROUTINE PRE-TOUCH ()
	 <COND (<AND <VERB? RAISE LOWER>
		     ,PRSI
		     <NOT <EQUAL? ,PRSI ,ROOMS>>>
		<RECOGNIZE>)
	       (<AND <VERB? TOUCH>
		     <PRSO? ,COOKIE>
		     <PRSI? ,DAGGER>>
		<TELL ,UNLADY>)
	       (<AND <VERB? OPEN CLOSE>
		     <PRSO? ,DIVAN ,COT ,CABIN-BED 
			    ,CAPT-BED ,LAFS-BED ,GUEST-BED>>
		<CANT-VERB-A-PRSO "do that to">
		;<TELL ,YOU-CANT "do that to" AR ,PRSO>)
	       (<AND <EQUAL? ,PRSO ,LINE>
		     <VERB? TOUCH>
		     <EQUAL? <LOC ,PROTAGONIST> ,CASK>>
		<TELL "Your fingers just brush" TR ,LINE>)
	       (<UNTOUCHABLE? ,PRSO>
		<CANT-REACH ,PRSO>)
	       (<VERB? EMPTY>
		<COND (<PRSO? ,WATER-BARREL ,RUM-BARREL>
		       <RFALSE>)
		      (<OR <NOT <HELD? ,PRSO>>
			   <NOT <TAKE-CHECK>>>
		       <TELL ,YNH TR ,PRSO>
		       <RFATAL>)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? EMPTY-FROM>
		     <NOT <PRSI? ,WATER-BARREL ,RUM-BARREL>>
		     <OR <NOT <HELD? ,PRSO>>
			 <NOT <TAKE-CHECK>>>>
		<TELL ,YNH TR ,PRSO>
		<RFATAL>)>>

<ROUTINE V-TOUCH ()
	 <COND (<LOC-CLOSED>
		<RTRUE>)
	       (T
		<HACK-HACK "Caressing">)>>

<ROUTINE V-STOUCH ()
	 <PERFORM ,V?TOUCH ,PRSI ,PRSO>
	 <RTRUE>>

;<ROUTINE V-UNCOVER ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?UNDRESS ,OBJECT>
		<RTRUE>)
	       (T
		<COND (<FSET? ,PRSO ,PLURALBIT>
		       <TELL "They're">)
		      (<FSET? ,PRSO ,FEMALEBIT>
		       <TELL "She's">)
		      (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "He's">)
		      (T
		       <TELL "It's">)>
		<TELL " not covered!" CR>)>>

;<ROUTINE SENSE-AGAIN (BODY-PART) 
	 <FCLEAR .BODY-PART ,MUNGBIT>
	 <TELL "You can once again sense with" TR .BODY-PART>>


<ROUTINE V-UNLOCK ()
	 <COND (,PRSI
		<IMPOSSIBLES>)
	       (<FSET? ,PRSO ,LOCKEDBIT>
		<SETG AWAITING-REPLY 2>
		<QUEUE I-REPLY 2>
		<TELL "Your nose is key-shaped, I suppose?" CR>)
	       (<FSET? ,PRSO ,DOORBIT>
		<TELL "But" T ,PRSO " isn't locked." CR>)
	       (T
		<WASTES>)>>

;<ROUTINE V-UNROLL ()
	 <IMPOSSIBLES>>

;<ROUTINE V-UNTIE ()
	 <IMPOSSIBLES>>

;<ROUTINE V-USE ()
	 <MORE-SPECIFIC>
	 ;<TELL
,YOULL-HAVE-TO "be more specific about how you want to use" TR ,PRSO>>

;<ROUTINE V-USE-QUOTES ()
	 <SEE-MANUAL "say something \"out loud.\"">
	 <RFATAL>>

<ROUTINE V-WALK ("AUX" AV VEHICLE PT PTS STR OBJ RM)
	 <SET AV <LOC ,PROTAGONIST>>
	 <COND (<NOT ,P-WALK-DIR>
		<PERFORM ,V?WALK-TO ,PRSO>
		<RTRUE>)
	       (<AND <PRSO? ,P?OUT>
		     <IN-EXITABLE-VEHICLE?>>
		<RTRUE>)
	       ;(<AND <PRSO? ,P?DOWN>
		     <EQUAL? .AV ,STOOL ,STALLION>>
		<PERFORM ,V?DISEMBARK .AV>
		<RTRUE>)
	       ;(<AND <PRSO? ,P?IN>
		     <EQUAL? ,HERE ,ON-LADDER>>
		<PERFORM ,V?BOARD ,LEDGE>
		<RTRUE>)
	       (<AND <PRSO? ,P?IN>
		     <NOT <GETPT ,HERE ,P?IN>>
		     <SET VEHICLE <FIND-IN ,HERE ,VEHBIT>>
		     <NOT <HELD? .VEHICLE>>>
		<PERFORM ,V?BOARD .VEHICLE>
		<RTRUE>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<EQUAL? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <GOTO <GETB .PT ,REXIT>>)
		      (<EQUAL? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<EQUAL? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
  ;"catacombs fake-move"      <COND (<EQUAL? .RM ,ROOMS>
				     <RTRUE>)>
			      <GOTO .RM>)
			     (T
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL ,CANT-GO>
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GETB .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <THIS-IS-IT .OBJ>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <THIS-IS-IT .OBJ>
			      <DO-FIRST "open" .OBJ>
			      <RFATAL>)>)>)
	       (T
		<COND (<PRSO? ,P?OUT ,P?IN>
		       <V-WALK-AROUND>)
		      (T
		       <TELL ,CANT-GO>)>
		<RFATAL>)>>

<ROUTINE V-WAVE ("OPTIONAL" (AT-OBJ <>))
         <TELL "You wave">
	 <COND (<NOT .AT-OBJ>
		<PRSO-PRINT>
		<TELL " in the air" ,PCR>)
	       (T
		<TELL " cheerfully at" TR ,PRSO>)>>

<ROUTINE V-WAVE-AT ()
	 <V-WAVE T>
	 <RTRUE>>

<ROUTINE V-WRING ()
	 <COND (<NOT ,PRSI>
		<COND (<OR <AND <PRSO? ,DRESS>
				,WET-DRESS>
			   <AND <PRSO? ,RAG>
				,WET-RAG>>
		       <TELL "You don't have time to dry it." CR>)
		      (<EQUAL? ,P-PRSA-WORD ,W?DRY>
		       <TELL "That isn't wet!" CR>)
		      (T
		       <WASTES>)>)
	       (<PRSI? ,DRESS ,RAG>
		<PERFORM ,V?WRING ,PRSI>
		<RTRUE>)
	       (T
		<WASTES>)>> 

;<ROUTINE NOT-GOING-ANYWHERE ("AUX" AV)
	 <SET AV <LOC ,PROTAGONIST>>
	 <TELL "You're not going anywhere until you get ">
	 <COND (<OFF-VEHICLE? .AV>
		<TELL "off">)
	       (T
		<TELL "out of">)>
	 <TELL TR .AV>
	 <RFATAL>>

<ROUTINE V-WALK-AROUND ()
	 <SETG AWAITING-REPLY 2>
	 <QUEUE I-REPLY 2>
	 <TELL "Did you have any particular " D ,INTDIR " in mind?" CR>>

<ROUTINE V-WALK-TO ()
	 <COND (<EQUAL? ,PRSO ,INTDIR>
		<DO-WALK ,P-DIRECTION>)
	       (T
		<V-WALK-AROUND>)>>

;<ROUTINE V-WALK-TO ()
	 <COND (<OR <IN? ,PRSO ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>>
	        <COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "He's">)
		      (T
		       <TELL "It's">)>
		<TELL " here!" CR>)
	       (T
		<V-WALK-AROUND>)>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 3))
	 <TELL "Time passes..." CR>
	 <REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0>
			<RETURN>)
		       (<CLOCKER>
			<RETURN>)>>
	 <SETG CLOCK-WAIT T>>

<ROUTINE PRE-DOFF ()
	 <COND (<AND <NOUN-USED ,W?DECK ,GROUND> 
		     <OR <EQUAL? ,HERE ,DEUX-DECK>
			 <SHIP-BOARD ,HERE>>>
		<V-WALK-AROUND>
		<RTRUE>)                         ;"GET OFF DECK"
	       (<AND ,PRSO
		     <VERB? UNDRESS>>
		<RFALSE>)
	       (<CHECK-STRIP>
		<RTRUE>)
	       (<OR <EQUAL? ,HERE ,LAFS-ROOM>
		    <AND <EQUAL? ,HERE ,ANTEROOM>
			 <NOT <IN? ,DAD ,HERE>>>>
		<RFALSE>)
	       (<OR <FIND-IN ,HERE ,ACTORBIT "in front of">
		    <EQUAL? ,HERE ,ORCHESTRA ,SUPPER-ROOM ,BALLROOM>>
		<TELL ,POLITE-SOCIETY>
		<RTRUE>)
	       (<AND <EQUAL? ,HERE ,ANTEROOM>
		     <NOT <EQUAL? ,HERE <LOC ,DAD> <LOC ,COOKIE>>>>
		<RFALSE>)
	       (<OR <NOT ,PRSO>
		    <PRSO? ,RETICULE>>
		<RFALSE>)
	       (<NOT <OR <FSET? ,PRSO ,WORNBIT>
			 <FSET? ,PRSO ,WEARBIT>>>
		<RFALSE>)
	       ;(<PRSO? ,ME>
		<V-GET-UNDRESSED>
		<RTRUE>)
	       (<NOT <FSET? ,PRSO ,WORNBIT>>
		<TELL "You're not wearing" T ,PRSO "!" CR>
		<RTRUE>)>>

<ROUTINE PRE-WEAR ()
	 <COND (<NOT <FSET? ,PRSO ,WEARBIT>>
		<CANT-VERB-A-PRSO "wear">
		;<TELL ,YOU-CANT "wear" AR ,PRSO>)
	       (<FSET? ,PRSO ,WORNBIT>
		<TELL ,YOU-ARE-ALREADY "wearing" T ,PRSO "!" CR>)
	       (<CHECK-STRIP>
		<RTRUE>)
	       (<AND ;<PRSO? ,CHEMISE>
		     <RUNNING? ,I-LSED>
		     <EQUAL? <LOC ,LAFOND> ,HERE ;<LOC ,PROTAGONIST>>>
		<TELL D ,LAFOND " prevents you." CR>)
	       (<AND <NOT ,ENDGAME>
		     <EQUAL? ,HERE ,FOYER ,BALLROOM ,SUPPER-ROOM ,ORCHESTRA>>
		<TELL "People might notice." CR>)>>

<ROUTINE CHECK-STRIP ()
	 <COND (<EQUAL? ,HERE ,CABIN>
		<TELL
"With pirates attacking?! " ,MOTHER>)
	       (<EQUAL? ,HERE ,ON-LADDER ,RIGGING-ROOM>
		<TELL 
,YOU-CANT "manage the fastenings while whipping to and fro ">
		<COND (<EQUAL? ,HERE ,ON-LADDER>
		       <TELL "on" AR ,LADDER>)
		      (T
		       <TELL "in" TR ,RIGGING-OBJECT>)>) 
	       (<EQUAL? ,HERE ,IN-HEDGE ,BY-HOUSE>
		<TELL
,YOU-CANT "even stand straight, much less change clothes!" CR>)>>

;<ROUTINE CHECK-STRIP ()
	 <COND (<EQUAL? ,HERE ,CABIN>
		<TELL
"With pirates attacking?! " ,MOTHER>)
	       (<EQUAL? ,HERE ,ON-LADDER>
		<TELL 
,YOU-CANT "undo the fastenings while whipping to and fro on" A ,LADDER ,PCR>)
	       (<EQUAL? ,HERE ,RIGGING-ROOM>
		<TELL "That'd be a neat trick" ,PCR>) 
	       (<EQUAL? ,HERE ,IN-HEDGE ,BY-HOUSE>
		<TELL
,YOU-CANT "even stand up straight, much less get undressed!" CR>)
	       (<AND <EQUAL? ,HERE ,LAFS-ROOM>
		     <IN? ,LAFOND ,HERE>>
		<RFALSE>)
	       (<OR <FIND-IN ,HERE ,ACTORBIT "in front of">
		    <EQUAL? ,HERE ,ORCHESTRA ;,SUPPER-ROOM>>
		<TELL ,POLITE-SOCIETY>)
	       (T
		<RFALSE>)>>

<ROUTINE V-WEAR ()
	 <MOVE ,PRSO ,PROTAGONIST>
	 ;<COND (<PRSO? ,FLOWER>
		<TELL
"You tuck" T ,FLOWER "behind your ear, but it slips out" ,PCR>)>
	 <FSET ,PRSO ,WORNBIT>
	 <TELL "You're now wearing" TR ,PRSO>>

;<ROUTINE V-WEAR ()
         <COND (<NOT <FSET? ,PRSO ,WEARBIT>>
		<CANT-VERB-A-PRSO "wear">)
	       (T
		<TELL "You're ">
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL "already">)
		      (T
		       <MOVE ,PRSO ,PROTAGONIST>
		       <FSET ,PRSO ,WORNBIT>
		       <TELL "now">)>
		<TELL " wearing" TR ,PRSO>)>>

<ROUTINE V-WHAT ()
	 <TELL "Good question." CR>>

<ROUTINE V-WHERE ()
	 <V-FIND T>>

;<ROUTINE V-WHIP ()
	 <TELL "It isn't ladylike to whip" AR ,PRSO>>

;<ROUTINE V-WRAP ()
	 <WASTES>>

<GLOBAL HELP-SCREAM "\"Help me!\" you cry, hoping someone will help you.">

<ROUTINE V-YELL ()
	 <COND ;(<EQUAL? ,HERE ,BALLROOM ,FOYER ,ORCHESTRA ,SUPPER-ROOM>
		<TELL
"You give a loud yelp above the music. Some nearby dancers stop, look
at you nervously, and return to dancing." CR>)
	       (<EQUAL? ,HERE ,GALLERY ,DEUX-DECK>
		<TELL
"Although your voice is quite piercing, no one notices you." CR>)
	       (<EQUAL? ,HERE ,CABIN>
		    ;<AND <EQUAL? ,HERE ,DUNGEON>
			 <FSET? ,MANACLES ,MUNGBIT>>
		<TELL ,HELP-SCREAM>
		<CRLF>)
	       (T
		<TELL "Papa always says, \"Action, not reaction, girl!\"" CR>
		;<SORE "throat">)>
	 <STOP>>

<ROUTINE I-REPLY ()
	 <SETG AWAITING-REPLY <>>
	 <RFALSE>>

<GLOBAL AWAITING-REPLY <>>

;"3 - secret door.
  4 - hero, leave me alone.
  5 - Jump to interrupt hero.
  6 - Dad and garter.
  ;7 - Kitchen, Lucy and ballgown. 
  8 - do you really want to fight the croc?
  9 - Jump to interrupt Lafond.
 10 - Cookie: do you know where hero is?
 11 - Hero: will you go with Lafond?"
<ROUTINE V-YES ()
	 <COND (<EQUAL? ,AWAITING-REPLY 1>
		<TELL "That wasn't a yes or no question" ,PCR>)
	       (<EQUAL? ,AWAITING-REPLY 2>
		<TELL "That was just a rhetorical question." CR>)
	       (<EQUAL? ,AWAITING-REPLY 3>
		<TELL "Whither goes a will, goes a way." CR>)
	       (<EQUAL? ,AWAITING-REPLY 4>
		<REMOVE ,HERO>
		<STOP-QUEUES>
		<TELL
"Silently he drops your arm and retreats. You are alone." CR>)
	       (<EQUAL? ,AWAITING-REPLY 5>
		<TELL "You nod tentatively." CR>)
	       (<EQUAL? ,AWAITING-REPLY 6>
		<TELL
"\"Quite a girl, isn't she? You two will be great friends,\" he says" ,PCR>)
	       (<EQUAL? ,AWAITING-REPLY 9>
		<TELL
"You have no breath to speak. You nod once,
never taking " D ,EYES " off Nicholas Jamison" ,PCR>)
	       (<EQUAL? ,AWAITING-REPLY 10>
		<TELL "You nod eagerly." CR>)
	       (<EQUAL? ,AWAITING-REPLY 11>
		<TELL
"You summon a gracious smile, \"Why yes, I'd love to.\""CR>)
	       (<EQUAL? ,AWAITING-REPLY 12>
		<TELL "You nod" ,PCR>)
	       (<EQUAL? ,AWAITING-REPLY 13>
		<TELL "Nicholas pulls forward a fettered wrist" ,PCR>)
	       (<EQUAL? ,AWAITING-REPLY 14>
		<TELL "Jamison grins at you" ,PCR>)
	       (<EQUAL? ,AWAITING-REPLY 15>
		<TELL "Breathless, eager, you lean into him" ,PCR>)
	       (<EQUAL? ,AWAITING-REPLY 16>
		<TELL
"Your father twinkles, \"Good! He's of good family, you know.\"" CR>)
	       (<EQUAL? ,AWAITING-REPLY 17>
		<TELL "\"Har, just you try!\"" CR>)
	       (T
	 	<YOU-SOUND "posi">)>>

<ROUTINE YOU-SOUND (STRING)
	 <TELL "You sound rather " .STRING "tive." CR>>

<ROUTINE YES-WORD (WRD)
	 <COND (<OR <EQUAL? .WRD ,W?YES ,W?Y ,W?YUP>
		    <EQUAL? .WRD ,W?OK ,W?OKAY ,W?SURE>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

;"subtitle object manipulation"

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" ;CNT OBJ)
	 <COND (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <WASTES>)>
		<RFATAL>)
	       (<PRE-TOUCH>
		<RFATAL>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,PROTAGONIST>> 110>>
		<COND (.VB
		       <TELL
"It's too heavy, considering your current load." CR>)>
		<RFATAL>)
	       (<G? <CCOUNT ,PROTAGONIST> 12>
		<COND (.VB
		       <TELL ,YOU-ARE-ALREADY
"juggling as many items as you can possibly carry." CR>)>
		<RFATAL>)>
	 <FSET ,PRSO ,TOUCHBIT>
	 <FCLEAR ,PRSO ,NDESCBIT>
	 <COND (<IN? ,PROTAGONIST ,PRSO>
		<RFALSE> ;"Hope this is right -- pdl 4/22/86")
	       ;(<AND <PRSO? ,RAFT>
		     ,RAFT-HELD>
		<SETG RAFT-HELD <>>)>
	 <MOVE ,PRSO ,PROTAGONIST>>

;"IDROP is called by PRE-GIVE and PRE-PUT.
  IDROP acts directly as PRE-DROP, PRE-THROW and PRE-PUT-THROUGH."
<ROUTINE IDROP ()
	 <COND (<PRSO? ,HANDS>
		<COND (<VERB? DROP THROW GIVE>
		       <IMPOSSIBLES>)
		      (T
		       <RFALSE>)>)
	       (<PRSO? ,RETICULE>
		<COND (<VERB? DROP THROW GIVE>
		       <TELL "A lady is never without her reticule." CR>)
		      (T
		       <RFALSE>)>)
	       (<AND <PRSO? ,ME>
		     <VERB? PUT>
		     <FSET? ,PRSI ,ACTORBIT>>
		<PERFORM ,V?BOARD ,PRSI>
		<RTRUE>)
	       (<AND <PRSI? ,ME>
		     <VERB? PUT>
		     <FSET? ,PRSO ,ACTORBIT>>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (<AND <OR <PRSO? ,SPICES>
			 <PRSO? ,PINCH>>
		     <HELD? ,PINCH>>
		<RFALSE>)
	       (<NOT <HELD? ,PRSO>>
		<COND (<OR <PRSO? ,ME>
		           <FSET? ,PRSO ,BODYBIT>>
		       <IMPOSSIBLES>)
		      ;(<AND <EQUAL? ,HERE ,ON-LADDER>
			    <EQUAL? ,PRSO ,LADDER>>
		       <RFALSE>)
		      (T
		       <TELL ,YNH TR ,PRSO>)>
		<RFATAL>)
	       (<AND <NOT <IN? ,PRSO ,PROTAGONIST>>
		     <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<DO-FIRST "open" <LOC ,PRSO>>)
	       (<FSET? ,PRSO ,WORNBIT>
		<DO-FIRST "remove" ,PRSO>)    ; "RETICULE is not WORNBIT"
	       (T
		<RFALSE>)>>

<ROUTINE CCOUNT	(OBJ "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<NOT <FSET? .X ,WORNBIT>>
			       <SET CNT <+ .CNT 1>>)>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

;"Gets SIZE of supplied object, recursing to nth level."
<ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))
	 <COND (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<SET WT <+ .WT <WEIGHT .CONT>>>
			<COND (<NOT <SET CONT <NEXT? .CONT>>>
			       <RETURN>)>>)>
	 <+ .WT <GETP .OBJ ,P?SIZE>>>

;"subtitle describers"

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (VERB-IS-LOOK <>)
			"AUX" (FIRST-VISIT <>) (NUM 0))
	 <COND (<NOT ,LIT>
		<TELL ,TOO-DARK>
		<CRLF>
		<RFALSE> ;"so DESCRIBE-CONTENTS of room isn't called")>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<FSET ,HERE ,TOUCHBIT>
		<SET FIRST-VISIT T>)>
	 <TELL D ,HERE>
	 ;<SET NUM <CANAL-LOC>>
	 <COND (<FSET? <LOC ,PROTAGONIST> ,VEHBIT>
		<TELL ", ">
		<COND (<FSET? <LOC ,PROTAGONIST> ,INBIT>
		       <TELL "i">)
		      (T
		       <TELL "o">)>
		<TELL "n" T <LOC ,PROTAGONIST>>)>
	 <CRLF>
	 <COND (<OR .VERB-IS-LOOK
		    <EQUAL? ,VERBOSITY 2>
		    <AND .FIRST-VISIT
			 <EQUAL? ,VERBOSITY 1>>>
		<TELL ,INDENT>
		<COND (<NOT <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <TELL <GETP ,HERE ,P?LDESC>>)>
		<CRLF>)>
	 <RTRUE>>

;"Print FDESCs, then DESCFCNs and LDESCs, then everything else. DESCFCNs
must handle M-DESC? by RTRUEing (but not printing) if the DESCFCN would
like to handle printing the object's description. RFALSE otherwise. DESCFCNs
are responsible for doing the beginning-of-paragraph indentation."

<ROUTINE DESCRIBE-OBJECTS ("AUX" O STR (1ST? T) (AV <LOC ,WINNER>))
	 <SET O <FIRST? ,HERE>>
	 <COND (<NOT .O>
		<RFALSE>)>
	 <REPEAT () ;"FDESCS and MISC."
		 <COND (<NOT .O>
			<RETURN>)
		       (<AND <DESCRIBABLE? .O>
			     <NOT <FSET? .O ,TOUCHBIT>>
			     <SET STR <GETP .O ,P?FDESC>>>
			<TELL ,INDENT .STR>
			<COND (<FSET? .O ,CONTBIT>
			       <DESCRIBE-CONTENTS .O T <+ ,D-ALL? ,D-PARA?>>)>
			<CRLF>)>
		 <SET O <NEXT? .O>>>
	 <SET O <FIRST? ,HERE>>
	 <SET 1ST? T>
	 <REPEAT () ;"DESCFCNS"
		 <COND (<NOT .O>
			<RETURN>)
		       (<OR <NOT <DESCRIBABLE? .O>>
			    <AND <GETP .O ,P?FDESC>
				 <NOT <FSET? .O ,TOUCHBIT>>>>
			T)
		       (<AND <SET STR <GETP .O ,P?DESCFCN>>
			     <SET STR <APPLY .STR ,M-OBJDESC>>>
			<COND (<AND <FSET? .O ,CONTBIT>
				    <N==? .STR ,M-FATAL>>
			       <DESCRIBE-CONTENTS .O T <+ ,D-ALL? ,D-PARA?>>)>
			<CRLF>)
		       (<SET STR <GETP .O ,P?LDESC>>
			;<TELL "   " .STR>
			<TELL ,INDENT .STR>
			<COND (<FSET? .O ,CONTBIT>
			       <DESCRIBE-CONTENTS .O T <+ ,D-ALL? ,D-PARA?>>)>
			<CRLF>)>
		 <SET O <NEXT? .O>>>
	 <DESCRIBE-CONTENTS ,HERE <> 0>
	 <COND (<AND .AV <NOT <EQUAL? ,HERE .AV>>>
		<DESCRIBE-CONTENTS .AV <> 0>)>>

<CONSTANT D-ALL? 1> ;"print everything?"
<CONSTANT D-PARA? 2> ;"started paragraph?"

"<DESCRIBE-CONTENTS ,OBJECT-WHOSE-CONTENTS-YOU-WANT-DESCRIBED
		    level: -1 means only top level
			    0 means top-level (include crlf)
			    1 for all other levels
			    or string to print
		    all?: t if not being called from room-desc >"

<ROUTINE DESCRIBE-CONTENTS (OBJ "OPTIONAL" (LEVEL -1) (ALL? ,D-ALL?)
  "AUX" (F <>) N (1ST? T) (IT? <>) (TWO? <>) (START? <>) (PARA? <>) DB)
  <COND (<EQUAL? .LEVEL 2>
	 <SET LEVEL T>
	 <SET PARA? T>
	 <SET START? T>)
	(<BTST .ALL? ,D-PARA?>
	 <SET PARA? T>)>
  <SET N <FIRST? .OBJ>>
  <COND (<OR .START?
	     <IN? .OBJ ,ROOMS>
	     <FSET? .OBJ ,ACTORBIT>
	     <AND .N
		  <FSET? .OBJ ,CONTBIT>
		  <OR <FSET? .OBJ ,OPENBIT>
		      <FSET? .OBJ ,TRANSBIT>>
		  <OR <EQUAL? .LEVEL -1>
		      <FSET? .OBJ ,SEARCHBIT>>>>
	 <REPEAT ()
	   <COND (<OR <NOT .N>
		      <AND <DESCRIBABLE? .N>
			   <OR <BTST .ALL? ,D-ALL?>
			       <SIMPLE-DESC? .N>>>>
		  <COND (.F
			 <COND (.1ST?
				<SET 1ST? <>>
				<COND (<EQUAL? .LEVEL <> T>
				       <COND (<NOT .START?>
					      <COND (<NOT .PARA?>
						     <COND (<NOT <EQUAL? .OBJ
								,PROTAGONIST>>
							    <TELL ,INDENT>
							    ;<TELL "   ">)>
						     <SET PARA? T>)
						    (<EQUAL? .LEVEL T>
						     <TELL " ">)>
					      <DESCRIBE-START .OBJ ;.N>)>)
				      (<NOT <EQUAL? .LEVEL -1>>
				       <TELL .LEVEL>)>)
			       (.N
				<TELL ",">)
			       (T
				<TELL " and">)>
			 <TELL A .F>
			 <COND (<FSET? .F ,ONBIT>
				<TELL " (providing light)">)
			       (<EQUAL? .F ,RETICULE>
				<TELL " (hanging from your wrist)">)
			       ;(<AND <EQUAL? .F ,HAT>
				     <NOT <FSET? ,HAT ,WORNBIT>>
				     <EQUAL? ,HERE ,FOYER ,BALLROOM>>
				<TELL " (hidden" ,FOLDS ")">)>
			 <COND (<AND <NOT .IT?> <NOT .TWO?>>
				<SET IT? .F>)
			       (T
				<SET TWO? T>
				<SET IT? <>>)>)>
		  <SET F .N>)>
	   <COND (.N
		  <SET N <NEXT? .N>>)>
	   <COND (<AND <NOT .F>
		       <NOT .N>>
		  <COND (<AND .IT?
			      <NOT .TWO?>>
			 <THIS-IS-IT .IT?>)>
		  <COND (<AND .1ST? .START?>
			 <TELL " nothing">
			 <RFALSE>)
			(<AND <NOT .1ST?>
			      <EQUAL? .LEVEL <> T>>
			 <COND (<EQUAL? .OBJ ,HERE>
				<TELL " here">)>
			 <TELL ".">)>
		  <RETURN>)>>
	 <COND (<EQUAL? .LEVEL <> T>
		<SET F <FIRST? .OBJ>>
		<REPEAT ()
		   <COND (<NOT .F>
			  <RETURN>)
			 (<AND <FSET? .F ,CONTBIT>
			       <DESCRIBABLE? .F T>
			       <OR <BTST .ALL? ,D-ALL?>
				   <SIMPLE-DESC? .F>>>
			  <SET DB ,D-BIT>
			  <SETG D-BIT <>>
			  <COND (<DESCRIBE-CONTENTS .F T
				      <COND (.PARA?
					     <+ ,D-ALL? ,D-PARA?>)
					    (T
					     ,D-ALL?)>>
				 <SET 1ST? <>>
				 <SET PARA? T>)>
			  <SETG D-BIT .DB>)>
		   <SET F <NEXT? .F>>>)>
	 <COND (<AND <NOT .1ST?>
		     <EQUAL? .LEVEL <> T>
		     <EQUAL? .OBJ ,HERE <LOC ,WINNER>>>
		<CRLF>)>
	 <NOT .1ST?>)>>

<ROUTINE DESCRIBE-START (OBJ)
	 <COND (<EQUAL? .OBJ ,HERE>
		<TELL ,YOU-SEE>)
	       (<EQUAL? .OBJ ,PROTAGONIST>
		<COND (<EQUAL? ,D-BIT ,WORNBIT>
		       <TELL " You are wearing">)
		      (T
		       <TELL "You have">)>)
	       (<FSET? .OBJ ,SURFACEBIT>
		<TELL "Sitting on" T .OBJ " is">)
	       (<AND <FSET? .OBJ ,ACTORBIT>
		     <NOT <EQUAL? .OBJ ,CROC>>>
		<COND (<EQUAL? .OBJ ,LUCY>
		       <TELL "Sh">)
		      (T
		       <TELL "H">)>
		<TELL "e has">)
	       (<EQUAL? .OBJ ,FENCE ,BOTTLE ,HORN>
		<RTRUE>)
	       (T
		<TELL ,IT-SEEMS-THAT T .OBJ " contains">)>>

<GLOBAL D-BIT <>>	;"bit to screen objects"

<ROUTINE DESCRIBABLE? (OBJ "OPT" (CONT? <>))
	 <COND (<FSET? .OBJ ,INVISIBLE> <RFALSE>)
	       (<EQUAL? .OBJ ,WINNER> <RFALSE>)
	       (<AND <EQUAL? .OBJ <LOC ,WINNER>>
		     <NOT <EQUAL? ,HERE <LOC ,WINNER>>>>
		<RFALSE>)
	       (<AND <NOT .CONT?> <FSET? .OBJ ,NDESCBIT>>
		<RFALSE>)
	       (,D-BIT
		<COND (<G? ,D-BIT 0>
		       <COND (<FSET? .OBJ ,D-BIT> <RTRUE>)
			     (ELSE <RFALSE>)>)
		      (<NOT <FSET? .OBJ <- ,D-BIT>>>
		       <RTRUE>)
		      (ELSE <RFALSE>)>)
	       (ELSE
		<RTRUE>)>>

;<ROUTINE DESCRIBABLE? (OBJ "OPT" (CONT? <>))
	 <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       (<EQUAL? .OBJ ,WINNER>
		<RFALSE>)
	       (<AND <EQUAL? .OBJ <LOC ,WINNER>>
		     <NOT <EQUAL? ,HERE <LOC ,WINNER>>>>
		<RFALSE>)
	       (<AND <NOT .CONT?>
		     <FSET? .OBJ ,NDESCBIT>>
		<RFALSE>)	       
	       ;(<AND <EQUAL? .OBJ ,RAFT ,BARGE>
		     <EQUAL? ,HERE ,CANAL>
		     <NOT <HELD? .OBJ>>
		     <NOT <IN? .OBJ ,BARGE>>
	             <NOT <EQUAL? ,RAFT-LOC-NUM ,BARGE-LOC-NUM>>>
		<RFALSE>)
	       (T
		<RTRUE>)>>

<ROUTINE SIMPLE-DESC? (OBJ "AUX" STR)
	 <COND (<AND <GETP .OBJ ,P?FDESC>
		     <NOT <FSET? .OBJ ,TOUCHBIT>>>
		<RFALSE>)
	       (<AND <SET STR <GETP .OBJ ,P?DESCFCN>>
		     <APPLY .STR ,M-DESC?>>
		<RFALSE>)
	       (<GETP .OBJ ,P?LDESC>
		<RFALSE>)
	       (T
		<RTRUE>)>>

<ROUTINE DESCRIBE-VEHICLE () ;"for LOOK AT/IN vehicle when you're in it"
	 <TELL "Other than " D ,ME ", you can see"> 
	 <COND (<NOT <DESCRIBE-NOTHING>>
		<COND (<FSET? ,PRSO ,INBIT>
		       <TELL " in">)
		      (T
		       <TELL " on">)>
		       <TELL TR ,PRSO>)>
	  <RTRUE>>

<ROUTINE DESCRIBE-NOTHING ()
	 <COND (<DESCRIBE-CONTENTS ,PRSO 2>
	 	<COND (<NOT <IN? ,PROTAGONIST ,PRSO>>
		       <CRLF>)>
		<RTRUE>)
	       (T ;"nothing"
		<RFALSE>)>>

;"subtitle movement and death"

<CONSTANT REXIT 0>
<CONSTANT UEXIT 1>
<CONSTANT NEXIT 2>
<CONSTANT FEXIT 3>
<CONSTANT CEXIT 4>
<CONSTANT DEXIT 5>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 1>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 1>

;<ROUTINE ;GOTO (NEW-LOC "AUX" OLD-HERE)
	 <SET OLD-HERE ,HERE>
	 <MOVE ,PROTAGONIST .NEW-LOC>
	 <COND (<IN? .NEW-LOC ,ROOMS>
		<SETG HERE .NEW-LOC>)
	       (T
		<SETG HERE <LOC .NEW-LOC>>)>
	 <SETG LIT <LIT? ,HERE>>
	 <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
	 <COND (<AND <DESCRIBE-ROOM>
		     <NOT <EQUAL? ,VERBOSITY 0>>>
		<DESCRIBE-OBJECTS>)>
	 <RTRUE>>

<ROUTINE GOTO (NEW-LOC "OPTIONAL" (DONT-DESCRIBE-DAD <>) "AUX" OLD-HERE)
	 <SET OLD-HERE ,HERE>
	 <MOVE ,PROTAGONIST .NEW-LOC>
	 <COND (<IN? .NEW-LOC ,ROOMS>
		<SETG HERE .NEW-LOC>)
	       (T
		<SETG HERE <LOC .NEW-LOC>>)>
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<AND <EQUAL? .OLD-HERE ,LIBRARY>
		     <HELD? ,HAT>
		     <EQUAL? ,HERE ,BY-HOUSE ,HALL-E>>
		<SAFETY-SAKE>
		<CRLF>)>
	 <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
	 ;<COND (<RUNNING? ,I-DUEL>
		<SEE/HEAR-DUEL>)>
	 <COND (<AND <EQUAL? ,HERE ,PASSAGE-4>
		     <IN? ,DAD ,HERE>>
		<TELL
"\"What a brave tot! You've inherited all your mother's spirit.\"
Your father beams with pride" ,PCR CR>)
	       (<AND <EQUAL? ,HERE ,BOTTOM-STAIRS>
		     <IN? ,COOKIE ,ANTEROOM>>
		<SETG COOKIE-FIGHTING-CROC <>>
		<FCLEAR ,CROC ,NDESCBIT>
		<TELL
"\"I ain't goin' to fight this beast if you're headin' back upstairs.\""
T ,COOKIE>
		<COND (<IN? ,RAPIER ,PROTAGONIST>
		       <MOVE ,RAPIER ,COOKIE>
		       <TELL
" eyes" T ,RAPIER " in" T ,HANDS ". \"Not a proper thing fer a lady,\"
he grumbles, taking it from you. He">)>
		<TELL " follows you" ,PCR CR>)
	       ;(<AND <EQUAL? ,HERE ,FOYER>
		     <NOT <EQUAL? .OLD-HERE ,BALLROOM>>
		     <NOT <FSET? ,BUTLER ,DEADBIT>>>
		<COND (<HELD? ,HAT>
		       <WEARING-HAT>
		       <CRLF>
		       <CRLF>)>)
	       (<EQUAL? ,HERE ,LAGOON>    ;"so as not to describe room again"
		<RTRUE>)> 
	 <COND (<AND <DESCRIBE-ROOM>
		     <NOT <EQUAL? ,VERBOSITY 0>>>
		<DESCRIBE-OBJECTS>)>
	 <COND (<AND <IN? ,DAD .OLD-HERE>
		     <IN? ,PROTAGONIST ,HERE> ;"don't, if you're in a vehicle"
		     <NOT .DONT-DESCRIBE-DAD>
		     <NOT ,ENDGAME>>
		<DAD-FOLLOWS-YOU>)>
	 <COND (<AND <IN? ,HERO .OLD-HERE>
		     <IN? ,PROTAGONIST ,HERE>
		     <NOT ,ENDGAME>>
		<COND (<AND <EQUAL? ,HERE ,BALLROOM>
			    <EQUAL? ,PARTNER ,HERO>>
		       <MOVE ,HERO ,HERE>
		       <TELL
D ,HERO " smiles and follows you, pulling you onto" ,DANCE-FLOOR ,PCR>)
		      (<EQUAL? .OLD-HERE ,BALLROOM>
		       <MOVE ,HERO ,HERE>
		       <RTRUE>)
		      (T
		       <STOP-QUEUES>
		       <REMOVE ,HERO>
		       <TELL ,INDENT "\"No, wait -- !\" Jamison cries. He ">
		       <COND (<EQUAL? ,HERE ,LAWN>
			      <TELL "slips past you into the forest">)
			     (T
			      <TELL "hesitates and turns away">)>
		       <TELL ,PCR>)>)>
	 <COND (<AND ,ENDGAME
		     <IN? ,COOKIE .OLD-HERE>
		     <IN? ,PROTAGONIST ,HERE>
		     <NOT ,COOKIE-FIGHTING-CROC>
		     <NOT <RUNNING? ,I-ENDGAME>>>
		<COND (<AND <RUNNING? ,I-DUEL>
			    <EQUAL? .OLD-HERE ,GALLERY ,STAIRTOP>>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,BEACH>  ;"prevents going back to ship"
		       <RTRUE>)>
		<MOVE ,COOKIE ,HERE>
		<TELL ,INDENT D ,COOKIE " pegs after you" ,PCR>)>
	 <RTRUE>>

<ROUTINE SAFETY-SAKE ()
	 <MOVE ,HAT ,LIBRARY>
	 <FCLEAR ,HAT ,WORNBIT>
	 <FSET ,HAT ,EVERYBIT>
	 <FCLEAR ,KNOB ,EVERYBIT>
	 <FSET ,KNOB ,DEADBIT>
	 <TELL
"For safety's sake, you leave" T ,HAT " on its knob.
Best not to show that you've been wandering" ,PCR>>

; "Sets globals to the appropriate T/<>: as soon as you pass through a room
   where a global's value might change, this checks and changes it."
;<ROUTINE SEE/HEAR-DUEL ()
	 <COND (<EQUAL? ,HERE ,LIBRARY ,VERANDA ,HALL-W>
		<SETG CAN-HEAR-DUEL T>)
	       (<EQUAL? ,HERE ,GALLERY>
		<SETG CAN-HEAR-DUEL <>>
		<SETG CAN-SEE-DUEL T>)
	       ;(<EQUAL? ,HERE ,STAIRTOP ,GALLERY>
		<SETG CAN-HEAR-DUEL <>>
		<SETG CAN-SEE-DUEL T>)
	       (<EQUAL? ,HERE ,STAIRWELL ,MAIN-ENTRANCE ,KITCHEN ,LAWN>
		<SETG CAN-HEAR-DUEL <>>)
	       (<EQUAL? ,HERE ,UPPER-HALL-E ,FOYER ,UPPER-HALL-W>
		<SETG CAN-SEE-DUEL <>>
		<SETG CAN-HEAR-DUEL T>)>
	 <RFALSE>>

<ROUTINE DAD-FOLLOWS-YOU ()
	 <COND (<EQUAL? ,HERE ,CELL-4>
		<TELL
"Your father chuckles in the darkness of the passageway, \"No dear,
I'm not going in there again!\"" CR>)
	       (T 
		<MOVE ,DAD <LOC ,PROTAGONIST>>
		<TELL ,INDENT "Papa " <PICK-ONE ,FOLLOWS> CR>)>>

<GLOBAL FOLLOWS
	<LTABLE
	 0
	 "mutters something to himself. You hear an occasional \"Zounds!\""
	 "follows you."
	 "enters just a few steps behind you."
	 ;" gives you a brief hug, \"It's good to see thee, daughter.\"">>

<GLOBAL YOU-DIED "||      ***   You have died   ***||">

<ROUTINE JIGS-UP (DESC)
	 <TELL ;,INDENT .DESC>
	 <TELL ,YOU-DIED>
	 <FINISH>>

<ROUTINE H-JIGS-UP (DESC "OPTIONAL" (DAD-DEAD <>))
	 <TELL .DESC>
	 <TELL ,YOU-DIED ,INDENT>
	 <COND (.DAD-DEAD
		<TELL
"Troubled by Papa's death, caused by your own unthinking pride,
your life loses meaning. You die by your own hand, in grief and shame.">)
	       (T
		<TELL
"Rather, your flesh is intact, but your spirit has flown with the death
of your heart's love. The years pass, unnoticed, twisting you into an old
and ugly spinster, that dies alone, loved by no one.">)>
	 <CRLF>
	 <FINISH>>  

<ROUTINE FWTD (DESC)
	 <TELL ;,INDENT .DESC>
	 <TELL CR CR
"  ***     You have suffered| 
     a fate worse than death  ***" CR>
	 <FINISH>>

;"subtitle useful utility routines"

<ROUTINE ACCESSIBLE? (OBJ "AUX" L) ;"revised 2/18/86 by SEM"
	 <COND (<NOT .OBJ>
		<RFALSE>)>
	 <SET L <LOC .OBJ>>
	 <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       (<EQUAL? .OBJ ,PSEUDO-OBJECT>
		<COND (<EQUAL? ,LAST-PSEUDO-LOC ,HERE>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<NOT .L>
		<RFALSE>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<RTRUE>)
	       (<AND <EQUAL? .L ,LOCAL-GLOBALS>
		     <GLOBAL-IN? .OBJ ,HERE>>
		<RTRUE>)
	       (<NOT <EQUAL? <META-LOC .OBJ> ,HERE>>
		<RFALSE>)
	       (<EQUAL? .L ,WINNER ,HERE>
		<RTRUE>)
	       (<AND <FSET? .L ,OPENBIT>
		     <ACCESSIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE VISIBLE? (OBJ "AUX" L) ;"revised 5/2/84 by SEM and SWG"
	 <COND (<NOT .OBJ>
		<RFALSE>)>
	 <SET L <LOC .OBJ>>
	 <COND (<ACCESSIBLE? .OBJ>
		<RTRUE>)
	       (<AND <SEE-INSIDE? .L>
		     <VISIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE UNTOUCHABLE? (OBJ)
;"figures out whether, due to vehicle-related locations, object is touchable"
	 <COND (<NOT .OBJ>
		<RFALSE>)
	       ;"next clause is special case for PH"
	       (<EQUAL? .OBJ ,SEA>
		<COND (<EQUAL? ,HERE ,LAGOON ,SHALLOWS ,MAIN-DECK ,BEACH>
		       <RFALSE>)
		      (T
		       <RTRUE>)>)
	       (<AND <EQUAL? .OBJ ,LADDER>
		     <EQUAL? <LOC ,PROTAGONIST> ,LEDGE>>
		<RFALSE>)
	       (<IN? ,PROTAGONIST ,HERE>
		<RFALSE>)
	       (<OR <HELD? .OBJ <LOC ,PROTAGONIST>>
		    <EQUAL? .OBJ <LOC ,PROTAGONIST>>
		    <IN? .OBJ ,GLOBAL-OBJECTS> ;"me, hands, etc.">
		<RFALSE>)
	       ;(<PRSO? ,PATROL>
		<CANT-REACH ,PRSO>)  ;"covered below" 
	       (T
		<RTRUE>)>>

<ROUTINE META-LOC (OBJ)
	 <REPEAT ()
		 <COND (<NOT .OBJ>
			<RFALSE>)
		       (<IN? .OBJ ,GLOBAL-OBJECTS>
			<RETURN ,GLOBAL-OBJECTS>)>
		 <COND (<IN? .OBJ ,ROOMS>
			<RETURN .OBJ>)
		       (T
			<SET OBJ <LOC .OBJ>>)>>>

<ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) TEE) ;"finds room on other side of door"
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RETURN <>>)
		       (T
			<SET TEE <GETPT ,HERE .P>>
			<COND (<AND <EQUAL? <PTSIZE .TEE> ,DEXIT>
				    <EQUAL? <GETB .TEE ,DEXITOBJ> .DOBJ>>
			       <RETURN .P>)>)>>>

<ROUTINE HELD? (OBJ "OPTIONAL" (CONT <>)) ;"formerly ULTIMATELY-IN?"
	 <COND (<NOT .CONT>
		<SET CONT ,WINNER>)>
	 <COND (<NOT .OBJ>
		<RFALSE>)
	       (<IN? .OBJ .CONT>
		<RTRUE>)
	       (<IN? .OBJ ,ROOMS>
		<RFALSE>)
	       ;(<IN? .OBJ ,GLOBAL-OBJECTS>
		<RFALSE>)
	       (T
		<HELD? <LOC .OBJ> .CONT>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND .OBJ
	      <NOT <FSET? .OBJ ,INVISIBLE>>
	      <OR <FSET? .OBJ ,TRANSBIT>
	          <FSET? .OBJ ,OPENBIT>>>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TEE)
	 <COND (<SET TEE <GETPT .OBJ2 ,P?GLOBAL>>
		<ZMEMQB .OBJ1 .TEE <- <PTSIZE .TEE> 1>>)>>

<ROUTINE FIND-IN (WHERE FLAG-IN-QUESTION
		  "OPTIONAL" (STRING <>) "AUX" OBJ RECURSIVE-OBJ)
	 <SET OBJ <FIRST? .WHERE>>
	 <COND (<NOT .OBJ>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<AND <FSET? .OBJ .FLAG-IN-QUESTION>
			     <NOT <FSET? .OBJ ,INVISIBLE>>>
			<COND (.STRING
			       <TELL "[" .STRING T .OBJ "]" CR>)>
			<RETURN .OBJ>)
		       (<SET RECURSIVE-OBJ <FIND-IN .OBJ .FLAG-IN-QUESTION>>
			<RETURN .RECURSIVE-OBJ>)
		       (<NOT <SET OBJ <NEXT? .OBJ>>>
			<RETURN <>>)>>>

;<ROUTINE DIRECTION? (OBJ)
	 <COND (<OR <EQUAL? .OBJ ,P?NORTH ,P?SOUTH ,P?EAST>
		    <EQUAL? .OBJ ,P?WEST ,P?NE ,P?NW>
		    <EQUAL? .OBJ ,P?SE ,P?SW>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

;<ROUTINE NOW-DARK? ()
	 <COND (<AND ,LIT
		     <NOT <LIT? ,HERE>>>
		<SETG LIT <>>
		<TELL ,INDENT "It is now too dark to see." CR>)>>

;<ROUTINE NOW-LIT? ()
	 <COND (<AND <NOT ,LIT>
		     <LIT? ,HERE>>
		<SETG LIT T>
		<CRLF>
		<V-LOOK>)>>

<ROUTINE LOC-CLOSED ("AUX" (L <LOC ,PRSO>))
	 <COND (<AND <FSET? .L ,CONTBIT>
		     <NOT <FSET? .L ,OPENBIT>>
		     <FSET? ,PRSO ,TAKEBIT>>
		<DO-FIRST "open" .L>)
	       (T
		<RFALSE>)>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>>

<ROUTINE STOP ()
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RFATAL>>

<ROUTINE ANYTHING-HELD ("AUX" (SOMETHING-HELD <>) N X)
	 <SET X <FIRST? ,PROTAGONIST>>
	 <REPEAT ()
	         <COND (<ZERO? .X>
			<RETURN>)>
	         <COND (<NOT <OR <FSET? .X ,WORNBIT>
				 <EQUAL? .X ,RETICULE>>>
	                <SET SOMETHING-HELD T>)>
	         <SET N <NEXT? .X>>
	         <SET X .N>>
	  <RETURN .SOMETHING-HELD>>

<ROUTINE ROB (WHO "OPTIONAL" (WHERE <>) "AUX" N X)
	 <SET X <FIRST? .WHO>>
	 <REPEAT ()
		 <COND (<ZERO? .X>
			<RETURN>)>
	         <SET N <NEXT? .X>>
		 <COND (<NOT <OR <FSET? .X ,WORNBIT>
				 <EQUAL? .X ,PINCH>>>
			<COND (.WHERE
			       <MOVE .X .WHERE>)
			      (T
			       <REMOVE .X>)>)>
		 <SET X .N>>
	 <MOVE ,RETICULE ,PROTAGONIST>>

<ROUTINE HACK-HACK (STR)
	 <TELL .STR T ,PRSO>
	 <HO-HUM>>

<ROUTINE HO-HUM ()
	 <TELL <PICK-ONE ,HO-HUM-LIST> CR>>

<GLOBAL HO-HUM-LIST
	<LTABLE
	 0 
	 " doesn't do anything."
	 " accomplishes nothing."
	 " has no desirable effect.">>		 

;<ROUTINE YUKS ()
	 <TELL <PICK-ONE ,YUK-LIST> CR>>

;<GLOBAL YUK-LIST
	<LTABLE
	 0 
	 "What an odd thing to attempt to do."
         "Nice try."
	 "Not a good idea.">>

<ROUTINE IMPOSSIBLES ()
	 <TELL <PICK-ONE ,IMPOSSIBLE-LIST> CR>>

<GLOBAL IMPOSSIBLE-LIST
	<LTABLE
	 0
	 "Think again, guv'nor."
	 "This is no time to get hysterical."
	 "It's Bedlam for you!"
	 "Don't be absurd."
	 "You have lost your mind.">>

<ROUTINE WASTES ()
	 <TELL <PICK-ONE ,WASTE-LIST> CR>>

<GLOBAL WASTE-LIST
	<LTABLE
	 0
	 "What an odd thing to attempt."
	 "That is a waste of time."
	 "Don't dally around."
	 "It's not worth it. Believe me."
	 "That seems a useless idea."
	 "Don't bother.">>

;<ROUTINE V-$CAPT ()
	 <DEQUEUE I-COFFER>
	 <DEQUEUE I-MEET-HERO>
	 <DEQUEUE I-CRULLEY>
	 <FCLEAR ,COFFER ,NDESCBIT>
	 <TELL "Cheat to captain's " D ,OBJ-QUARTERS "." CR>
	 <I-END-PROLOGUE>>

;<ROUTINE V-$SHIP ()
	 <TELL "Nah" ,PCR>>

;<ROUTINE V-$SHIP ()
	 <DEQUEUE I-COFFER>
	 <DEQUEUE I-MEET-HERO>
	 <DEQUEUE I-CRULLEY>
	 ;<MOVE ,LADDER ,CAPT-QUARTERS>
	 <SETG LADDER-HANGING T>
	 <REMOVE ,COFFER>
	 <FSET ,LEDGE ,MUNGBIT>
	 <FSET ,POOP ,TOUCHBIT>
	 <FCLEAR ,DRESS ,WORNBIT>
	 ;<FCLEAR ,HOOPS ,WORNBIT>
	 <FSET ,SHIRT ,WORNBIT>
	 <FSET ,PANTS ,WORNBIT>
	 <FCLEAR ,SHIRT ,NDESCBIT>
	 <FCLEAR ,PANTS ,NDESCBIT>
	 <FSET ,SHIRT ,TOUCHBIT>
	 <FSET ,PANTS ,TOUCHBIT>
	 <MOVE ,SHIRT ,PROTAGONIST>
	 <MOVE ,PANTS ,PROTAGONIST>
	 <SETG BOY-DRESS? T>
	 <REMOVE ,PILE-OF-CLOTHES>
	 <I-END-PROLOGUE>
	 <TELL CR "Wheeeeeee!" CR>
	 <GOTO ,MAIN-DECK>
	 <DEQUEUE I-HSHIP>
	 <QUEUE I-SMELL-SMOKE 2>
	 <REMOVE ,HERO>>

;<ROUTINE V-$BEACH ()
	 <CLEAR-SCREEN>
	 ;<DEQUEUE I-JIGS-UP-SNAFU>
	 <DEQUEUE I-MEET-HERO>
	 <DEQUEUE I-PIRATE-ATTACK>
	 <DEQUEUE I-CRULLEY>
	 <DEQUEUE I-COFFER>
	 <MOVE ,SHIRT ,PROTAGONIST>
	 <MOVE ,PANTS ,PROTAGONIST>
	 ;<FCLEAR ,HOOPS ,WORNBIT>
	 <FCLEAR ,DRESS ,WORNBIT>
	 <FSET ,SHIRT ,WORNBIT>
	 <FSET ,PANTS ,WORNBIT>
	 <FSET ,POOP ,TOUCHBIT>
	 <SETG BOY-DRESS? T>
	 <MOVE ,CASK ,SHALLOWS>
	 <GOTO ,BEACH>
	 <REMOVE ,HERO>>

;<ROUTINE V-$DUNGEON ()
	 <TELL "Nah" ,PCR>>

;<ROUTINE V-$DUNGEON ()
	 <PERFORM ,V?$BEACH>
	 <TELL CR ,INDENT "\"Ooh, nice beach. Me? I go in for dungeons.\"" CR>
	 <MOVE ,PROTAGONIST ,STAIRWELL>
	 ;<MOVE ,CANDLE ,PROTAGONIST>
	 <FSET ,PORTRAIT ,MUNGBIT>
	 <FSET ,PORTRAIT ,OPENBIT>
	 ;<FSET ,IRON-CELL-DOOR ,OPENBIT>>

;<ROUTINE V-$BUTLER ()
	 <CLEAR-SCREEN>
	 <DEQUEUE I-COFFER>
	 <DEQUEUE I-CRULLEY>
	 <DEQUEUE I-MEET-HERO>
	 <DEQUEUE I-HSHIP>
	 <DEQUEUE I-PIRATE-ATTACK>
	 ;<DEQUEUE I-JIGS-UP-SNAFU>
	 <MOVE ,INVITE ,PROTAGONIST>
	 <MOVE ,SHIRT ,PROTAGONIST>
	 <MOVE ,PANTS ,PROTAGONIST>
	 ;<REMOVE ,HOOPS>
	 <FCLEAR ,DRESS ,WORNBIT>
	 <REMOVE ,HERO>
	 <MOVE ,GOWN ,PROTAGONIST>
	 <FSET ,GOWN ,WORNBIT>
	 <FCLEAR ,GOWN ,NDESCBIT>
	 <TELL "Yippee! A ball!" CR>
	 <GOTO ,MAIN-ENTRANCE>>

;<ROUTINE V-$MUZZLED ()
	 <SETG MUZZLED T>
	 <MOVE ,GARTER ,CROC>
	 <FCLEAR ,GARTER ,INVISIBLE>
	 <TELL "It's safe now, the baby's muzzled." CR>>

;<ROUTINE V-$GARTER ()
	 <MOVE ,GARTER ,PROTAGONIST>
	 <FCLEAR ,GARTER ,INVISIBLE>
	 <TELL "You got it, baby" ,PCR>>

;<ROUTINE V-$SEDUCTION ()
	 ;<TELL "[This should be done only after giving the butler your
invitation, by the way. You can V-$BUTLER to shortcut.]" CR>
	 <FSET ,BALLROOM ,TOUCHBIT>
	 <MOVE ,PROTAGONIST ,FOYER>
	 <MOVE ,MIRROR ,PROTAGONIST>
	 <MOVE ,BOTTLE ,PROTAGONIST>
	 <QUEUE I-SUMMONS 1>>

;<ROUTINE V-$END ()         ;"Puts you in the gallery, ready to swing."
	 <CLEAR-SCREEN>
	 <DEQUEUE I-COFFER>
	 <DEQUEUE I-CRULLEY>
	 <DEQUEUE I-MEET-HERO>
	 <DEQUEUE I-HSHIP>
	 <DEQUEUE I-PIRATE-ATTACK>
	 ;<DEQUEUE I-JIGS-UP-SNAFU>
	 <MOVE ,PROTAGONIST ,GALLERY>
	 <MOVE ,HORN ,PROTAGONIST>
	 <FCLEAR ,ROPE ,EVERYBIT>
	 <SETG ENDGAME T>
	 <FSET ,COOKIE ,MUNGBIT>
	 <QUEUE I-DUEL -1>
	 <FSET ,RAPIER ,NDESCBIT>
	 <MOVE ,DAD ,GALLERY>
	 <MOVE ,LUCY ,GALLERY>
	 <MOVE ,COOKIE ,GALLERY>
	 <MOVE ,HERO ,GALLERY>
	 <MOVE ,RAPIER ,HERO>
	 <MOVE ,LAFOND ,GALLERY>
	 <FCLEAR ,BALLROOM ,EVERYBIT>
	 <MOVE ,BUTLER ,UPPER-HALL-E>
	 <MOVE ,SKIFF ,SHALLOWS>
	 <FSET ,BUTLER ,DEADBIT>
	 ;<FSET ,BUTLER ,MUNGBIT>
	 <MOVE ,INVITE ,BUTLER>
	 <FSET ,LAWN ,TOUCHBIT>
	 <FSET ,BEACH ,TOUCHBIT>
	 <MOVE ,GARTER ,DAD>
	 <FCLEAR ,GARTER ,INVISIBLE>
	 ;<MOVE ,DAGGER ,PROTAGONIST>
	 <FSET ,DRESS ,MUNGBIT>
	 <FCLEAR ,DRESS ,WORNBIT>
	 <FSET ,GOWN ,WORNBIT>
	 <FSET ,BALLROOM ,TOUCHBIT>
	 <TELL "[You're ready to go, swinger!]" CR>>
	 
	 
	 
	 
	 