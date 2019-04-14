"EXTRAS for
 			PLUNDERED HEARTS
	(c) Copyright 1987 Infocom, Inc. All Rights Reserved."


<OBJECT CRULLEY                       ;"EVERYBIT = 1/2 fight in dungeon."
	(DESC "Crulley")                    ;"DEADBIT = unconscious"
	(DESCFCN CRULLEY-F)                        ;"MUNGBIT = down well"
	(SYNONYM PIRATE CRULLEY HOOK)
	(ADJECTIVE ANDREW ANDY)
	(SIZE 10)
	(FLAGS ACTORBIT NARTICLEBIT OPENBIT CONTBIT TRANSBIT)
	(GENERIC GEN-PIRATE)
	(ACTION CRULLEY-F)>

<ROUTINE CRULLEY-F ("OPTIONAL" (OARG <>) "AUX" X)
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-DESC?>
		       <RTRUE>)>
		<TELL ,INDENT>
		<COND (<EQUAL? ,HERE ,BEACH>
		       <TELL D ,CRULLEY " stands">
		       <COND (<G? ,LAFOND-CTR <- ,DEAD 1>>
			      <TELL ", pistol ready," ,HALFWAY>)
			     (T
			      ;<G? ,LAFOND-CTR 4>
			      <TELL " with the dragoons.">)>)

               ;"Less than 4, in ENDGAME, Crulley handled in LAFOND-F"

		      (<EQUAL? ,HERE ,CABIN>
		       <TELL D ,CRULLEY " the pirate">
		       <COND (<FSET? ,CRULLEY ,DEADBIT>
			      <TELL " lies unconscious on the floor.">)
			     (T
		       <TELL ", hook raised, leering, comes toward you.">)>)>)
	       (<EQUAL? ,CRULLEY ,WINNER>
		<COND (<FSET? ,CRULLEY ,DEADBIT>
		       <TELL ,DOESNT-RESPOND>)
		      (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <COND (<NOUN-USED ,W?HOOK ,CRULLEY>
			      <TELL
"He snarls at the memory, \"'Twere bit off by a monster crocodile.\"" CR>)
			     (<PRSI? ,LAFOND>
			      <TELL
"\"'E's a hard 'un, who won't take no guff. But 'e pays well">
			      <COND (<NOT <FSET? ,BEACH ,TOUCHBIT>>
				     <TELL " -- er, so I hear">)>
			      <TELL ".\"" CR>)
			     (T
			      <TELL D ,CRULLEY " ignores you" ,PCR>)>
		       <STOP>)
		      (<VERB? HELLO>
		       <TELL "\"Har-har.\"" CR>)
		      (<AND <VERB? KISS>
			    <PRSO? ,ME>>
		       <TELL
"\"Wi' a wannion! I likes me ladies forward!\"" CR>)
		      (<SET X <COM-CHECK ,CRULLEY>>
		       <COND (<==? .X ,M-FATAL> <RFALSE>)
			     (T <RTRUE>)>)
		      ;(T
		       <TELL D ,CRULLEY
" cackles, his breath hot and pungent." CR>
		       <STOP>)>)
	       (<VERB? KILL CUT>
		<COND (<FSET? ,CRULLEY ,DEADBIT>
		       <MAN-IS-DOWN>)
		      (<OR <NOT ,PRSI>
			   <PRSI? ,HANDS>>
		       <COND (<EQUAL? ,P-PRSA-WORD ,W?SLAP>
			      <TELL
"Slap! The pirate fingers the red welt left by" T ,HANDS ", and laughs." CR>)
			     (<AND <IN? ,COFFER ,PROTAGONIST>
				   <NOT ,PRSI>>
			      <PERFORM ,V?KILL ,CRULLEY ,COFFER>
			      <RTRUE>)
			     (<AND <IN? ,RAPIER ,PROTAGONIST>
				   <NOT ,PRSI>>
			      <PERFORM ,V?KILL ,CRULLEY ,RAPIER>
			      <RTRUE>)
			     (T
			      <CANT-HURT "dainty fists">)>)
		      (<PRSI? ,COFFER>
		       <SETG ATTACK-C <+ ,ATTACK-C 1>>
		       <SETG CRULLEY-HIT T>
		       <TELL
"With all your strength you whack the pirate" ,OVER-HEAD TR ,PRSI>
		       <MOVE ,PROTAGONIST ,HERE> ;"in case you're in bed"
		       <DEQUEUE I-CRULLEY>
		       <I-CRULLEY>)
		      (<PRSI? ,RAPIER>
		       <COND (<FSET? ,CRULLEY ,EVERYBIT>
			      <COND (<FSET? ,CRULLEY ,MUNGBIT>
				     <TELL
,YOU-CANT "very well reach" T ,CRULLEY " when he's down in" TR ,WELL>)
				    (T
				     <DEQUEUE I-CDUNG>
				     <SETG SCORE <+ ,SCORE 1>>
				     <SETG CRULLEY-CTR 1>
				     <QUEUE I-CCLIMBS-UP 2>
				     <FSET ,CRULLEY ,MUNGBIT>
				     <FSET ,CRULLEY ,NDESCBIT>
				     <MOVE ,CRULLEY ,TRAP>
				     <REMOVE ,WHIP>
				     <TELL
"You flick" T ,RAPIER " across his chest, barely scratching him. He cries,
\"Avast me! Pricked by a woman!\" and trips into" TR ,TRAP
,INDENT "You peer down the hole to find " D ,CRULLEY " hanging in midair,
his hook caught in the rocks a few yards down. He curses and starts to
climb up the sheer slimy walls of" TR ,WELL>)>)
			     (T
			      <FSET ,CRULLEY ,EVERYBIT>
			      <TELL
D ,CRULLEY " seems more amazed than frightened of your attack, guessing
correctly that you hardly know the tip from the hilt of" T ,RAPIER
". He steps sideways in surprise, so he stands at" ,THE-EDGE TR ,TRAP>)>)
		      (T
		       <TELL
"You slap" T ,CRULLEY ,OVER-HEAD T ,PRSI ", to no effect" ,PCR>)>)
	       (<VERB? KISS>
		<SETG WINNER ,CRULLEY>
		<PERFORM ,V?KISS ,ME>
		<SETG WINNER ,PROTAGONIST>
		<RTRUE>)
	       (<VERB? KICK>
		<CANT-HURT "slippered toes">)
	       (<VERB? THROW PUT PUT-ON THROW-AT>
		<COND (<FSET? ,CRULLEY ,MUNGBIT>
		       <COND (<PRSO? ,RAPIER>
			      <PERFORM ,V?PUT ,RAPIER ,TRAP>
			      <RTRUE>)
			     (<PRSO? ,RETICULE>
			      <RFALSE>)
			     (T
			      <REMOVE ,PRSO>
			      <TELL
D ,CRULLEY " curses as" T ,PRSO " sails past him down into" TR ,WELL>)>)
		      (<PRSO? ,COFFER>
		       <PERFORM ,V?KILL ,CRULLEY ,PRSO>)
		      (T
		       <RFALSE>)>)
	       ;(<AND <VERB? THROW>
		     <NOT <EQUAL? ,HERE ,DUNGEON>>>
		<PERFORM ,V?KILL ,CRULLEY ,PRSO>
		<RTRUE>)
	       (<VERB? SEARCH>
		<COND (<FSET? ,CRULLEY ,DEADBIT>
		       <TELL "And dirty your lily hands? Never!" CR>)
		      (<FSET? ,CRULLEY ,MUNGBIT>
		       <CANT-REACH ,CRULLEY>)
		      (T
		       <TELL
"You are uncomfortably sure he would love to have you frisk him." CR>)>) 
	       (<AND <VERB? GIVE>
		     <PRSO? ,BANKNOTE>
		     <NOT <EQUAL? ,HERE ,BEACH>>>
		<TELL "He takes it, smiling blackly" ,PCR>)
	       (<VERB? EXAMINE>
		<COND (<NOUN-USED ,W?HOOK ,CRULLEY>
		       <TELL "The hook replaces one of his hands." CR>)
		      (T 
		       <TELL
"The pirate's unsavory face is crisscrossed with scars, and those not
from shaving nicks, to judge by his scruffy beard. A hook
replaces one of his hands at the end of a torn black sleeve" ,PCR>)>)>>


<GLOBAL CRULLEY-CTR 0>
<GLOBAL CRULLEY-HIT <>>
<GLOBAL ATTACK-C 0>                ;"ATTACK-C, HEARD-CRULLEY, CRULLEY-BACK" 
<GLOBAL HEARD-CRULLEY <>>          ;"could, in emergencies, be made into one"
<GLOBAL CRULLEY-BACK 0>            ;"wild-card global, set <> at intervals"

<ROUTINE I-CRULLEY ()
	 <TELL ,INDENT>
	 <COND (<AND <EQUAL? ,ATTACK-C 0>
		     <NOT <FSET? ,CRULLEY ,TOUCHBIT>>>
		<QUEUE I-MEET-HERO 2>
		<FSET ,CRULLEY ,TOUCHBIT>
		<MOVE ,CRULLEY ,CABIN>
	 	<QUEUE I-CRULLEY -1>
		<FSET ,DOOR ,MUNGBIT>
		<TELL
"Crash! You whirl around to see" T ,DOOR " shatter,
kicked by a hulking man, his twisted visage blackened with soot and blood. ">)
	       (<EQUAL? ,ATTACK-C 1>
		;<QUEUE I-CRULLEY 1>       ;"to fix ZIP20 Warning 15/7"
		<TELL "The pirate stumbles, dizzy. ">)>
	 <COND (<EQUAL? ,ATTACK-C 2>
		<FSET ,CRULLEY ,DEADBIT>
		<TELL ,STUNNED-THE-SAILOR ,PCR>)
	       (T
		<CRULLEY-SAYS>)>
	 <SETG CRULLEY-CTR <+ ,CRULLEY-CTR 1>>>

<GLOBAL STUNNED-THE-SAILOR "Stunned, Crulley collapses at your feet,
his eyes rolling">

<ROUTINE CRULLEY-SAYS ()
	 <TELL "\"" <GET ,MENACES ,CRULLEY-CTR> ",\" ">
	 <COND (<EQUAL? ,ATTACK-C 1>
	        <TELL "slurs">)
	       (T
		<TELL "sniggers">)>
	 <TELL " the pirate">
	 <COND (<EQUAL? ,CRULLEY-CTR 1>
		<TELL ". His breath is heavy with rum">)
	       (<PROB 60>
		<TELL ", advancing toward you">)>
	 <TELL ,PCR>>

<GLOBAL MENACES
	<TABLE
	 "Me name's Andy Crulley, and ladies learn to love me"
	 "Avast me, but ain't ye a beauty"
	 "They calls me Andy, but I'm really randy">>

;<ROUTINE old-CRULLEY-SAYS ("AUX" STRING)
	 <COND (<EQUAL? ,ATTACK-C 0>
		<SET STRING "sniggers">)
	       (<EQUAL? ,ATTACK-C 1>
		<SET STRING "slurs">)
	       ;(T
		<SET STRING "mumbles">)>
	 <TELL "\"" <GET ,MENACES ,CRULLEY-CTR> ",\" " .STRING " the pirate">
	           ;<PICK-ONE ,MENACES>
	 <COND (<EQUAL? ,ATTACK-C 1>
		<TELL ". His breath is heavy with rum">)
	       (<PROB 60>
		<TELL ", advancing toward you">)>
	 <TELL ,PCR>>

<ROUTINE I-OVERHEAR-CRULLEY ()
	 <COND (<EQUAL? ,HERE ,CREWS-QUARTERS>
		<SETG HEARD-CRULLEY T>
		<FSET ,ANCHOR ,MUNGBIT>
		<FSET ,LEVER ,MUNGBIT>
		<QUEUE I-SEE-CRULLEY-ESCAPE 20>
		<QUEUE I-LOOK-SEA 10>
		<TELL ,INDENT 
"\"I gotta let" T ,LAFOND " know 'e's comin'.\"" T ,CRULLEY " stands on deck
above, talking to himself, his voice floating down through" A ,GRATE " in"
T ,CEILING ". \"First, I do in the mates aboard-ship, with this and t'other
mischief,\" he grunts, and you hear a snapping noise, like a taut rope being
cut. \"Now to warn the boss and collect me pay. Off I go, har.\"
He dives into" TR ,SEA>)>>

;<ROUTINE old-I-OVERHEAR-CRULLEY ()
	 <COND (<NOT <EQUAL? ,HERE ,CREWS-QUARTERS>>
		<RFALSE>)>
	 <SETG CRULLEY-CTR <+ ,CRULLEY-CTR 1>>
	 <COND (<EQUAL? ,CRULLEY-CTR 1>
		<SETG HEARD-CRULLEY T>
		<QUEUE I-OVERHEAR-CRULLEY 1>
		<FSET ,ANCHOR ,MUNGBIT>
		<FSET ,LEVER ,MUNGBIT>
		<QUEUE I-SEE-CRULLEY-ESCAPE 20>
		<QUEUE I-LOOK-SEA 10>
		<TELL ,INDENT 
"\"So now to let" T ,LAFOND " know 'e's comin'.\"" T ,CRULLEY "'s whisper
floats down through the grate in the ceiling. \"I do in the mates
aboard-ship, and warn the boss; then we'll see who's doin' the flogging,
Falcon, on you 'n the old man down in the dungeon.\"" CR>)
	       (<AND <EQUAL? ,CRULLEY-CTR 2>
		     <EQUAL? ,HERE ,CREWS-QUARTERS>>
		<TELL ,INDENT
D ,CRULLEY " seems to be alone, muttering to himself. \"" D ,LAFOND 
" pays me more for spying than Falcon pays me to get flogged.\"
You hear a snapping noise, like a taut rope being cut. \"One last mischief
to keep 'em busy! And off I go, har.\" He splashes quietly into" TR ,SEA>)
	       (T
		<RFALSE>)>>

<ROUTINE I-SEE-CRULLEY-ESCAPE ()
	 <COND (<AND <SHIP-BOARD ,HERE>
		     <NOT <INNER-DECK ,HERE>>>
		<TELL ,INDENT
"Your eyes are drawn to a flicker of light off the sea. Squinting,
you see a man swimming to shore, moonlight flashing off his hook.">
		<COND (<EQUAL? ,HERE ,POOP ,QUARTERDECK ,MAIN-DECK ,FOCSLE>
		       <TELL
" A wisp of breeze brings an odor of onions and rum, and the occasional
gargling chuckle, \"...mischief, har...reefs.\"">)>
		<CRLF>)
	       (T
		<QUEUE I-SEE-CRULLEY-ESCAPE 3>)>>

<ROUTINE I-CDUNG ()
	 <COND (<L? ,CRULLEY-CTR 7>
		<TELL ,INDENT D ,CRULLEY>
		<COND (<EQUAL? ,CRULLEY-CTR 1>
		       <TELL " steps leering out of the shadows and">)> 
		<TELL
" cracks" T ,WHIP " near you, hopping you towards the open " D ,TRAP ". \"">
		<COND (<AND ,CRULLEY-HIT
			    <EQUAL? ,CRULLEY-CTR 1>>
		       <QUEUE I-REPLY 2>
		       <SETG AWAITING-REPLY 17>
		       <TELL "Come to hit me agin, are ye?">)
		      (T
		       <SETG AWAITING-REPLY 2>
		       <QUEUE I-REPLY 2>
		       <TELL <PICK-ONE ,ABUSES>>)>
		<TELL "\"" CR>) 
	       (T
		<TELL ,INDENT
D ,CRULLEY " snaps" T ,WHIP " around your neck,
jerking you sideways and down through" T ,TRAP "."> 
		<JIGS-UP ,FALL-TO-BOTTOM>)>
	 <SETG CRULLEY-CTR <+ ,CRULLEY-CTR 1>>>

<GLOBAL ABUSES
	<LTABLE
	 0
	 "Would yer like a taste o' water?"
	 "What, afrighted of a lick o' the whip?"
	 "Leave yer honey be, wench. He'll join ye anon."
	 "Ye're a tasty doxy to let slip, but no 'elp fer it.">>

<ROUTINE I-CCLIMBS-UP ()
	 <QUEUE I-CCLIMBS-UP -1>
	 <SETG CRULLEY-CTR <+ ,CRULLEY-CTR 1>>
	 <COND (<EQUAL? ,CRULLEY-CTR 10>
		<SETG CRULLEY-BACK T>
		<FCLEAR ,CRULLEY ,NDESCBIT>
		<DEQUEUE I-CCLIMBS-UP>
		<COND (<NOT <EQUAL? ,HERE ,DUNGEON>>
		       <FCLEAR ,CRULLEY ,MUNGBIT>
		       <MOVE ,CRULLEY ,DUNGEON>
		       <RFALSE>)
		      (<NOT <FSET? ,TRAP ,OPENBIT>>
		       <TELL ,INDENT
"Roaring with anger," T ,CRULLEY " slaps" T ,TRAP " back on its hinges and">)
		      (T
		       <TELL ,INDENT D ,CRULLEY>)>
		<TELL " leaps out of" T ,WELL ", seizing you.">
		<JIGS-UP ,FALL-TO-BOTTOM>)
	       (<AND <PROB 50>
		     <EQUAL? ,HERE ,DUNGEON>>
		<TELL ,INDENT
"Sounds of scraping hook against stone and curses echo out of" T ,WELL>
		<COND (<NOT <FSET? ,TRAP ,OPENBIT>>
		       <TELL ", muffled by" T ,TRAP>)>
		<TELL ,PCR>)>>

<OBJECT WHIP
	(DESC "whip")
	(SYNONYM WHIP)
	(FLAGS TRYTAKEBIT)
	(ACTION WHIP-F)>

<ROUTINE WHIP-F ()
	 <COND (<VERB? TAKE>
	        <TELL
D ,CRULLEY " snaps" T ,WHIP " near you. \"Get away wit' ye.\"" CR>)>>

<OBJECT DAVIS
	(IN DEUX-DECK)
	(DESC "Davis")
	(LDESC
"Out of the smoke staggers Davis, tugging a bloodied knife from
the back of a pirate. Davis's eyes gleam white from a face blackened and
bloody, his lips dark red as if he has been drinking blood. He turns to
face you.")
	(SYNONYM DAVIS)
	(FLAGS ACTORBIT NARTICLEBIT)
	(ACTION DAVIS-F)>

<ROUTINE DAVIS-F ()
	 <COND (<VERB? KILL KICK MUNG KISS>
		<TELL D ,DAVIS " dodges." CR>)
	       (<VERB? EXAMINE>
		<TELL D ,DAVIS " is ugly with fear." CR>)
	       (<EQUAL? ,DAVIS ,WINNER>
		<FAILS-TO-NOTICE>)>>

<OBJECT COOKIE                        ;"MUNGBIT has asked you about hero"
	(IN GALLEY)                   ;"DEADBIT in I-ENDGAME -- dead"
	(DESC "Cookie")               ;"EVERYBIT = Cookie searching library"
	(DESCFCN COOKIE-F)
	(SYNONYM COOKIE QUICK COOK RODNEY)
	(ADJECTIVE RODNEY)
	(SIZE 10)
	(FLAGS NARTICLEBIT ACTORBIT CONTBIT OPENBIT TRANSBIT SEARCHBIT)
	(ACTION COOKIE-F)>

<GLOBAL COOKIE-FIGHTING-CROC <>>

<ROUTINE COOKIE-F ("OPTIONAL" (OARG <>) "AUX" X) 
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-DESC?>
		       <RTRUE>)>
		<TELL ,INDENT>
		<COND (<EQUAL? ,HERE ,GALLEY>
		       <TELL 
"An entirely bald man sits here, carving into his peg leg">)
		      (,COOKIE-FIGHTING-CROC
		       <TELL
"The pool is roily with the writhing bodies of" T ,COOKIE " and" T ,CROC>)
		      (<AND <QUEUED? ,I-ENDGAME>
			    <EQUAL? ,HERE ,BEACH>>
		       <COND (<FSET? ,COOKIE ,DEADBIT>
			      <TELL
"Lucy cleans the sand from Quick's quiescent face, as Papa ">
			      <COND (<FSET? ,LAFOND ,DEADBIT>
				     <TELL "sneaks up the cliff stairs">)
				    (T
				     <TELL "stands nearby">
				     <COND (<IN? ,GARTER ,DAD>
					    <TELL ", holding" T ,GARTER>)>)>)
			     (T
			      <TELL
D, COOKIE ", Lucy and your father are moving towards" T ,SKIFF>)>)
		      (T
		       <TELL D ,COOKIE " chews anxiously at a cheroot">)>
		<TELL ".">)
	       (<EQUAL? ,COOKIE ,WINNER>
		<COND (<FSET? ,COOKIE ,DEADBIT>
		       <TELL ,DOESNT-RESPOND>)
		      (<VERB? READ>
		       <TELL
"\"I can't read! I'm a cook, not a gentleman!\"" CR>
		       <RTRUE>)
		      (<VERB? HELLO>
		       <TELL "\"Hullo -- boy!\" He winks at you" ,PCR>)
		      (<VERB? HELP SAVE-SOMETHING>
		       <COND (<EQUAL? ,HERE ,GALLEY>
			      <TELL
"\"Eh? Don't be panicking. We'll be fine.\"
He carves a smile into his leg" ,PCR>)
			     (T
			      <TELL
D ,COOKIE " grumbles, \"What d'ye think I'm trying to do!\"" CR>)>)
		      (<AND <VERB? FIX>
			    <PRSO? ,DAGGER>>
		       <TELL
"\"I never was able to sharpen that dagger.\"" CR>)
		      (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <COND (<PRSI? ,HERO>
			      <COND (<IN? ,HERO ,MANACLES>
				     <TELL "\"I'm tryin' to find him!\"" CR>)
				    (T
				     <TELL
"\"The Cap'n? I been with him since the war. Then came Lafond.\"" CR>)>)
			     (<PRSI? ,COOKIE>
			      <TELL
"\"'Rodney Quick's me name, cookin's me game.|
Lost me leg in sixty-eight, 'tis why I bake.|
Losin' me hearin' in every fight, but I've got me sight --|
And come our Good Lord's 1701, I'll lose me life to a ruffian's gun.'|
-- Old dame told me that. Leastways, I've several years left.\"" CR>)
			     (<PRSI? ,LAFOND>
			      <TELL
"\"He murdered Cap'n's brother and family these
three year'n past. Cap'n's been searching for a
time to avenge the dead ones, and now he's found it.\"" CR>)
			     (<PRSI? ,CRULLEY>
			      <TELL "\"Don't trust 'im. Never 'ave.\"" CR>)
			     (T
			      <TELL
D ,COOKIE " cocks an ear, \"Eh, what's that?\"" CR>)>
		       <STOP>)
		      (<AND <VERB? GIVE>
			    <PRSO? ME>
			    <IN? ,RAPIER ,COOKIE>>
		       <PERFORM ,V?TAKE ,RAPIER>
		       <RTRUE>)
		      (<AND <VERB? FOLLOW>
			    <PRSO? ,ME>>
		       <TELL "\"Foller you?">
		       <COND (<NOT <EQUAL? ,HERE ,GALLEY>>
			      <TELL " Anywheres">)>
		       <TELL "!\"" CR>)
		      (<AND <VERB? TAKE>
			    <PRSO? ,PAIR>
			    <EQUAL? ,HERE ,X-ROOM>>
		       <TELL
"\"No, lass. A lady don't use guns, and I've no need for one.\"" CR>) 
		      (<SET X <COM-CHECK ,COOKIE>>
		       <COND (<==? .X ,M-FATAL> <RFALSE>)
			     (T <RTRUE>)>)
		      ;(T
		       <FAILS-TO-NOTICE>
		       <STOP>)>)
	       (<VERB? EXAMINE>
		<TELL
D ,COOKIE " is a grizzled old man with a peg-leg." CR>
		;<COND (<FIRST? ,COOKIE>
		       <TELL " ">
		       <RFALSE>)
		      (T
		       <CRLF>)>)
	       ;(<AND <VERB? ASK-FOR>
		     <PRSO? ,COOKIE>>
		<COND (<HELD? ,PRSI ,COOKIE>
		       <MOVE ,PRSI ,PROTAGONIST>
		       <TELL "\"Take anything ye like.\"" CR>)
		      (T
		       <TELL "\"I hain't got none o' that!\"" CR>)>)
	       (<VERB? TELL-ABOUT>
		<COND (<NOUN-USED ,W?GUNPOW ,SUPPLIES>
		       <TELL
"\"Clam chowder? Never make it -- too fancy.\"" CR>)
		      (<PRSI? ,REEFS>
		       <TELL
"\"We dropped the sea anchor -- no need to fear.\"" CR>)
		      (<PRSI? ,SUPPLIES>
		       <TELL
"\"Aye, you must mean the supplies in the hold.
Yep, that's where we store them.\"" CR>)
		      (<PRSI? ,HOLD ,FIRE>
		       <TELL
"\"Fire for the cold? I think it be too warm...\"" CR>)
		      (<PRSI? ,FUSE>
		       <TELL 
"\"Lose sommat? I be always losing things.
Think there be thieves aboard.\"" CR>)
		      (<PRSI? ,HERO>
		       <COND (,COOKIE-FIGHTING-CROC
			      <FAILS-TO-NOTICE>)
			     (<HELD? ,HERO ,DUNGEON> ;<IN? ,HERO ,MANACLES>
			      <TELL
"\"Well, show me, lass!\" he grumbles" ,PCR>)
			     (T
			      <TELL
"\"He's a fine man, is Cap'n,\" he smiles" ,PCR>)>)
		      (T
		       <RFALSE>)>)  
	       (<VERB? KISS>
		<TELL "\"Nah, me pretty, ye belong to Cap'n.\"" CR>)
	       (<AND <VERB? GIVE>
		     <PRSO? ,BANKNOTE>>
		<TELL
"\"I hain't no need fer that kind of money,\"
he waves away your offer" ,PCR>)
	       (<VERB? KILL MUNG CUT>
		<COND (<FSET? ,COOKIE ,DEADBIT>
		       <MAN-IS-DOWN>)
		      (T
		       <TELL
"He holds you off, \"'Ere now, there's no call for that!\"" CR>)>)>>

;"Crulley-ctr serves for Cookie in this one instance."
<ROUTINE I-COOKIE ("OPTIONAL" (FIRST-MOVE <>))
	 <COND (.FIRST-MOVE
		<SETG COOKIE-LOOKING <>>
		<SETG QUESTIONER ,COOKIE>
		<SETG AWAITING-REPLY 10>
		<QUEUE I-REPLY 2>
		<QUEUE I-COOKIE <COND (,CLOCK-WAIT 1) (T 2)>>
		<MOVE ,COOKIE ,HERE>
		<FSET ,COOKIE ,MUNGBIT>
		<SETG CRULLEY-CTR 0>
		<TELL ,INDENT
D ,COOKIE " rushes up to you, looking worried.
\"Miss, we must find the Cap'n. Have ye any idea where to look?\"" CR>)
	       (<NOT <IN? ,COOKIE ,HERE>>
		<DEQUEUE I-COOKIE>)
	       (<OR <EQUAL? ,REACTION ,REACTION-POSITIVE>
		    <VERB? WALK>>
		<TELL ,INDENT D ,COOKIE
" grins broadly, \"I knew we could depend on you, lass. Lead on!\"" CR>)
	       (<EQUAL? ,CRULLEY-CTR 2>     ;"gives you a couple chances"
		<MOVE ,COOKIE ,LIBRARY>     ;" to say no."
		<COND (<EQUAL? ,REACTION ,REACTION-NEGATIVE>
		       <TELL ,INDENT
"\"Hell and damnation, I was afraid of that">)
		      (T
		       <TELL ,INDENT
"He harrumphs. \"So ye do not care fer him after all">)>
		<TELL
"!\" " D ,COOKIE " orders the men to search, moving off himself.|">)
	       (T
		<SETG QUESTIONER ,COOKIE>
		<SETG AWAITING-REPLY 10>
		<QUEUE I-REPLY 2>
		<QUEUE I-COOKIE 1>
		<TELL ,INDENT D ,COOKIE
" urges you, \"Think agin. Any idea?\"" CR>)>
	 <SETG CRULLEY-CTR <+ ,CRULLEY-CTR 1>>>

;<ROUTINE I-MOVE-GROUP ("AUX" GROUP-HERE NEW-HERE)
       <SET GROUP-HERE <LOC ,COOKIE>>
       <COND ;(<EQUAL? .GROUP-HERE ,BALLROOM>
	      <FSET ,VER-DOOR ,OPENBIT>
	      <SET NEW-HERE ,VERANDA>)
	     (<EQUAL? .GROUP-HERE ,VERANDA>
	      <SET NEW-HERE ,LAWN>)
	     (<EQUAL? .GROUP-HERE ,LAWN>
	      <SET NEW-HERE ,BEACH>
	      <DEQUEUE I-MOVE-GROUP>)
	     (T
	      <RFALSE>)>
       <TELL ,INDENT>
       <COND (<NOT <EQUAL? ,HERE .GROUP-HERE>>
	      <TELL
"Nicholas calls your name distantly and is shushed, as t">)
	     (T
	      <TELL "T">)>
       <TELL "he group straggles on towards the beach">
       <MOVE ,COOKIE .NEW-HERE>
       <MOVE ,DAD .NEW-HERE>
       <MOVE ,LUCY .NEW-HERE>
       <MOVE ,HERO .NEW-HERE>
       <TELL ,PCR>>

<OBJECT CREW
	(IN LOCAL-GLOBALS)
	(DESC "pirate")
	(SYNONYM SAILOR PIRATE SEAMAN)
	(SIZE 10)
	(FLAGS ACTORBIT PLURALBIT ;NARTICLEBIT NDESCBIT)
	(ACTION CREW-F)>

<ROUTINE CREW-F ()
	 <COND (<EQUAL? ,CREW ,WINNER>
		<COND (<VERB? HELLO>
		       <TELL "He grins at you toothlessly" ,PCR>)
		      (<AND ,ENDGAME
			    <VERB? WHERE FIND>
			    <PRSO? ,COOKIE ,HERO>>
		       <PERFORM ,V?TELL-ABOUT ,ME ,PRSO>
		       <RTRUE>)
		      (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <COND (<AND ,ENDGAME
				   <PRSI? ,COOKIE ,HERO>>
			      <COND (<PRSI? ,COOKIE>
				     <TELL "\"'E went">)
				    (T
				     <TELL "\"Cookie be">)>
			      <TELL " a-lookin' for Cap'n.\"" CR>)
			     (<PRSI? ,LAFOND>
			      <TELL "\"'E be an evil man, I do hear.\"" CR>)
			     (T
			      <FAILS-TO-NOTICE>)>)
		      (T
		       <TELL
"\"I'm busy. Do it yerself, boy.\" He cuffs you aside." CR>)>
		       <STOP>)
	       (<VERB? EXAMINE>
		<TELL D ,HERO "'s crew are a ragged, toothless bunch,
all sporting jagged scars. Despite their abhorrent appearances, they call
friendlily to each other" ,PCR>)>>

<OBJECT LUCY
	(IN KITCHEN)
	(DESC "Lucy")
	(DESCFCN LUCY-F)
	(SYNONYM WOMAN COOK LUCY)
	(ADJECTIVE BLOND)
	(SIZE 10)
	(FLAGS ACTORBIT CONTBIT OPENBIT FEMALEBIT NARTICLEBIT)
	(ACTION LUCY-F)>

<ROUTINE LUCY-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-DESC?>
		       <RTRUE>)>
		<COND (<EQUAL? ,HERE ,KITCHEN>
		       <TELL ,INDENT>
		       <COND (<FSET? ,LUCY ,TOUCHBIT>
			      <TELL D ,LUCY>)
			     (T
			      <TELL "A blond woman">)>
		       <COND (<RUNNING? ,I-LUCY>
			      <TELL " stands talking to you">)
			     (T
			      <TELL
" huddles alone by the fire, as if cold">)>
		       <TELL ".">)>)
	       (<EQUAL? ,LUCY ,WINNER>
		<COND (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <COND (<NOUN-USED ,W?LIBRARY ,HOUSE>
			      <TELL
"\"I ain't allowed in that wing of" TR ,HOUSE>)
			     (<PRSI? ,LAFOND>
			      <TELL
"\"He's a regular lout who don't like my cooking.\"" CR>)
			     (T
			      <FAILS-TO-NOTICE>)
			     ;(T
			      <TELL "\"Blusteration! I dunno!\"" CR>)>
		       <STOP>)
		      (<VERB? HELLO>
		       <TELL "She smiles" ,PCR>)
		      (<AND <VERB? KISS>
			    <PRSO? ,ME>>
		       <TELL "\"I hardly know you!\" she gasps." CR>)
		      (<SET OARG <COM-CHECK ,LUCY>>
		       <COND (<==? .OARG ,M-FATAL> <RFALSE>)
			     (T <RTRUE>)>)
		      ;(T
		       <FAILS-TO-NOTICE>
		       <STOP>)>)
	       (<AND <VERB? TELL-ABOUT>
		     <PRSI? ,DAD>>
		<COND (<FSET? ,DAD ,TOUCHBIT>
		       <TELL "\"Yes, he told me.\"" CR>)
		      (T
		       <SETG AWAITING-REPLY 2>
		       <QUEUE I-REPLY 2>
		       <TELL
"She yelps, \"Dear Dimsy, how can I save him?\"" CR>)>)
	       (<VERB? GIVE>
		<COND (<AND <PRSO? ,GARTER>
			    <NOT <FSET? ,GARTER ,INVISIBLE>>>
		       <TELL
 D ,LUCY " frowns. \"No, you silly boy! Give that to Dimsford!\"" CR>)
		      (<PRSO? ,BANKNOTE>
		       <TELL D ,LUCY
" slaps you hard across the face. \"I'm not that sort of girl!\"" CR>)>)
	       (<VERB? LISTEN>
		<COND (<RUNNING? ,I-LUCY>
		       <TELL "You are listening to her!" CR>)
		      (T
		       <TELL "She talks a lot, but doesn't say much" ,PCR>)>) 
	       (<AND <VERB? ASK-FOR>
		     <PRSI? ,GARTER>>
		<PERFORM ,V?TAKE ,GARTER>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"Lucy is a very pretty woman, a few years your senior,
her yellow hair neatly arranged. She wears a cook's apron" ,PCR>)>>

<ROUTINE I-LUCY ()
	 <FCLEAR ,GARTER ,INVISIBLE>
	 <THIS-IS-IT ,GARTER>
	 <TELL ,INDENT 
"\"I haven't found Lafond's papers, I'm watched too closely.
Tell Dimsford that I -- I'm scared, and I want him to come get me. Give this
to him -- he'll recognize it.\" Lucy slides" A ,GARTER " down her leg and
holds it out to you" ,PCR>>

<ROUTINE I-CATCH-KISS ()
	 <FCLEAR ,FOREST ,EVERYBIT>>

<OBJECT BUTLER               ;"EVERYBIT means the butler is looking for you"
	(IN FOYER)           ;"MUNGBIT -- you didn't give bribe or invite"
	(DESC "butler")      ;"DEADBIT -- need I say anything?"
	(DESCFCN BUTLER-F)   ;"INDOORSBIT -- he's been bribed/invited"
	(SYNONYM BUTLER)
	(SIZE 10)
	(FLAGS ACTORBIT OPENBIT SEARCHBIT)
	(ACTION BUTLER-F)>

<ROUTINE BUTLER-F ("OPTIONAL" (OARG <>) "AUX" (CONTENTS 0))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-DESC?>
		       <RTRUE>)>
		<TELL ,INDENT CTHE ,BUTLER>
		<COND (<NOT <FSET? ,BUTLER ,DEADBIT>>
		       <TELL " stands near the entrance to ">
		       <COND (<EQUAL? ,HERE ,FOYER>
			      <TELL "the ballroom">)
			     ;(<EQUAL? ,HERE ,UPPER-HALL-E>
			      <TELL "Lafond's bedroom">)
			     (T
			      <TELL "the hallway">)>)
		      (T
		       <TELL " lies on the floor, prone and snoring loudly">)>
		<TELL ".">) 
	       (<EQUAL? ,BUTLER ,WINNER>
		<COND (<FSET? ,BUTLER ,DEADBIT>
		       <TELL ,DOESNT-RESPOND>)
		      (<VERB? HELLO>
		       <TELL "He bows" ,PCR>)
		      (<AND <VERB? TAKE>
			    <PRSO? ,INVITE ,BANKNOTE
				   ,BLUE-GLASS ,GREEN-GLASS>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?GIVE ,PRSO ,BUTLER>
		       <SETG WINNER ,BUTLER>
		       <RTRUE>)
		      (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>
			    <PRSI? ,LAFOND>>
		       <COND (<OR <QUEUED? ,I-SUMMONS>
				  <NOT <FSET? ,LDOOR ,LOCKEDBIT>>>
			      <COND (<EQUAL? ,HERE ,LAFS-ROOM>
				   <TELL "\"He's gone for water, Miss.\"" CR>)
				    (T
				     <TELL
"\"He's awaiting you now, Miss. In his room.\"" CR>
				     <MOVE ,LAFOND ,LAFS-ROOM>)>)
			     (<EQUAL? ,DANCED-WITH ,LAFOND>
			                    ;<NOT <IN? ,DAD ,CELL-4>>
			      <TELL
"\"He has retired to his room, and requests not to be disturbed.\"" CR>)
			     (T
			      <TELL
"\"The governor is in the ballroom, Miss.\"" CR>)>)
		      ;(<IN? ,INVITE ,BUTLER>
		       <TELL CTHE ,BUTLER " affects not to hear you." CR>
		       <STOP>)
		      (<SET OARG <COM-CHECK ,BUTLER>>
		       <COND (<==? .OARG ,M-FATAL> <RFALSE>)
			     (T <RTRUE>)>)
		      ;(T
		       <I-BUTLER T>)>)
	       (<VERB? EXAMINE>
		<TELL CTHE ,BUTLER
", scarred and burly, looks uncomfortable in his formal blacks,
as if he'd prefer the rags of a pirate">
		<COND (<FSET? ,BUTLER ,DEADBIT>
		       <TELL ". He lies snoring on the floor">)>
		<TELL ,PCR>)
	       (<FSET? ,BUTLER ,DEADBIT>
		<COND (<VERB? SEARCH>
		       <TELL ,NOTHING-NEW>)
		      (<NOT <VERB? TELL ASK-ABOUT HELLO>>
		       <TELL ,DOESNT-RESPOND>
		       <RTRUE>)>)
	       (<VERB? GIVE SHOW>
		<COND (<PRSO? ,INVITE ,BANKNOTE>
		       <BRIBE-BUTLER ,PRSO>)
		      (<PRSO? ,BLUE-GLASS ,GREEN-GLASS>
		       <TELL "He looks pleased">
		       <COND (<EQUAL? <GETP ,PRSO ,P?CONTENTS> 0 ,POISONED>
			      <TELL
", then disappointed. \"There's no wine in that glass, Ma'am.\"" CR>
			      <RTRUE>)
			     (<EQUAL? <GETP ,PRSO ,P?CONTENTS> ,W-P>
			      <SETG DRUGGEE ,BUTLER>
			      <QUEUE I-WATCH-SLEEP 2>)>
		       <MOVE ,PRSO ,BUTLER>
		       <PUTP ,PRSO ,P?CONTENTS 0>
		       <TELL
". \"I am rather parched, Ma'am,\" he says, taking and emptying" TR ,PRSO>)
		      (T
		       <RFALSE>)>)
	       (<EQUAL? ,P-PRSA-WORD ,W?TIP>
		<COND (<HELD? ,BANKNOTE>
		       <BRIBE-BUTLER ,BANKNOTE>)
		      (T
		       <TELL "You have nothing to do that with." CR>)>)>>

<GLOBAL BUTLER-CTR 0>

<ROUTINE I-BUTLER ("OPTIONAL" (CALLED-BY-BUTLER-F <>))
	 <SETG BUTLER-CTR <+ ,BUTLER-CTR 1>>
	 <COND (.CALLED-BY-BUTLER-F
	 	<QUEUE I-BUTLER 2>)
	       (T
		<QUEUE I-BUTLER -1>)>
	 <COND (<NOT <EQUAL? ,HERE ,FOYER>>      ;"You can only bother him"
		<SETG AWAITING-FAKE-ORPHAN <>>   ;"X times. And if you enter,"
		<DEQUEUE I-BUTLER>             ;"then leave, dequeue, but N+1"
		<RFALSE>)
	       (<NOT <FSET? ,GOWN ,WORNBIT>>   ;"added so you won't get"
		<RFALSE>)>                  ;"Your invite? ... kicks you out"
	 <COND (<NOT .CALLED-BY-BUTLER-F>
		<TELL ,INDENT>
		<TELL "\"">)>
	 <COND ;(<FSET? ,BUTLER ,MUNGBIT>
		<TELL ,NO-LOITERING ,PUSHING-YOU-OUT CR>
		<GOTO ,MAIN-ENTRANCE>)
	       (T
		<COND (<EQUAL? ,BUTLER-CTR 3 ;5>
		       <DEQUEUE I-BUTLER>
		       <FSET ,BUTLER ,MUNGBIT>
		       <TELL ,YOULL-HAVE-TO
"hope to be invited to the next party,\" smirks"
T ,BUTLER ,PUSHING-YOU-OUT CR>
		       <GOTO ,MAIN-ENTRANCE>)
		      (T
		       <TELL
"Your invitation, Miss?\" says" T ,BUTLER>
		       <COND (<EQUAL? ,BUTLER-CTR 4>
			      <TELL " snapping his fingers">)
			     (T
			      <TELL " bowing">)>
		       <TELL ,PCR>)>)>>

<ROUTINE BRIBE-BUTLER (GRAFT)
	 <MOVE .GRAFT ,BUTLER>
	 <COND (<FSET? ,BUTLER ,INDOORSBIT> ;"he's been bribed/invite already"
		<TELL
"He takes" T .GRAFT " and bows. \"Thank you, Miss">
		<COND (<EQUAL? .GRAFT ,INVITE>
		       <TELL " Davis">)>
		<TELL ".\"" CR>)
	       (T
		<FSET ,BUTLER ,INDOORSBIT>
		<FCLEAR ,BUTLER ,MUNGBIT>     ;"Stop 'No Loitering' interrupt"
		<DEQUEUE I-BUTLER>
		<SETG SCORE <+ ,SCORE 1>>
		<TELL CTHE ,BUTLER " takes" T .GRAFT>
		<COND (<EQUAL? .GRAFT ,BANKNOTE>
		       <TELL " and secrets it away">)>
		<TELL ". \"Enjoy the dance, Miss">
		<COND (<EQUAL? .GRAFT ,INVITE>
		       <TELL " Davis">)>
		<TELL ".\"" CR>)>>
		      
		       

<OBJECT DANCERS
	(IN LOCAL-GLOBALS)
	(DESC "dancer")
	;(DESCFCN DANCERS-F)
	(SYNONYM WOMAN MEN LADY LADIES)
	(ADJECTIVE DANCER)
	(SIZE 10)
	(FLAGS ACTORBIT)
	(ACTION DANCERS-F)>

<ROUTINE DANCERS-F ()
	 <COND (<EQUAL? ,DANCERS ,WINNER>
		<COND (,ENDGAME
		       <TELL CTHE ,DANCERS " looks away, terrified." CR>)
		      (<VERB? HELLO>
		       <TELL
"A dancer smiles nervously and looks away" ,PCR>)
		      (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <COND (<PRSI? ,LAFOND>
			      <TELL
"\"He's such a good host! I've never been to such a fine party! I'm so glad
he is our governor.\" You have never seen anyone so nervous before" ,PCR>)
			     (T
			      <TELL
"Nobody seems inclined to chat with you" ,PCR>)>
		       <STOP>)>)
	       (<OR <VERB? DANCE>
		    <AND <VERB? ASK-FOR>
			 <PRSI? ,BALLROOM>>>
		<TELL
"A man regretfully shakes his head.
\"We haven't been introduced by the governor.\"" CR>)
	       (<AND <VERB? ASK-FOR>
		     <PRSI? ,BALLROOM>>
		<PERFORM ,V?DANCE ,DANCERS>
		<RTRUE>)
		(<VERB? EXAMINE>
		 <TELL
CTHE ,DANCERS "s are dressed in powdered wigs and heavy jewels.
All seem paler than fashion and the tropics would decree,
and rather nervous" ,PCR>)>>

<GLOBAL DAD-KISS "He kisses your forehead.|">

<OBJECT DAD
	(IN CELL-4)
	(DESC "your father")
	(DESCFCN DAD-F)
	(SYNONYM DAD PAPA FATHER DIMSFORD)
	(ADJECTIVE ERNEST RYALL MY)
	(SIZE 10)
	(FLAGS ACTORBIT NARTICLEBIT CONTBIT OPENBIT NDESCBIT)
	(ACTION DAD-F)>

<ROUTINE DAD-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-DESC?>
		       <RTRUE>)>
		<TELL ,INDENT "Your father calmly stands nearby.">)
	       (<EQUAL? ,DAD ,WINNER>
		<COND ;(<AND <VERB? READ>
			     <PRSO? ,SCRAP-OF-PAPER>>
			<PERFORM ,V?TELL-ABOUT ,ME ,SCRAP-OF-PAPER>
			<RTRUE>)
		      (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <COND (<PRSI? ,GARTER>
			      <TELL "\"That belongs to -- a friend.\"" CR>)
			     (T
			      <TELL
"\"My dear,\" he says rather impatiently, \"There are people waiting for our
help -- I haven't time to answer your questions just now.\"" CR>)>
		       <STOP>)
		      (<VERB? I-LOVE-YOU>
		       <COND (<PRSI? ,EYES>
			      <TELL ,DAD-KISS>)
			     (<PRSI? ,HERO>
			      <TELL "\"I hoped you would,\" he smiles." CR>)
			     (<PRSI? ,LAFOND>
			      <TELL "\"My poor doomed daughter!\"" CR>)
			     (T
			      <FAILS-TO-NOTICE>)>)
		      (<AND <VERB? FOLLOW>
			    <PRSO? ,ME>>
		       <TELL "\"Lead on, daughter!\"" CR>)
		      (<VERB? HELLO>
		       <TELL ,DAD-KISS>)
		      (<SET OARG <COM-CHECK ,DAD>>
		       <COND (<==? .OARG ,M-FATAL> <RFALSE>)
			     (T <RTRUE>)>)
		      ;(T
		       <FAILS-TO-NOTICE>
		       <STOP>)>)
	       (<AND <VERB? ASK-FOR>
		     <PRSI? ,GARTER>>
		<PERFORM ,V?TAKE ,GARTER>
		<RTRUE>)
	       (<VERB? TELL-ABOUT>
		<COND (<PRSI? ,LUCY>
		       <TELL
"He listens intently, and laughs,
\"What a delightful girl she is, to be sure!\"" CR>)
		      (<PRSI? ,HERO>
		       <COND (<RUNNING? ,I-DAD>
			      <DEQUEUE I-DAD>
			      <I-DAD T>)
			     (T
			      <SETG AWAITING-REPLY 16>
			      <QUEUE I-REPLY 2>
			      <TELL 
"\"So you like him?\" he asks, smiling" ,PCR>)>)
		      (T
		       <RFALSE>)>)
	       (<VERB? GIVE SHOW>
		<COND (<PRSO? ,BANKNOTE>
		       <REMOVE ,BANKNOTE>
		       <TELL
"\"Do not stain yourself with that dirty money,\" he takes"
T ,BANKNOTE " and rips it up" ,PCR>)
		      (<PRSO? ,GARTER>
		       <TELL "He smiles dreamily at a memory." CR>)
		      (T
		       <RFALSE>)>)
	       (<VERB? EXAMINE>
		<TELL
"Prison has only added a peppery beard to your father's handsome features.
His green eyes still twinkle, his wrists still poke bonily out of his shirt
cuffs" ,PCR>)>>

<ROUTINE I-DAD ("OPTIONAL" (CALLED-BY-DAD-F <>))
	 <COND (<NOT .CALLED-BY-DAD-F>
		<TELL ,INDENT>)>
	 <TELL "You briefly explain the current situation to your father.|
   \"I knew Falcon would do his best to rescue me, once you were safe,\" he
responds. \"Now to rescue Lucy -- Nicholas will have told you about her.
You get him while I get Lucy, and the four of us will meet down at the beach.
Just show me the way out of this maze, and we'll get started.\"" CR>>

<OBJECT LAFOND
	(IN LAFS-ROOM)
	(DESC "Lafond")
	(DESCFCN LAFOND-F)
	(SYNONYM LAFOND VILLAIN GOVERNOR)
	(ADJECTIVE JEAN)
	(SIZE 10)
	(FLAGS ACTORBIT NARTICLEBIT CONTBIT OPENBIT)
	(ACTION LAFOND-F)>

<GLOBAL LAF-GRABS "Lafond grabs your hair and pulls your head
sharply back, clinching your arms to your sides. ">

<GLOBAL KILL-L <>>

<CONSTANT LAF-MUNGED ", his wig awry, sprawls across the parquet floor.">

<ROUTINE LAFOND-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-DESC?>
		       <RTRUE>)>
		<TELL ,INDENT D ,LAFOND>
		<COND (<FSET? ,LAFOND ,MUNGBIT>
		       <TELL ,LAF-MUNGED>)
		      (<FSET? ,LAFOND ,DEADBIT>
		       <TELL " is slumped in the sand, dead.">)
		      (<EQUAL? ,HERE ,BEACH>
		       <TELL " stands" ,HALFWAY>)

           ;"Lafond is described in HERO-F during fighting on beach."

		      (T
		       <TELL " is leering, lip curled.">)>)
	       (<EQUAL? ,LAFOND ,WINNER>
		<COND (<AND <OR <RUNNING? ,I-DUEL>
				<RUNNING? ,I-ENDGAME>>
			    <NOT <FSET? ,LAFOND ,DEADBIT>>>
		       <TELL "He ignores you." CR>)
		      (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>
			    <PRSI? ,LRING>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?TAKE ,LRING>
		       <SETG WINNER ,LAFOND>
		       <RTRUE>)
		      (<SET OARG <COM-CHECK ,LAFOND>>
		       <COND (<==? .OARG ,M-FATAL> <RFALSE>)
			     (T <RTRUE>)>)
		      ;(T
		       <FAILS-TO-NOTICE>
		       <COND (<VERB? DRINK>
			      <SETG REACTION ,REACTION-NEGATIVE>)>
		       <STOP>)>)
	       (<AND <VERB? POUR>
		     <PRSO? ,WINE>
		     <NOT <FSET? ,LAFOND ,DEADBIT>>>
		<FWTD ,SMACK-YOUR-FACE>)
	       (<AND <VERB? DANCE>
		     <EQUAL? ,HERE ,BALLROOM>>
		<COND (<EQUAL? ,PARTNER ,LAFOND>
		       <TELL ,PACE>)
		      (<RUNNING? ,I-LDANCE>
		       <TELL "You curtsey and walk to" ,DANCE-FLOOR ,PCR>
		       <SETG REACTION ,REACTION-POSITIVE>)>)
	       (<VERB? KILL BITE KICK>
		<COND (<FSET? ,LAFOND ,MUNGBIT>
		       <MAN-IS-DOWN>)
		      (<EQUAL? ,HERE ,BALLROOM>
		       <SETG AWAITING-REPLY 2>
		       <QUEUE I-REPLY 2>
		       <TELL
,LAF-GRABS ,THE-BALLROOM "whirling blur through your tears as he
leads you around the floor.  \"Ma petite, a ball is not the right
place to kill me. What would my guests think?!\"" CR>)
		      (<NOT ,KILL-L>
		       <SETG KILL-L T>
		       <TELL ,LAF-GRABS
"Twisting your wrist, pain stabbing down your arm, he forces his mouth on
yours, hard, thrusting, cutting your lips. He releases you">
		       <COND (<AND ,PRSI
				   <NOT <PRSI? ,RETICULE>>
				   <NOT <FSET? ,PRSI ,WORNBIT>>>
			      <MOVE ,PRSI ,LAFOND>
			      <TELL ", taking" T ,PRSI>)>
		       <TELL
". \"Let that be a warning to you, my love.\"" CR>)
		      (T
		       <JIGS-UP
"Lafond hits you back. The end is not sweet and not fast.">)>)
	       (<AND <VERB? TOUCH>
		     <NOT <FSET? ,LAFOND ,DEADBIT>>>
		<TELL "He smiles." CR>)
	       (<AND <VERB? GIVE>
		     <PRSO? ,BLUE-GLASS ,GREEN-GLASS>>
		<COND (<OR <IN? ,BLUE-GLASS ,LAFOND>
			   <IN? ,GREEN-GLASS ,LAFOND>>
		       <TELL "\"I already have a glass, thank you.\"" CR>)
		      (T
		       <MOVE ,PRSO ,LAFOND>
		       <TELL "He takes" TR ,PRSO>)>)
	       (<VERB? KISS>
		<COND (<EQUAL? ,HERE ,LAFS-ROOM>
		       <COND (<G? ,LAFOND-CTR ,HORNY>
			      <TELL
"Queasy, you turn up your face to be kissed. His lips are cold, dry." CR>)
			     (T 
			      <TELL "He laughs. \"Not yet, petite.\"" CR>)>)
		      (T
		       <TELL "You shudder at the thought" ,PCR>)>)
	       (<VERB? EXAMINE>
		<COND (<AND <RUNNING? ,I-LSED>
			    <G? ,LAFOND-CTR 11>>
		       <TELL
"You turn away in modesty after a
brief glimpse of pasty pink flesh" ,PCR>)
		      (<FSET? ,LAFOND ,MUNGBIT>
		       <TELL D ,LAFOND ,LAF-MUNGED CR>)
		      (<OR ,ENDGAME
			   <AND <RUNNING? ,I-LSED>
				<G? ,LAFOND-CTR 4>>>
		       <TELL
"Lafond is dressed in a rich brocade robe" ,PCR>)
		      
		      (T
		       <TELL
"Wigged in dark brown curls, dressed in velvets and brocade,
he is warmly attractive. Until you meet his eyes,
stone gray and cold" ,PCR>)>)>>

<OBJECT LRING
	(IN LAFOND)
	(DESC "gold ring")
	(SYNONYM RING LATIN)
	(ADJECTIVE GOLD)
	(FLAGS NDESCBIT ;TRYTAKEBIT)
	(GENERIC GEN-RING)
	(ACTION RING-F)>

<OBJECT HRING
	(IN HERO)
	(DESC "new ring")
	(SYNONYM RING LATIN)
	(ADJECTIVE NEW)
	(FLAGS ;TRYTAKEBIT NDESCBIT)
	(GENERIC GEN-RING)
	(ACTION RING-F)>

<ROUTINE RING-F ()
	 <COND (<OR <NOUN-USED ,W?LATIN ,LRING>
		    <NOUN-USED ,W?LATIN ,HRING>
		    <VERB? READ>>
		<REPERTOIRE "The study of Latin">)
	       (<VERB? EXAMINE>
		<COND (<PRSO? ,LRING>
		       <TELL "It's an ancient gold band, with">)
		      (T
		       <TELL "Made of copper," T ,HRING " has">)>
		<TELL
" a curious design of gargoyles, curled tongues extended, on its flat face,
with \"Sal Sapit Omnia\" engraved at the bottom" ,PCR>)
	       (<VERB? TAKE>
		<COND (<AND <PRSO? ,LRING>
			    <IN? ,LRING ,LAFOND>>
		       <COND (<FSET? ,LAFOND ,MUNGBIT>
			      <TELL
D ,LAFOND "'s fingers are curled tight in a fist. You cannot get it" ,PCR>)
			     (T
			      <TELL
"\"It is an impressive crest, no? I've
thought of making it my own.\"" CR>)>)
		      (T
		       <COND (<FSET? ,HERO ,DEADBIT>
			      <NO-TIME-FOR "steal jewelry">
		       ;<TELL "This is no time to be stealing jewelry!" CR>)
			     (T 
			      <TELL
D ,HERO " curls his fist around it. \"This is ">
			      <COND (<IN? ,HRING ,HERO>
				     <TELL "a copy of ">)>
			      <TELL
"the family ring lost with my brother.\"" CR>)>)>)>>

<ROUTINE GEN-RING ()
	 <RETURN ,HRING>>

<ROUTINE COM-CHECK (PER)
	 <COND (<VERB? HELP>
	        <COND (<EQUAL? .PER ,LAFOND>
		       <TELL
"He snickers, \"So I shall, petite.\"" CR>)
		      (<EQUAL? .PER ,CRULLEY>
		       <TELL
"\"An' what'll I get fer it?\" he says, eying your body." CR>)
		      (T  
		       <TELL "\"I'm doing all I can.\"" CR>)
		      ;(<EQUAL? ,WINNER ,PROTAGONIST>
		       <PROPOSE>)
		      ;(<OR <FSET? .PER ,MUNGBIT>
			   <FSET? .PER ,DEADBIT>>
		       <TELL
"This isn't a good time to ask him for help." CR>)>)
	       (<AND <VERB? KISS>
		     <PRSO? ,ME>>
		<SETG WINNER ,PROTAGONIST>
		<PERFORM ,V?KISS .PER>
		<SETG WINNER .PER>
		<RTRUE>)
	       (<VERB? WALK>
		<TELL "\"After you!\"" CR>)
	       (<AND <VERB? FOLLOW>
		     <PRSO? ,ME>>
		<TELL "\"Anywhere!\"" CR>)
	       (<VERB? HELLO>
		<TELL "\"Hello!\"" CR>)
	       (<VERB? WHAT>
		<PERFORM ,V?TELL-ABOUT ,ME ,PRSO>
		<RTRUE>)
	       (<AND <VERB? GIVE>
		     <PRSI? ,ME>>
		<SETG WINNER ,PROTAGONIST>
		<PERFORM ,V?ASK-FOR .PER ,PRSO>
		<SETG WINNER .PER>
		<RTRUE>)
	       (<VERB? SGIVE>
		<RFATAL>)
	       (<VERB? YES NO>
		<SETG WINNER ,PROTAGONIST>
		<PERFORM-PRSA>
		<SETG WINNER .PER>
		<RTRUE>)
	       (T
		<FAILS-TO-NOTICE>
		<COND (<VERB? DRINK>
		       <SETG REACTION ,REACTION-NEGATIVE>)>
		;<COND (<EQUAL? .PER ,BUTLER>
		       <I-BUTLER T>)
		      (T
		       <FAILS-TO-NOTICE>
		       <COND (<VERB? DRINK>
			      <SETG REACTION ,REACTION-NEGATIVE>)>)>
		<STOP>
		<RTRUE>)>>

<GLOBAL LAFOND-CTR 0>
<GLOBAL HERO-ARRESTED <>>    ;"Hero arrested: NO to Lafond, Dad free already"

<ROUTINE I-LDANCE ()
	 <COND (<NOT <EQUAL? ,HERE ,BALLROOM>>
		<DEQUEUE I-LDANCE>)
	       (T
		<COND (<EQUAL? ,LAFOND-CTR 1>
		       <MOVE ,LAFOND ,HERE>
		       <QUEUE I-LDANCE -1>
		       <SETG AWAITING-REPLY 11>
		       <QUEUE I-REPLY 2>
		       <SETG QUESTIONER ,LAFOND>
		       <SETG DANCED-WITH ,LAFOND>
		       <TELL ,INDENT
"A fashionably bewigged man stalks up to you and bows deeply. \"Will you
dance?\" he asks, with a light French accent. \"Not that you have much
choice. If you turn me down," T ,DAD " dies.\"" CR>)
		      (<EQUAL? ,LAFOND-CTR 2>
		       <COND (<EQUAL? ,REACTION ,REACTION-POSITIVE>
			      <SETG PARTNER ,LAFOND>
;"So to skip the next turn"   <SETG LAFOND-CTR <+ ,LAFOND-CTR 1>>  
			      <TELL
,INDENT "\"I am, of course, Lafond.\" " ,LAUGHS>)
			     (T
			      <SETG QUESTIONER ,LAFOND>
			      <SETG AWAITING-REPLY 11>
			      <QUEUE I-REPLY 2>
			      <TELL ,INDENT
"The man's smile hardens. \"You have" T ,DAD "'s eyes. I am Lafond -- 
I have recently become intimate with that gentleman.\" He slightly
stresses the word \"intimate.\"|
   \"Now, tell me 'yes.' And remember, I am a man of my word.\"" CR>)>)
		      (<EQUAL? ,LAFOND-CTR 3>
		       <COND (<EQUAL? ,REACTION ,REACTION-NEGATIVE
				                ,REACTION-NEUTRAL>
			      <DEQUEUE I-LDANCE>
			      <QUEUE I-CKILLS-DAD 2>
			      <TELL ,INDENT
"\"A mistake, ma petite.\" Lafond gestures to a
shadowy figure, who disappears into the east wing.
\"Say adieu to your dear Papa.\"" CR>)
			     (T
			      <SETG PARTNER ,LAFOND>
			      <TELL ,LAUGHS>)>)
		      (<EQUAL? ,LAFOND-CTR 4>
		       <QUEUE I-LDANCE -1>
		       <TELL ,INDENT
"\"So you know I am not your father's friend,\" Lafond says, offering a
hand for the promenade. \"Unfortunately, you are in my power, ">
		       <COND (,HERO-ARRESTED
			      <TELL "the Falcon is with my dragoons">)
			     (T
			      <TELL "he is in my dungeon">)>
		       <TELL 
" and I am still King of these waters.\" A gold ring flashes
on his hand. It seems vaguely familiar" ,PCR>)
		      (<EQUAL? ,LAFOND-CTR 5>
		       <COND (<FSET? ,DAD ,TOUCHBIT>
			      <COND (<NOT ,HERO-ARRESTED>
				     <QUEUE I-HARRESTED 3>)>
			      <QUEUE I-SUMMONS 5>)>
		       <SETG SCORE <+ ,SCORE 1>>
		       <DEQUEUE I-LDANCE>
		       <REMOVE ,LAFOND>
		       <SETG PARTNER <>>
		       <TELL ,INDENT D ,LAFOND
"'s eyes rake your body. \"When I am ready," T ,BUTLER " will
summon you to sup with me in my room">
		       <COND (<NOT <FSET? ,DAD ,TOUCHBIT>>
			      <TELL "; it may be some time">)>
		       <TELL
". We will find much in common before dawn, I am sure. Then I may free your ">
		       <COND (,HERO-ARRESTED
			      <TELL "lover">)
			     (T
			      <TELL "father">)>
		       <TELL
".\"" T ,LAFOND " bows as the dance ends, and kisses " D ,HANDS ". ">
		       <COND (<NOT <FSET? ,DAD ,TOUCHBIT>>
			      <TELL
"He cocks his head, curious, \"You have far less spirit than" T ,DAD
" credited you. He swore you would have him freed in no time at all.
A pity, I prefer doyennes with mettle.\" ">)>
		       <TELL "He moves to speak with" T ,BUTLER ", then ">
		       <COND (<QUEUED? ,I-SUMMONS>
			      <TELL "heads upstairs.">)
			     (T
			      <TELL "drifts into the crowd.">)>
		       <CRLF>)
		      (T
		       <RFALSE>)>
		<SETG LAFOND-CTR <+ ,LAFOND-CTR 1>>)>>

<GLOBAL LAFOND-LOOKING T>

<GLOBAL AFTER-HESITATING ", shrugging off your lack of cooperation">

<CONSTANT HORNY 10>   ;"Lafond at 11, no, 10 -- he removes your clothes"

;"LSED = Lafond's Seduction"
<ROUTINE I-LSED () 
	 <SETG AWAITING-REPLY 12>
	 <QUEUE I-REPLY 1>
	 <TELL ,INDENT>
	 <COND (<EQUAL? ,LAFOND-CTR 1>
		<MOVE ,LAFOND ,HERE>
		<MOVE ,BLUE-GLASS ,PROTAGONIST>
		<PUTP ,BLUE-GLASS ,P?CONTENTS ,WINED>
		<MOVE ,GREEN-GLASS ,LAFOND>
		<MOVE ,FLAGON ,TABLE>
		<FCLEAR ,LDOOR ,OPENBIT>
		<QUEUE I-WONT-DRINK 1>
		<TELL "\"Have some wine.\" Lafond pours wine into two
glasses, giving a blue one to you. \"Drink this down. We have a long
night ahead of us.\" He drains his own" ,PCR>)
	       (<EQUAL? ,LAFOND-CTR 2>
		<MOVE ,GREEN-GLASS ,TABLE>
		<MOVE ,BUTLER ,UPPER-HALL-E>
		<MOVE ,HERO ,MANACLES>
		<FSET ,HERO ,DEADBIT>
		<FSET ,HERO ,NDESCBIT>
		<FSET ,TRAP ,OPENBIT>
		<FCLEAR ,PORTRAIT ,OPENBIT>
		<FCLEAR ,KNOB ,EVERYBIT>
		<FCLEAR ,POWER ,EVERYBIT>
		<MOVE ,RAPIER ,DUNGEON>
		<FCLEAR ,RAPIER ,NDESCBIT>
		<FCLEAR ,MANACLES ,OPENBIT>
		<FSET ,MANACLES ,LOCKEDBIT>
		<FSET ,CRULLEY ,NDESCBIT>
		<MOVE ,CRULLEY ,DUNGEON>
		<MOVE ,WHIP ,CRULLEY>
		<QUEUE I-LSED -1>
		<FCLEAR ,FLAGON ,TRYTAKEBIT>  ;"so you can take it"
		<SETG LAFOND-LOOKING <>>
		<TELL
"Suddenly, the door slams open. It is Jamison, coatless, sword bared,
his shirt ripped. \"Thank God I am not too late. Leave, darling,
before I skewer this dog to his bedposts,\" he cries. The scar on his cheek
gleams coldly.|
   With a yell," T ,CRULLEY " and" T ,BUTLER " jump out of the darkness
behind him. Nicholas struggles, but soon lies unconscious on the floor.|
   \"Take him to the dungeon,\" Lafond says, setting down his glass. \"You,
butler, stay nearby. I do not wish to be disturbed again.|
   \"Now that we are rid of that intrusion, cherie, I will change into
something more comfortable. Pour me more wine.\" He crosses to the wardrobe
removing his coat and vest, turned slightly away from you" ,PCR>)
	       (<EQUAL? ,LAFOND-CTR 3>
		<TELL
"\"In private, call me Jean, or whatever endearment you choose, once
I have approved it.\" Lafond is looking into the wardrobe" ,PCR>)
	       (<EQUAL? ,LAFOND-CTR 4>
		<MOVE ,TRAY ,TABLE>
		<TELL CTHE ,BUTLER
" enters, laying" A ,TRAY " of " D ,CHICKEN " on" T ,TABLE ". \"The kitchen
wench has gone, your grace. I took the liberty of fetching these myself.\"
He bows and leaves the room.|
   \"Sprinkle some spices on the fowl, ma petite,\" Lafond says, donning a
long brocade robe, his back to you. \"They are hot, but delicious.\"" CR>)
	       (<EQUAL? ,LAFOND-CTR 5>
		<TELL
"\"Tsk. The cook has gone too far. She shall be 'leaving us'
tomorrow.\" Lafond adjusts the lace at his neck" ,PCR>)
	       ;(<EQUAL? ,LAFOND-CTR 6>
		<TELL D ,LAFOND
" has stopped talking momentarily.
His attention seems devoted entirely to preening himself" ,PCR>)
	       (<EQUAL? ,LAFOND-CTR 6>
		<SETG QUESTIONER ,LAFOND>
		<SETG LAFOND-LOOKING T>
		<TELL D ,LAFOND " strolls to">
		<COND (<EQUAL? <LOC ,GREEN-GLASS> ,TABLE>
		       <TELL T ,TABLE>)
		      (T
		       <TELL " you,">)>
		<TELL " smiling slyly">
		<COND (<OR <EQUAL? <GETP ,BLUE-GLASS ,P?CONTENTS> 2 0>
			   <EQUAL? <GETP ,GREEN-GLASS ,P?CONTENTS> 2 0>>
		       <TELL
". \"But you haven't finished pouring the wine.\" He tops off both glasses">
		       <COND (<EQUAL? <GETP ,BLUE-GLASS ,P?CONTENTS> 2 0>
			      <POUR-WINE ,BLUE-GLASS T>
			      ;<PUTP ,BLUE-GLASS ,P?CONTENTS
				    <+ <GETP ,BLUE-GLASS ,P?CONTENTS> 1>>)>
		       <COND (<EQUAL? <GETP ,GREEN-GLASS ,P?CONTENTS> 2 0>
			      <POUR-WINE ,GREEN-GLASS T>
			      ;<PUTP ,GREEN-GLASS ,P?CONTENTS
				    <+ <GETP ,GREEN-GLASS ,P?CONTENTS> 1>>)>)>
		<COND (,USED-LAUD
		       <TELL
". \"Which glass was mine? I seem to have forgotten.\" He points at"
T ,GREEN-GLASS " and smiles in a way that does not grant you confidence.
\"Is this it?\"" CR>)
		      (T
		       <SETG LAFOND-CTR <+ ,LAFOND-CTR 1>> ;"skip next turn"
		       <TELL ".|
   Lafond takes" T ,GREEN-GLASS " and salutes you,
gulping down the contents" ,PCR>)>) 	
	       (<EQUAL? ,LAFOND-CTR 7>
		<SETG QUESTIONER ,LAFOND>
	        <TELL "\"Ah yes, of course.\" Lafond obligingly takes">
		<COND (,USED-LAUD
		       <COND (<EQUAL? ,REACTION ,REACTION-POSITIVE>
			      <SWITCH-GLASSES ,GREEN-GLASS>)
			     (<EQUAL? ,REACTION ,REACTION-NEGATIVE>
			      <SWITCH-GLASSES ,BLUE-GLASS>)
			     (T
			      <COND (<AND <G? <GETP ,BLUE-GLASS ,P?CONTENTS>
					       ,WINED>
				       <EQUAL? <GETP ,GREEN-GLASS ,P?CONTENTS>
					      ,WINED>>
				     <SWITCH-GLASSES ,BLUE-GLASS>)
				    (T
				     <SWITCH-GLASSES ,GREEN-GLASS>)>
			      <TELL ,AFTER-HESITATING>)>)
		      ;(T
		       <COND (<EQUAL? ,REACTION ,REACTION-NEGATIVE>
			      <MOVE ,BLUE-GLASS ,LAFOND>
			      <TELL T ,GREEN-GLASS>)
			     (T
			      <MOVE ,GREEN-GLASS ,LAFOND>
			      <TELL T ,GREEN-GLASS>
			      <COND (<EQUAL? ,REACTION ,REACTION-NEUTRAL>
				     <TELL ,AFTER-HESITATING>)>)>)>
		<TELL ,PCR ,INDENT>
		<DEQUEUE I-LSED>
		<QUEUE I-WONT-DRINK 1>
		<TELL
"He inhales deeply of the bouquet of his wine, then turns to you.
\"You must think me very naive to fall for such a trick. I saw you
pour something into one of these glasses -- although ">
		<COND (,SPICED-WINE
		       <TELL 
"you have tried to cover the scent with" T ,SPICES>)
		      (T
		       <TELL "I cannot smell it">)>
		<TELL ".\" He switches goblets, setting" T ,YOUR-GLASS>
		<TELL
" into your nerveless grasp and taking up the other, smiling evilly.
\"Now you will drink from the cup intended for me.\"" CR> 
		;<COND (<NOT ,USED-LAUD>
		       <SET-CONTENTS ,LAFOND 0>
		       <TELL "He gulps down" TR ,WINE>)
		      (T
		       <DEQUEUE I-LSED>
		       <QUEUE I-WONT-DRINK 1>
		       <TELL
"He inhales deeply of the bouquet of his wine, then turns to you.
\"You must think me very naive to fall for such a trick. I saw you
pour something -- although I cannot smell it -- into
one of these glasses.\" He switches goblets, setting">
		       <COND (<HELD? ,BLUE-GLASS>
			      <TELL T ,BLUE-GLASS>)
			     (T
			      <TELL T ,GREEN-GLASS>)>
		       <TELL
" into your nerveless grasp and taking up the other, smiling evilly.
\"Now you will drink from the cup intended for me.\"" CR>)>)
	       (<EQUAL? ,LAFOND-CTR 8>
		<QUEUE I-LSED -1>
		<TELL D ,LAFOND
" draws near, whispering indecencies. He caresses your lily white
neck, his fingers ice-cold despite the tropic heat" ,PCR>)
	       (<EQUAL? ,LAFOND-CTR 9>
		<ROB ,PROTAGONIST ,LAFS-ROOM>
		;<COND (<IN? ,HAT ,PROTAGONIST>
		       <MOVE ,HAT ,HERE>
		       <FCLEAR ,HAT ,WORNBIT>)> 
		<TELL D ,LAFOND
" slides his hand up your neck and into your hair, letting it fall down
your back in thick waves and tresses. He lays everything you carry on the
floor" ,PCR>)
	       (<EQUAL? ,LAFOND-CTR ,HORNY>
		<TELL
"One by one Lafond undoes your buttons. He pulls open your ">
		<COND (<FSET? ,SHIRT ,WORNBIT>
		       <TELL "shirt">)
		      (<OR <FSET? ,GOWN ,WORNBIT>
			   <FSET? ,DRESS ,WORNBIT>>
		       <TELL "bodice">)
		      (T
		       <TELL "chemise">)>
		<REMOVE-CLOTHES>
		<FCLEAR ,CHEMISE ,WORNBIT>
		<FSET ,CHEMISE ,EVERYBIT>  ;"desc: covered by other clothes"
		<FCLEAR ,SHOES ,WORNBIT>
		<ROB ,PROTAGONIST ,LAFS-ROOM>  ;"get rid of clothes, shoes"
		;<FCLEAR ,RETICULE ,WORNBIT>  ;"not needed. no wornbit"
		<MOVE ,RETICULE ,LAFS-ROOM>
		<ROB ,LAFOND ,LAFS-ROOM>
		<TELL ". Your clothes float to the floor" ,PCR>)
	       (<EQUAL? ,LAFOND-CTR 11>
		<TELL D ,LAFOND
" runs his fingers down your naked spine, and
compliments your body. He removes his dressing gown" ,PCR>)
	       (<EQUAL? ,LAFOND-CTR 12>
		<TELL D ,LAFOND
" kisses your shoulder, your neck, your ear. \"Close your eyes, if you
will,\" he taunts, \"and pretend I am your dearest" T ,HERO ". But I am
greater than he will ever be.\" He kisses you, his lips thin and cold" ,PCR>)
	       (<EQUAL? ,LAFOND-CTR 13>
		<COND (<IN? ,PROTAGONIST ,LAFS-BED>
		       <SETG LAFOND-CTR 14>
		       <I-LSED>)
		      (T
		       <MOVE ,LAFOND ,LAFS-BED>
		       <MOVE ,PROTAGONIST ,LAFS-BED>
		       <TELL D ,LAFOND " leads you over to the bed" ,PCR>)>)
	       (<EQUAL? ,LAFOND-CTR 14>
		<FWTD
"Lafond pulls the sheets up to cover you both, pressing his long flaccid body
against yours. Waves crash against the base of the cliff.">)>
	 <SETG LAFOND-CTR <+ ,LAFOND-CTR 1>>>


;"moves appropriate glass to appropriate character,
  then TELLS the other one (lies)."

<ROUTINE SWITCH-GLASSES (GLASS)
	 <COND (<EQUAL? .GLASS ,GREEN-GLASS>
		<SETG LAF-GLASS ,BLUE-GLASS>
		<SETG YOUR-GLASS ,GREEN-GLASS>)
	       (T
		<SETG LAF-GLASS ,GREEN-GLASS>
		<SETG YOUR-GLASS ,BLUE-GLASS>)>
	 <MOVE ,YOUR-GLASS ,PROTAGONIST>
	 <MOVE ,LAF-GLASS ,LAFOND>
	 <TELL T .GLASS>>

;<ROUTINE ;I-WONT-DRINK ("AUX" (POISON-SCENE <>) OTHER-WINE YOUR-WINE)
	 <COND (<G? ,LAFOND-CTR 7>
		<SET POISON-SCENE T>)>
	 <COND (<HELD? ,BLUE-GLASS>
		<SET OTHER-WINE ,CONTENTS-GREEN>
		<SET YOUR-WINE ,CONTENTS-BLUE>)
	       (<HELD? ,GREEN-GLASS>
		<SET OTHER-WINE ,CONTENTS-BLUE>
		<SET YOUR-WINE ,CONTENTS-GREEN>)>
	 <SETG ANGER-CTR <+ ,ANGER-CTR 1>>
	 ;<QUEUE I-LSED 1>
	 <TELL ,INDENT>
	 <SETG QUESTIONER ,LAFOND>
	 <SETG AWAITING-REPLY 12>
	 <QUEUE I-REPLY 2>  
	 <COND (<EQUAL? ,REACTION ,REACTION-POSITIVE>
		<SET-CONTENTS ,PROTAGONIST 0>
		<TELL "\"Good girl,\" he says. ">
		<COND (.POISON-SCENE
		       <COND (<G? .OTHER-WINE ,WINED>
			      <SETG DRUGGEE ,BUTLER>
			      <QUEUE I-WATCH-SLEEP 1>)>
		       <SET-CONTENTS ,LAFOND 0>
		       <SET LAUD-LEFT 0>
		       <REMOVE ,BOTTLE>
		       <TELL
"Lafond takes" T ,BOTTLE " and throws it out the window. \"You shall
need no more of this, my dear. Certainly you will suffer no headaches in
my employ.\"|
   He lifts his glass to drink, but stops. \"Your father, for all
his idiotic meddling in other people's business, is not a fool. I doubt
you are, either.\" He calls in" T ,BUTLER ", ordering him to empty">
		       <COND (<EQUAL? .OTHER-WINE ,CONTENTS-BLUE>
			      <TELL T ,BLUE-GLASS>)
			     (T
			      <TELL T ,GREEN-GLASS>)>
		       <TELL ".
The man reports no odd taste and dutifully returns to his post" ,PCR>)
		      (T
		       <TELL
"\"Let's see more cooperation of this sort.\"" CR>)>)
	       (T
		<COND (<G? ,ANGER-CTR 2>
		       <COND (.POISON-SCENE
			      <TELL
"Lafond grows suddenly violent. \"I will not have
insubordination. You shall cooperate, my pretty miss.\"
He forces the wine down your throat" ,PCR>
			      <COND (<AND <G? .YOUR-WINE ,WINED>
					  <NOT <QUEUED? ,I-SLEEP>>> 
				     <QUEUE I-SLEEP 2>)>
			      <SET-CONTENTS ,PROTAGONIST 0>)
			     (T
			      <MOVE ,BLUE-GLASS ,TABLE>
			      <SETG CONTENTS-BLUE 0>
			      <TELL
"He angrily takes" T ,BLUE-GLASS " and sets it on" T ,TABLE ", slopping the
wine in a dark red stain across the lace. \"Do not try my patience, little
one. I have those you love, remember.\"" CR>)>)
		      (T
		       <DEQUEUE I-LSED>      ;"To stop what is queued above"
		       <QUEUE I-WONT-DRINK 1>
		       <COND (<EQUAL? ,ANGER-CTR 1>
			      <TELL
"Lafond taps his foot impatiently, waiting for you to drink" ,PCR>)
			     (<EQUAL? ,ANGER-CTR 2>
			      <TELL
"\"Come, milady, drink. We must not waste all night.\"
Lafond pushes the glass toward " D ,MOUTH ,PCR>)>)>)>>

<ROUTINE I-WONT-DRINK ("AUX" (POISON-SCENE <>))
	 <COND (<G? ,LAFOND-CTR 7>
		<SET POISON-SCENE T>)>
	 <SETG ANGER-CTR <+ ,ANGER-CTR 1>>
	 ;<QUEUE I-LSED 1>
	 <SETG QUESTIONER ,LAFOND>
	 <SETG AWAITING-REPLY 12>
	 <QUEUE I-REPLY 2>
	 <TELL ,INDENT>  
	 <COND (<AND <NOT <EQUAL? ,REACTION ,REACTION-NEGATIVE>>
		     <OR <AND <PRSO? ,YOUR-GLASS>
			      <VERB? DRINK-FROM>>
			 <AND <PRSO? ,WINE>
			      <OR <VERB? EAT DRINK DRINK-FROM>
				  <AND <VERB? POUR>
				       <PRSI? ,MOUTH ,ME>>>>>>
		<PUTP ,YOUR-GLASS ,P?CONTENTS 0>
		;<SET-CONTENTS ,PROTAGONIST 0>
		<TELL "\"Good girl,\" he says">
		<COND (.POISON-SCENE
		       <TELL ". ">
		       <CALL-IN-BUTLER>)
		      (T
		       <TELL
", \"Let's see more cooperation of this sort.\"" CR>
		       <I-LSED>)>)
	       (T
		<COND (<G? ,ANGER-CTR 2>
		       <QUEUE I-LSED 1>
		       <COND (.POISON-SCENE
			      <TELL
"Lafond grows suddenly violent. \"I will not have
insubordination. You shall cooperate, minx.\"
He forces" T ,WINE " down your throat" ,PCR>
			      <COND (<AND <G? <GETP ,YOUR-GLASS ,P?CONTENTS>
					      ,WINED>
					  <NOT <QUEUED? ,I-SLEEP>>> 
				     <QUEUE I-SLEEP 2>)>
			      <PUTP ,YOUR-GLASS ,P?CONTENTS 0>
			      <TELL ,INDENT>
			      <CALL-IN-BUTLER>
			      ;<SET-CONTENTS ,PROTAGONIST 0>)
			     (T
			      <MOVE ,YOUR-GLASS ,TABLE>
			      <PUTP ,YOUR-GLASS ,P?CONTENTS 0>
			      <TELL
"He angrily takes" T ,YOUR-GLASS " and sets it on" T ,TABLE ". " CTHE ,WINE
" slops a dark stain across the lace. \"Do not try my patience, little one.
I have those you love, remember.\"" CR>)>)
		      (T
		       <QUEUE I-WONT-DRINK 1>
		       <COND (<EQUAL? ,ANGER-CTR 1>
			      <TELL D ,LAFOND
" waits impatiently for you to drink" ,PCR>)
			     (<EQUAL? ,ANGER-CTR 2>
			      <TELL
"\"Drink. We must not waste all night.\"" T ,LAFOND
" pushes the glass toward " D ,MOUTH ,PCR>)>)>)>>

<ROUTINE CALL-IN-BUTLER ()
	 <COND (<G? <GETP ,LAF-GLASS ,P?CONTENTS> ,WINED>
		<SETG DRUGGEE ,BUTLER>
		<QUEUE I-WATCH-SLEEP 1>)>
	 <PUTP ,LAF-GLASS ,P?CONTENTS 0>
	 ;<SET-CONTENTS ,LAFOND 0>
	 <SET LAUD-LEFT 0>
	 <QUEUE I-LSED 1>
	 <COND (<EQUAL? <META-LOC ,BOTTLE> ,HERE>
		<REMOVE ,BOTTLE>
		<TELL
"Lafond takes" T ,BOTTLE " and drops it out the window. \"You shall not need
this. You may suffer no headaches in my employ.\"" CR ,INDENT>)>
	 <TELL
"He lifts his glass to drink, but stops. \"Your father, for all his
idiotic meddling in other people's business, is not a fool. I doubt you
are, either.\" He calls in" T ,BUTLER ", ordering him to empty" T ,LAF-GLASS
". The man reports no odd taste and returns to his post" ,PCR>>

<GLOBAL ANGER-CTR 0>

;<ROUTINE SET-CONTENTS (WHO WHAT)
	 <COND (<IN? ,BLUE-GLASS .WHO>
		<PUTP ,BLUE-GLASS ,P?CONTENTS .WHAT>
		;<SETG CONTENTS-BLUE .WHAT>)
	       (<IN? ,GREEN-GLASS .WHO>
		<PUTP ,GREEN-GLASS ,P?CONTENTS .WHAT>
		;<SETG CONTENTS-GREEN .WHAT>)
	       (T
		<RFALSE>)>>

<ROUTINE I-SUMMONS ()
	 <FCLEAR ,LDOOR ,LOCKEDBIT>
	 <MOVE ,LAFOND ,LAFS-ROOM>
	 <COND (<EQUAL? ,HERE ,LIBRARY>
		<COND (<IN? ,DAD ,HERE>
		       <QUEUE I-SUMMONS 2>
		       <RTRUE>)>
		<TELL ,INDENT CTHE ,BUTLER " enters the room">
		<COND (<FSET? ,PORTRAIT ,OPENBIT>
		       <TELL
", sees the open " D ,PORTRAIT ", and seizes your arms,
pinning them behind your back. ">
		       <FWTD ,SOMETHING-HITS-YOU>)
		      (T
		       <REMOVE ,BUTLER>
		       <TELL
". \"Excuse me for interrupting, Miss, but the master requests your company
in his room.\" He ">
		       <COND (<OR <FSET? ,KNOB ,EVERYBIT>
				  <FSET? ,POWER ,EVERYBIT>>
			      <FCLEAR ,KNOB ,EVERYBIT>
			      <FCLEAR ,POWER ,EVERYBIT>
			      <TELL
"moves around the room, straightening things, then ">)>
		       <TELL
"guides you back to the foyer. \"The governor's "
D ,OBJ-QUARTERS " are in the east wing." ,BUTLER-POINTS CR>
		       <GOTO ,FOYER>)>)
	       ;(<BELOW-GROUND <LOC ,PROTAGONIST>>
		 <FSET ,LIBRARY ,EVERYBIT>)
	       (<OR <EQUAL? ,HERE ,BALLROOM ,SUPPER-ROOM ,ORCHESTRA>
		    <EQUAL? ,HERE ,HALL-W ,FOYER ,HALL-E>
		    <EQUAL? ,HERE ,BEDROOM ,GALLERY ,X-ROOM>
		    <EQUAL? ,HERE ,MAIN-ENTRANCE ,VERANDA ,KITCHEN>
		    <EQUAL? ,HERE ,STAIRTOP ,UPPER-HALL-W ,UPPER-HALL-E>>
		<COND (<FSET? ,GOWN ,WORNBIT>
		       <REMOVE ,BUTLER>
		       <TELL ,INDENT CTHE ,BUTLER ,BUTLER-SUMMONS>
		       <COND (<EQUAL? ,HERE ,UPPER-HALL-E>
			      <TELL "to" T ,LDOOR ", unlocks it">)
			     (<EQUAL? ,HERE ,STAIRTOP ,UPPER-HALL-W 
				      ,X-ROOM ,BEDROOM>
			      <TELL "to the east">)
			     (<EQUAL? ,HERE ,GALLERY>
			      <TELL "to the north">) 
			     (T
			      <TELL "up" T ,STAIRS "s">)>
		       <TELL ", bows, and leaves." CR>)
		      (T
		       <FSET ,FOYER ,EVERYBIT>
		       <TELL ,INDENT CTHE ,BUTLER
", who looks like he is seeking someone, grabs your collar, \"Who invited
beggars? Get back to the village where you belong.\"">
		       <COND (<NOT <EQUAL? ,HERE ,MAIN-ENTRANCE>>
			      <TELL
" He escorts you out of the house" ,PCR CR>
			      <GOTO ,MAIN-ENTRANCE>)
			     (T
			      <CRLF>)>)>)
	       (T
		<FSET ,FOYER ,EVERYBIT>)>>

<ROUTINE I-CKILLS-DAD ()
	 ;<COND (<IN? ,DAD ,CELL-4>
		<FSET ,DAD ,DEADBIT>
		<FSET ,IRON-CELL-DOOR ,OPENBIT>
		<COND (<NOT <FSET? ,LARGE-KEY ,TOUCHBIT>>
		       <MOVE ,LARGE-KEY ,DUNGEON>
		       <FSET ,LARGE-KEY ,TOUCHBIT>)>
		<REMOVE ,DAD>)>
	 <COND (<OR <EQUAL? ,HERE ,BALLROOM ,FOYER>
		    <EQUAL? ,HERE ,SUPPER-ROOM ,ORCHESTRA>>
		<TELL ,INDENT
"You see" T ,CRULLEY " come in from the east wing and beckon to Lafond.
\"'E's gone">
		<COND (<FSET? ,DAD ,TOUCHBIT>
		       <QUEUE I-LDANCE 2>
		       <REMOVE ,HERO>
		       ;<TELL " urgently" ,PCR ,INDENT>
		       <TELL
"! The cocky crupper 'as disappeared!\" Lafond looks around angrily, eyes
narrowed, \"Then get his compatriot. Take Falcon.\"" T ,CRULLEY
" runs out the front door, reappearing a moment later with help" ,PCR>
		       <I-HARRESTED T>)
		      (T
		       <H-JIGS-UP
". Visiting that Neptune you tol' me about. Gone to sea, poor
man,\" he laughs, and returns to lurking around the doorway." T>)>)
	       (T
		<RFALSE>)>
	 <SETG CRULLEY-CTR <+ ,CRULLEY-CTR 1>>>

;<ROUTINE old-I-CKILLS-DAD ()
	 <COND (<EQUAL? ,CRULLEY-CTR 1>
		;<QUEUE I-CKILLS-DAD 2>
		<COND (<IN? ,DAD ,CELL-4>
		       <FSET ,DAD ,DEADBIT>
		       <FSET ,IRON-CELL-DOOR ,OPENBIT>
		       <COND (<NOT <FSET? ,LARGE-KEY ,TOUCHBIT>>
			      <MOVE ,LARGE-KEY ,DUNGEON>
			      <FSET ,LARGE-KEY ,TOUCHBIT>)>
		       <REMOVE ,DAD>)>)
	       (<EQUAL? ,CRULLEY-CTR 2>
		<COND (<OR <EQUAL? ,HERE ,BALLROOM ,FOYER>
			   <EQUAL? ,HERE ,SUPPER-ROOM ,ORCHESTRA>>
		       <TELL ,INDENT
"You see " D ,CRULLEY " come in from the east wing and beckon to" T ,LAFOND>
		       <COND (<FSET? ,DAD ,TOUCHBIT>
			      <QUEUE I-LDANCE 2>
			      <REMOVE ,HERO>
			      <TELL " urgently" ,PCR ,INDENT>
			      <TELL
"\"'E's gone! The cocky crupper 'as disappeared!\" Lafond looks around
angrily, eyes narrowed, \"Then get his compatriot. Take Falcon.\"" T ,CRULLEY
" runs out the front door, reappearing a moment later with help" ,PCR>
			      <I-HARRESTED T>)
			     (T
			      ;<SETG DANCED-WITH ;,BLOWN>
			      <TELL
". \"'E's gone. Visiting that Neptune you told me about. Gone to sea, poor
man,\" he laughs, and returns to lurking around the doorway" ,PCR>)>)
		      (T
		       <RFALSE>)>)
	       (T
		<RFALSE>)>
	 <SETG CRULLEY-CTR <+ ,CRULLEY-CTR 1>>>

;<TELL "Swords clash in anger as the duel rages on" ,PCR>

;<GLOBAL CAN-SEE-DUEL <>>
;<GLOBAL CAN-HEAR-DUEL <>>

;(<AND <NOT ,CAN-HEAR-DUEL>
       <NOT ,CAN-SEE-DUEL>>
  <RFALSE>)

<ROUTINE I-DUEL ()
	 <COND (<AND <CANT-HEAR-DUEL>
		     <L? ,HERO-CTR 16>> T)
	       (<L? ,HERO-CTR 12>
		<TELL ,INDENT>
		<COND (<EQUAL? ,HERE ,GALLERY>             ;,CAN-SEE-DUEL
		       <TELL
"Nicholas and Lafond circle each other intently, the one breathing hard, the
other casual, sword tips almost touching. Jamison has lost copious amounts
of blood and is no match for Lafond, cool and competent." CR>)>
		<TELL <PICK-ONE ,DUEL-SOUNDS> CR>)
	       (<EQUAL? ,HERO-CTR 12>
		<TELL ,INDENT 
"Someone calls out, \"We've got the Dimsford girl, Governor\" -- lying, of
course, since you're obviously free">
		<COND (<EQUAL? ,HERE ,GALLERY>              ;,CAN-SEE-DUEL
		       <TELL
". But Nick glances towards the voice, missteps, and slips in his own blood,
falling backwards to the floor, his rapier skittering aside">)>
		<TELL ,PCR>)
	       (<EQUAL? ,HERO-CTR 13>
		<TELL ,INDENT>
		<COND (<EQUAL? ,HERE ,GALLERY>               ;,CAN-SEE-DUEL
		       <TELL D ,LAFOND
" leaps to Jamison's side, placing one heeled boot on the prostrate man's
throat, the tip of his sword over Nick's heart. He sneers then, one eyebrow
tilted, and moves to plunge in the sword. Nicholas cannot move.">)
		      (T
		       <SETG HERO-CTR 15>   ;"skip to last move I-DUEL"
		       <TELL 
"One of the duellists falls heavily to the floor, his sword skittering away.
All is silence for a moment, broken once by a low chuckle. Then a woman
screams, someone gasps, and Jean Lafond's wicked laugh blasts your ears,
\"Who else cares to taste my blade?\"">
		       ;<TELL
"A duellist leaps forward, but no sound of sword scraping sword,
as the lunge is parried, follows. Instead, one labored breath whispers from
the ballroom and a body thuds dully the floor. A woman screams then, someone
faints, and from the frightened silence comes Jean Lafond's wicked laugh,
\"Who else cares to taste my blade?\"">)>
		<CRLF>)
	       (<EQUAL? ,HERO-CTR 14>
		<COND (<EQUAL? ,HERE ,GALLERY>               ;,CAN-SEE-DUEL
		       <TELL ,INDENT
"The sword plunges down into Jamison's heart, a red stain flowing up to meet
it on his breast. Nicholas draws his last breath, his tortured gaze drawn
heavenwards, to your face. He reaches for you, his hand dripping his own
blood, and breathes your name...|
   Nicholas's hand falls limply to the swelling pool of wine red blood and
silence pounds on your ears" ,PCR>)>)
	       (<EQUAL? ,HERO-CTR 15>
		<COND (<EQUAL? ,HERE ,GALLERY>                 ;,CAN-SEE-DUEL
		       <TELL ,INDENT
"Lafond wipes his sword on your lover's inert body, ordering someone to drag
away the corpse. Suddenly there are sounds of fighting all about, and you
realize dragoons surround the house" ,PCR>)
		      (T
		       <TELL "Time has stopped. Silence reigns." CR>)>)
	       (<EQUAL? ,HERO-CTR 16>
		<COND (<NOT <CANT-HEAR-DUEL>>
		       ;<OR <EQUAL? ,HERE ,GALLERY ,STAIRTOP ,FOYER>
			   <EQUAL? ,HERE ,SUPPER-ROOM ,VERANDA ,HALL-E>>
		       <TELL ,INDENT
"\"Find the girl and bring her to me,\" Lafond orders." CR>)>
		<TELL ,INDENT ,DRAGOONS-SURROUND>
		<FWTD ,SOMETHING-HITS-YOU>)>
	 <SETG HERO-CTR <+ ,HERO-CTR 1>>>

<GLOBAL DUEL-SOUNDS
	<LTABLE
	 0
	 "Swords engage and disengage."
	 "You hear metal scrape metal. A woman gasps."
	 "Lafond's voice is cold, lazy, \"You will die, you know, Jamison.\""
	 "You hear a piece of furniture being knocked over."
	 "\"You must ... pay ... for your actions!\" Nicholas gasps."
	 "Rapiers click and slide. \"Bad parry, Captain,\" Lafond says."
         "You hear a duellist leap forward, and swords clash, parrying.">>

<ROUTINE CANT-HEAR-DUEL ()
	 <COND (<EQUAL? ,HERE ,UPPER-HALL-E ,STAIRTOP ,HALL-W ,FOYER
			      ,LIBRARY ,HALL-E ,VERANDA ,GALLERY>
		<RFALSE>)
	       (T
		<RTRUE>)>>

<CONSTANT DEAD 7>     ;"Lafond by 7 -- skewered by Nicholas"
<CONSTANT FIGHTING 5>  ;"Lafond by 5 -- fighting Nicholas"

<OBJECT AIR
	(IN GLOBAL-OBJECTS)
	(DESC "air")
	(SYNONYM AIR)>

<OBJECT PISTOL
	(DESC "pistol")
	(SYNONYM PISTOL GUN)
	(FLAGS TAKEBIT)
	(SIZE 3)
	(ACTION PISTOL-F)>

<ROUTINE PISTOL-F ()
	 <COND (<VERB? FILL>
		<COND (<AND <NOT ,PRSI>
		            <EQUAL? ,P-PRSA-WORD ,W?LOAD>>
		       <COND (<HELD? ,POWDER>
			      <PERFORM ,V?FILL ,PISTOL ,POWDER>
			      <RTRUE>)
			     (T
			      <TELL ,YNH " any " D ,POWDER ,PCR>)>)
		      (<PRSI? ,POWDER>
		       <COND (,PRIMED
			      <TELL ,YOU-HAVE-ALREADY " loaded" TR ,PISTOL>)
			     (T
			      <SETG PRIMED T>
			      <MOVE ,HORN ,PROTAGONIST>
			      
			      ;"LOAD GUN/PUT STONE IN GARTER"

			      <COND (<NOT ,PENULTIM-POINT>   
				     <SETG PENULTIM-POINT T>
				     <SETG SCORE <+ ,SCORE 1>>)>
			      <TELL
"You pour a lumpy stream of" T ,POWDER " mixture into the barrel of"
T ,PISTOL " tamping it as best you can" ,PCR>)>)
		      (<PRSO? ,PISTOL>
		       <TELL ,YOU-CANT "put that into" AR ,PISTOL>)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? PUT POUR>
		     <PRSI? ,PISTOL>>
		<COND (<PRSO? ,POWDER>
		       <PERFORM ,V?FILL ,PISTOL ,PRSO>
		       <RTRUE>)
		      (T
		       <TELL ,HUH>)>)
	       (<VERB? EXAMINE>
		<TELL "One of" A ,PAIR ", the gun is ">
		<COND (,PRIMED
		       <TELL "primed and ready to fire.">)
		      (T
		       <TELL "not loaded.">)>
		<CRLF>)
	       (<VERB? KILL>
		<PERFORM ,V?SHOOT ,PRSO ,PRSI>
		<RTRUE>)
	       (<VERB? SHOOT>
		<COND (<NOT ,PRIMED>
		       <TELL "But" T ,PISTOL " is not loaded." CR>)
		      ;(<L? ,LAFOND-CTR ,DEAD>
		       <TELL CR "BUG #32 (&c.)" CR>)
		      (<OR <NOT ,PRSI>
			   <PRSO? ,AIR>>        ;" FIRE PISTOL/ SHOOT GUN "
		       <SETG SCORE <+ ,SCORE 1>>   ;"WIN 3"
		       <TELL
"You fire" T ,PISTOL " into the air. Startled by the loud report," T ,CRULLEY
" jerks his pistol and fires, aiming not at Nicholas, but at you. You hear a
distant scream, your own, and watch, as through from afar," T ,DAD " wrestle"
T ,CRULLEY " to" T ,GROUND ". You feel only numbness as loving arms take you
up, and Nicholas kisses you into death, his tears damp on your cheek."
,YOU-DIED>
		       ;<CLEAR-SCREEN 5>
		       <SETG FINAL-RANK 2>
		       ;<FINISH T>
		       <FINISH>)
		      (<PRSO? ,PATROL ,BUSHES>
		       <TELL "They are out of range." CR>)
		      (<PRSO? ,CRULLEY>
		       <SETG SCORE <+ ,SCORE 1>>    ;"WIN 5"
		       <TELL
"Trembling, you fire the heavy pistol. You hear its loud report over
roaring surf. Crulley staggers, hit, and falls from the cliff.
The gun falls from your nerveless hands.|
   Time stops as you and Nicholas gaze at one another, adoring and amazed.
Slowly he bows and offers his hand.|
   " ,NUTBROWN "His eyes, twin seas of blue, devour you with a love
deep and true-hearted, and you are pulled into his embrace, your mouth
on his, lips parted, thirsting, arching into his kiss..." CR>
		       <FINALE>)
		      (<PRSO? ,PISTOL>
		       <IMPOSSIBLES>)
		      (<FSET? ,PRSO ,DEADBIT>
		       <MAN-IS-DOWN>)
		      (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "You wouldn't kill" T ,PRSO "!" CR>)
		      (<NOT <IN? ,PRSO ,HERE>>
		       <TELL CTHE ,PISTOL " can't fire that far" ,PCR>)
		      (T
		       <WASTES>)>)
	       (<AND <PRSO? ,STONE>
		     <VERB? SSHOOT>>
		<WASTES>)
	       ;(<PRSI? ,GUN>
		 <PERFORM ,V?SSHOOT ,GUN ,PRSO>
		 <RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE I-ENDGAME ()
	 <COND (<AND <EQUAL? ,HERE ,LAGOON ,BY-SHIP>
		     <G? ,LAFOND-CTR 1>>
		<SETG SCORE 25>  ;<+ ,SCORE 1>
		<TELL ,INDENT
"You hear distant shots and screams, and gaze back across the restless waves
to the massacre on the beach. The sight blurs with your tears of
shame, tears for the father and the lover you left behind." CR>
	        <CLEAR-SCREEN 15>
		<TELL ,INDENT
"The tale you tell Jamison's crew, of rapine and blood, of your heroic
attempt to save their captain, and of your own escape after his death in
your arms, is not so far from the truth that you cannot appear sincere.
Cannily, you take advantage of their temporary grief, select a private
guard, and teach the rest the discipline of the whip.">
		<SETG FINAL-RANK 3>
		<COND (<L? ,LAFOND-CTR ,DEAD>
		       ;<NOT <FSET? ,LAFOND ,DEADBIT>>
		       <TELL
" You have started on the ruthless road to revenge. You intend to meet
Lafond again, and that time, you intend to win.">)>
		;<SETG FINAL-RANK <COND (<FSET? ,LAFOND ,DEADBIT> 3 ;6)
				       (T <TELL
"You have started on the ruthless road to revenge. You intend to meet
Lafond again, and next time, you intend to win."> 4 ;1)>>
		<CRLF>
		;<FINISH T>
		<FINISH>
		<RFALSE>)>
	 <TELL ,INDENT>
	 <COND (<EQUAL? ,LAFOND-CTR 1>
		<COND (<NOT <EQUAL? ,HERE ,BEACH ,SHALLOWS ,LAGOON>>
		       <FWTD
"Dragoons surround you, appearing from nowhere.
They show you no mercy, though they let you survive.">)
		      (T
		       <QUEUE I-ENDGAME -1>
		       <MOVE ,LAFOND ,BEACH>
		       <FCLEAR ,LAFOND ,MUNGBIT>
		       <MOVE ,CRULLEY ,BEACH>
		       <FCLEAR ,CRULLEY ,MUNGBIT>
		       <TELL
"A shot rings out over the roar of the surf. Turning, you see that Lafond
stands at the top of the cliff, a pistol in each hand. \"Trying to sneak
out the back, cowards? You will die like your brother, Falcon. Snivelling
for mercy.\" He hands one gun to " D ,CRULLEY ", standing nearby, and levels
the other at Jamison" ,PCR>)>)
	       (<EQUAL? ,LAFOND-CTR 2>
		<FSET ,COOKIE ,DEADBIT>
		<SETG QUESTIONER ,HERO>
		<SETG AWAITING-REPLY 9>
		<QUEUE I-REPLY 2>
		<TELL
"As the gun fires, Cookie throws himself before his captain. He cries out,
blood blossoming on his shoulder, and falls face first into the sand.
Lucy runs to him.|
   Jamison yells up the cliff, brandishing his sword. \"Fight like a man,
Lafond. You have drawn my blood once tonight -- let me draw yours.\"|
   Lafond sneers. \"On one condition. If I win, your lady comes to me.
You will have no need of her when you are dead.\"|
   Nicholas stiffens, glances at the dragoons on the cliff above, and turns
slowly to you. He says nothing, his face hard, but his eyes tell you what
you want to know. \"Answer, my darling. Yes or no?\"" CR>)
	       (<EQUAL? ,LAFOND-CTR 3 4>
		<SETG QUESTIONER ,HERO>
		<SETG AWAITING-REPLY 9>
		<QUEUE I-REPLY 2>
		<COND (<OR <AFFIRMATIVE-ANSWER>
			   <VERB? YES>>
		               ;<EQUAL? ,REACTION ,REACTION-POSITIVE>
		       <FSET ,RAPIER ,NDESCBIT>
		       <FSET ,LAFOND ,NDESCBIT>
		       <FCLEAR ,CRULLEY ,NDESCBIT>
		       <MOVE ,PISTOL ,BEACH>
		                   ;"then skip to FIGHTING next turn"
		       <SETG LAFOND-CTR <- ,FIGHTING 1>> 
		       <TELL
"Nicholas looks determined. \"I accept. So long as my people go free
if I win. Order your dragoons to obey us, then.\" In answer, Lafond jumps
off the cliff like a huge brocaded bat to land in front of" T ,HERO ".
\"Die then, fool!\"|
   " CTHE ,PISTOL ", spinning from Lafond's grip, drops to the sand ">
		       <COND (<EQUAL? ,HERE ,BEACH>
			      <TELL "nearby." CR>)
			     (T
			      <TELL "of the beach." CR>)>)
		      (<AND <EQUAL? ,REACTION ,REACTION-NEUTRAL>
			    <EQUAL? ,LAFOND-CTR 3>>
		       <TELL
"Lafond calls down to you, \"My pretty doxy,
do make up your mind. Yes or no?\"" CR>)
		      (T
		       <JIGS-UP
"Lafond cries, \"No deal then. Take them, men!\"
The dragoons pour down the cliff.">)>)
	       (<EQUAL? ,LAFOND-CTR ,FIGHTING>
		<TELL
D ,LAFOND " immediately takes the advantage, forcing Nicholas in a
retreat towards the foaming surf. But Nicholas fights hard, jaw set, ignoring
his wounds. Lafond finally loses his smile.|
   Behind the duellists, far away atop the cliff, you notice "
D ,CRULLEY " madly reloading the pistol" ,PCR>)
	       (<EQUAL? ,LAFOND-CTR 6>
		<FCLEAR ,LAFOND ,NDESCBIT>
		<REMOVE ,HRING>
		<MOVE ,LRING ,HERO>
		<FCLEAR ,RAPIER ,NDESCBIT>
		<FSET ,LAFOND ,DEADBIT>
		<TELL 
"Suddenly the force of the duel turns, Nicholas advancing against Lafond's
retreat. Their blades silently flash in the moonlight. Lafond is pressed
back into the shadow of the cliff, sweat beading on his forehead. Abruptly,
Jamison leaps forward, metal scrapes, and his rapier licks neatly into
Lafond's ribs, like a snake slipping into its burrow. The body of the governor
of St. Sinistra convulses, as in amazement, then sags dead on the sword.|
   Nicholas removes" A ,LRING " from the dead man's finger, throwing his own
cheap copy into the surf.|
   Far above him," T ,CRULLEY " moves down the stairs." CR>)
	       (<EQUAL? ,LAFOND-CTR ,DEAD>
		<TELL D ,CRULLEY
" is levelling" T ,PISTOL ", feet apart, braced by the cliff wall." CR>)
	       (<EQUAL? ,LAFOND-CTR <+ ,DEAD 1>>
		<TELL
D ,CRULLEY " carefully aims" T ,PISTOL ", a triumphal grin benighting his
face. Nicholas turns and walks smiling towards you, oblivious to his
danger" ,PCR>)
	       (<EQUAL? ,LAFOND-CTR <+ ,DEAD 2>>
		;<SETG FINAL-RANK 0 ;2>
		;<SETG SCORE <+ ,SCORE 1>> 
		<JIGS-UP
"The pistol fires with a deafening roar, spraying shot into Nicholas.
Time stops as he falls, reaching for you, your name his last breath.|
   The battle afterwards is short and bloody. Spurred by grief, you fight
hard, yet greet benumbing death thankfully.">
		;<FINISH T>
		;<FINISH>)>  
	 <SETG LAFOND-CTR <+ ,LAFOND-CTR 1>>>

;(<EQUAL? ,LAFOND-CTR ,DEAD>
  <TELL
"For a moment, all eyes are on you in surprise.
Crulley lifts the pistol to aim it at Nicholas.">)

<ROUTINE FINALE ()
	 <MOVE ,HERO ,FOCSLE>
	 <CLEAR-SCREEN 15>
	 <SET VERBOSITY 0>
	 <GOTO ,FOCSLE>
	 <TELL ,INDENT
"As dawn breaks over the eastern seas, you stand with Nicholas on his ship,
looking north. \"I have nothing left in England,\" he says. \"There I am but a
destitute gentleman, wanted for piracy. Here -- this isle holds too many
memories">
	 <COND (<FSET? ,DAD ,DEADBIT>
		<SETG FINAL-RANK 1 ;4>
		<TELL
" --\" he pauses, gazing into your tear-filled eyes with compassion. \"">)
	       (T
		<SETG FINAL-RANK 4 ;5>
		<TELL "; your father may have it. ">)>
	 <TELL
"Mayhap my brother's wife yet lives. I must try to find her, either way.\"
He takes you into his arms. \"Come with me, my love? To America -- they tell
of endless fertile fields and strange beasts in that wild land. It won't be
easy, but we will have each other. Together, shall we carve a kingdom blessed
with fair children and freedom?\"|
   You wrap your arms about his waist and lean into him, and smile at the
rising sun" ,PCR>
	 ;<FINISH T>
	 <FINISH>>


<OBJECT PATROL
	(IN FRONT-DRIVE)
	(DESC "patrol")
	(LDESC
"Dragoons, conversing quietly, patrol the other side of the gate.")
	(SYNONYM DRAGOO PATROL)
	(ADJECTIVE DRAGOO)
	(FLAGS ACTORBIT)
	(ACTION PATROL-F)>

<ROUTINE PATROL-F ()
	 <COND (<EQUAL? ,PATROL ,WINNER>
		<TELL "A rough voice yells to leave them alone." CR>)
	       (<TOUCHING? ,PATROL>
		<CANT-REACH ,PATROL>)>>


<ROUTINE FAILS-TO-NOTICE ()     ;("OPTIONAL" (WOMAN? <>))
	 <COND (<EQUAL? ,WINNER ,LUCY>
		<TELL "Sh">)
	       (T
		<TELL "H">)>
	 <TELL "e fails to notice you've spoken" ,PCR>>