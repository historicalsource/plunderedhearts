"HERO for
		        PLUNDERED HEARTS
        (c) Copyright 1987 Infocom, Inc.  All Rights Reserved."


<OBJECT HERO                            ;"MUNGBIT: unconscious."              
	(IN CAPT-QUARTERS)
	(DESC "Captain Jamison")
	(DESCFCN HERO-F)
	(SYNONYM HERO PIRATE JAMISON CAPTAIN)
	(ADJECTIVE NICHOLAS NICK CAPTAIN FALCON)
	(SIZE 10)
	(FLAGS ACTORBIT NARTICLEBIT CONTBIT OPENBIT SEARCHBIT)
	(GENERIC GEN-PIRATE)
	(ACTION HERO-F)>

<GLOBAL HERO-CTR 1>

<GLOBAL HDAD-SPEECH <>>    ;"You've told him about freeing Dad,"
                           ;"(which you can do by NICK, FOLLOW ME - dance)"
                           ;"OR he's answered your question about Dad."
                           ;"(To prevent his dance speech happening twice)"
 
<ROUTINE HERO-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-DESC?>
		       <RTRUE>)>
		<COND (<NOT <EQUAL? ,HERE ,FOLLY>>
		       <TELL ,INDENT>)>      ;"To prevent indent in folly"
		<COND (<EQUAL? ,HERE ,CABIN>
		       <TELL ,CTHE-PIRATE-CAPTAIN "is studying you">)
		      (<EQUAL? ,HERE ,DEUX-DECK>
		       <TELL ,CTHE-PIRATE-CAPTAIN
"stands protectively a few steps behind you">)
		      (<EQUAL? ,HERE ,CAPT-QUARTERS>
		       <TELL D ,HERO " is adjusting his clothes">)
		      (<RUNNING? ,I-DUEL>
		       <TELL
"Battered and bruised, Nicholas can hardly stand">)
		      ;(<IN? ,HERO ,MANACLES>
		       <RTRUE>)              ;"TOLD in MANACLES-DESC"
		      (<FSET? ,HERO ,DEADBIT>
		       <TELL ,HERO-EYES-CLOSED>)
                      (<EQUAL? ,HERE ,BEACH>
		       <TELL "Nicholas ">
		       <COND (<FSET? ,LAFOND ,DEADBIT>
			      <TELL "walks toward you, smiling wearily">)
			     (<G? ,LAFOND-CTR <- ,FIGHTING 1>>
			      <TELL "and Lafond are fighting">)
			     (T
			      <TELL 
"stands alone at one edge of the beach">)>)
		      (<QUEUED? ,I-ENDGAME>
		       <TELL
"Nicholas stands, half-supported by Lucy and" T ,DAD>)
		      (<EQUAL? ,HERE ,BALLROOM>
		       <TELL
"Nicholas looks quite rakish, in red velvet and white,
his rapier flashing in the light of the " D ,CHANDELIER>)
		      (T
		       <RFALSE>)>
		<TELL ".">)
	       (<EQUAL? ,HERO ,WINNER>
		<COND (<AND <RUNNING? ,I-DUEL>
			    <EQUAL? ,HERE ,GALLERY ,STAIRTOP>>
		       <TELL ,SPEECHLESS>)
		      (<AND <EQUAL? ,HERE ,BEACH>
			    <RUNNING? ,I-ENDGAME>>
		       <COND (<AND <NOT <FSET? ,LAFOND ,DEADBIT>>
				   <G? ,LAFOND-CTR <- ,FIGHTING 1>>>
			      <TELL ,SPEECHLESS>)
			     (<VERB? HALT LOOK-INSIDE WALK CLIMB-DOWN>
			      <H-JIGS-UP
"Nicholas stops at your cry, and turns, curious, to face Crulley
just as the pistol sprays shot into his chest.">) 
			     (T
			      <FAILS-TO-NOTICE>)>)
		      (<FSET? ,HERO ,DEADBIT>
		       <TELL ,DOESNT-RESPOND>)
		      (<AND <VERB? FOLLOW>
			    <PRSO? ,ME>
			    <RUNNING? ,I-HDANCE>   ;"Dad told you to"
			    <FSET? ,DAD ,TOUCHBIT>>  ;" fetch Nick"
		       <SETG HDAD-SPEECH T>
		       <TELL
"\"I will follow you anywhere you please,
but first I must kill Lafond.\"" CR>) 
		      (<VERB? I-LOVE-YOU>
		       <COND (<PRSO? ,MAN ,HERO>
			      <TELL
"He smiles at you warmly, his eyes full of passion." CR>)
			     (<PRSO? ,LAFOND>
			      <COND (<OR <RUNNING? ,I-HFOLLY>
					 <RUNNING? ,I-HDANCE>>
				     <REMOVE ,HERO>
				     <STOP-QUEUES>
				     <TELL
"He looks at you in disgust and walks away." CR>)
				    (T
				     <TELL "\"Don't jest,\" he says." CR>)>)
			     (T
			      <TELL "He isn't all that interested." CR>)>)
		      (<VERB? LEAVE>
		       <COND (<FSET? ,BEACH ,TOUCHBIT>
			      <SETG AWAITING-REPLY 4>
			      <QUEUE I-REPLY 2>
			      <TELL
"He catches your arm, \"Nay, can you mean that?\"" CR>)
			     (T
			      <TELL
"\"I have business to attend to here,
and have no intention of leaving.\"" CR>)>
		       <RTRUE>)
		      (<AND <VERB? READ>
			    <PRSO? ,LETTER>>
		       <PERFORM ,V?TELL-ABOUT ,ME ,LETTER>
		       <RTRUE>)
		      (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <COND (<PRSI? ,LETTER>
			      <TELL "\"Your father wrote it for you.\"" CR>)
			     (<PRSI? ,HRING>
			      <SETG WINNER ,PROTAGONIST>
			      <PERFORM ,V?TAKE ,HRING>
			      <RTRUE>)
			     (<PRSI? ,LAFOND>
			      <TELL
"\"I abhor the fiend.\" He clenches a fist." CR>)
			     (<PRSI? ,DAD>
			      <COND (<RUNNING? ,I-HDANCE>
				     <SETG HDAD-SPEECH T>
				     <TELL <GET ,HERO-SPEECHES 0> ,PCR>)
				    (<RUNNING? ,I-HFOLLY>
				     <TELL
"\"Let's not discuss" T ,DAD " just now,\"
he says, kissing your neck" ,PCR>)
				    (T
				     <TELL
"\"I admire and respect your father greatly.\"" CR>)>)
			     (T
			      <FAILS-TO-NOTICE>)>
		       <STOP>)
		      
		      ;(<AND <VERB? RAISE>
			    <PRSO? ,ME>
			    <EQUAL? <LOC ,PROTAGONIST> ,TREE-HOLE ,CLOSET>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?CLIMB-ON ,SIDEKICK>
		       <SETG WINNER ,SIDEKICK>
		       <RTRUE>)
		      (<AND <VERB? TAKE>
			    <PRSO? ,FLOWER>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?GIVE ,FLOWER ,HERO>
		       <SET WINNER ,HERO>
		       <RTRUE>)
		      (<SET OARG <COM-CHECK ,HERO>>
		       <COND (<==? .OARG ,M-FATAL>
			      <RFALSE>)
			     (T
			      <RTRUE>)>)
		      ;(T
		       <FAILS-TO-NOTICE>
		       <STOP>)>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,HERO ,DEADBIT>
		       <COND (<RUNNING? ,I-DUEL>
			      <TELL "He lies in a pool of blood." CR>)
			     (T
			      <TELL ,HERO-EYES-CLOSED>)>)
		      (<AND <EQUAL? ,HERE ,CAPT-QUARTERS ,BALLROOM ,FOLLY>
			    <NOT ,ENDGAME>>
		       <TELL
"Jamison is finely dressed, in red velvet coat and full breeches, with a
long gold embroidered vest and waterfalls of white lace at his neck, wrists
and boottops. His rapier is bedecked with a fringed gold ribbon. He wears no
wig, his unpowdered hair tied neatly at the back of his neck" ,PCR>)
		      (T
		       <TELL
"Jamison carries an aura of power unusual in men so slim and tall,
the strength of a willow in his hard seaworn body, straight shouldered and
resilient. " ,NUTBROWN "A jagged scar etches one cheek, harsh against
the warmth of his limpid blue eyes" ,PCR>)>)
	       (<AND <VERB? SAVE-SOMETHING ROLL>
		     <RUNNING? ,I-ENDGAME>>
		<SETG WINNER ,HERO>
		<PERFORM ,V?HALT ,ROOMS>
		<SETG WINNER ,PROTAGONIST>
		<RTRUE>)
	       (<FSET? ,HERO ,DEADBIT>
		<COND (<AND <VERB? GIVE>
			    <PRSO? ,SALTS>>
		       <REVIVE-HERO>)
		      (<AND <VERB? BLOW PUT-ON THROW-AT>
			    <PRSO? ,SPICES>>
		       <TELL "He sneezes involuntarily, unconscious." CR>)
		      (<VERB? KILL KICK MUNG>
		       <MAN-IS-DOWN>)
		      (<VERB? MOVE>
		       <TELL "He's too heavy." CR>)
		      (<VERB? KISS EMBRACE>
		       <TELL
"You press your lips to his cold mouth. " ,DOESNT-RESPOND>)
		      (<OR <AND <VERB? TELL TELL-ABOUT ASK-ABOUT>
				<NOT <PRSO? ,HERO>>>
			   <TOUCHING? ,HERO>>
		       <TELL ,DOESNT-RESPOND>)
		      (T
		       <RFALSE>)>)
	       (<VERB? GIVE>
		<COND (<PRSO? ,SALTS>
		       <REVIVE-HERO>)
		      (<PRSO? ,BANKNOTE>
		       <TELL D ,HERO " returns" T ,BANKNOTE " to you" ,PCR>)
		      (<PRSO? ,FLOWER>
		       <TELL 
"He prevents you, smiling. \"It looks much
too pretty against your hair. Keep it.\"" CR>)
		      (<PRSO? ,COFFER>
		       <FAILS-TO-NOTICE>)
		      (T
		       <RFALSE>)>)
	       (<VERB? ALARM>
		<COND ;(<NOT ,PRSI>
		       <PROPOSE>)
		      (<NOT <PRSI? SALTS>>
		       <TELL ,YOU-CANT "revive him with that!" CR>)
		      (<HELD? ,SALTS>
		       <REVIVE-HERO>)
		      ;(<HELD? ,QUILL>
		       <PERFORM ,V?ALARM ,HERO ,QUILL>
		       <RTRUE>)
		      (T
		       <TELL D ,HERO " is not asleep" ,PCR>)>)
	       (<AND <VERB? UNTIE>
		     <EQUAL? ,P-PRSA-WORD ,W?FREE>>
		<COND (<IN? ,HERO ,MANACLES>
		       <SETG AWAITING-REPLY 2>
		       <QUEUE I-REPLY 2>
		       <TELL "You have the key, maybe?" CR>)
		      (T
		       <TELL "Jamison is free enough as it is" ,PCR>)>)
	       (<VERB? KILL KICK MUNG>
		<TELL "\"Please, I'm not trying to hurt you,\"">
		<COND (<EQUAL? ,HERE ,CABIN>
		       <TELL " the stranger">)
		      (T
		       <TELL T ,HERO>)>
		<TELL " says, casually deflecting the blow" ,PCR>)
	       (<AND <VERB? KISS>
		     <EQUAL? ,WINNER ,PROTAGONIST>>
		<COND (<EQUAL? ,HERE ,CABIN ,DEUX-DECK>
		       <TELL
"You are not so pert as to kiss a stranger, and a pirate, at that!">
		       <CRLF>)
		      (<SHIP-BOARD ,HERE>
		       <TELL
"That thought has occurred to you before,
but now does not seem appropriate" ,PCR>)
		      (<EQUAL? ,HERE ,FOLLY>
		       <SETG REACTION ,REACTION-POSITIVE>
		       <TELL "You lean into his arms, face lifted" ,PCR>)
		      (<OR <RUNNING? ,I-DUEL>
			   <RUNNING? ,I-ENDGAME>>
		       <TELL "You would only distract" TR ,HERO>)
		      (<RUNNING? ,I-HDANCE>
		       <TELL
"In view of all" T ,DANCERS "s, you exchange
only a peck on the cheek" ,PCR>)
		      (T
		       <TELL "He kisses you back" ,PCR>)>)
	       (<VERB? TELL-ABOUT>
		<COND ;(<EQUAL? ,WINNER ,PROTAGONIST>
		       <TELL ,DOESNT-RESPOND>)
		      (<OR <NOUN-USED ,W?LIBRARY ,HOUSE>
			   <NOUN-USED ,W?CELL ,CELL-4>
			   <PRSI? ,PORTRAIT ,DUNGEON>>
		       <TELL "He nods. \"That area is guarded well.\"" CR>)
		      (<PRSI? ,DAD>
		       <COND (<IN? ,DAD ,CELL-4>
			      <TELL
"He smiles fondly at your reminiscing.
\"I never knew my father -- he died when I was a boy.\"" CR>)
			     (T
			      <SET HDAD-SPEECH T>
			      <TELL
"\"Such bravery joined with such beauty!\"" CR>)>)
		      (<AND <PRSI? ,CRULLEY>
			    <FSET? ,BEACH ,TOUCHBIT>>
		       <TELL "\"Crulley?! God's blood!\"" CR>) 
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? EMBRACE TOUCH>
		     <EQUAL? ,HERE ,FOLLY>>
		<PERFORM ,V?KISS ,HERO>
		<RTRUE>)
	       ;(<AND <VERB? WALK FOLLOW>
		     <EQUAL? ,HERE ,CABIN>
		     <IN? ,HERO ,HERE>>
		<TELL D ,HERO " guides you through" TR ,DOOR CR>
		<GOTO ,DEUX-DECK>)
	       (<VERB? DANCE>
		<COND (<AND <EQUAL? ,HERE ,BALLROOM>
			    <EQUAL? ,PARTNER ,HERO>>
		       <TELL ,PACE>)
		      (<RUNNING? ,I-HDANCE>
		       <MOVE ,PROTAGONIST ,BALLROOM>
		       <MOVE ,HERO ,BALLROOM>
		       <SETG PARTNER ,HERO>
		       <TELL "You whirl back out to" ,DANCE-FLOOR ,PCR>)
		      (T
		       <RFALSE>)>) 
	       (<AND <VERB? SHOW>
		     <PRSO? ,JEWEL>
		     <IN? ,HERO ,MANACLES>>
		<TELL
"Nick smiles dazzlingly, \"Of course! Now pick the locks.\"" CR>)>>

<GLOBAL NUTBROWN
"Chestnut hair, tousled by the wind, frames the tanned oval of his face. ">

<ROUTINE GEN-PIRATE ()
	 <COND (<AND ,ENDGAME
		     <EQUAL? ,HERE ,BALLROOM>>
		,CREW)
	       (<FSET? ,CAPT-QUARTERS ,TOUCHBIT>
		,CRULLEY)
	       (T
		<RFALSE>)>>


;<GLOBAL HEROS-NAME " Captain Nicholas Brent Charles Lancelot Richard
Blaise Peaceable Jamison -- a mouthful, so my friends call me Nick">

<GLOBAL CTHE-PIRATE-CAPTAIN "The pirate captain ">

<GLOBAL HERO-EYES-CLOSED
"Eyes closed, his skin with the pallor of death, Nick looks entirely spent.|">

;"1st meeting with hero in Cabin, (14-11-86)"
<ROUTINE I-MEET-HERO ()
	 <SETG AWAITING-REPLY 5>
	 <QUEUE I-REPLY 1>
	 <SETG QUESTIONER ,HERO>
	 <TELL ,INDENT>
	 <COND (<EQUAL? ,HERO-CTR 1>
		<MOVE ,HERO ,HERE>
		<QUEUE I-MEET-HERO -1>
		<COND (<L? ,ATTACK-C 2>
		       <DEQUEUE I-CRULLEY>
		       <FSET ,CRULLEY ,DEADBIT>
		       <TELL
D ,CRULLEY " drags you, despite your resistance, to">
		       <COND (<EQUAL? <LOC ,PROTAGONIST> ,CABIN-BED>
			      <MOVE ,PROTAGONIST ,HERE>
			      <TELL " your feet">)
			     (T
			      <TELL "wards him">)>
		       <TELL
". Then suddenly he grunts, stiffens and slumps into your arms. "
,STUNNED-THE-SAILOR ".|
   A tall form blocks the shattered door, one fist still raised from
striking your attacker">)
		      (T
		       <TELL CTHE ,DOOR " creaks slightly as a tall
form bends through its smashed remains. \"You seem to have this situation
well in hand,\" timbers a well-bred voice">)>
		<TELL
". You catch a glimpse of the hard masculinity of his broad shoulders,
the implied power in the scar that etches the stranger's jaw,
and feel tremors course through your veins. Then you realize how ragged are
his shirt, patched breeches and high boots. Intuitively, you understand -- he
is the dreaded Falcon, scourge of the sea! Alas, your fate is sealed.
Resigned, you meet his sea-blue eyes." CR>)

;[Under the impact of his gaze, the hard masculinity
of his broad shoulders, the implied power in the scar that etches his
jaw, you discover yourself blind to the dangers of this infamous pirate,
aware only of the tremors that course your veins, of that flutter deep
in your stomach as he draws near you. In this most unlikely of places,
you have met the man you have been waiting for all these years.]

	       (<EQUAL? ,HERO-CTR 2>
		<MOVE ,LETTER ,PROTAGONIST>
		<THIS-IS-IT ,LETTER>
		<TELL ,SURPRISE
"the stranger bows. \"Well met, my lady.\" His accent
is cultured, his smile vibrant. \"I am Captain Nicholas Jamison, known
in these waters as 'The Falcon'. Your father has sent me.\" He chuckles
at your glare of distrust. \"Yes, you are like your sire. You needn't
believe me untried -- I carry this.\" He hands you" AR ,LETTER>
		;<TELL
"To your surprise, the stranger bows. \"My lady, thank God I have found you.\"
His accent is cultured, his smile vibrant. \"I am Captain Nicholas Jamison,
known in these waters as 'The Falcon'. Your father sent me.\" He chuckles
at your glare of distrust. \"Yes, you are like your sire. You needn't believe
me untried -- I carry this.\" He hands you" AR ,LETTER>)
	       (<EQUAL? ,HERO-CTR 3>
		<FSET ,DOOR ,OPENBIT>
		<TELL ,CTHE-PIRATE-CAPTAIN
"glances around the empty room, then notices the coffer">
		<COND ;(<IN? ,COFFER ,RETICULE>
		       <TELL ", outlined in" T ,RETICULE>) 
		      (<IN? ,COFFER ,PROTAGONIST>
		       <TELL " in your arms">)>
		<MOVE ,COFFER ,HERO>
		<TELL
". \"Davis's safety box -- my men were hoping I'd
find it.\" He takes it and nudges the unconscious man on the floor, \"I
wonder how " D ,CRULLEY " knew you were here? Just his bad luck? He'll
be flogged when he wakes.\"|
   The pirate bows. \"My lady, may I offer my protection and my
ship until your father is free?\"" CR>)
	       (<EQUAL? ,HERO-CTR 4 5>
		<COND (<AND <EQUAL? ,HERO-CTR 4>
			    <EQUAL? ,REACTION ,REACTION-NEUTRAL>>
		       <SETG QUESTIONER ,HERO>
		       <TELL
"\"We haven't time to waste. Will you come willingly or not?\"
says" TR ,HERO>)
		      (T
		       <DEQUEUE I-MEET-HERO>
		       <DEQUEUE I-PIRATE-ATTACK>
		       <COND (<EQUAL? ,REACTION ,REACTION-POSITIVE>
			      <TELL
"He chuckles. \"Brave lady, to trust a stranger -- and a pirate.
Who knows, perhaps I forged your father's signature? Keep by my
side as we go to my ship -- few sailors respect a lady's dignity.\"
He helps you through" TR ,DOOR CR>)
			     (T
			      <TELL "He sighs, \"You share" T ,DAD "'s
stubborn streak. I wished not to do this.\" He leaps to your side,
hauling you up onto his shoulder, and carries you out of the room." T
,HERO " sets you on your feet again on the horror of the deck" ,PCR CR>)>
		       <FSET ,HERO ,NDESCBIT>
		       <MOVE ,HERO ,DEUX-DECK>
		       <GOTO ,DEUX-DECK>)>)>
	 <SETG HERO-CTR <+ ,HERO-CTR 1>>>


;"2nd meeting, in his quarters. Covers three turns." 
<ROUTINE I-HSHIP ()
	 <TELL ,INDENT <GET ,HERO-SHIP-SPEECHES ,HERO-CTR> CR>
	 <COND (<EQUAL? ,HERO-CTR 2>
		<REMOVE ,HERO>
		<QUEUE I-HSECOND-BYE 8>)
	       (T
		<QUEUE I-HSHIP 1>)>
	 <SETG HERO-CTR <+ ,HERO-CTR 1>>>

<GLOBAL HERO-SHIP-SPEECHES
	<TABLE 
	 "\"We have anchored off St. Sinistra,\" says Captain Jamison,
\"and I must look like a guest at Lafond's dance tonight. I will find and
free your father, and then finally wreak my revenge on Lafond.\" He half
draws his rapier from its scabbard."
	 "\"I am sorry you have been confined down here, but I don't trust my
lonely crew with such beauty. Crulley isn't the only man aboard with
few principles.\" He smiles at you, eyes lingering, and takes your hand. You
feel your color rising. \"If anything goes wrong, turn to Cookie. He is quite
deaf, but capable. He'll see you through.\""
	 "His look darkens. \"You should know why I hate Lafond:
Some years ago, as my brother and his bride sailed to a new life in
Virginia, pirates struck. Their ship was boarded, looted and burned, the
women taken, never to be seen again. A sailor, the one survivor, watched
as a man of Lafond's description shot my brother in the back as he tried
to save the women. Lafond has now bought respectability, but he shall
never buy peace.\" Jamison straightens resolutely, bows, and departs.">>

;<ROUTINE I-HSHIP ()
	 <COND (<EQUAL? ,HERO-CTR 1>
		<QUEUE I-HSHIP 1>
		<TELL ,INDENT
"\"We have anchored off " D ,ISLAND ",\" says " D ,HERO ", \"and I am
inviting myself to the ball at Lafond's mansion tonight. I hope to find and
rescue your father, and then to wreak final revenge against Lafond.\" He
half draws his rapier from its scabbard" ,PCR>)
	       (<EQUAL? ,HERO-CTR 2>
		<QUEUE I-HSHIP 1>
		<TELL ,INDENT
"\"I am sorry you have been confined down here, but I don't trust my
lonely crew with such beauty. " D ,CRULLEY " isn't the only man aboard with
few principles.\" He smiles at you, eyes lingering, \"Perhaps I just wanted
to keep the sight of you to myself.\"|
   He takes " D ,HANDS ". \"I should return in a few hours with your
father. If all should not go well, turn to Rodney --" T ,COOKIE ", as he is
known to the men. He is gruff, but trustworthy. He'll see you through.\"" CR>)
	       (<EQUAL? ,HERO-CTR 3>
		<REMOVE ,HERO>
		<QUEUE I-HSECOND-BYE 8>
		<TELL ,INDENT
"Jamison bows and deftly twists " D ,HANDS " so his lips brush hotly
against the inside of your wrist. As he leaves, he pushes" A ,CUPBOARD-OBJECT
" up against the doorway, one corner jutting somewhat through
the curtain. You hear a soft, \"Fare thee well,\" and he climbs the
steps to the quarterdeck" ,PCR>)
	       (T
		<RFALSE>)>
	 <SETG HERO-CTR <+ ,HERO-CTR 1>>>

<ROUTINE I-HSECOND-BYE ()
	 <COND (<OR <RUNNING? ,I-OVERHEAR-CRULLEY>
		    <EQUAL? ,HERE ,SLEEPING-CUPBOARD>>
		<QUEUE I-HSECOND-BYE 2>)
	       (T
		<MOVE ,JEWEL ,PROTAGONIST>
		<TELL ,INDENT "You hear">
		<COND (<EQUAL? ,HERE ,CAPT-QUARTERS>
		       <TELL T ,CUPBOARD-OBJECT " scrape">)
		      (<EQUAL? ,HERE ,LANDING>
		       <TELL T ,DOOR " being unbarred">)
		      (T
		       <TELL " a footstep">)>
		<TELL ", ">
		<COND (<NOT <FSET? ,CHEMISE ,EVERYBIT>>
		       <TELL
"turn, and cover " D ,ME " as best you can with what you are holding,
for Jamison stands there, his eyes burning through your lightweight chemise.
He chuckles, \"I am not sorry in the least that I surprised you.">)
		      (,BOY-DRESS?
		       <TELL
"and" T ,HERO "'s startled laugh. \"For a moment I thought you were Matthew,
the boy who used to sleep in the cupboard. He ran off last port.">) 
		      (T
		       <TELL
"and turn to see" T ,HERO ". \"Hello!">)>
		<COND (<NOT <EQUAL? ,HERE ,CAPT-QUARTERS>>
		       <TELL
" How did you escape? Don't stutter, I won't lock you up again -- you are
safe as long as you remain below-decks.">)>
		<TELL
" I came down to give you this -- my allotment from" T ,COFFER ".\" He nods
at the box in his arms.|
   Jamison starts to pin" A ,JEWEL " on your clothes, but, \"Devil take it,
the clasp is broken. I'll have it repaired.\" He folds the pretty thing into "
D ,HANDS ". \"And I meant to reassure you that if the men suddenly abandon
ship, they are off to help me. Rodney will stay behind with you.\" He ">
		
		;[He takes a white card from" T ,COFFER "]
		
		<COND (<EQUAL? ,HERE ,CAPT-QUARTERS>
		       <MOVE ,COFFER ,HERE>
		       <TELL
"drops" T ,COFFER " on the floor, smiling in farewell,">)
		      (T
		       <MOVE ,COFFER ,PROTAGONIST>
		       <TELL
"hands" T ,COFFER " to you. \"Please return
this to my quarters for me, will you?\"">)>
		<TELL " and walks swiftly ">
		<COND (<EQUAL? ,HERE ,LANDING>
		       <TELL
"up the stairs to the deck, barring the door a moment later">)
		      (T
		       <TELL "away">)>
		<TELL ,PCR>
		<QUEUE I-SMELL-SMOKE 3>
		<QUEUE I-HERO-TO-ISLAND 5>
		<RFATAL>)>>

<GLOBAL PARTNER <>>

<ROUTINE I-HDANCE ()
	 <COND (<AND <EQUAL? ,HERO-CTR 1>
		     <EQUAL? ,BALLROOM ,HERE>>
		<MOVE ,HERO ,HERE>
		<SETG LAFOND-CTR 1>
		<QUEUE I-LDANCE 7>
		<SETG PARTNER ,HERO>
		<SETG QUESTIONER ,HERO>
		<SETG AWAITING-REPLY 14>
		<QUEUE I-REPLY 2>
		<SETG DANCED-WITH ,HERO> 
		<TELL
,INDENT D ,HERO " moves up to you, saying, \"May I have this dance?\"
He doesn't await an answer, sweeping you out onto" ,DANCE-FLOOR ,PCR>)
	       (<EQUAL? ,HERO-CTR 2>
		<SETG QUESTIONER ,HERO>
		<COND (<NOT ,MET-ALREADY>
		       <SETG MET-ALREADY T>
		       <TELL ,INDENT "\"" ,FIRST-SIGHTING 
"smiles suddenly. \"Why should I complain? You are quite safe, since
no one expects you here. And you are looking lovely.\"" CR>)
		      (T
		       <HERO-TALKS>)>
		<COND (<EQUAL? ,HERE ,BALLROOM>
		       <TELL ,INDENT
"The steps of the dance separate you a moment, as you twirl around and
curtsey to another dancer. You glide back into the captain's arms" ,PCR>)>)
	       (<EQUAL? ,HERO-CTR 3>
		<SETG QUESTIONER ,HERO>
		<HERO-TALKS>
		<COND (<EQUAL? ,HERE ,BALLROOM>
		       <TELL ,INDENT
"Your hands linked tightly with his and held high over " D ,HEAD "s, a
line of dancers files between you and Jamison" ,PCR>)>)
	       (<EQUAL? ,HERO-CTR 4>
		<SETG QUESTIONER ,HERO>
		<HERO-TALKS>
		<COND (<EQUAL? ,HERE ,BALLROOM>
		       <TELL ,INDENT
"Together you whirl around the ballroom, his arm snug around your waist,
leading you gracefully, masterfully.|
    Nicholas's grip tenses as he nods to a bewigged man staring at you.
You turn, and the man moves on" ,PCR>)>)
	       (<EQUAL? ,HERO-CTR 5>
		<REMOVE ,HERO>
		<SETG PARTNER <>>
		<DEQUEUE I-HDANCE>
		<HERO-TALKS>
	        <TELL ,INDENT
"The music ends with a flourish">
		<COND (<EQUAL? ,HERE ,BALLROOM>
		       <TELL
" and you pirouette once more before curtseying to Jamison. As you move">)
		      (T
		       <TELL ". As he guides you back">)>
		<TELL " to the side of" ,DANCE-FLOOR ", Nick adds, \"We
should separate -- I'm sure I am being watched. You would be safer
aboard" T ,SHIP ". If you slip out the veranda doors, no one will notice
you leaving.\" He touches " D ,HANDS " and dissolves into the crowd" ,PCR>
		<COND (<NOT <EQUAL? ,HERE ,BALLROOM>>
		       <GOTO ,BALLROOM>)>)
	       (T
		<RFALSE>)>
	 <SETG HERO-CTR <+ ,HERO-CTR 1>>>

<ROUTINE I-HARRESTED ("OPTIONAL" (FROM-LDANCE <>))
	 <SETG HERO-ARRESTED T>
	 <TELL ,INDENT
"There is a commotion from the west. A woman screams and a man yells,
\"Stop, Pirate!\" ">
	 <COND (<AND <NOT .FROM-LDANCE>
		     <NOT <EQUAL? ,HERE ,FOYER>>>
		<COND (<HELD? ,HAT>
		       <FCLEAR ,HAT ,WORNBIT>
		       <MOVE ,HAT ,LIBRARY>)>
		<TELL
"You run to the foyer in time to see two dragoons dragging out
the battered frame of" T ,HERO>)
	       (T
		<TELL
"and Jamison is dragged out of the ballroom by two burly dragoons">)>
	 <TELL ,PCR
"   An officer quiets the guests, \"This is the buccaneer who has been
pirating our ships. He had the audacity to come here tonight intending
to assassinate our dear governor. Do not worry, ladies, he was arrogant
enough to come alone.\" The officer marches after his men. "
CTHE ,DANCERS "s return to their banal conversations" ,PCR>
	 <COND (<NOT .FROM-LDANCE>
		<CRLF>
		<GOTO ,FOYER>)
	       (T
		<QUEUE I-LDANCE 1>
		<SETG PARTNER ,LAFOND>
		<TELL ,INDENT
"Only the painful grip" T ,LAFOND " has on your arm prevents you from
swooning away. \"Ah, so that's the way of it,\" he purrs, noticing your
sudden pallor. \"All the better for me.\" He pulls you unresisting into
a dance." CR>)>>

<GLOBAL MET-ALREADY <>>   ;"gets set by first meeting on land."

<GLOBAL FIRST-SIGHTING "What the devil are you doing here!
Lafond is a dangerous man to play with!\" Jamison ">

<GLOBAL HERO-LEAVES-FOLLY
" With an engaging smile he bows and leaves the folly.|">

<ROUTINE I-HFOLLY ("OPTIONAL" (CALLED-BY-HERO-F <>))
	 <COND (<NOT <EQUAL? ,HERE ,FOLLY>>
		<RFALSE>)
	       (T
		<SETG QUESTIONER ,HERO>
		<COND (<NOT .CALLED-BY-HERO-F>
		       <TELL ,INDENT>)>
		<COND (<EQUAL? ,HERO-CTR 1>
		       <QUEUE I-HFOLLY -1>
		       <MOVE ,HERO ,FOLLY>
		       <TELL D ,HERO
" enters" T ,FOLLY-OBJECT ", stooping to avoid the flowers dangling over
the door. \"I thought I heard someone.">
		       <COND (<NOT ,MET-ALREADY>
			      <SETG MET-ALREADY T>
			      <TELL " " ,FIRST-SIGHTING>)
                             (T
                              <TELL "\" Jamison ">)>
		       <TELL
"sighs. \"What an astonishing girl you are, my dear. ">
		       <COND (<NOT <FSET? ,CHEMISE ,EVERYBIT>>
			      <TELL
"If --\"" ,EYES-RAKE ", \"somewhat underdressed">)
			     (,BOY-DRESS?
			      <TELL "And so ingeniously dressed">)
			     (T
			      <TELL "And looking more lovely than ever">)>
		       <TELL
".\" He plucks" A ,FLOWER " from the tangle above the door, and sets it
in your hair. \"The beauty of this blossom is nothing to yours.\"" CR>
		       <MOVE ,FLOWER ,PROTAGONIST>
		       <FCLEAR ,FLOWER ,NDESCBIT> 
		       <FSET ,FLOWER ,TAKEBIT>)
		      (<AND <OR <EQUAL? ,REACTION ,REACTION-NEGATIVE>
			        <EQUAL? ,HERO-CTR 6>>
			    <IN? ,HERO ,HERE>>
		       <DEQUEUE I-HFOLLY>
		       <SETG QUESTIONER <>>
		       <REMOVE ,HERO>
		       <TELL
"Jamison backs away from you, smiling wistfully">
		       <TELL "." ,HERO-LEAVES-FOLLY>)
		      (<EQUAL? ,HERO-CTR 2>
		       <TELL
"Catching his breath, Jamison pulls you against
him, his hands circling your waist">
		       <COND (<IN? ,FLOWER ,PROTAGONIST>
			      <TELL
", crushing" T ,FLOWER " between you">)>
		       <TELL
". \"Darling,\" he whispers, leaning over you, \"oh, my angel ...\"" CR>)
		      (<EQUAL? ,HERO-CTR 3>
		       <SETG AWAITING-REPLY 15>
		       <QUEUE I-REPLY 2>
		       <TELL
"\"My lovely,\" Jamison says huskily. His eyes burn intently, their blue
like the sea on a summer day. A shiver of warmth flows through you, and
you tremble at his touch. The pirate's hands, warm and exciting, caress
you, searing through the thin linen of your chemise. His lips
near yours, his breath softly scented. \"May I kiss you?\"" CR>
		       ;<COND (,BOY-DRESS?
			      <TELL "inside the loose shirt">)
			     (<OR <FSET? ,GOWN ,WORNBIT>
				  <FSET? ,DRESS ,WORNBIT>>
			      <TELL "into your bodice">)
			     (T
			      <TELL "up">)>)
		      (<EQUAL? ,HERO-CTR 4>
		       <TELL
"Tender is his kiss, soft his lips as his body presses hard against you.
You drown in the tide of your passion, swept like the sea against the rocks
of the shore." CR>)
		      (<EQUAL? ,HERO-CTR 5>
		       <REMOVE ,HERO>
		       ;<SETG QUESTIONER <>>
		       ;<DEQUEUE I-HFOLLY>
		       <TELL
"With a pent-up sigh, Nicholas forces himself away from you. \"Now is not the
time or the place to advance my suit,\" he says, wistfully. \"But the night
is still young and you are so beautiful! I must be gone, lest I lose my soul
in you.\"" ,HERO-LEAVES-FOLLY>)>)>
	 <SETG HERO-CTR <+ ,HERO-CTR 1>>>

;<ROUTINE I-HFOLLY ("OPTIONAL" (CALLED-BY-HERO-F <>))
	 <COND (<NOT <EQUAL? ,HERE ,FOLLY>>
		<RFALSE>)
	       (T
		<SETG QUESTIONER ,HERO>
		<COND (<NOT .CALLED-BY-HERO-F>
		       <TELL ,INDENT>)>
		<COND (<EQUAL? ,HERO-CTR 1>
		       <QUEUE I-HFOLLY -1>
		       <MOVE ,HERO ,FOLLY>
		       <TELL D ,HERO
" enters the folly, stooping to avoid the flowers dangling over the door.
\"I thought I heard someone.">
		       <COND (<NOT ,MET-ALREADY>
			      <SETG MET-ALREADY T>
			      <TELL " "
,FIRST-SIGHTING " Jamison sighs. \"What an astonishing girl you are, my dear.
And ">
			      <COND (,BOY-DRESS?
				    <TELL "rather ingeniously dressed, too">)
				    (<FSET? ,GOWN ,WORNBIT>
				     <TELL "looking more lovely than ever">)
				    (<NOT <FSET? ,CHEMISE ,EVERYBIT>>
				     <TELL
"--\"" ,EYES-RAKE ", \"ahem, somewhat underdressed">)
				    (T
				     <TELL "that is that">)>
			      <TELL ".\" " <PICK-ONE ,MANNERISMS> ,PCR>)
			     (T
			      <MOVE ,FLOWER ,PROTAGONIST>
			      <FCLEAR ,FLOWER ,NDESCBIT> 
			      <FSET ,FLOWER ,TAKEBIT>
			      <TELL
"\" He plucks" A ,FLOWER " from the tangle above the door, and sets it in your
hair. \"The beauty of this " D ,FLOWER " is nothing to yours.\"" CR>)>)
		      (<EQUAL? ,REACTION ,REACTION-NEGATIVE>
		       <TELL
"Jamison backs away from you, smiling wistfully">
		       <COND (<EQUAL? ,HERO-CTR 5>
			      <REMOVE ,HERO>
			      <TELL "." ,HERO-LEAVES-FOLLY>)
			     (T
			      <TELL ,PCR>)>)
		      (<EQUAL? ,HERO-CTR 2>
		       <TELL
"Catching his breath, Jamison pulls you against
him, his hands circling your waist">
		       <COND (<IN? ,FLOWER ,PROTAGONIST>
			      <TELL
", crushing" T ,FLOWER " between you">)>
		       <TELL
". \"Darling,\" he whispers, leaning over you, \"oh, my angel ...\"" CR>)
		      (<EQUAL? ,HERO-CTR 3>
		       <SETG AWAITING-REPLY 15>
		       <QUEUE I-REPLY 2>
		       <TELL
"\"My lovely,\" Jamison says huskily. His eyes burn intently, their blue
like the sea on a summer day. A shiver of warmth flows through you, and
you tremble at his touch. The pirate's hands, warm and exciting, caress
you, searing through the thin linen of your chemise. His lips
near yours, his breath softly scented. \"May I kiss you?\"" CR>
		       ;<COND (,BOY-DRESS?
			      <TELL "inside the loose shirt">)
			     (<OR <FSET? ,GOWN ,WORNBIT>
				  <FSET? ,DRESS ,WORNBIT>>
			      <TELL "into your bodice">)
			     (T
			      <TELL "up">)>)
		      (<EQUAL? ,HERO-CTR 4>
		       <TELL
"Tender is his kiss, soft his lips, yet his body presses hard against you.
You drown in the tide of your passion, swept like the sea against the rocks
of the shore." CR>)
		      (<EQUAL? ,HERO-CTR 5>
		       <REMOVE ,HERO>
		       <SETG QUESTIONER <>>
		       <DEQUEUE I-HFOLLY>
		       <TELL
"With a pent-up sigh, Nicholas forces himself away from you. \"Now is not the
time or the place to advance my suit,\" he says, wistfully. \"But the night
is still young and you are so beautiful! I must be gone, lest I lose my soul
in you.\"" ,HERO-LEAVES-FOLLY>)>)>
	 <SETG HERO-CTR <+ ,HERO-CTR 1>>>

<ROUTINE HERO-TALKS ()
	 <TELL ,INDENT>
	 <COND (<AND <PROB 65>
		     <L? ,WHAT-HERO-SAYS 3>>
		<COND (<AND <EQUAL? ,WHAT-HERO-SAYS 0>
			    ,HDAD-SPEECH>
		       <TELL <PICK-ONE ,MANNERISMS> ,PCR>)
		      (T
		       <TELL <GET ,HERO-SPEECHES ,WHAT-HERO-SAYS> ,PCR>
		       <SETG WHAT-HERO-SAYS <+ ,WHAT-HERO-SAYS 1>>)>)
	       (T
		<TELL <PICK-ONE ,MANNERISMS> ,PCR>)>>

<GLOBAL WHAT-HERO-SAYS 0>

<GLOBAL HERO-SPEECHES
	<TABLE
	 "\"I haven't found your father. We've long suspected a passage
under the library, but I cannot find an entrance,\" says Jamison"
	 "\"If there is any trouble, and I am unable to help -- a signal from
an upstairs seaward window will bring my men. They can be here in moments,\"
the Captain says"
	 "\"I wish you would call me 'Nicholas' -- I feel I know you much
better than our brief acquaintance would allow.\" He presses your hand">>

<GLOBAL MANNERISMS
	<LTABLE
	 0
	 "Jamison touches your hair softly"
	 "Jamison grins down at you, a dazzling white smile"
	 "The blue of the captain's eyes seems to deepen, looking at you"
	 "His eyes twinkle, like moonlight on the sea"
	 "Nicholas's hands are smooth and cool">>

<OBJECT RAPIER
	(IN HERO)
	(DESC "rapier")
	(DESCFCN RAPIER-F)
	(SYNONYM SWORD RAPIER)
	(ADJECTIVE SHARP)
	(FLAGS TRYTAKEBIT TAKEBIT)
	(ACTION RAPIER-F)>

<ROUTINE RAPIER-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? ,HERE ,DUNGEON>
		       <COND (<EQUAL? .OARG ,M-DESC?>
			      <RTRUE>)>
		       <TELL ,INDENT
"A rapier lies in the half-dark of a corner.">)
		      (T
		       <RFALSE>)>)
	       (<VERB? TAKE>
		<COND (<AND <NOT <FSET? ,HERO ,DEADBIT>> 
			    <IN? ,HERO ,HERE>>
		       <TELL
"Jamison prevents you, \"This is not a weapon for ladies.\"" CR>)
		      (<AND <EQUAL? ,HERE ,DUNGEON>
			    <IN? ,CRULLEY ,DUNGEON>
			    <NOT <FSET? ,RAPIER ,TOUCHBIT>>
			    <NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>>
		       <TELL "Taken. "
D ,CRULLEY " snorts, \"Be careful, you might hurt yer dearie.\"" CR>)
		      (<IN? ,RAPIER ,COOKIE>
		       <TELL D ,COOKIE
" objects. \"It ain't fer a lady.\"" CR>)>)
	       (<AND <VERB? THROW PUT PUT-THROUGH>
		     <OR <PRSI? ,TRAP>
			 <AND <PRSI? ,CRULLEY>
			      <FSET? ,CRULLEY ,MUNGBIT>>>>
		<TELL "But you might need it later!" CR>)
	       (<VERB? EXAMINE>
		<TELL
"Jamison's rapier is a dangerous looking sword with a narrow pointed blade">
		<COND (<NOT <EQUAL? ,HERE ,CABIN ,DEUX-DECK>>
		       <TELL ". It is decorated with a big floppy ribbon">)>
		<TELL ,PCR>)>>



