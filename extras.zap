

	.FUNCT	CRULLEY-F,OARG=0,X
	ZERO?	OARG /?CCL3
	EQUAL?	OARG,M-DESC? /TRUE
	PRINT	INDENT
	EQUAL?	HERE,BEACH \?CCL8
	PRINTD	CRULLEY
	PRINTI	" stands"
	GRTR?	LAFOND-CTR,6 \?CCL11
	PRINTI	", pistol ready,"
	PRINT	HALFWAY
	RTRUE	
?CCL11:	PRINTI	" with the dragoons."
	RTRUE	
?CCL8:	EQUAL?	HERE,CABIN \FALSE
	PRINTD	CRULLEY
	PRINTI	" the pirate"
	FSET?	CRULLEY,DEADBIT \?CCL16
	PRINTI	" lies unconscious on the floor."
	RTRUE	
?CCL16:	PRINTI	", hook raised, leering, comes toward you."
	RTRUE	
?CCL3:	EQUAL?	CRULLEY,WINNER \?CCL18
	FSET?	CRULLEY,DEADBIT \?CCL21
	PRINT	DOESNT-RESPOND
	RTRUE	
?CCL21:	EQUAL?	PRSA,V?TELL-ABOUT \?CCL23
	EQUAL?	PRSO,ME \?CCL23
	CALL	NOUN-USED,W?HOOK,CRULLEY
	ZERO?	STACK /?CCL28
	PRINTI	"He snarls at the memory, ""'Twere bit off by a monster crocodile."""
	CRLF	
	JUMP	?CND26
?CCL28:	EQUAL?	PRSI,LAFOND \?CCL30
	PRINTI	"""'E's a hard 'un, who won't take no guff. But 'e pays well"
	FSET?	BEACH,TOUCHBIT /?CND31
	PRINTI	" -- er, so I hear"
?CND31:	PRINTI	"."""
	CRLF	
	JUMP	?CND26
?CCL30:	PRINTD	CRULLEY
	PRINTI	" ignores you"
	PRINT	PCR
?CND26:	CALL	STOP
	RSTACK	
?CCL23:	EQUAL?	PRSA,V?HELLO \?CCL34
	PRINTR	"""Har-har."""
?CCL34:	EQUAL?	PRSA,V?KISS \?CCL36
	EQUAL?	PRSO,ME \?CCL36
	PRINTR	"""Wi' a wannion! I likes me ladies forward!"""
?CCL36:	CALL	COM-CHECK,CRULLEY >X
	ZERO?	X /FALSE
	EQUAL?	X,M-FATAL /FALSE
	RTRUE	
?CCL18:	EQUAL?	PRSA,V?CUT,V?KILL \?CCL45
	FSET?	CRULLEY,DEADBIT \?CCL48
	CALL	MAN-IS-DOWN
	RSTACK	
?CCL48:	ZERO?	PRSI /?CTR49
	EQUAL?	PRSI,HANDS \?CCL50
?CTR49:	EQUAL?	P-PRSA-WORD,W?SLAP \?CCL55
	PRINTI	"Slap! The pirate fingers the red welt left by"
	CALL	TPRINT,HANDS
	PRINTR	", and laughs."
?CCL55:	IN?	COFFER,PROTAGONIST \?CCL57
	ZERO?	PRSI \?CCL57
	CALL	PERFORM,V?KILL,CRULLEY,COFFER
	RTRUE	
?CCL57:	IN?	RAPIER,PROTAGONIST \?CCL61
	ZERO?	PRSI \?CCL61
	CALL	PERFORM,V?KILL,CRULLEY,RAPIER
	RTRUE	
?CCL61:	CALL	CANT-HURT,STR?334
	RSTACK	
?CCL50:	EQUAL?	PRSI,COFFER \?CCL65
	INC	'ATTACK-C
	SET	'CRULLEY-HIT,TRUE-VALUE
	PRINTI	"With all your strength you whack the pirate"
	PRINT	OVER-HEAD
	CALL	TRPRINT,PRSI
	MOVE	PROTAGONIST,HERE
	CALL	DEQUEUE,I-CRULLEY
	CALL	I-CRULLEY
	RSTACK	
?CCL65:	EQUAL?	PRSI,RAPIER \?CCL67
	FSET?	CRULLEY,EVERYBIT \?CCL70
	FSET?	CRULLEY,MUNGBIT \?CCL73
	PRINT	YOU-CANT
	PRINTI	"very well reach"
	CALL	TPRINT,CRULLEY
	PRINTI	" when he's down in"
	CALL	TRPRINT,WELL
	RSTACK	
?CCL73:	CALL	DEQUEUE,I-CDUNG
	INC	'SCORE
	SET	'CRULLEY-CTR,1
	CALL	QUEUE,I-CCLIMBS-UP,2
	FSET	CRULLEY,MUNGBIT
	FSET	CRULLEY,NDESCBIT
	MOVE	CRULLEY,TRAP
	REMOVE	WHIP
	PRINTI	"You flick"
	CALL	TPRINT,RAPIER
	PRINTI	" across his chest, barely scratching him. He cries, ""Avast me! Pricked by a woman!"" and trips into"
	CALL	TRPRINT,TRAP
	PRINT	INDENT
	PRINTI	"You peer down the hole to find "
	PRINTD	CRULLEY
	PRINTI	" hanging in midair, his hook caught in the rocks a few yards down. He curses and starts to climb up the sheer slimy walls of"
	CALL	TRPRINT,WELL
	RSTACK	
?CCL70:	FSET	CRULLEY,EVERYBIT
	PRINTD	CRULLEY
	PRINTI	" seems more amazed than frightened of your attack, guessing correctly that you hardly know the tip from the hilt of"
	CALL	TPRINT,RAPIER
	PRINTI	". He steps sideways in surprise, so he stands at"
	PRINT	THE-EDGE
	CALL	TRPRINT,TRAP
	RSTACK	
?CCL67:	PRINTI	"You slap"
	CALL	TPRINT,CRULLEY
	PRINT	OVER-HEAD
	CALL	TPRINT-PRSI
	PRINTI	", to no effect"
	PRINT	PCR
	RTRUE	
?CCL45:	EQUAL?	PRSA,V?KISS \?CCL75
	SET	'WINNER,CRULLEY
	CALL	PERFORM,V?KISS,ME
	SET	'WINNER,PROTAGONIST
	RTRUE	
?CCL75:	EQUAL?	PRSA,V?KICK \?CCL77
	CALL	CANT-HURT,STR?335
	RSTACK	
?CCL77:	EQUAL?	PRSA,V?PUT-ON,V?PUT,V?THROW /?CTR78
	EQUAL?	PRSA,V?THROW-AT \?CCL79
?CTR78:	FSET?	CRULLEY,MUNGBIT \?CCL84
	EQUAL?	PRSO,RAPIER \?CCL87
	CALL	PERFORM,V?PUT,RAPIER,TRAP
	RTRUE	
?CCL87:	EQUAL?	PRSO,RETICULE /FALSE
	REMOVE	PRSO
	PRINTD	CRULLEY
	PRINTI	" curses as"
	CALL	TPRINT-PRSO
	PRINTI	" sails past him down into"
	CALL	TRPRINT,WELL
	RSTACK	
?CCL84:	EQUAL?	PRSO,COFFER \FALSE
	CALL	PERFORM,V?KILL,CRULLEY,PRSO
	RSTACK	
?CCL79:	EQUAL?	PRSA,V?SEARCH \?CCL93
	FSET?	CRULLEY,DEADBIT \?CCL96
	PRINTR	"And dirty your lily hands? Never!"
?CCL96:	FSET?	CRULLEY,MUNGBIT \?CCL98
	CALL	CANT-REACH,CRULLEY
	RSTACK	
?CCL98:	PRINTR	"You are uncomfortably sure he would love to have you frisk him."
?CCL93:	EQUAL?	PRSA,V?GIVE \?CCL100
	EQUAL?	PRSO,BANKNOTE \?CCL100
	EQUAL?	HERE,BEACH /?CCL100
	PRINTI	"He takes it, smiling blackly"
	PRINT	PCR
	RTRUE	
?CCL100:	EQUAL?	PRSA,V?EXAMINE \FALSE
	CALL	NOUN-USED,W?HOOK,CRULLEY
	ZERO?	STACK /?CCL108
	PRINTR	"The hook replaces one of his hands."
?CCL108:	PRINTI	"The pirate's unsavory face is crisscrossed with scars, and those not from shaving nicks, to judge by his scruffy beard. A hook replaces one of his hands at the end of a torn black sleeve"
	PRINT	PCR
	RTRUE	


	.FUNCT	I-CRULLEY
	PRINT	INDENT
	ZERO?	ATTACK-C \?CCL3
	FSET?	CRULLEY,TOUCHBIT /?CCL3
	CALL	QUEUE,I-MEET-HERO,2
	FSET	CRULLEY,TOUCHBIT
	MOVE	CRULLEY,CABIN
	CALL	QUEUE,I-CRULLEY,-1
	FSET	DOOR,MUNGBIT
	PRINTI	"Crash! You whirl around to see"
	CALL	TPRINT,DOOR
	PRINTI	" shatter, kicked by a hulking man, his twisted visage blackened with soot and blood. "
	JUMP	?CND1
?CCL3:	EQUAL?	ATTACK-C,1 \?CND1
	PRINTI	"The pirate stumbles, dizzy. "
?CND1:	EQUAL?	ATTACK-C,2 \?CCL9
	FSET	CRULLEY,DEADBIT
	PRINT	STUNNED-THE-SAILOR
	PRINT	PCR
	JUMP	?CND7
?CCL9:	CALL	CRULLEY-SAYS
?CND7:	INC	'CRULLEY-CTR
	RETURN	CRULLEY-CTR


	.FUNCT	CRULLEY-SAYS
	PRINTC	34
	GET	MENACES,CRULLEY-CTR
	PRINT	STACK
	PRINTI	","" "
	EQUAL?	ATTACK-C,1 \?CCL3
	PRINTI	"slurs"
	JUMP	?CND1
?CCL3:	PRINTI	"sniggers"
?CND1:	PRINTI	" the pirate"
	EQUAL?	CRULLEY-CTR,1 \?CCL6
	PRINTI	". His breath is heavy with rum"
	JUMP	?CND4
?CCL6:	RANDOM	100
	LESS?	60,STACK /?CND4
	PRINTI	", advancing toward you"
?CND4:	PRINT	PCR
	RTRUE	


	.FUNCT	I-OVERHEAR-CRULLEY
	EQUAL?	HERE,CREWS-QUARTERS \FALSE
	SET	'HEARD-CRULLEY,TRUE-VALUE
	FSET	ANCHOR,MUNGBIT
	FSET	LEVER,MUNGBIT
	CALL	QUEUE,I-SEE-CRULLEY-ESCAPE,20
	CALL	QUEUE,I-LOOK-SEA,10
	PRINT	INDENT
	PRINTI	"""I gotta let"
	CALL	TPRINT,LAFOND
	PRINTI	" know 'e's comin'."""
	CALL	TPRINT,CRULLEY
	PRINTI	" stands on deck above, talking to himself, his voice floating down through"
	CALL	APRINT,GRATE
	PRINTI	" in"
	CALL	TPRINT,CEILING
	PRINTI	". ""First, I do in the mates aboard-ship, with this and t'other mischief,"" he grunts, and you hear a snapping noise, like a taut rope being cut. ""Now to warn the boss and collect me pay. Off I go, har."" He dives into"
	CALL	TRPRINT,SEA
	RSTACK	


	.FUNCT	I-SEE-CRULLEY-ESCAPE
	CALL	SHIP-BOARD,HERE
	ZERO?	STACK /?CCL3
	CALL	INNER-DECK,HERE
	ZERO?	STACK \?CCL3
	PRINT	INDENT
	PRINTI	"Your eyes are drawn to a flicker of light off the sea. Squinting, you see a man swimming to shore, moonlight flashing off his hook."
	EQUAL?	HERE,POOP,QUARTERDECK,MAIN-DECK /?CCL7
	EQUAL?	HERE,FOCSLE \?CND6
?CCL7:	PRINTR	" A wisp of breeze brings an odor of onions and rum, and the occasional gargling chuckle, ""...mischief, har...reefs."""
?CND6:	CRLF	
	RTRUE	
?CCL3:	CALL	QUEUE,I-SEE-CRULLEY-ESCAPE,3
	RSTACK	


	.FUNCT	I-CDUNG
	LESS?	CRULLEY-CTR,7 \?CCL3
	PRINT	INDENT
	PRINTD	CRULLEY
	EQUAL?	CRULLEY-CTR,1 \?CND4
	PRINTI	" steps leering out of the shadows and"
?CND4:	PRINTI	" cracks"
	CALL	TPRINT,WHIP
	PRINTI	" near you, hopping you towards the open "
	PRINTD	TRAP
	PRINTI	". """
	ZERO?	CRULLEY-HIT /?CCL8
	EQUAL?	CRULLEY-CTR,1 \?CCL8
	CALL	QUEUE,I-REPLY,2
	SET	'AWAITING-REPLY,17
	PRINTI	"Come to hit me agin, are ye?"
	JUMP	?CND6
?CCL8:	SET	'AWAITING-REPLY,2
	CALL	QUEUE,I-REPLY,2
	CALL	PICK-ONE,ABUSES
	PRINT	STACK
?CND6:	PRINTC	34
	CRLF	
	JUMP	?CND1
?CCL3:	PRINT	INDENT
	PRINTD	CRULLEY
	PRINTI	" snaps"
	CALL	TPRINT,WHIP
	PRINTI	" around your neck, jerking you sideways and down through"
	CALL	TPRINT,TRAP
	PRINTC	46
	CALL	JIGS-UP,FALL-TO-BOTTOM
?CND1:	INC	'CRULLEY-CTR
	RETURN	CRULLEY-CTR


	.FUNCT	I-CCLIMBS-UP
	CALL	QUEUE,I-CCLIMBS-UP,-1
	INC	'CRULLEY-CTR
	EQUAL?	CRULLEY-CTR,10 \?CCL3
	SET	'CRULLEY-BACK,TRUE-VALUE
	FCLEAR	CRULLEY,NDESCBIT
	CALL	DEQUEUE,I-CCLIMBS-UP
	EQUAL?	HERE,DUNGEON /?CCL6
	FCLEAR	CRULLEY,MUNGBIT
	MOVE	CRULLEY,DUNGEON
	RFALSE	
?CCL6:	FSET?	TRAP,OPENBIT /?CCL8
	PRINT	INDENT
	PRINTI	"Roaring with anger,"
	CALL	TPRINT,CRULLEY
	PRINTI	" slaps"
	CALL	TPRINT,TRAP
	PRINTI	" back on its hinges and"
	JUMP	?CND4
?CCL8:	PRINT	INDENT
	PRINTD	CRULLEY
?CND4:	PRINTI	" leaps out of"
	CALL	TPRINT,WELL
	PRINTI	", seizing you."
	CALL	JIGS-UP,FALL-TO-BOTTOM
	RSTACK	
?CCL3:	RANDOM	100
	LESS?	50,STACK /FALSE
	EQUAL?	HERE,DUNGEON \FALSE
	PRINT	INDENT
	PRINTI	"Sounds of scraping hook against stone and curses echo out of"
	CALL	TPRINT,WELL
	FSET?	TRAP,OPENBIT /?CND13
	PRINTI	", muffled by"
	CALL	TPRINT,TRAP
?CND13:	PRINT	PCR
	RTRUE	


	.FUNCT	WHIP-F
	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTD	CRULLEY
	PRINTI	" snaps"
	CALL	TPRINT,WHIP
	PRINTR	" near you. ""Get away wit' ye."""


	.FUNCT	DAVIS-F
	EQUAL?	PRSA,V?MUNG,V?KICK,V?KILL /?CTR2
	EQUAL?	PRSA,V?KISS \?CCL3
?CTR2:	PRINTD	DAVIS
	PRINTR	" dodges."
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL7
	PRINTD	DAVIS
	PRINTR	" is ugly with fear."
?CCL7:	EQUAL?	DAVIS,WINNER \FALSE
	CALL	FAILS-TO-NOTICE
	RSTACK	


	.FUNCT	COOKIE-F,OARG=0,X
	ZERO?	OARG /?CCL3
	EQUAL?	OARG,M-DESC? /TRUE
	PRINT	INDENT
	EQUAL?	HERE,GALLEY \?CCL8
	PRINTI	"An entirely bald man sits here, carving into his peg leg"
	JUMP	?CND6
?CCL8:	ZERO?	COOKIE-FIGHTING-CROC /?CCL10
	PRINTI	"The pool is roily with the writhing bodies of"
	CALL	TPRINT,COOKIE
	PRINTI	" and"
	CALL	TPRINT,CROC
	JUMP	?CND6
?CCL10:	CALL	QUEUED?,I-ENDGAME
	ZERO?	STACK /?CCL12
	EQUAL?	HERE,BEACH \?CCL12
	FSET?	COOKIE,DEADBIT \?CCL17
	PRINTI	"Lucy cleans the sand from Quick's quiescent face, as Papa "
	FSET?	LAFOND,DEADBIT \?CCL20
	PRINTI	"sneaks up the cliff stairs"
	JUMP	?CND6
?CCL20:	PRINTI	"stands nearby"
	IN?	GARTER,DAD \?CND6
	PRINTI	", holding"
	CALL	TPRINT,GARTER
	JUMP	?CND6
?CCL17:	PRINTD	COOKIE
	PRINTI	", Lucy and your father are moving towards"
	CALL	TPRINT,SKIFF
	JUMP	?CND6
?CCL12:	PRINTD	COOKIE
	PRINTI	" chews anxiously at a cheroot"
?CND6:	PRINTC	46
	RTRUE	
?CCL3:	EQUAL?	COOKIE,WINNER \?CCL24
	FSET?	COOKIE,DEADBIT \?CCL27
	PRINT	DOESNT-RESPOND
	RTRUE	
?CCL27:	EQUAL?	PRSA,V?READ \?CCL29
	PRINTR	"""I can't read! I'm a cook, not a gentleman!"""
?CCL29:	EQUAL?	PRSA,V?HELLO \?CCL31
	PRINTI	"""Hullo -- boy!"" He winks at you"
	PRINT	PCR
	RTRUE	
?CCL31:	EQUAL?	PRSA,V?SAVE-SOMETHING,V?HELP \?CCL33
	EQUAL?	HERE,GALLEY \?CCL36
	PRINTI	"""Eh? Don't be panicking. We'll be fine."" He carves a smile into his leg"
	PRINT	PCR
	RTRUE	
?CCL36:	PRINTD	COOKIE
	PRINTR	" grumbles, ""What d'ye think I'm trying to do!"""
?CCL33:	EQUAL?	PRSA,V?FIX \?CCL38
	EQUAL?	PRSO,DAGGER \?CCL38
	PRINTR	"""I never was able to sharpen that dagger."""
?CCL38:	EQUAL?	PRSA,V?TELL-ABOUT \?CCL42
	EQUAL?	PRSO,ME \?CCL42
	EQUAL?	PRSI,HERO \?CCL47
	IN?	HERO,MANACLES \?CCL50
	PRINTI	"""I'm tryin' to find him!"""
	CRLF	
	JUMP	?CND45
?CCL50:	PRINTI	"""The Cap'n? I been with him since the war. Then came Lafond."""
	CRLF	
	JUMP	?CND45
?CCL47:	EQUAL?	PRSI,COOKIE \?CCL52
	PRINTI	"""'Rodney Quick's me name, cookin's me game.
Lost me leg in sixty-eight, 'tis why I bake.
Losin' me hearin' in every fight, but I've got me sight --
And come our Good Lord's 1701, I'll lose me life to a ruffian's gun.'
-- Old dame told me that. Leastways, I've several years left."""
	CRLF	
	JUMP	?CND45
?CCL52:	EQUAL?	PRSI,LAFOND \?CCL54
	PRINTI	"""He murdered Cap'n's brother and family these three year'n past. Cap'n's been searching for a time to avenge the dead ones, and now he's found it."""
	CRLF	
	JUMP	?CND45
?CCL54:	EQUAL?	PRSI,CRULLEY \?CCL56
	PRINTI	"""Don't trust 'im. Never 'ave."""
	CRLF	
	JUMP	?CND45
?CCL56:	PRINTD	COOKIE
	PRINTI	" cocks an ear, ""Eh, what's that?"""
	CRLF	
?CND45:	CALL	STOP
	RSTACK	
?CCL42:	EQUAL?	PRSA,V?GIVE \?CCL58
	EQUAL?	PRSO,ME \?CCL58
	IN?	RAPIER,COOKIE \?CCL58
	CALL	PERFORM,V?TAKE,RAPIER
	RTRUE	
?CCL58:	EQUAL?	PRSA,V?FOLLOW \?CCL63
	EQUAL?	PRSO,ME \?CCL63
	PRINTI	"""Foller you?"
	EQUAL?	HERE,GALLEY /?CND66
	PRINTI	" Anywheres"
?CND66:	PRINTR	"!"""
?CCL63:	EQUAL?	PRSA,V?TAKE \?CCL69
	EQUAL?	PRSO,PAIR \?CCL69
	EQUAL?	HERE,X-ROOM \?CCL69
	PRINTR	"""No, lass. A lady don't use guns, and I've no need for one."""
?CCL69:	CALL	COM-CHECK,COOKIE >X
	ZERO?	X /FALSE
	EQUAL?	X,M-FATAL /FALSE
	RTRUE	
?CCL24:	EQUAL?	PRSA,V?EXAMINE \?CCL79
	PRINTD	COOKIE
	PRINTR	" is a grizzled old man with a peg-leg."
?CCL79:	EQUAL?	PRSA,V?TELL-ABOUT \?CCL81
	CALL	NOUN-USED,W?GUNPOW,SUPPLIES
	ZERO?	STACK /?CCL84
	PRINTR	"""Clam chowder? Never make it -- too fancy."""
?CCL84:	EQUAL?	PRSI,REEFS \?CCL86
	PRINTR	"""We dropped the sea anchor -- no need to fear."""
?CCL86:	EQUAL?	PRSI,SUPPLIES \?CCL88
	PRINTR	"""Aye, you must mean the supplies in the hold. Yep, that's where we store them."""
?CCL88:	EQUAL?	PRSI,FIRE,HOLD \?CCL90
	PRINTR	"""Fire for the cold? I think it be too warm..."""
?CCL90:	EQUAL?	PRSI,FUSE \?CCL92
	PRINTR	"""Lose sommat? I be always losing things. Think there be thieves aboard."""
?CCL92:	EQUAL?	PRSI,HERO \FALSE
	ZERO?	COOKIE-FIGHTING-CROC /?CCL97
	CALL	FAILS-TO-NOTICE
	RSTACK	
?CCL97:	CALL	HELD?,HERO,DUNGEON
	ZERO?	STACK /?CCL99
	PRINTI	"""Well, show me, lass!"" he grumbles"
	PRINT	PCR
	RTRUE	
?CCL99:	PRINTI	"""He's a fine man, is Cap'n,"" he smiles"
	PRINT	PCR
	RTRUE	
?CCL81:	EQUAL?	PRSA,V?KISS \?CCL101
	PRINTR	"""Nah, me pretty, ye belong to Cap'n."""
?CCL101:	EQUAL?	PRSA,V?GIVE \?CCL103
	EQUAL?	PRSO,BANKNOTE \?CCL103
	PRINTI	"""I hain't no need fer that kind of money,"" he waves away your offer"
	PRINT	PCR
	RTRUE	
?CCL103:	EQUAL?	PRSA,V?CUT,V?MUNG,V?KILL \FALSE
	FSET?	COOKIE,DEADBIT \?CCL110
	CALL	MAN-IS-DOWN
	RSTACK	
?CCL110:	PRINTR	"He holds you off, ""'Ere now, there's no call for that!"""


	.FUNCT	I-COOKIE,FIRST-MOVE=0
	ZERO?	FIRST-MOVE /?CCL3
	SET	'COOKIE-LOOKING,FALSE-VALUE
	SET	'QUESTIONER,COOKIE
	SET	'AWAITING-REPLY,10
	CALL	QUEUE,I-REPLY,2
	ZERO?	CLOCK-WAIT /?CCL6
	PUSH	1
	JUMP	?CND4
?CCL6:	PUSH	2
?CND4:	CALL	QUEUE,I-COOKIE,STACK
	MOVE	COOKIE,HERE
	FSET	COOKIE,MUNGBIT
	SET	'CRULLEY-CTR,0
	PRINT	INDENT
	PRINTD	COOKIE
	PRINTI	" rushes up to you, looking worried. ""Miss, we must find the Cap'n. Have ye any idea where to look?"""
	CRLF	
	JUMP	?CND1
?CCL3:	IN?	COOKIE,HERE /?CCL8
	CALL	DEQUEUE,I-COOKIE
	JUMP	?CND1
?CCL8:	EQUAL?	REACTION,REACTION-POSITIVE /?CTR9
	EQUAL?	PRSA,V?WALK \?CCL10
?CTR9:	PRINT	INDENT
	PRINTD	COOKIE
	PRINTI	" grins broadly, ""I knew we could depend on you, lass. Lead on!"""
	CRLF	
	JUMP	?CND1
?CCL10:	EQUAL?	CRULLEY-CTR,2 \?CCL14
	MOVE	COOKIE,LIBRARY
	EQUAL?	REACTION,REACTION-NEGATIVE \?CCL17
	PRINT	INDENT
	PRINTI	"""Hell and damnation, I was afraid of that"
	JUMP	?CND15
?CCL17:	PRINT	INDENT
	PRINTI	"He harrumphs. ""So ye do not care fer him after all"
?CND15:	PRINTI	"!"" "
	PRINTD	COOKIE
	PRINTI	" orders the men to search, moving off himself.
"
	JUMP	?CND1
?CCL14:	SET	'QUESTIONER,COOKIE
	SET	'AWAITING-REPLY,10
	CALL	QUEUE,I-REPLY,2
	CALL	QUEUE,I-COOKIE,1
	PRINT	INDENT
	PRINTD	COOKIE
	PRINTI	" urges you, ""Think agin. Any idea?"""
	CRLF	
?CND1:	INC	'CRULLEY-CTR
	RETURN	CRULLEY-CTR


	.FUNCT	CREW-F
	EQUAL?	CREW,WINNER \?CCL3
	EQUAL?	PRSA,V?HELLO \?CCL6
	PRINTI	"He grins at you toothlessly"
	PRINT	PCR
	JUMP	?CND4
?CCL6:	ZERO?	ENDGAME /?CCL8
	EQUAL?	PRSA,V?FIND,V?WHERE \?CCL8
	EQUAL?	PRSO,HERO,COOKIE \?CCL8
	CALL	PERFORM,V?TELL-ABOUT,ME,PRSO
	RTRUE	
?CCL8:	EQUAL?	PRSA,V?TELL-ABOUT \?CCL13
	EQUAL?	PRSO,ME \?CCL13
	ZERO?	ENDGAME /?CCL18
	EQUAL?	PRSI,HERO,COOKIE \?CCL18
	EQUAL?	PRSI,COOKIE \?CCL23
	PRINTI	"""'E went"
	JUMP	?CND21
?CCL23:	PRINTI	"""Cookie be"
?CND21:	PRINTI	" a-lookin' for Cap'n."""
	CRLF	
	JUMP	?CND4
?CCL18:	EQUAL?	PRSI,LAFOND \?CCL25
	PRINTI	"""'E be an evil man, I do hear."""
	CRLF	
	JUMP	?CND4
?CCL25:	CALL	FAILS-TO-NOTICE
	JUMP	?CND4
?CCL13:	PRINTI	"""I'm busy. Do it yerself, boy."" He cuffs you aside."
	CRLF	
?CND4:	CALL	STOP
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTD	HERO
	PRINTI	"'s crew are a ragged, toothless bunch, all sporting jagged scars. Despite their abhorrent appearances, they call friendlily to each other"
	PRINT	PCR
	RTRUE	


	.FUNCT	LUCY-F,OARG=0
	ZERO?	OARG /?CCL3
	EQUAL?	OARG,M-DESC? /TRUE
	EQUAL?	HERE,KITCHEN \FALSE
	PRINT	INDENT
	FSET?	LUCY,TOUCHBIT \?CCL11
	PRINTD	LUCY
	JUMP	?CND9
?CCL11:	PRINTI	"A blond woman"
?CND9:	CALL	RUNNING?,I-LUCY
	ZERO?	STACK /?CCL14
	PRINTI	" stands talking to you"
	JUMP	?CND12
?CCL14:	PRINTI	" huddles alone by the fire, as if cold"
?CND12:	PRINTC	46
	RTRUE	
?CCL3:	EQUAL?	LUCY,WINNER \?CCL16
	EQUAL?	PRSA,V?TELL-ABOUT \?CCL19
	EQUAL?	PRSO,ME \?CCL19
	CALL	NOUN-USED,W?LIBRARY,HOUSE
	ZERO?	STACK /?CCL24
	PRINTI	"""I ain't allowed in that wing of"
	CALL	TRPRINT,HOUSE
	JUMP	?CND22
?CCL24:	EQUAL?	PRSI,LAFOND \?CCL26
	PRINTI	"""He's a regular lout who don't like my cooking."""
	CRLF	
	JUMP	?CND22
?CCL26:	CALL	FAILS-TO-NOTICE
?CND22:	CALL	STOP
	RSTACK	
?CCL19:	EQUAL?	PRSA,V?HELLO \?CCL28
	PRINTI	"She smiles"
	PRINT	PCR
	RTRUE	
?CCL28:	EQUAL?	PRSA,V?KISS \?CCL30
	EQUAL?	PRSO,ME \?CCL30
	PRINTR	"""I hardly know you!"" she gasps."
?CCL30:	CALL	COM-CHECK,LUCY >OARG
	ZERO?	OARG /FALSE
	EQUAL?	OARG,M-FATAL /FALSE
	RTRUE	
?CCL16:	EQUAL?	PRSA,V?TELL-ABOUT \?CCL39
	EQUAL?	PRSI,DAD \?CCL39
	FSET?	DAD,TOUCHBIT \?CCL44
	PRINTR	"""Yes, he told me."""
?CCL44:	SET	'AWAITING-REPLY,2
	CALL	QUEUE,I-REPLY,2
	PRINTR	"She yelps, ""Dear Dimsy, how can I save him?"""
?CCL39:	EQUAL?	PRSA,V?GIVE \?CCL46
	EQUAL?	PRSO,GARTER \?CCL49
	FSET?	GARTER,INVISIBLE /?CCL49
	PRINTD	LUCY
	PRINTR	" frowns. ""No, you silly boy! Give that to Dimsford!"""
?CCL49:	EQUAL?	PRSO,BANKNOTE \FALSE
	PRINTD	LUCY
	PRINTR	" slaps you hard across the face. ""I'm not that sort of girl!"""
?CCL46:	EQUAL?	PRSA,V?LISTEN \?CCL55
	CALL	RUNNING?,I-LUCY
	ZERO?	STACK /?CCL58
	PRINTR	"You are listening to her!"
?CCL58:	PRINTI	"She talks a lot, but doesn't say much"
	PRINT	PCR
	RTRUE	
?CCL55:	EQUAL?	PRSA,V?ASK-FOR \?CCL60
	EQUAL?	PRSI,GARTER \?CCL60
	CALL	PERFORM,V?TAKE,GARTER
	RTRUE	
?CCL60:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"Lucy is a very pretty woman, a few years your senior, her yellow hair neatly arranged. She wears a cook's apron"
	PRINT	PCR
	RTRUE	


	.FUNCT	I-LUCY
	FCLEAR	GARTER,INVISIBLE
	CALL	THIS-IS-IT,GARTER
	PRINT	INDENT
	PRINTI	"""I haven't found Lafond's papers, I'm watched too closely. Tell Dimsford that I -- I'm scared, and I want him to come get me. Give this to him -- he'll recognize it."" Lucy slides"
	CALL	APRINT,GARTER
	PRINTI	" down her leg and holds it out to you"
	PRINT	PCR
	RTRUE	


	.FUNCT	I-CATCH-KISS
	FCLEAR	FOREST,EVERYBIT
	RTRUE	


	.FUNCT	BUTLER-F,OARG=0,CONTENTS=0
	ZERO?	OARG /?CCL3
	EQUAL?	OARG,M-DESC? /TRUE
	PRINT	INDENT
	CALL	CTPRINT,BUTLER
	FSET?	BUTLER,DEADBIT /?CCL8
	PRINTI	" stands near the entrance to "
	EQUAL?	HERE,FOYER \?CCL11
	PRINTI	"the ballroom"
	JUMP	?CND6
?CCL11:	PRINTI	"the hallway"
	JUMP	?CND6
?CCL8:	PRINTI	" lies on the floor, prone and snoring loudly"
?CND6:	PRINTC	46
	RTRUE	
?CCL3:	EQUAL?	BUTLER,WINNER \?CCL13
	FSET?	BUTLER,DEADBIT \?CCL16
	PRINT	DOESNT-RESPOND
	RTRUE	
?CCL16:	EQUAL?	PRSA,V?HELLO \?CCL18
	PRINTI	"He bows"
	PRINT	PCR
	RTRUE	
?CCL18:	EQUAL?	PRSA,V?TAKE \?CCL20
	EQUAL?	PRSO,BLUE-GLASS,BANKNOTE,INVITE /?CTR19
	EQUAL?	PRSO,GREEN-GLASS \?CCL20
?CTR19:	SET	'WINNER,PROTAGONIST
	CALL	PERFORM,V?GIVE,PRSO,BUTLER
	SET	'WINNER,BUTLER
	RTRUE	
?CCL20:	EQUAL?	PRSA,V?TELL-ABOUT \?CCL26
	EQUAL?	PRSO,ME \?CCL26
	EQUAL?	PRSI,LAFOND \?CCL26
	CALL	QUEUED?,I-SUMMONS
	ZERO?	STACK \?CTR31
	FSET?	LDOOR,LOCKEDBIT /?CCL32
?CTR31:	EQUAL?	HERE,LAFS-ROOM \?CCL37
	PRINTR	"""He's gone for water, Miss."""
?CCL37:	PRINTI	"""He's awaiting you now, Miss. In his room."""
	CRLF	
	MOVE	LAFOND,LAFS-ROOM
	RTRUE	
?CCL32:	EQUAL?	DANCED-WITH,LAFOND \?CCL39
	PRINTR	"""He has retired to his room, and requests not to be disturbed."""
?CCL39:	PRINTR	"""The governor is in the ballroom, Miss."""
?CCL26:	CALL	COM-CHECK,BUTLER >OARG
	ZERO?	OARG /FALSE
	EQUAL?	OARG,M-FATAL /FALSE
	RTRUE	
?CCL13:	EQUAL?	PRSA,V?EXAMINE \?CCL46
	CALL	CTPRINT,BUTLER
	PRINTI	", scarred and burly, looks uncomfortable in his formal blacks, as if he'd prefer the rags of a pirate"
	FSET?	BUTLER,DEADBIT \?CND47
	PRINTI	". He lies snoring on the floor"
?CND47:	PRINT	PCR
	RTRUE	
?CCL46:	FSET?	BUTLER,DEADBIT \?CCL50
	EQUAL?	PRSA,V?SEARCH \?CCL53
	PRINT	NOTHING-NEW
	RTRUE	
?CCL53:	EQUAL?	PRSA,V?HELLO,V?ASK-ABOUT,V?TELL /FALSE
	PRINT	DOESNT-RESPOND
	RTRUE	
?CCL50:	EQUAL?	PRSA,V?SHOW,V?GIVE \?CCL57
	EQUAL?	PRSO,BANKNOTE,INVITE \?CCL60
	CALL	BRIBE-BUTLER,PRSO
	RSTACK	
?CCL60:	EQUAL?	PRSO,GREEN-GLASS,BLUE-GLASS \FALSE
	PRINTI	"He looks pleased"
	GETP	PRSO,P?CONTENTS
	EQUAL?	STACK,0,POISONED \?CCL65
	PRINTR	", then disappointed. ""There's no wine in that glass, Ma'am."""
?CCL65:	GETP	PRSO,P?CONTENTS
	EQUAL?	STACK,W-P \?CND63
	SET	'DRUGGEE,BUTLER
	CALL	QUEUE,I-WATCH-SLEEP,2
?CND63:	MOVE	PRSO,BUTLER
	PUTP	PRSO,P?CONTENTS,0
	PRINTI	". ""I am rather parched, Ma'am,"" he says, taking and emptying"
	CALL	TRPRINT,PRSO
	RSTACK	
?CCL57:	EQUAL?	P-PRSA-WORD,W?TIP \FALSE
	CALL	HELD?,BANKNOTE
	ZERO?	STACK /?CCL71
	CALL	BRIBE-BUTLER,BANKNOTE
	RSTACK	
?CCL71:	PRINTR	"You have nothing to do that with."


	.FUNCT	I-BUTLER,CALLED-BY-BUTLER-F=0
	INC	'BUTLER-CTR
	ZERO?	CALLED-BY-BUTLER-F /?CCL3
	CALL	QUEUE,I-BUTLER,2
	JUMP	?CND1
?CCL3:	CALL	QUEUE,I-BUTLER,-1
?CND1:	EQUAL?	HERE,FOYER /?CCL6
	SET	'AWAITING-FAKE-ORPHAN,FALSE-VALUE
	CALL	DEQUEUE,I-BUTLER
	RFALSE	
?CCL6:	FSET?	GOWN,WORNBIT \FALSE
	ZERO?	CALLED-BY-BUTLER-F \?CND8
	PRINT	INDENT
	PRINTC	34
?CND8:	EQUAL?	BUTLER-CTR,3 \?CCL13
	CALL	DEQUEUE,I-BUTLER
	FSET	BUTLER,MUNGBIT
	PRINT	YOULL-HAVE-TO
	PRINTI	"hope to be invited to the next party,"" smirks"
	CALL	TPRINT,BUTLER
	PRINT	PUSHING-YOU-OUT
	CRLF	
	CALL	GOTO,MAIN-ENTRANCE
	RSTACK	
?CCL13:	PRINTI	"Your invitation, Miss?"" says"
	CALL	TPRINT,BUTLER
	EQUAL?	BUTLER-CTR,4 \?CCL16
	PRINTI	" snapping his fingers"
	JUMP	?CND14
?CCL16:	PRINTI	" bowing"
?CND14:	PRINT	PCR
	RTRUE	


	.FUNCT	BRIBE-BUTLER,GRAFT
	MOVE	GRAFT,BUTLER
	FSET?	BUTLER,INDOORSBIT \?CCL3
	PRINTI	"He takes"
	CALL	TPRINT,GRAFT
	PRINTI	" and bows. ""Thank you, Miss"
	EQUAL?	GRAFT,INVITE \?CND4
	PRINTI	" Davis"
?CND4:	PRINTR	"."""
?CCL3:	FSET	BUTLER,INDOORSBIT
	FCLEAR	BUTLER,MUNGBIT
	CALL	DEQUEUE,I-BUTLER
	INC	'SCORE
	CALL	CTPRINT,BUTLER
	PRINTI	" takes"
	CALL	TPRINT,GRAFT
	EQUAL?	GRAFT,BANKNOTE \?CND6
	PRINTI	" and secrets it away"
?CND6:	PRINTI	". ""Enjoy the dance, Miss"
	EQUAL?	GRAFT,INVITE \?CND8
	PRINTI	" Davis"
?CND8:	PRINTR	"."""


	.FUNCT	DANCERS-F
	EQUAL?	DANCERS,WINNER \?CCL3
	ZERO?	ENDGAME /?CCL6
	CALL	CTPRINT,DANCERS
	PRINTR	" looks away, terrified."
?CCL6:	EQUAL?	PRSA,V?HELLO \?CCL8
	PRINTI	"A dancer smiles nervously and looks away"
	PRINT	PCR
	RTRUE	
?CCL8:	EQUAL?	PRSA,V?TELL-ABOUT \FALSE
	EQUAL?	PRSO,ME \FALSE
	EQUAL?	PRSI,LAFOND \?CCL15
	PRINTI	"""He's such a good host! I've never been to such a fine party! I'm so glad he is our governor."" You have never seen anyone so nervous before"
	PRINT	PCR
	JUMP	?CND13
?CCL15:	PRINTI	"Nobody seems inclined to chat with you"
	PRINT	PCR
?CND13:	CALL	STOP
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?DANCE /?CTR16
	EQUAL?	PRSA,V?ASK-FOR \?CCL17
	EQUAL?	PRSI,BALLROOM \?CCL17
?CTR16:	PRINTR	"A man regretfully shakes his head. ""We haven't been introduced by the governor."""
?CCL17:	EQUAL?	PRSA,V?ASK-FOR \?CCL23
	EQUAL?	PRSI,BALLROOM \?CCL23
	CALL	PERFORM,V?DANCE,DANCERS
	RTRUE	
?CCL23:	EQUAL?	PRSA,V?EXAMINE \FALSE
	CALL	CTPRINT,DANCERS
	PRINTI	"s are dressed in powdered wigs and heavy jewels. All seem paler than fashion and the tropics would decree, and rather nervous"
	PRINT	PCR
	RTRUE	


	.FUNCT	DAD-F,OARG=0
	ZERO?	OARG /?CCL3
	EQUAL?	OARG,M-DESC? /TRUE
	PRINT	INDENT
	PRINTI	"Your father calmly stands nearby."
	RTRUE	
?CCL3:	EQUAL?	DAD,WINNER \?CCL7
	EQUAL?	PRSA,V?TELL-ABOUT \?CCL10
	EQUAL?	PRSO,ME \?CCL10
	EQUAL?	PRSI,GARTER \?CCL15
	PRINTI	"""That belongs to -- a friend."""
	CRLF	
	JUMP	?CND13
?CCL15:	PRINTI	"""My dear,"" he says rather impatiently, ""There are people waiting for our help -- I haven't time to answer your questions just now."""
	CRLF	
?CND13:	CALL	STOP
	RSTACK	
?CCL10:	EQUAL?	PRSA,V?I-LOVE-YOU \?CCL17
	EQUAL?	PRSI,EYES \?CCL20
	PRINT	DAD-KISS
	RTRUE	
?CCL20:	EQUAL?	PRSI,HERO \?CCL22
	PRINTR	"""I hoped you would,"" he smiles."
?CCL22:	EQUAL?	PRSI,LAFOND \?CCL24
	PRINTR	"""My poor doomed daughter!"""
?CCL24:	CALL	FAILS-TO-NOTICE
	RSTACK	
?CCL17:	EQUAL?	PRSA,V?FOLLOW \?CCL26
	EQUAL?	PRSO,ME \?CCL26
	PRINTR	"""Lead on, daughter!"""
?CCL26:	EQUAL?	PRSA,V?HELLO \?CCL30
	PRINT	DAD-KISS
	RTRUE	
?CCL30:	CALL	COM-CHECK,DAD >OARG
	ZERO?	OARG /FALSE
	EQUAL?	OARG,M-FATAL /FALSE
	RTRUE	
?CCL7:	EQUAL?	PRSA,V?ASK-FOR \?CCL37
	EQUAL?	PRSI,GARTER \?CCL37
	CALL	PERFORM,V?TAKE,GARTER
	RTRUE	
?CCL37:	EQUAL?	PRSA,V?TELL-ABOUT \?CCL41
	EQUAL?	PRSI,LUCY \?CCL44
	PRINTR	"He listens intently, and laughs, ""What a delightful girl she is, to be sure!"""
?CCL44:	EQUAL?	PRSI,HERO \FALSE
	CALL	RUNNING?,I-DAD
	ZERO?	STACK /?CCL49
	CALL	DEQUEUE,I-DAD
	CALL	I-DAD,TRUE-VALUE
	RSTACK	
?CCL49:	SET	'AWAITING-REPLY,16
	CALL	QUEUE,I-REPLY,2
	PRINTI	"""So you like him?"" he asks, smiling"
	PRINT	PCR
	RTRUE	
?CCL41:	EQUAL?	PRSA,V?SHOW,V?GIVE \?CCL51
	EQUAL?	PRSO,BANKNOTE \?CCL54
	REMOVE	BANKNOTE
	PRINTI	"""Do not stain yourself with that dirty money,"" he takes"
	CALL	TPRINT,BANKNOTE
	PRINTI	" and rips it up"
	PRINT	PCR
	RTRUE	
?CCL54:	EQUAL?	PRSO,GARTER \FALSE
	PRINTR	"He smiles dreamily at a memory."
?CCL51:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"Prison has only added a peppery beard to your father's handsome features. His green eyes still twinkle, his wrists still poke bonily out of his shirt cuffs"
	PRINT	PCR
	RTRUE	


	.FUNCT	I-DAD,CALLED-BY-DAD-F=0
	ZERO?	CALLED-BY-DAD-F \?CND1
	PRINT	INDENT
?CND1:	PRINTR	"You briefly explain the current situation to your father.
   ""I knew Falcon would do his best to rescue me, once you were safe,"" he responds. ""Now to rescue Lucy -- Nicholas will have told you about her. You get him while I get Lucy, and the four of us will meet down at the beach. Just show me the way out of this maze, and we'll get started."""


	.FUNCT	LAFOND-F,OARG=0
	ZERO?	OARG /?CCL3
	EQUAL?	OARG,M-DESC? /TRUE
	PRINT	INDENT
	PRINTD	LAFOND
	FSET?	LAFOND,MUNGBIT \?CCL8
	PRINT	LAF-MUNGED
	RTRUE	
?CCL8:	FSET?	LAFOND,DEADBIT \?CCL10
	PRINTI	" is slumped in the sand, dead."
	RTRUE	
?CCL10:	EQUAL?	HERE,BEACH \?CCL12
	PRINTI	" stands"
	PRINT	HALFWAY
	RTRUE	
?CCL12:	PRINTI	" is leering, lip curled."
	RTRUE	
?CCL3:	EQUAL?	LAFOND,WINNER \?CCL14
	CALL	RUNNING?,I-DUEL
	ZERO?	STACK \?PRD19
	CALL	RUNNING?,I-ENDGAME
	ZERO?	STACK /?CCL17
?PRD19:	FSET?	LAFOND,DEADBIT /?CCL17
	PRINTR	"He ignores you."
?CCL17:	EQUAL?	PRSA,V?TELL-ABOUT \?CCL23
	EQUAL?	PRSO,ME \?CCL23
	EQUAL?	PRSI,LRING \?CCL23
	SET	'WINNER,PROTAGONIST
	CALL	PERFORM,V?TAKE,LRING
	SET	'WINNER,LAFOND
	RTRUE	
?CCL23:	CALL	COM-CHECK,LAFOND >OARG
	ZERO?	OARG /FALSE
	EQUAL?	OARG,M-FATAL /FALSE
	RTRUE	
?CCL14:	EQUAL?	PRSA,V?POUR \?CCL33
	EQUAL?	PRSO,WINE \?CCL33
	FSET?	LAFOND,DEADBIT /?CCL33
	CALL	FWTD,SMACK-YOUR-FACE
	RSTACK	
?CCL33:	EQUAL?	PRSA,V?DANCE \?CCL38
	EQUAL?	HERE,BALLROOM \?CCL38
	EQUAL?	PARTNER,LAFOND \?CCL43
	PRINT	PACE
	RTRUE	
?CCL43:	CALL	RUNNING?,I-LDANCE
	ZERO?	STACK /FALSE
	PRINTI	"You curtsey and walk to"
	PRINT	DANCE-FLOOR
	PRINT	PCR
	SET	'REACTION,REACTION-POSITIVE
	RETURN	REACTION
?CCL38:	EQUAL?	PRSA,V?KICK,V?BITE,V?KILL \?CCL47
	FSET?	LAFOND,MUNGBIT \?CCL50
	CALL	MAN-IS-DOWN
	RSTACK	
?CCL50:	EQUAL?	HERE,BALLROOM \?CCL52
	SET	'AWAITING-REPLY,2
	CALL	QUEUE,I-REPLY,2
	PRINT	LAF-GRABS
	PRINT	THE-BALLROOM
	PRINTR	"whirling blur through your tears as he leads you around the floor. ""Ma petite, a ball is not the right place to kill me. What would my guests think?!"""
?CCL52:	ZERO?	KILL-L \?CCL54
	SET	'KILL-L,TRUE-VALUE
	PRINT	LAF-GRABS
	PRINTI	"Twisting your wrist, pain stabbing down your arm, he forces his mouth on yours, hard, thrusting, cutting your lips. He releases you"
	ZERO?	PRSI /?CND55
	EQUAL?	PRSI,RETICULE /?CND55
	FSET?	PRSI,WORNBIT /?CND55
	MOVE	PRSI,LAFOND
	PRINTI	", taking"
	CALL	TPRINT-PRSI
?CND55:	PRINTR	". ""Let that be a warning to you, my love."""
?CCL54:	CALL	JIGS-UP,STR?336
	RSTACK	
?CCL47:	EQUAL?	PRSA,V?TOUCH \?CCL61
	FSET?	LAFOND,DEADBIT /?CCL61
	PRINTR	"He smiles."
?CCL61:	EQUAL?	PRSA,V?GIVE \?CCL65
	EQUAL?	PRSO,GREEN-GLASS,BLUE-GLASS \?CCL65
	IN?	BLUE-GLASS,LAFOND /?CTR69
	IN?	GREEN-GLASS,LAFOND \?CCL70
?CTR69:	PRINTR	"""I already have a glass, thank you."""
?CCL70:	MOVE	PRSO,LAFOND
	PRINTI	"He takes"
	CALL	TRPRINT,PRSO
	RSTACK	
?CCL65:	EQUAL?	PRSA,V?KISS \?CCL74
	EQUAL?	HERE,LAFS-ROOM \?CCL77
	GRTR?	LAFOND-CTR,HORNY \?CCL80
	PRINTR	"Queasy, you turn up your face to be kissed. His lips are cold, dry."
?CCL80:	PRINTR	"He laughs. ""Not yet, petite."""
?CCL77:	PRINTI	"You shudder at the thought"
	PRINT	PCR
	RTRUE	
?CCL74:	EQUAL?	PRSA,V?EXAMINE \FALSE
	CALL	RUNNING?,I-LSED
	ZERO?	STACK /?CCL85
	GRTR?	LAFOND-CTR,11 \?CCL85
	PRINTI	"You turn away in modesty after a brief glimpse of pasty pink flesh"
	PRINT	PCR
	RTRUE	
?CCL85:	FSET?	LAFOND,MUNGBIT \?CCL89
	PRINTD	LAFOND
	PRINT	LAF-MUNGED
	CRLF	
	RTRUE	
?CCL89:	ZERO?	ENDGAME \?CTR90
	CALL	RUNNING?,I-LSED
	ZERO?	STACK /?CCL91
	GRTR?	LAFOND-CTR,4 \?CCL91
?CTR90:	PRINTI	"Lafond is dressed in a rich brocade robe"
	PRINT	PCR
	RTRUE	
?CCL91:	PRINTI	"Wigged in dark brown curls, dressed in velvets and brocade, he is warmly attractive. Until you meet his eyes, stone gray and cold"
	PRINT	PCR
	RTRUE	


	.FUNCT	RING-F
	CALL	NOUN-USED,W?LATIN,LRING
	ZERO?	STACK \?CTR2
	CALL	NOUN-USED,W?LATIN,HRING
	ZERO?	STACK \?CTR2
	EQUAL?	PRSA,V?READ \?CCL3
?CTR2:	CALL	REPERTOIRE,STR?337
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \?CCL8
	EQUAL?	PRSO,LRING \?CCL11
	PRINTI	"It's an ancient gold band, with"
	JUMP	?CND9
?CCL11:	PRINTI	"Made of copper,"
	CALL	TPRINT,HRING
	PRINTI	" has"
?CND9:	PRINTI	" a curious design of gargoyles, curled tongues extended, on its flat face, with ""Sal Sapit Omnia"" engraved at the bottom"
	PRINT	PCR
	RTRUE	
?CCL8:	EQUAL?	PRSA,V?TAKE \FALSE
	EQUAL?	PRSO,LRING \?CCL16
	IN?	LRING,LAFOND \?CCL16
	FSET?	LAFOND,MUNGBIT \?CCL21
	PRINTD	LAFOND
	PRINTI	"'s fingers are curled tight in a fist. You cannot get it"
	PRINT	PCR
	RTRUE	
?CCL21:	PRINTR	"""It is an impressive crest, no? I've thought of making it my own."""
?CCL16:	FSET?	HERO,DEADBIT \?CCL24
	CALL	NO-TIME-FOR,STR?338
	RSTACK	
?CCL24:	PRINTD	HERO
	PRINTI	" curls his fist around it. ""This is "
	IN?	HRING,HERO \?CND25
	PRINTI	"a copy of "
?CND25:	PRINTR	"the family ring lost with my brother."""


	.FUNCT	GEN-RING
	RETURN	HRING


	.FUNCT	COM-CHECK,PER
	EQUAL?	PRSA,V?HELP \?CCL3
	EQUAL?	PER,LAFOND \?CCL6
	PRINTR	"He snickers, ""So I shall, petite."""
?CCL6:	EQUAL?	PER,CRULLEY \?CCL8
	PRINTR	"""An' what'll I get fer it?"" he says, eying your body."
?CCL8:	PRINTR	"""I'm doing all I can."""
?CCL3:	EQUAL?	PRSA,V?KISS \?CCL10
	EQUAL?	PRSO,ME \?CCL10
	SET	'WINNER,PROTAGONIST
	CALL	PERFORM,V?KISS,PER
	SET	'WINNER,PER
	RTRUE	
?CCL10:	EQUAL?	PRSA,V?WALK \?CCL14
	PRINTR	"""After you!"""
?CCL14:	EQUAL?	PRSA,V?FOLLOW \?CCL16
	EQUAL?	PRSO,ME \?CCL16
	PRINTR	"""Anywhere!"""
?CCL16:	EQUAL?	PRSA,V?HELLO \?CCL20
	PRINTR	"""Hello!"""
?CCL20:	EQUAL?	PRSA,V?WHAT \?CCL22
	CALL	PERFORM,V?TELL-ABOUT,ME,PRSO
	RTRUE	
?CCL22:	EQUAL?	PRSA,V?GIVE \?CCL24
	EQUAL?	PRSI,ME \?CCL24
	SET	'WINNER,PROTAGONIST
	CALL	PERFORM,V?ASK-FOR,PER,PRSO
	SET	'WINNER,PER
	RTRUE	
?CCL24:	EQUAL?	PRSA,V?SGIVE \?CCL28
	RETURN	8
?CCL28:	EQUAL?	PRSA,V?NO,V?YES \?CCL32
	SET	'WINNER,PROTAGONIST
	CALL	PERFORM-PRSA
	SET	'WINNER,PER
	RTRUE	
?CCL32:	CALL	FAILS-TO-NOTICE
	EQUAL?	PRSA,V?DRINK \?CND33
	SET	'REACTION,REACTION-NEGATIVE
?CND33:	CALL	STOP
	RTRUE	


	.FUNCT	I-LDANCE
	EQUAL?	HERE,BALLROOM /?CCL3
	CALL	DEQUEUE,I-LDANCE
	RSTACK	
?CCL3:	EQUAL?	LAFOND-CTR,1 \?CCL6
	MOVE	LAFOND,HERE
	CALL	QUEUE,I-LDANCE,-1
	SET	'AWAITING-REPLY,11
	CALL	QUEUE,I-REPLY,2
	SET	'QUESTIONER,LAFOND
	SET	'DANCED-WITH,LAFOND
	PRINT	INDENT
	PRINTI	"A fashionably bewigged man stalks up to you and bows deeply. ""Will you dance?"" he asks, with a light French accent. ""Not that you have much choice. If you turn me down,"
	CALL	TPRINT,DAD
	PRINTI	" dies."""
	CRLF	
	JUMP	?CND4
?CCL6:	EQUAL?	LAFOND-CTR,2 \?CCL8
	EQUAL?	REACTION,REACTION-POSITIVE \?CCL11
	SET	'PARTNER,LAFOND
	INC	'LAFOND-CTR
	PRINT	INDENT
	PRINTI	"""I am, of course, Lafond."" "
	PRINT	LAUGHS
	JUMP	?CND4
?CCL11:	SET	'QUESTIONER,LAFOND
	SET	'AWAITING-REPLY,11
	CALL	QUEUE,I-REPLY,2
	PRINT	INDENT
	PRINTI	"The man's smile hardens. ""You have"
	CALL	TPRINT,DAD
	PRINTI	"'s eyes. I am Lafond --  I have recently become intimate with that gentleman."" He slightly stresses the word ""intimate.""
   ""Now, tell me 'yes.' And remember, I am a man of my word."""
	CRLF	
	JUMP	?CND4
?CCL8:	EQUAL?	LAFOND-CTR,3 \?CCL13
	EQUAL?	REACTION,REACTION-NEGATIVE,REACTION-NEUTRAL \?CCL16
	CALL	DEQUEUE,I-LDANCE
	CALL	QUEUE,I-CKILLS-DAD,2
	PRINT	INDENT
	PRINTI	"""A mistake, ma petite."" Lafond gestures to a shadowy figure, who disappears into the east wing. ""Say adieu to your dear Papa."""
	CRLF	
	JUMP	?CND4
?CCL16:	SET	'PARTNER,LAFOND
	PRINT	LAUGHS
	JUMP	?CND4
?CCL13:	EQUAL?	LAFOND-CTR,4 \?CCL18
	CALL	QUEUE,I-LDANCE,-1
	PRINT	INDENT
	PRINTI	"""So you know I am not your father's friend,"" Lafond says, offering a hand for the promenade. ""Unfortunately, you are in my power, "
	ZERO?	HERO-ARRESTED /?CCL21
	PRINTI	"the Falcon is with my dragoons"
	JUMP	?CND19
?CCL21:	PRINTI	"he is in my dungeon"
?CND19:	PRINTI	" and I am still King of these waters."" A gold ring flashes on his hand. It seems vaguely familiar"
	PRINT	PCR
	JUMP	?CND4
?CCL18:	EQUAL?	LAFOND-CTR,5 \FALSE
	FSET?	DAD,TOUCHBIT \?CND24
	ZERO?	HERO-ARRESTED \?CND26
	CALL	QUEUE,I-HARRESTED,3
?CND26:	CALL	QUEUE,I-SUMMONS,5
?CND24:	INC	'SCORE
	CALL	DEQUEUE,I-LDANCE
	REMOVE	LAFOND
	SET	'PARTNER,FALSE-VALUE
	PRINT	INDENT
	PRINTD	LAFOND
	PRINTI	"'s eyes rake your body. ""When I am ready,"
	CALL	TPRINT,BUTLER
	PRINTI	" will summon you to sup with me in my room"
	FSET?	DAD,TOUCHBIT /?CND28
	PRINTI	"; it may be some time"
?CND28:	PRINTI	". We will find much in common before dawn, I am sure. Then I may free your "
	ZERO?	HERO-ARRESTED /?CCL32
	PRINTI	"lover"
	JUMP	?CND30
?CCL32:	PRINTI	"father"
?CND30:	PRINTI	"."""
	CALL	TPRINT,LAFOND
	PRINTI	" bows as the dance ends, and kisses "
	PRINTD	HANDS
	PRINTI	". "
	FSET?	DAD,TOUCHBIT /?CND33
	PRINTI	"He cocks his head, curious, ""You have far less spirit than"
	CALL	TPRINT,DAD
	PRINTI	" credited you. He swore you would have him freed in no time at all. A pity, I prefer doyennes with mettle."" "
?CND33:	PRINTI	"He moves to speak with"
	CALL	TPRINT,BUTLER
	PRINTI	", then "
	CALL	QUEUED?,I-SUMMONS
	ZERO?	STACK /?CCL37
	PRINTI	"heads upstairs."
	JUMP	?CND35
?CCL37:	PRINTI	"drifts into the crowd."
?CND35:	CRLF	
?CND4:	INC	'LAFOND-CTR
	RETURN	LAFOND-CTR


	.FUNCT	I-LSED
	SET	'AWAITING-REPLY,12
	CALL	QUEUE,I-REPLY,1
	PRINT	INDENT
	EQUAL?	LAFOND-CTR,1 \?CCL3
	MOVE	LAFOND,HERE
	MOVE	BLUE-GLASS,PROTAGONIST
	PUTP	BLUE-GLASS,P?CONTENTS,WINED
	MOVE	GREEN-GLASS,LAFOND
	MOVE	FLAGON,TABLE
	FCLEAR	LDOOR,OPENBIT
	CALL	QUEUE,I-WONT-DRINK,1
	PRINTI	"""Have some wine."" Lafond pours wine into two glasses, giving a blue one to you. ""Drink this down. We have a long night ahead of us."" He drains his own"
	PRINT	PCR
	JUMP	?CND1
?CCL3:	EQUAL?	LAFOND-CTR,2 \?CCL5
	MOVE	GREEN-GLASS,TABLE
	MOVE	BUTLER,UPPER-HALL-E
	MOVE	HERO,MANACLES
	FSET	HERO,DEADBIT
	FSET	HERO,NDESCBIT
	FSET	TRAP,OPENBIT
	FCLEAR	PORTRAIT,OPENBIT
	FCLEAR	KNOB,EVERYBIT
	FCLEAR	POWER,EVERYBIT
	MOVE	RAPIER,DUNGEON
	FCLEAR	RAPIER,NDESCBIT
	FCLEAR	MANACLES,OPENBIT
	FSET	MANACLES,LOCKEDBIT
	FSET	CRULLEY,NDESCBIT
	MOVE	CRULLEY,DUNGEON
	MOVE	WHIP,CRULLEY
	CALL	QUEUE,I-LSED,-1
	FCLEAR	FLAGON,TRYTAKEBIT
	SET	'LAFOND-LOOKING,FALSE-VALUE
	PRINTI	"Suddenly, the door slams open. It is Jamison, coatless, sword bared, his shirt ripped. ""Thank God I am not too late. Leave, darling, before I skewer this dog to his bedposts,"" he cries. The scar on his cheek gleams coldly.
   With a yell,"
	CALL	TPRINT,CRULLEY
	PRINTI	" and"
	CALL	TPRINT,BUTLER
	PRINTI	" jump out of the darkness behind him. Nicholas struggles, but soon lies unconscious on the floor.
   ""Take him to the dungeon,"" Lafond says, setting down his glass. ""You, butler, stay nearby. I do not wish to be disturbed again.
   ""Now that we are rid of that intrusion, cherie, I will change into something more comfortable. Pour me more wine."" He crosses to the wardrobe removing his coat and vest, turned slightly away from you"
	PRINT	PCR
	JUMP	?CND1
?CCL5:	EQUAL?	LAFOND-CTR,3 \?CCL7
	PRINTI	"""In private, call me Jean, or whatever endearment you choose, once I have approved it."" Lafond is looking into the wardrobe"
	PRINT	PCR
	JUMP	?CND1
?CCL7:	EQUAL?	LAFOND-CTR,4 \?CCL9
	MOVE	TRAY,TABLE
	CALL	CTPRINT,BUTLER
	PRINTI	" enters, laying"
	CALL	APRINT,TRAY
	PRINTI	" of "
	PRINTD	CHICKEN
	PRINTI	" on"
	CALL	TPRINT,TABLE
	PRINTI	". ""The kitchen wench has gone, your grace. I took the liberty of fetching these myself."" He bows and leaves the room.
   ""Sprinkle some spices on the fowl, ma petite,"" Lafond says, donning a long brocade robe, his back to you. ""They are hot, but delicious."""
	CRLF	
	JUMP	?CND1
?CCL9:	EQUAL?	LAFOND-CTR,5 \?CCL11
	PRINTI	"""Tsk. The cook has gone too far. She shall be 'leaving us' tomorrow."" Lafond adjusts the lace at his neck"
	PRINT	PCR
	JUMP	?CND1
?CCL11:	EQUAL?	LAFOND-CTR,6 \?CCL13
	SET	'QUESTIONER,LAFOND
	SET	'LAFOND-LOOKING,TRUE-VALUE
	PRINTD	LAFOND
	PRINTI	" strolls to"
	LOC	GREEN-GLASS
	EQUAL?	STACK,TABLE \?CCL16
	CALL	TPRINT,TABLE
	JUMP	?CND14
?CCL16:	PRINTI	" you,"
?CND14:	PRINTI	" smiling slyly"
	GETP	BLUE-GLASS,P?CONTENTS
	EQUAL?	STACK,2,0 /?CCL18
	GETP	GREEN-GLASS,P?CONTENTS
	EQUAL?	STACK,2,0 \?CND17
?CCL18:	PRINTI	". ""But you haven't finished pouring the wine."" He tops off both glasses"
	GETP	BLUE-GLASS,P?CONTENTS
	EQUAL?	STACK,2,0 \?CND21
	CALL	POUR-WINE,BLUE-GLASS,TRUE-VALUE
?CND21:	GETP	GREEN-GLASS,P?CONTENTS
	EQUAL?	STACK,2,0 \?CND17
	CALL	POUR-WINE,GREEN-GLASS,TRUE-VALUE
?CND17:	ZERO?	USED-LAUD /?CCL27
	PRINTI	". ""Which glass was mine? I seem to have forgotten."" He points at"
	CALL	TPRINT,GREEN-GLASS
	PRINTI	" and smiles in a way that does not grant you confidence. ""Is this it?"""
	CRLF	
	JUMP	?CND1
?CCL27:	INC	'LAFOND-CTR
	PRINTI	".
   Lafond takes"
	CALL	TPRINT,GREEN-GLASS
	PRINTI	" and salutes you, gulping down the contents"
	PRINT	PCR
	JUMP	?CND1
?CCL13:	EQUAL?	LAFOND-CTR,7 \?CCL29
	SET	'QUESTIONER,LAFOND
	PRINTI	"""Ah yes, of course."" Lafond obligingly takes"
	ZERO?	USED-LAUD /?CND30
	EQUAL?	REACTION,REACTION-POSITIVE \?CCL34
	CALL	SWITCH-GLASSES,GREEN-GLASS
	JUMP	?CND30
?CCL34:	EQUAL?	REACTION,REACTION-NEGATIVE \?CCL36
	CALL	SWITCH-GLASSES,BLUE-GLASS
	JUMP	?CND30
?CCL36:	GETP	BLUE-GLASS,P?CONTENTS
	GRTR?	STACK,WINED \?CCL39
	GETP	GREEN-GLASS,P?CONTENTS
	EQUAL?	STACK,WINED \?CCL39
	CALL	SWITCH-GLASSES,BLUE-GLASS
	JUMP	?CND37
?CCL39:	CALL	SWITCH-GLASSES,GREEN-GLASS
?CND37:	PRINT	AFTER-HESITATING
?CND30:	PRINT	PCR
	PRINT	INDENT
	CALL	DEQUEUE,I-LSED
	CALL	QUEUE,I-WONT-DRINK,1
	PRINTI	"He inhales deeply of the bouquet of his wine, then turns to you. ""You must think me very naive to fall for such a trick. I saw you pour something into one of these glasses -- although "
	ZERO?	SPICED-WINE /?CCL44
	PRINTI	"you have tried to cover the scent with"
	CALL	TPRINT,SPICES
	JUMP	?CND42
?CCL44:	PRINTI	"I cannot smell it"
?CND42:	PRINTI	"."" He switches goblets, setting"
	CALL	TPRINT,YOUR-GLASS
	PRINTI	" into your nerveless grasp and taking up the other, smiling evilly. ""Now you will drink from the cup intended for me."""
	CRLF	
	JUMP	?CND1
?CCL29:	EQUAL?	LAFOND-CTR,8 \?CCL46
	CALL	QUEUE,I-LSED,-1
	PRINTD	LAFOND
	PRINTI	" draws near, whispering indecencies. He caresses your lily white neck, his fingers ice-cold despite the tropic heat"
	PRINT	PCR
	JUMP	?CND1
?CCL46:	EQUAL?	LAFOND-CTR,9 \?CCL48
	CALL	ROB,PROTAGONIST,LAFS-ROOM
	PRINTD	LAFOND
	PRINTI	" slides his hand up your neck and into your hair, letting it fall down your back in thick waves and tresses. He lays everything you carry on the floor"
	PRINT	PCR
	JUMP	?CND1
?CCL48:	EQUAL?	LAFOND-CTR,HORNY \?CCL50
	PRINTI	"One by one Lafond undoes your buttons. He pulls open your "
	FSET?	SHIRT,WORNBIT \?CCL53
	PRINTI	"shirt"
	JUMP	?CND51
?CCL53:	FSET?	GOWN,WORNBIT /?CTR54
	FSET?	DRESS,WORNBIT \?CCL55
?CTR54:	PRINTI	"bodice"
	JUMP	?CND51
?CCL55:	PRINTI	"chemise"
?CND51:	CALL	REMOVE-CLOTHES
	FCLEAR	CHEMISE,WORNBIT
	FSET	CHEMISE,EVERYBIT
	FCLEAR	SHOES,WORNBIT
	CALL	ROB,PROTAGONIST,LAFS-ROOM
	MOVE	RETICULE,LAFS-ROOM
	CALL	ROB,LAFOND,LAFS-ROOM
	PRINTI	". Your clothes float to the floor"
	PRINT	PCR
	JUMP	?CND1
?CCL50:	EQUAL?	LAFOND-CTR,11 \?CCL59
	PRINTD	LAFOND
	PRINTI	" runs his fingers down your naked spine, and compliments your body. He removes his dressing gown"
	PRINT	PCR
	JUMP	?CND1
?CCL59:	EQUAL?	LAFOND-CTR,12 \?CCL61
	PRINTD	LAFOND
	PRINTI	" kisses your shoulder, your neck, your ear. ""Close your eyes, if you will,"" he taunts, ""and pretend I am your dearest"
	CALL	TPRINT,HERO
	PRINTI	". But I am greater than he will ever be."" He kisses you, his lips thin and cold"
	PRINT	PCR
	JUMP	?CND1
?CCL61:	EQUAL?	LAFOND-CTR,13 \?CCL63
	IN?	PROTAGONIST,LAFS-BED \?CCL66
	SET	'LAFOND-CTR,14
	CALL	I-LSED
	JUMP	?CND1
?CCL66:	MOVE	LAFOND,LAFS-BED
	MOVE	PROTAGONIST,LAFS-BED
	PRINTD	LAFOND
	PRINTI	" leads you over to the bed"
	PRINT	PCR
	JUMP	?CND1
?CCL63:	EQUAL?	LAFOND-CTR,14 \?CND1
	CALL	FWTD,STR?339
?CND1:	INC	'LAFOND-CTR
	RETURN	LAFOND-CTR


	.FUNCT	SWITCH-GLASSES,GLASS
	EQUAL?	GLASS,GREEN-GLASS \?CCL3
	SET	'LAF-GLASS,BLUE-GLASS
	SET	'YOUR-GLASS,GREEN-GLASS
	JUMP	?CND1
?CCL3:	SET	'LAF-GLASS,GREEN-GLASS
	SET	'YOUR-GLASS,BLUE-GLASS
?CND1:	MOVE	YOUR-GLASS,PROTAGONIST
	MOVE	LAF-GLASS,LAFOND
	CALL	TPRINT,GLASS
	RSTACK	


	.FUNCT	I-WONT-DRINK,POISON-SCENE=0
	GRTR?	LAFOND-CTR,7 \?CND1
	SET	'POISON-SCENE,TRUE-VALUE
?CND1:	INC	'ANGER-CTR
	SET	'QUESTIONER,LAFOND
	SET	'AWAITING-REPLY,12
	CALL	QUEUE,I-REPLY,2
	PRINT	INDENT
	EQUAL?	REACTION,REACTION-NEGATIVE /?CCL5
	EQUAL?	PRSO,YOUR-GLASS \?PRD9
	EQUAL?	PRSA,V?DRINK-FROM /?CTR4
?PRD9:	EQUAL?	PRSO,WINE \?CCL5
	EQUAL?	PRSA,V?DRINK-FROM,V?DRINK,V?EAT /?CTR4
	EQUAL?	PRSA,V?POUR \?CCL5
	EQUAL?	PRSI,ME,MOUTH \?CCL5
?CTR4:	PUTP	YOUR-GLASS,P?CONTENTS,0
	PRINTI	"""Good girl,"" he says"
	ZERO?	POISON-SCENE /?CCL20
	PRINTI	". "
	CALL	CALL-IN-BUTLER
	RSTACK	
?CCL20:	PRINTI	", ""Let's see more cooperation of this sort."""
	CRLF	
	CALL	I-LSED
	RSTACK	
?CCL5:	GRTR?	ANGER-CTR,2 \?CCL23
	CALL	QUEUE,I-LSED,1
	ZERO?	POISON-SCENE /?CCL26
	PRINTI	"Lafond grows suddenly violent. ""I will not have insubordination. You shall cooperate, minx."" He forces"
	CALL	TPRINT,WINE
	PRINTI	" down your throat"
	PRINT	PCR
	GETP	YOUR-GLASS,P?CONTENTS
	GRTR?	STACK,WINED \?CND27
	CALL	QUEUED?,I-SLEEP
	ZERO?	STACK \?CND27
	CALL	QUEUE,I-SLEEP,2
?CND27:	PUTP	YOUR-GLASS,P?CONTENTS,0
	PRINT	INDENT
	CALL	CALL-IN-BUTLER
	RSTACK	
?CCL26:	MOVE	YOUR-GLASS,TABLE
	PUTP	YOUR-GLASS,P?CONTENTS,0
	PRINTI	"He angrily takes"
	CALL	TPRINT,YOUR-GLASS
	PRINTI	" and sets it on"
	CALL	TPRINT,TABLE
	PRINTI	". "
	CALL	CTPRINT,WINE
	PRINTR	" slops a dark stain across the lace. ""Do not try my patience, little one. I have those you love, remember."""
?CCL23:	CALL	QUEUE,I-WONT-DRINK,1
	EQUAL?	ANGER-CTR,1 \?CCL33
	PRINTD	LAFOND
	PRINTI	" waits impatiently for you to drink"
	PRINT	PCR
	RTRUE	
?CCL33:	EQUAL?	ANGER-CTR,2 \FALSE
	PRINTI	"""Drink. We must not waste all night."""
	CALL	TPRINT,LAFOND
	PRINTI	" pushes the glass toward "
	PRINTD	MOUTH
	PRINT	PCR
	RTRUE	


	.FUNCT	CALL-IN-BUTLER
	GETP	LAF-GLASS,P?CONTENTS
	GRTR?	STACK,WINED \?CND1
	SET	'DRUGGEE,BUTLER
	CALL	QUEUE,I-WATCH-SLEEP,1
?CND1:	PUTP	LAF-GLASS,P?CONTENTS,0
	SET	'LAUD-LEFT,0
	CALL	QUEUE,I-LSED,1
	CALL	META-LOC,BOTTLE
	EQUAL?	STACK,HERE \?CND3
	REMOVE	BOTTLE
	PRINTI	"Lafond takes"
	CALL	TPRINT,BOTTLE
	PRINTI	" and drops it out the window. ""You shall not need this. You may suffer no headaches in my employ."""
	CRLF	
	PRINT	INDENT
?CND3:	PRINTI	"He lifts his glass to drink, but stops. ""Your father, for all his idiotic meddling in other people's business, is not a fool. I doubt you are, either."" He calls in"
	CALL	TPRINT,BUTLER
	PRINTI	", ordering him to empty"
	CALL	TPRINT,LAF-GLASS
	PRINTI	". The man reports no odd taste and returns to his post"
	PRINT	PCR
	RTRUE	


	.FUNCT	I-SUMMONS
	FCLEAR	LDOOR,LOCKEDBIT
	MOVE	LAFOND,LAFS-ROOM
	EQUAL?	HERE,LIBRARY \?CCL3
	IN?	DAD,HERE \?CND4
	CALL	QUEUE,I-SUMMONS,2
	RTRUE	
?CND4:	PRINT	INDENT
	CALL	CTPRINT,BUTLER
	PRINTI	" enters the room"
	FSET?	PORTRAIT,OPENBIT \?CCL8
	PRINTI	", sees the open "
	PRINTD	PORTRAIT
	PRINTI	", and seizes your arms, pinning them behind your back. "
	CALL	FWTD,SOMETHING-HITS-YOU
	RSTACK	
?CCL8:	REMOVE	BUTLER
	PRINTI	". ""Excuse me for interrupting, Miss, but the master requests your company in his room."" He "
	FSET?	KNOB,EVERYBIT /?CCL10
	FSET?	POWER,EVERYBIT \?CND9
?CCL10:	FCLEAR	KNOB,EVERYBIT
	FCLEAR	POWER,EVERYBIT
	PRINTI	"moves around the room, straightening things, then "
?CND9:	PRINTI	"guides you back to the foyer. ""The governor's "
	PRINTD	OBJ-QUARTERS
	PRINTI	" are in the east wing."
	PRINT	BUTLER-POINTS
	CRLF	
	CALL	GOTO,FOYER
	RSTACK	
?CCL3:	EQUAL?	HERE,BALLROOM,SUPPER-ROOM,ORCHESTRA /?CTR13
	EQUAL?	HERE,HALL-W,FOYER,HALL-E /?CTR13
	EQUAL?	HERE,BEDROOM,GALLERY,X-ROOM /?CTR13
	EQUAL?	HERE,MAIN-ENTRANCE,VERANDA,KITCHEN /?CTR13
	EQUAL?	HERE,STAIRTOP,UPPER-HALL-W,UPPER-HALL-E \?CCL14
?CTR13:	FSET?	GOWN,WORNBIT \?CCL22
	REMOVE	BUTLER
	PRINT	INDENT
	CALL	CTPRINT,BUTLER
	PRINT	BUTLER-SUMMONS
	EQUAL?	HERE,UPPER-HALL-E \?CCL25
	PRINTI	"to"
	CALL	TPRINT,LDOOR
	PRINTI	", unlocks it"
	JUMP	?CND23
?CCL25:	EQUAL?	HERE,STAIRTOP,UPPER-HALL-W,X-ROOM /?CTR26
	EQUAL?	HERE,BEDROOM \?CCL27
?CTR26:	PRINTI	"to the east"
	JUMP	?CND23
?CCL27:	EQUAL?	HERE,GALLERY \?CCL31
	PRINTI	"to the north"
	JUMP	?CND23
?CCL31:	PRINTI	"up"
	CALL	TPRINT,STAIRS
	PRINTC	115
?CND23:	PRINTR	", bows, and leaves."
?CCL22:	FSET	FOYER,EVERYBIT
	PRINT	INDENT
	CALL	CTPRINT,BUTLER
	PRINTI	", who looks like he is seeking someone, grabs your collar, ""Who invited beggars? Get back to the village where you belong."""
	EQUAL?	HERE,MAIN-ENTRANCE /?CCL34
	PRINTI	" He escorts you out of the house"
	PRINT	PCR
	CRLF	
	CALL	GOTO,MAIN-ENTRANCE
	RSTACK	
?CCL34:	CRLF	
	RTRUE	
?CCL14:	FSET	FOYER,EVERYBIT
	RTRUE	


	.FUNCT	I-CKILLS-DAD
	EQUAL?	HERE,BALLROOM,FOYER /?CTR2
	EQUAL?	HERE,SUPPER-ROOM,ORCHESTRA \FALSE
?CTR2:	PRINT	INDENT
	PRINTI	"You see"
	CALL	TPRINT,CRULLEY
	PRINTI	" come in from the east wing and beckon to Lafond. ""'E's gone"
	FSET?	DAD,TOUCHBIT \?CCL8
	CALL	QUEUE,I-LDANCE,2
	REMOVE	HERO
	PRINTI	"! The cocky crupper 'as disappeared!"" Lafond looks around angrily, eyes narrowed, ""Then get his compatriot. Take Falcon."""
	CALL	TPRINT,CRULLEY
	PRINTI	" runs out the front door, reappearing a moment later with help"
	PRINT	PCR
	CALL	I-HARRESTED,TRUE-VALUE
	JUMP	?CND1
?CCL8:	CALL	H-JIGS-UP,STR?340,TRUE-VALUE
?CND1:	INC	'CRULLEY-CTR
	RETURN	CRULLEY-CTR


	.FUNCT	I-DUEL
	CALL	CANT-HEAR-DUEL
	ZERO?	STACK /?CCL3
	LESS?	HERO-CTR,16 /?CND1
?CCL3:	LESS?	HERO-CTR,12 \?CCL7
	PRINT	INDENT
	EQUAL?	HERE,GALLERY \?CND8
	PRINTI	"Nicholas and Lafond circle each other intently, the one breathing hard, the other casual, sword tips almost touching. Jamison has lost copious amounts of blood and is no match for Lafond, cool and competent."
	CRLF	
?CND8:	CALL	PICK-ONE,DUEL-SOUNDS
	PRINT	STACK
	CRLF	
	JUMP	?CND1
?CCL7:	EQUAL?	HERO-CTR,12 \?CCL11
	PRINT	INDENT
	PRINTI	"Someone calls out, ""We've got the Dimsford girl, Governor"" -- lying, of course, since you're obviously free"
	EQUAL?	HERE,GALLERY \?CND12
	PRINTI	". But Nick glances towards the voice, missteps, and slips in his own blood, falling backwards to the floor, his rapier skittering aside"
?CND12:	PRINT	PCR
	JUMP	?CND1
?CCL11:	EQUAL?	HERO-CTR,13 \?CCL15
	PRINT	INDENT
	EQUAL?	HERE,GALLERY \?CCL18
	PRINTD	LAFOND
	PRINTI	" leaps to Jamison's side, placing one heeled boot on the prostrate man's throat, the tip of his sword over Nick's heart. He sneers then, one eyebrow tilted, and moves to plunge in the sword. Nicholas cannot move."
	JUMP	?CND16
?CCL18:	SET	'HERO-CTR,15
	PRINTI	"One of the duellists falls heavily to the floor, his sword skittering away. All is silence for a moment, broken once by a low chuckle. Then a woman screams, someone gasps, and Jean Lafond's wicked laugh blasts your ears, ""Who else cares to taste my blade?"""
?CND16:	CRLF	
	JUMP	?CND1
?CCL15:	EQUAL?	HERO-CTR,14 \?CCL20
	EQUAL?	HERE,GALLERY \?CND1
	PRINT	INDENT
	PRINTI	"The sword plunges down into Jamison's heart, a red stain flowing up to meet it on his breast. Nicholas draws his last breath, his tortured gaze drawn heavenwards, to your face. He reaches for you, his hand dripping his own blood, and breathes your name...
   Nicholas's hand falls limply to the swelling pool of wine red blood and silence pounds on your ears"
	PRINT	PCR
	JUMP	?CND1
?CCL20:	EQUAL?	HERO-CTR,15 \?CCL24
	EQUAL?	HERE,GALLERY \?CCL27
	PRINT	INDENT
	PRINTI	"Lafond wipes his sword on your lover's inert body, ordering someone to drag away the corpse. Suddenly there are sounds of fighting all about, and you realize dragoons surround the house"
	PRINT	PCR
	JUMP	?CND1
?CCL27:	PRINTI	"Time has stopped. Silence reigns."
	CRLF	
	JUMP	?CND1
?CCL24:	EQUAL?	HERO-CTR,16 \?CND1
	CALL	CANT-HEAR-DUEL
	ZERO?	STACK \?CND29
	PRINT	INDENT
	PRINTI	"""Find the girl and bring her to me,"" Lafond orders."
	CRLF	
?CND29:	PRINT	INDENT
	PRINT	DRAGOONS-SURROUND
	CALL	FWTD,SOMETHING-HITS-YOU
?CND1:	INC	'HERO-CTR
	RETURN	HERO-CTR


	.FUNCT	CANT-HEAR-DUEL
	EQUAL?	HERE,UPPER-HALL-E,STAIRTOP,HALL-W /FALSE
	EQUAL?	HERE,FOYER,LIBRARY,HALL-E /FALSE
	EQUAL?	HERE,VERANDA,GALLERY /FALSE
	RTRUE	


	.FUNCT	PISTOL-F
	EQUAL?	PRSA,V?FILL \?CCL3
	ZERO?	PRSI \?CCL6
	EQUAL?	P-PRSA-WORD,W?LOAD \?CCL6
	CALL	HELD?,POWDER
	ZERO?	STACK /?CCL11
	CALL	PERFORM,V?FILL,PISTOL,POWDER
	RTRUE	
?CCL11:	PRINT	YNH
	PRINTI	" any "
	PRINTD	POWDER
	PRINT	PCR
	RTRUE	
?CCL6:	EQUAL?	PRSI,POWDER \?CCL13
	ZERO?	PRIMED /?CCL16
	PRINT	YOU-HAVE-ALREADY
	PRINTI	" loaded"
	CALL	TRPRINT,PISTOL
	RSTACK	
?CCL16:	SET	'PRIMED,TRUE-VALUE
	MOVE	HORN,PROTAGONIST
	ZERO?	PENULTIM-POINT \?CND17
	SET	'PENULTIM-POINT,TRUE-VALUE
	INC	'SCORE
?CND17:	PRINTI	"You pour a lumpy stream of"
	CALL	TPRINT,POWDER
	PRINTI	" mixture into the barrel of"
	CALL	TPRINT,PISTOL
	PRINTI	" tamping it as best you can"
	PRINT	PCR
	RTRUE	
?CCL13:	EQUAL?	PRSO,PISTOL \FALSE
	PRINT	YOU-CANT
	PRINTI	"put that into"
	CALL	ARPRINT,PISTOL
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?POUR,V?PUT \?CCL22
	EQUAL?	PRSI,PISTOL \?CCL22
	EQUAL?	PRSO,POWDER \?CCL27
	CALL	PERFORM,V?FILL,PISTOL,PRSO
	RTRUE	
?CCL27:	PRINT	HUH
	RTRUE	
?CCL22:	EQUAL?	PRSA,V?EXAMINE \?CCL29
	PRINTI	"One of"
	CALL	APRINT,PAIR
	PRINTI	", the gun is "
	ZERO?	PRIMED /?CCL32
	PRINTR	"primed and ready to fire."
?CCL32:	PRINTR	"not loaded."
?CCL29:	EQUAL?	PRSA,V?KILL \?CCL34
	CALL	PERFORM,V?SHOOT,PRSO,PRSI
	RTRUE	
?CCL34:	EQUAL?	PRSA,V?SHOOT \?CCL36
	ZERO?	PRIMED \?CCL39
	PRINTI	"But"
	CALL	TPRINT,PISTOL
	PRINTR	" is not loaded."
?CCL39:	ZERO?	PRSI /?CTR40
	EQUAL?	PRSO,AIR \?CCL41
?CTR40:	INC	'SCORE
	PRINTI	"You fire"
	CALL	TPRINT,PISTOL
	PRINTI	" into the air. Startled by the loud report,"
	CALL	TPRINT,CRULLEY
	PRINTI	" jerks his pistol and fires, aiming not at Nicholas, but at you. You hear a distant scream, your own, and watch, as through from afar,"
	CALL	TPRINT,DAD
	PRINTI	" wrestle"
	CALL	TPRINT,CRULLEY
	PRINTI	" to"
	CALL	TPRINT,GROUND
	PRINTI	". You feel only numbness as loving arms take you up, and Nicholas kisses you into death, his tears damp on your cheek."
	PRINT	YOU-DIED
	SET	'FINAL-RANK,2
	CALL	FINISH
	RSTACK	
?CCL41:	EQUAL?	PRSO,BUSHES,PATROL \?CCL45
	PRINTR	"They are out of range."
?CCL45:	EQUAL?	PRSO,CRULLEY \?CCL47
	INC	'SCORE
	PRINTI	"Trembling, you fire the heavy pistol. You hear its loud report over roaring surf. Crulley staggers, hit, and falls from the cliff. The gun falls from your nerveless hands.
   Time stops as you and Nicholas gaze at one another, adoring and amazed. Slowly he bows and offers his hand.
   "
	PRINT	NUTBROWN
	PRINTI	"His eyes, twin seas of blue, devour you with a love deep and true-hearted, and you are pulled into his embrace, your mouth on his, lips parted, thirsting, arching into his kiss..."
	CRLF	
	CALL	FINALE
	RSTACK	
?CCL47:	EQUAL?	PRSO,PISTOL \?CCL49
	CALL	IMPOSSIBLES
	RSTACK	
?CCL49:	FSET?	PRSO,DEADBIT \?CCL51
	CALL	MAN-IS-DOWN
	RSTACK	
?CCL51:	FSET?	PRSO,ACTORBIT \?CCL53
	PRINTI	"You wouldn't kill"
	CALL	TPRINT-PRSO
	PRINTR	"!"
?CCL53:	IN?	PRSO,HERE /?CCL55
	CALL	CTPRINT,PISTOL
	PRINTI	" can't fire that far"
	PRINT	PCR
	RTRUE	
?CCL55:	CALL	WASTES
	RSTACK	
?CCL36:	EQUAL?	PRSO,STONE \FALSE
	EQUAL?	PRSA,V?SSHOOT \FALSE
	CALL	WASTES
	RSTACK	


	.FUNCT	I-ENDGAME
	EQUAL?	HERE,LAGOON,BY-SHIP \?CND1
	GRTR?	LAFOND-CTR,1 \?CND1
	SET	'SCORE,25
	PRINT	INDENT
	PRINTI	"You hear distant shots and screams, and gaze back across the restless waves to the massacre on the beach. The sight blurs with your tears of shame, tears for the father and the lover you left behind."
	CRLF	
	CALL	CLEAR-SCREEN,15
	PRINT	INDENT
	PRINTI	"The tale you tell Jamison's crew, of rapine and blood, of your heroic attempt to save their captain, and of your own escape after his death in your arms, is not so far from the truth that you cannot appear sincere. Cannily, you take advantage of their temporary grief, select a private guard, and teach the rest the discipline of the whip."
	SET	'FINAL-RANK,3
	LESS?	LAFOND-CTR,DEAD \?CND5
	PRINTI	" You have started on the ruthless road to revenge. You intend to meet Lafond again, and that time, you intend to win."
?CND5:	CRLF	
	CALL	FINISH
	RFALSE	
?CND1:	PRINT	INDENT
	EQUAL?	LAFOND-CTR,1 \?CCL9
	EQUAL?	HERE,BEACH,SHALLOWS,LAGOON /?CCL12
	CALL	FWTD,STR?341
	JUMP	?CND7
?CCL12:	CALL	QUEUE,I-ENDGAME,-1
	MOVE	LAFOND,BEACH
	FCLEAR	LAFOND,MUNGBIT
	MOVE	CRULLEY,BEACH
	FCLEAR	CRULLEY,MUNGBIT
	PRINTI	"A shot rings out over the roar of the surf. Turning, you see that Lafond stands at the top of the cliff, a pistol in each hand. ""Trying to sneak out the back, cowards? You will die like your brother, Falcon. Snivelling for mercy."" He hands one gun to "
	PRINTD	CRULLEY
	PRINTI	", standing nearby, and levels the other at Jamison"
	PRINT	PCR
	JUMP	?CND7
?CCL9:	EQUAL?	LAFOND-CTR,2 \?CCL14
	FSET	COOKIE,DEADBIT
	SET	'QUESTIONER,HERO
	SET	'AWAITING-REPLY,9
	CALL	QUEUE,I-REPLY,2
	PRINTI	"As the gun fires, Cookie throws himself before his captain. He cries out, blood blossoming on his shoulder, and falls face first into the sand. Lucy runs to him.
   Jamison yells up the cliff, brandishing his sword. ""Fight like a man, Lafond. You have drawn my blood once tonight -- let me draw yours.""
   Lafond sneers. ""On one condition. If I win, your lady comes to me. You will have no need of her when you are dead.""
   Nicholas stiffens, glances at the dragoons on the cliff above, and turns slowly to you. He says nothing, his face hard, but his eyes tell you what you want to know. ""Answer, my darling. Yes or no?"""
	CRLF	
	JUMP	?CND7
?CCL14:	EQUAL?	LAFOND-CTR,3,4 \?CCL16
	SET	'QUESTIONER,HERO
	SET	'AWAITING-REPLY,9
	CALL	QUEUE,I-REPLY,2
	CALL	AFFIRMATIVE-ANSWER
	ZERO?	STACK \?CTR18
	EQUAL?	PRSA,V?YES \?CCL19
?CTR18:	FSET	RAPIER,NDESCBIT
	FSET	LAFOND,NDESCBIT
	FCLEAR	CRULLEY,NDESCBIT
	MOVE	PISTOL,BEACH
	SET	'LAFOND-CTR,4
	PRINTI	"Nicholas looks determined. ""I accept. So long as my people go free if I win. Order your dragoons to obey us, then."" In answer, Lafond jumps off the cliff like a huge brocaded bat to land in front of"
	CALL	TPRINT,HERO
	PRINTI	". ""Die then, fool!""
   "
	CALL	CTPRINT,PISTOL
	PRINTI	", spinning from Lafond's grip, drops to the sand "
	EQUAL?	HERE,BEACH \?CCL24
	PRINTI	"nearby."
	CRLF	
	JUMP	?CND7
?CCL24:	PRINTI	"of the beach."
	CRLF	
	JUMP	?CND7
?CCL19:	ZERO?	REACTION \?CCL26
	EQUAL?	LAFOND-CTR,3 \?CCL26
	PRINTI	"Lafond calls down to you, ""My pretty doxy, do make up your mind. Yes or no?"""
	CRLF	
	JUMP	?CND7
?CCL26:	CALL	JIGS-UP,STR?342
	JUMP	?CND7
?CCL16:	EQUAL?	LAFOND-CTR,FIGHTING \?CCL30
	PRINTD	LAFOND
	PRINTI	" immediately takes the advantage, forcing Nicholas in a retreat towards the foaming surf. But Nicholas fights hard, jaw set, ignoring his wounds. Lafond finally loses his smile.
   Behind the duellists, far away atop the cliff, you notice "
	PRINTD	CRULLEY
	PRINTI	" madly reloading the pistol"
	PRINT	PCR
	JUMP	?CND7
?CCL30:	EQUAL?	LAFOND-CTR,6 \?CCL32
	FCLEAR	LAFOND,NDESCBIT
	REMOVE	HRING
	MOVE	LRING,HERO
	FCLEAR	RAPIER,NDESCBIT
	FSET	LAFOND,DEADBIT
	PRINTI	"Suddenly the force of the duel turns, Nicholas advancing against Lafond's retreat. Their blades silently flash in the moonlight. Lafond is pressed back into the shadow of the cliff, sweat beading on his forehead. Abruptly, Jamison leaps forward, metal scrapes, and his rapier licks neatly into Lafond's ribs, like a snake slipping into its burrow. The body of the governor of St. Sinistra convulses, as in amazement, then sags dead on the sword.
   Nicholas removes"
	CALL	APRINT,LRING
	PRINTI	" from the dead man's finger, throwing his own cheap copy into the surf.
   Far above him,"
	CALL	TPRINT,CRULLEY
	PRINTI	" moves down the stairs."
	CRLF	
	JUMP	?CND7
?CCL32:	EQUAL?	LAFOND-CTR,DEAD \?CCL34
	PRINTD	CRULLEY
	PRINTI	" is levelling"
	CALL	TPRINT,PISTOL
	PRINTI	", feet apart, braced by the cliff wall."
	CRLF	
	JUMP	?CND7
?CCL34:	EQUAL?	LAFOND-CTR,8 \?CCL36
	PRINTD	CRULLEY
	PRINTI	" carefully aims"
	CALL	TPRINT,PISTOL
	PRINTI	", a triumphal grin benighting his face. Nicholas turns and walks smiling towards you, oblivious to his danger"
	PRINT	PCR
	JUMP	?CND7
?CCL36:	EQUAL?	LAFOND-CTR,9 \?CND7
	CALL	JIGS-UP,STR?343
?CND7:	INC	'LAFOND-CTR
	RETURN	LAFOND-CTR


	.FUNCT	FINALE
	MOVE	HERO,FOCSLE
	CALL	CLEAR-SCREEN,15
	SET	'VERBOSITY,0
	CALL	GOTO,FOCSLE
	PRINT	INDENT
	PRINTI	"As dawn breaks over the eastern seas, you stand with Nicholas on his ship, looking north. ""I have nothing left in England,"" he says. ""There I am but a destitute gentleman, wanted for piracy. Here -- this isle holds too many memories"
	FSET?	DAD,DEADBIT \?CCL3
	SET	'FINAL-RANK,1
	PRINTI	" --"" he pauses, gazing into your tear-filled eyes with compassion. """
	JUMP	?CND1
?CCL3:	SET	'FINAL-RANK,4
	PRINTI	"; your father may have it. "
?CND1:	PRINTI	"Mayhap my brother's wife yet lives. I must try to find her, either way."" He takes you into his arms. ""Come with me, my love? To America -- they tell of endless fertile fields and strange beasts in that wild land. It won't be easy, but we will have each other. Together, shall we carve a kingdom blessed with fair children and freedom?""
   You wrap your arms about his waist and lean into him, and smile at the rising sun"
	PRINT	PCR
	CALL	FINISH
	RSTACK	


	.FUNCT	PATROL-F
	EQUAL?	PATROL,WINNER \?CCL3
	PRINTR	"A rough voice yells to leave them alone."
?CCL3:	CALL	TOUCHING?,PATROL
	ZERO?	STACK /FALSE
	CALL	CANT-REACH,PATROL
	RSTACK	


	.FUNCT	FAILS-TO-NOTICE
	EQUAL?	WINNER,LUCY \?CCL3
	PRINTI	"Sh"
	JUMP	?CND1
?CCL3:	PRINTC	72
?CND1:	PRINTI	"e fails to notice you've spoken"
	PRINT	PCR
	RTRUE	

	.ENDI
