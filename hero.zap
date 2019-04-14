

	.FUNCT	HERO-F,OARG=0
	ZERO?	OARG /?CCL3
	EQUAL?	OARG,M-DESC? /TRUE
	EQUAL?	HERE,FOLLY /?CND6
	PRINT	INDENT
?CND6:	EQUAL?	HERE,CABIN \?CCL10
	PRINT	CTHE-PIRATE-CAPTAIN
	PRINTI	"is studying you"
	JUMP	?CND8
?CCL10:	EQUAL?	HERE,DEUX-DECK \?CCL12
	PRINT	CTHE-PIRATE-CAPTAIN
	PRINTI	"stands protectively a few steps behind you"
	JUMP	?CND8
?CCL12:	EQUAL?	HERE,CAPT-QUARTERS \?CCL14
	PRINTD	HERO
	PRINTI	" is adjusting his clothes"
	JUMP	?CND8
?CCL14:	CALL	RUNNING?,I-DUEL
	ZERO?	STACK /?CCL16
	PRINTI	"Battered and bruised, Nicholas can hardly stand"
	JUMP	?CND8
?CCL16:	FSET?	HERO,DEADBIT \?CCL18
	PRINT	HERO-EYES-CLOSED
	JUMP	?CND8
?CCL18:	EQUAL?	HERE,BEACH \?CCL20
	PRINTI	"Nicholas "
	FSET?	LAFOND,DEADBIT \?CCL23
	PRINTI	"walks toward you, smiling wearily"
	JUMP	?CND8
?CCL23:	GRTR?	LAFOND-CTR,4 \?CCL25
	PRINTI	"and Lafond are fighting"
	JUMP	?CND8
?CCL25:	PRINTI	"stands alone at one edge of the beach"
	JUMP	?CND8
?CCL20:	CALL	QUEUED?,I-ENDGAME
	ZERO?	STACK /?CCL27
	PRINTI	"Nicholas stands, half-supported by Lucy and"
	CALL	TPRINT,DAD
	JUMP	?CND8
?CCL27:	EQUAL?	HERE,BALLROOM \FALSE
	PRINTI	"Nicholas looks quite rakish, in red velvet and white, his rapier flashing in the light of the "
	PRINTD	CHANDELIER
?CND8:	PRINTC	46
	RTRUE	
?CCL3:	EQUAL?	HERO,WINNER \?CCL31
	CALL	RUNNING?,I-DUEL
	ZERO?	STACK /?CCL34
	EQUAL?	HERE,GALLERY,STAIRTOP \?CCL34
	PRINT	SPEECHLESS
	RTRUE	
?CCL34:	EQUAL?	HERE,BEACH \?CCL38
	CALL	RUNNING?,I-ENDGAME
	ZERO?	STACK /?CCL38
	FSET?	LAFOND,DEADBIT /?CCL43
	GRTR?	LAFOND-CTR,4 \?CCL43
	PRINT	SPEECHLESS
	RTRUE	
?CCL43:	EQUAL?	PRSA,V?WALK,V?LOOK-INSIDE,V?HALT /?CTR46
	EQUAL?	PRSA,V?CLIMB-DOWN \?CCL47
?CTR46:	CALL	H-JIGS-UP,STR?316
	RSTACK	
?CCL47:	CALL	FAILS-TO-NOTICE
	RSTACK	
?CCL38:	FSET?	HERO,DEADBIT \?CCL51
	PRINT	DOESNT-RESPOND
	RTRUE	
?CCL51:	EQUAL?	PRSA,V?FOLLOW \?CCL53
	EQUAL?	PRSO,ME \?CCL53
	CALL	RUNNING?,I-HDANCE
	ZERO?	STACK /?CCL53
	FSET?	DAD,TOUCHBIT \?CCL53
	SET	'HDAD-SPEECH,TRUE-VALUE
	PRINTR	"""I will follow you anywhere you please, but first I must kill Lafond."""
?CCL53:	EQUAL?	PRSA,V?I-LOVE-YOU \?CCL59
	EQUAL?	PRSO,HERO,MAN \?CCL62
	PRINTR	"He smiles at you warmly, his eyes full of passion."
?CCL62:	EQUAL?	PRSO,LAFOND \?CCL64
	CALL	RUNNING?,I-HFOLLY
	ZERO?	STACK \?CTR66
	CALL	RUNNING?,I-HDANCE
	ZERO?	STACK /?CCL67
?CTR66:	REMOVE	HERO
	CALL	STOP-QUEUES
	PRINTR	"He looks at you in disgust and walks away."
?CCL67:	PRINTR	"""Don't jest,"" he says."
?CCL64:	PRINTR	"He isn't all that interested."
?CCL59:	EQUAL?	PRSA,V?LEAVE \?CCL71
	FSET?	BEACH,TOUCHBIT \?CCL74
	SET	'AWAITING-REPLY,4
	CALL	QUEUE,I-REPLY,2
	PRINTR	"He catches your arm, ""Nay, can you mean that?"""
?CCL74:	PRINTR	"""I have business to attend to here, and have no intention of leaving."""
?CCL71:	EQUAL?	PRSA,V?READ \?CCL76
	EQUAL?	PRSO,LETTER \?CCL76
	CALL	PERFORM,V?TELL-ABOUT,ME,LETTER
	RTRUE	
?CCL76:	EQUAL?	PRSA,V?TELL-ABOUT \?CCL80
	EQUAL?	PRSO,ME \?CCL80
	EQUAL?	PRSI,LETTER \?CCL85
	PRINTI	"""Your father wrote it for you."""
	CRLF	
	JUMP	?CND83
?CCL85:	EQUAL?	PRSI,HRING \?CCL87
	SET	'WINNER,PROTAGONIST
	CALL	PERFORM,V?TAKE,HRING
	RTRUE	
?CCL87:	EQUAL?	PRSI,LAFOND \?CCL89
	PRINTI	"""I abhor the fiend."" He clenches a fist."
	CRLF	
	JUMP	?CND83
?CCL89:	EQUAL?	PRSI,DAD \?CCL91
	CALL	RUNNING?,I-HDANCE
	ZERO?	STACK /?CCL94
	SET	'HDAD-SPEECH,TRUE-VALUE
	GET	HERO-SPEECHES,0
	PRINT	STACK
	PRINT	PCR
	JUMP	?CND83
?CCL94:	CALL	RUNNING?,I-HFOLLY
	ZERO?	STACK /?CCL96
	PRINTI	"""Let's not discuss"
	CALL	TPRINT,DAD
	PRINTI	" just now,"" he says, kissing your neck"
	PRINT	PCR
	JUMP	?CND83
?CCL96:	PRINTI	"""I admire and respect your father greatly."""
	CRLF	
	JUMP	?CND83
?CCL91:	CALL	FAILS-TO-NOTICE
?CND83:	CALL	STOP
	RSTACK	
?CCL80:	EQUAL?	PRSA,V?TAKE \?CCL98
	EQUAL?	PRSO,FLOWER \?CCL98
	SET	'WINNER,PROTAGONIST
	CALL	PERFORM,V?GIVE,FLOWER,HERO
	SET	'WINNER,HERO
	RTRUE	
?CCL98:	CALL	COM-CHECK,HERO >OARG
	ZERO?	OARG /FALSE
	EQUAL?	OARG,M-FATAL /FALSE
	RTRUE	
?CCL31:	EQUAL?	PRSA,V?EXAMINE \?CCL107
	FSET?	HERO,DEADBIT \?CCL110
	CALL	RUNNING?,I-DUEL
	ZERO?	STACK /?CCL113
	PRINTR	"He lies in a pool of blood."
?CCL113:	PRINT	HERO-EYES-CLOSED
	RTRUE	
?CCL110:	EQUAL?	HERE,CAPT-QUARTERS,BALLROOM,FOLLY \?CCL115
	ZERO?	ENDGAME \?CCL115
	PRINTI	"Jamison is finely dressed, in red velvet coat and full breeches, with a long gold embroidered vest and waterfalls of white lace at his neck, wrists and boottops. His rapier is bedecked with a fringed gold ribbon. He wears no wig, his unpowdered hair tied neatly at the back of his neck"
	PRINT	PCR
	RTRUE	
?CCL115:	PRINTI	"Jamison carries an aura of power unusual in men so slim and tall, the strength of a willow in his hard seaworn body, straight shouldered and resilient. "
	PRINT	NUTBROWN
	PRINTI	"A jagged scar etches one cheek, harsh against the warmth of his limpid blue eyes"
	PRINT	PCR
	RTRUE	
?CCL107:	EQUAL?	PRSA,V?ROLL,V?SAVE-SOMETHING \?CCL119
	CALL	RUNNING?,I-ENDGAME
	ZERO?	STACK /?CCL119
	SET	'WINNER,HERO
	CALL	PERFORM,V?HALT,ROOMS
	SET	'WINNER,PROTAGONIST
	RTRUE	
?CCL119:	FSET?	HERO,DEADBIT \?CCL123
	EQUAL?	PRSA,V?GIVE \?CCL126
	EQUAL?	PRSO,SALTS \?CCL126
	CALL	REVIVE-HERO
	RSTACK	
?CCL126:	EQUAL?	PRSA,V?THROW-AT,V?PUT-ON,V?BLOW \?CCL130
	EQUAL?	PRSO,SPICES \?CCL130
	PRINTR	"He sneezes involuntarily, unconscious."
?CCL130:	EQUAL?	PRSA,V?MUNG,V?KICK,V?KILL \?CCL134
	CALL	MAN-IS-DOWN
	RSTACK	
?CCL134:	EQUAL?	PRSA,V?MOVE \?CCL136
	PRINTR	"He's too heavy."
?CCL136:	EQUAL?	PRSA,V?EMBRACE,V?KISS \?CCL138
	PRINTI	"You press your lips to his cold mouth. "
	PRINT	DOESNT-RESPOND
	RTRUE	
?CCL138:	EQUAL?	PRSA,V?ASK-ABOUT,V?TELL-ABOUT,V?TELL \?PRD142
	EQUAL?	PRSO,HERO \?CTR139
?PRD142:	CALL	TOUCHING?,HERO
	ZERO?	STACK /FALSE
?CTR139:	PRINT	DOESNT-RESPOND
	RTRUE	
?CCL123:	EQUAL?	PRSA,V?GIVE \?CCL146
	EQUAL?	PRSO,SALTS \?CCL149
	CALL	REVIVE-HERO
	RSTACK	
?CCL149:	EQUAL?	PRSO,BANKNOTE \?CCL151
	PRINTD	HERO
	PRINTI	" returns"
	CALL	TPRINT,BANKNOTE
	PRINTI	" to you"
	PRINT	PCR
	RTRUE	
?CCL151:	EQUAL?	PRSO,FLOWER \?CCL153
	PRINTR	"He prevents you, smiling. ""It looks much too pretty against your hair. Keep it."""
?CCL153:	EQUAL?	PRSO,COFFER \FALSE
	CALL	FAILS-TO-NOTICE
	RSTACK	
?CCL146:	EQUAL?	PRSA,V?ALARM \?CCL157
	EQUAL?	PRSI,SALTS /?CCL160
	PRINT	YOU-CANT
	PRINTR	"revive him with that!"
?CCL160:	CALL	HELD?,SALTS
	ZERO?	STACK /?CCL162
	CALL	REVIVE-HERO
	RSTACK	
?CCL162:	PRINTD	HERO
	PRINTI	" is not asleep"
	PRINT	PCR
	RTRUE	
?CCL157:	EQUAL?	PRSA,V?UNTIE \?CCL164
	EQUAL?	P-PRSA-WORD,W?FREE \?CCL164
	IN?	HERO,MANACLES \?CCL169
	SET	'AWAITING-REPLY,2
	CALL	QUEUE,I-REPLY,2
	PRINTR	"You have the key, maybe?"
?CCL169:	PRINTI	"Jamison is free enough as it is"
	PRINT	PCR
	RTRUE	
?CCL164:	EQUAL?	PRSA,V?MUNG,V?KICK,V?KILL \?CCL171
	PRINTI	"""Please, I'm not trying to hurt you,"""
	EQUAL?	HERE,CABIN \?CCL174
	PRINTI	" the stranger"
	JUMP	?CND172
?CCL174:	CALL	TPRINT,HERO
?CND172:	PRINTI	" says, casually deflecting the blow"
	PRINT	PCR
	RTRUE	
?CCL171:	EQUAL?	PRSA,V?KISS \?CCL176
	EQUAL?	WINNER,PROTAGONIST \?CCL176
	EQUAL?	HERE,CABIN,DEUX-DECK \?CCL181
	PRINTR	"You are not so pert as to kiss a stranger, and a pirate, at that!"
?CCL181:	CALL	SHIP-BOARD,HERE
	ZERO?	STACK /?CCL183
	PRINTI	"That thought has occurred to you before, but now does not seem appropriate"
	PRINT	PCR
	RTRUE	
?CCL183:	EQUAL?	HERE,FOLLY \?CCL185
	SET	'REACTION,REACTION-POSITIVE
	PRINTI	"You lean into his arms, face lifted"
	PRINT	PCR
	RTRUE	
?CCL185:	CALL	RUNNING?,I-DUEL
	ZERO?	STACK \?CTR186
	CALL	RUNNING?,I-ENDGAME
	ZERO?	STACK /?CCL187
?CTR186:	PRINTI	"You would only distract"
	CALL	TRPRINT,HERO
	RSTACK	
?CCL187:	CALL	RUNNING?,I-HDANCE
	ZERO?	STACK /?CCL191
	PRINTI	"In view of all"
	CALL	TPRINT,DANCERS
	PRINTI	"s, you exchange only a peck on the cheek"
	PRINT	PCR
	RTRUE	
?CCL191:	PRINTI	"He kisses you back"
	PRINT	PCR
	RTRUE	
?CCL176:	EQUAL?	PRSA,V?TELL-ABOUT \?CCL193
	CALL	NOUN-USED,W?LIBRARY,HOUSE
	ZERO?	STACK \?CTR195
	CALL	NOUN-USED,W?CELL,CELL-4
	ZERO?	STACK \?CTR195
	EQUAL?	PRSI,DUNGEON,PORTRAIT \?CCL196
?CTR195:	PRINTR	"He nods. ""That area is guarded well."""
?CCL196:	EQUAL?	PRSI,DAD \?CCL201
	IN?	DAD,CELL-4 \?CCL204
	PRINTR	"He smiles fondly at your reminiscing. ""I never knew my father -- he died when I was a boy."""
?CCL204:	SET	'HDAD-SPEECH,TRUE-VALUE
	PRINTR	"""Such bravery joined with such beauty!"""
?CCL201:	EQUAL?	PRSI,CRULLEY \FALSE
	FSET?	BEACH,TOUCHBIT \FALSE
	PRINTR	"""Crulley?! God's blood!"""
?CCL193:	EQUAL?	PRSA,V?TOUCH,V?EMBRACE \?CCL210
	EQUAL?	HERE,FOLLY \?CCL210
	CALL	PERFORM,V?KISS,HERO
	RTRUE	
?CCL210:	EQUAL?	PRSA,V?DANCE \?CCL214
	EQUAL?	HERE,BALLROOM \?CCL217
	EQUAL?	PARTNER,HERO \?CCL217
	PRINT	PACE
	RTRUE	
?CCL217:	CALL	RUNNING?,I-HDANCE
	ZERO?	STACK /FALSE
	MOVE	PROTAGONIST,BALLROOM
	MOVE	HERO,BALLROOM
	SET	'PARTNER,HERO
	PRINTI	"You whirl back out to"
	PRINT	DANCE-FLOOR
	PRINT	PCR
	RTRUE	
?CCL214:	EQUAL?	PRSA,V?SHOW \FALSE
	EQUAL?	PRSO,JEWEL \FALSE
	IN?	HERO,MANACLES \FALSE
	PRINTR	"Nick smiles dazzlingly, ""Of course! Now pick the locks."""


	.FUNCT	GEN-PIRATE
	ZERO?	ENDGAME /?CCL3
	EQUAL?	HERE,BALLROOM \?CCL3
	RETURN	CREW
?CCL3:	FSET?	CAPT-QUARTERS,TOUCHBIT \FALSE
	RETURN	CRULLEY


	.FUNCT	I-MEET-HERO
	SET	'AWAITING-REPLY,5
	CALL	QUEUE,I-REPLY,1
	SET	'QUESTIONER,HERO
	PRINT	INDENT
	EQUAL?	HERO-CTR,1 \?CCL3
	MOVE	HERO,HERE
	CALL	QUEUE,I-MEET-HERO,-1
	LESS?	ATTACK-C,2 \?CCL6
	CALL	DEQUEUE,I-CRULLEY
	FSET	CRULLEY,DEADBIT
	PRINTD	CRULLEY
	PRINTI	" drags you, despite your resistance, to"
	LOC	PROTAGONIST
	EQUAL?	STACK,CABIN-BED \?CCL9
	MOVE	PROTAGONIST,HERE
	PRINTI	" your feet"
	JUMP	?CND7
?CCL9:	PRINTI	"wards him"
?CND7:	PRINTI	". Then suddenly he grunts, stiffens and slumps into your arms. "
	PRINT	STUNNED-THE-SAILOR
	PRINTI	".
   A tall form blocks the shattered door, one fist still raised from striking your attacker"
	JUMP	?CND4
?CCL6:	CALL	CTPRINT,DOOR
	PRINTI	" creaks slightly as a tall form bends through its smashed remains. ""You seem to have this situation well in hand,"" timbers a well-bred voice"
?CND4:	PRINTI	". You catch a glimpse of the hard masculinity of his broad shoulders, the implied power in the scar that etches the stranger's jaw, and feel tremors course through your veins. Then you realize how ragged are his shirt, patched breeches and high boots. Intuitively, you understand -- he is the dreaded Falcon, scourge of the sea! Alas, your fate is sealed. Resigned, you meet his sea-blue eyes."
	CRLF	
	JUMP	?CND1
?CCL3:	EQUAL?	HERO-CTR,2 \?CCL11
	MOVE	LETTER,PROTAGONIST
	CALL	THIS-IS-IT,LETTER
	PRINT	SURPRISE
	PRINTI	"the stranger bows. ""Well met, my lady."" His accent is cultured, his smile vibrant. ""I am Captain Nicholas Jamison, known in these waters as 'The Falcon'. Your father has sent me."" He chuckles at your glare of distrust. ""Yes, you are like your sire. You needn't believe me untried -- I carry this."" He hands you"
	CALL	ARPRINT,LETTER
	JUMP	?CND1
?CCL11:	EQUAL?	HERO-CTR,3 \?CCL13
	FSET	DOOR,OPENBIT
	PRINT	CTHE-PIRATE-CAPTAIN
	PRINTI	"glances around the empty room, then notices the coffer"
	IN?	COFFER,PROTAGONIST \?CND14
	PRINTI	" in your arms"
?CND14:	MOVE	COFFER,HERO
	PRINTI	". ""Davis's safety box -- my men were hoping I'd find it."" He takes it and nudges the unconscious man on the floor, ""I wonder how "
	PRINTD	CRULLEY
	PRINTI	" knew you were here? Just his bad luck? He'll be flogged when he wakes.""
   The pirate bows. ""My lady, may I offer my protection and my ship until your father is free?"""
	CRLF	
	JUMP	?CND1
?CCL13:	EQUAL?	HERO-CTR,4,5 \?CND1
	EQUAL?	HERO-CTR,4 \?CCL19
	ZERO?	REACTION \?CCL19
	SET	'QUESTIONER,HERO
	PRINTI	"""We haven't time to waste. Will you come willingly or not?"" says"
	CALL	TRPRINT,HERO
	JUMP	?CND1
?CCL19:	CALL	DEQUEUE,I-MEET-HERO
	CALL	DEQUEUE,I-PIRATE-ATTACK
	EQUAL?	REACTION,REACTION-POSITIVE \?CCL24
	PRINTI	"He chuckles. ""Brave lady, to trust a stranger -- and a pirate. Who knows, perhaps I forged your father's signature? Keep by my side as we go to my ship -- few sailors respect a lady's dignity."" He helps you through"
	CALL	TRPRINT,DOOR
	CRLF	
	JUMP	?CND22
?CCL24:	PRINTI	"He sighs, ""You share"
	CALL	TPRINT,DAD
	PRINTI	"'s stubborn streak. I wished not to do this."" He leaps to your side, hauling you up onto his shoulder, and carries you out of the room."
	CALL	TPRINT,HERO
	PRINTI	" sets you on your feet again on the horror of the deck"
	PRINT	PCR
	CRLF	
?CND22:	FSET	HERO,NDESCBIT
	MOVE	HERO,DEUX-DECK
	CALL	GOTO,DEUX-DECK
?CND1:	INC	'HERO-CTR
	RETURN	HERO-CTR


	.FUNCT	I-HSHIP
	PRINT	INDENT
	GET	HERO-SHIP-SPEECHES,HERO-CTR
	PRINT	STACK
	CRLF	
	EQUAL?	HERO-CTR,2 \?CCL3
	REMOVE	HERO
	CALL	QUEUE,I-HSECOND-BYE,8
	JUMP	?CND1
?CCL3:	CALL	QUEUE,I-HSHIP,1
?CND1:	INC	'HERO-CTR
	RETURN	HERO-CTR


	.FUNCT	I-HSECOND-BYE
	CALL	RUNNING?,I-OVERHEAR-CRULLEY
	ZERO?	STACK \?CTR2
	EQUAL?	HERE,SLEEPING-CUPBOARD \?CCL3
?CTR2:	CALL	QUEUE,I-HSECOND-BYE,2
	RSTACK	
?CCL3:	MOVE	JEWEL,PROTAGONIST
	PRINT	INDENT
	PRINTI	"You hear"
	EQUAL?	HERE,CAPT-QUARTERS \?CCL8
	CALL	TPRINT,CUPBOARD-OBJECT
	PRINTI	" scrape"
	JUMP	?CND6
?CCL8:	EQUAL?	HERE,LANDING \?CCL10
	CALL	TPRINT,DOOR
	PRINTI	" being unbarred"
	JUMP	?CND6
?CCL10:	PRINTI	" a footstep"
?CND6:	PRINTI	", "
	FSET?	CHEMISE,EVERYBIT /?CCL13
	PRINTI	"turn, and cover "
	PRINTD	ME
	PRINTI	" as best you can with what you are holding, for Jamison stands there, his eyes burning through your lightweight chemise. He chuckles, ""I am not sorry in the least that I surprised you."
	JUMP	?CND11
?CCL13:	ZERO?	BOY-DRESS? /?CCL15
	PRINTI	"and"
	CALL	TPRINT,HERO
	PRINTI	"'s startled laugh. ""For a moment I thought you were Matthew, the boy who used to sleep in the cupboard. He ran off last port."
	JUMP	?CND11
?CCL15:	PRINTI	"and turn to see"
	CALL	TPRINT,HERO
	PRINTI	". ""Hello!"
?CND11:	EQUAL?	HERE,CAPT-QUARTERS /?CND16
	PRINTI	" How did you escape? Don't stutter, I won't lock you up again -- you are safe as long as you remain below-decks."
?CND16:	PRINTI	" I came down to give you this -- my allotment from"
	CALL	TPRINT,COFFER
	PRINTI	"."" He nods at the box in his arms.
   Jamison starts to pin"
	CALL	APRINT,JEWEL
	PRINTI	" on your clothes, but, ""Devil take it, the clasp is broken. I'll have it repaired."" He folds the pretty thing into "
	PRINTD	HANDS
	PRINTI	". ""And I meant to reassure you that if the men suddenly abandon ship, they are off to help me. Rodney will stay behind with you."" He "
	EQUAL?	HERE,CAPT-QUARTERS \?CCL20
	MOVE	COFFER,HERE
	PRINTI	"drops"
	CALL	TPRINT,COFFER
	PRINTI	" on the floor, smiling in farewell,"
	JUMP	?CND18
?CCL20:	MOVE	COFFER,PROTAGONIST
	PRINTI	"hands"
	CALL	TPRINT,COFFER
	PRINTI	" to you. ""Please return this to my quarters for me, will you?"""
?CND18:	PRINTI	" and walks swiftly "
	EQUAL?	HERE,LANDING \?CCL23
	PRINTI	"up the stairs to the deck, barring the door a moment later"
	JUMP	?CND21
?CCL23:	PRINTI	"away"
?CND21:	PRINT	PCR
	CALL	QUEUE,I-SMELL-SMOKE,3
	CALL	QUEUE,I-HERO-TO-ISLAND,5
	RETURN	8


	.FUNCT	I-HDANCE
	EQUAL?	HERO-CTR,1 \?CCL3
	EQUAL?	BALLROOM,HERE \?CCL3
	MOVE	HERO,HERE
	SET	'LAFOND-CTR,1
	CALL	QUEUE,I-LDANCE,7
	SET	'PARTNER,HERO
	SET	'QUESTIONER,HERO
	SET	'AWAITING-REPLY,14
	CALL	QUEUE,I-REPLY,2
	SET	'DANCED-WITH,HERO
	PRINT	INDENT
	PRINTD	HERO
	PRINTI	" moves up to you, saying, ""May I have this dance?"" He doesn't await an answer, sweeping you out onto"
	PRINT	DANCE-FLOOR
	PRINT	PCR
	JUMP	?CND1
?CCL3:	EQUAL?	HERO-CTR,2 \?CCL7
	SET	'QUESTIONER,HERO
	ZERO?	MET-ALREADY \?CCL10
	SET	'MET-ALREADY,TRUE-VALUE
	PRINT	INDENT
	PRINTC	34
	PRINT	FIRST-SIGHTING
	PRINTI	"smiles suddenly. ""Why should I complain? You are quite safe, since no one expects you here. And you are looking lovely."""
	CRLF	
	JUMP	?CND8
?CCL10:	CALL	HERO-TALKS
?CND8:	EQUAL?	HERE,BALLROOM \?CND1
	PRINT	INDENT
	PRINTI	"The steps of the dance separate you a moment, as you twirl around and curtsey to another dancer. You glide back into the captain's arms"
	PRINT	PCR
	JUMP	?CND1
?CCL7:	EQUAL?	HERO-CTR,3 \?CCL14
	SET	'QUESTIONER,HERO
	CALL	HERO-TALKS
	EQUAL?	HERE,BALLROOM \?CND1
	PRINT	INDENT
	PRINTI	"Your hands linked tightly with his and held high over "
	PRINTD	HEAD
	PRINTI	"s, a line of dancers files between you and Jamison"
	PRINT	PCR
	JUMP	?CND1
?CCL14:	EQUAL?	HERO-CTR,4 \?CCL18
	SET	'QUESTIONER,HERO
	CALL	HERO-TALKS
	EQUAL?	HERE,BALLROOM \?CND1
	PRINT	INDENT
	PRINTI	"Together you whirl around the ballroom, his arm snug around your waist, leading you gracefully, masterfully.
    Nicholas's grip tenses as he nods to a bewigged man staring at you. You turn, and the man moves on"
	PRINT	PCR
	JUMP	?CND1
?CCL18:	EQUAL?	HERO-CTR,5 \FALSE
	REMOVE	HERO
	SET	'PARTNER,FALSE-VALUE
	CALL	DEQUEUE,I-HDANCE
	CALL	HERO-TALKS
	PRINT	INDENT
	PRINTI	"The music ends with a flourish"
	EQUAL?	HERE,BALLROOM \?CCL25
	PRINTI	" and you pirouette once more before curtseying to Jamison. As you move"
	JUMP	?CND23
?CCL25:	PRINTI	". As he guides you back"
?CND23:	PRINTI	" to the side of"
	PRINT	DANCE-FLOOR
	PRINTI	", Nick adds, ""We should separate -- I'm sure I am being watched. You would be safer aboard"
	CALL	TPRINT,SHIP
	PRINTI	". If you slip out the veranda doors, no one will notice you leaving."" He touches "
	PRINTD	HANDS
	PRINTI	" and dissolves into the crowd"
	PRINT	PCR
	EQUAL?	HERE,BALLROOM /?CND1
	CALL	GOTO,BALLROOM
?CND1:	INC	'HERO-CTR
	RETURN	HERO-CTR


	.FUNCT	I-HARRESTED,FROM-LDANCE=0
	SET	'HERO-ARRESTED,TRUE-VALUE
	PRINT	INDENT
	PRINTI	"There is a commotion from the west. A woman screams and a man yells, ""Stop, Pirate!"" "
	ZERO?	FROM-LDANCE \?CCL3
	EQUAL?	HERE,FOYER /?CCL3
	CALL	HELD?,HAT
	ZERO?	STACK /?CND6
	FCLEAR	HAT,WORNBIT
	MOVE	HAT,LIBRARY
?CND6:	PRINTI	"You run to the foyer in time to see two dragoons dragging out the battered frame of"
	CALL	TPRINT,HERO
	JUMP	?CND1
?CCL3:	PRINTI	"and Jamison is dragged out of the ballroom by two burly dragoons"
?CND1:	PRINT	PCR
	PRINTI	"   An officer quiets the guests, ""This is the buccaneer who has been pirating our ships. He had the audacity to come here tonight intending to assassinate our dear governor. Do not worry, ladies, he was arrogant enough to come alone."" The officer marches after his men. "
	CALL	CTPRINT,DANCERS
	PRINTI	"s return to their banal conversations"
	PRINT	PCR
	ZERO?	FROM-LDANCE \?CCL10
	CRLF	
	CALL	GOTO,FOYER
	RSTACK	
?CCL10:	CALL	QUEUE,I-LDANCE,1
	SET	'PARTNER,LAFOND
	PRINT	INDENT
	PRINTI	"Only the painful grip"
	CALL	TPRINT,LAFOND
	PRINTR	" has on your arm prevents you from swooning away. ""Ah, so that's the way of it,"" he purrs, noticing your sudden pallor. ""All the better for me."" He pulls you unresisting into a dance."


	.FUNCT	I-HFOLLY,CALLED-BY-HERO-F=0
	EQUAL?	HERE,FOLLY \FALSE
	SET	'QUESTIONER,HERO
	ZERO?	CALLED-BY-HERO-F \?CND4
	PRINT	INDENT
?CND4:	EQUAL?	HERO-CTR,1 \?CCL8
	CALL	QUEUE,I-HFOLLY,-1
	MOVE	HERO,FOLLY
	PRINTD	HERO
	PRINTI	" enters"
	CALL	TPRINT,FOLLY-OBJECT
	PRINTI	", stooping to avoid the flowers dangling over the door. ""I thought I heard someone."
	ZERO?	MET-ALREADY \?CCL11
	SET	'MET-ALREADY,TRUE-VALUE
	PRINTC	32
	PRINT	FIRST-SIGHTING
	JUMP	?CND9
?CCL11:	PRINTI	""" Jamison "
?CND9:	PRINTI	"sighs. ""What an astonishing girl you are, my dear. "
	FSET?	CHEMISE,EVERYBIT /?CCL14
	PRINTI	"If --"""
	PRINT	EYES-RAKE
	PRINTI	", ""somewhat underdressed"
	JUMP	?CND12
?CCL14:	ZERO?	BOY-DRESS? /?CCL16
	PRINTI	"And so ingeniously dressed"
	JUMP	?CND12
?CCL16:	PRINTI	"And looking more lovely than ever"
?CND12:	PRINTI	"."" He plucks"
	CALL	APRINT,FLOWER
	PRINTI	" from the tangle above the door, and sets it in your hair. ""The beauty of this blossom is nothing to yours."""
	CRLF	
	MOVE	FLOWER,PROTAGONIST
	FCLEAR	FLOWER,NDESCBIT
	FSET	FLOWER,TAKEBIT
	JUMP	?CND1
?CCL8:	EQUAL?	REACTION,REACTION-NEGATIVE /?PRD20
	EQUAL?	HERO-CTR,6 \?CCL18
?PRD20:	IN?	HERO,HERE \?CCL18
	CALL	DEQUEUE,I-HFOLLY
	SET	'QUESTIONER,FALSE-VALUE
	REMOVE	HERO
	PRINTI	"Jamison backs away from you, smiling wistfully"
	PRINTC	46
	PRINT	HERO-LEAVES-FOLLY
	JUMP	?CND1
?CCL18:	EQUAL?	HERO-CTR,2 \?CCL24
	PRINTI	"Catching his breath, Jamison pulls you against him, his hands circling your waist"
	IN?	FLOWER,PROTAGONIST \?CND25
	PRINTI	", crushing"
	CALL	TPRINT,FLOWER
	PRINTI	" between you"
?CND25:	PRINTI	". ""Darling,"" he whispers, leaning over you, ""oh, my angel ..."""
	CRLF	
	JUMP	?CND1
?CCL24:	EQUAL?	HERO-CTR,3 \?CCL28
	SET	'AWAITING-REPLY,15
	CALL	QUEUE,I-REPLY,2
	PRINTI	"""My lovely,"" Jamison says huskily. His eyes burn intently, their blue like the sea on a summer day. A shiver of warmth flows through you, and you tremble at his touch. The pirate's hands, warm and exciting, caress you, searing through the thin linen of your chemise. His lips near yours, his breath softly scented. ""May I kiss you?"""
	CRLF	
	JUMP	?CND1
?CCL28:	EQUAL?	HERO-CTR,4 \?CCL30
	PRINTI	"Tender is his kiss, soft his lips as his body presses hard against you. You drown in the tide of your passion, swept like the sea against the rocks of the shore."
	CRLF	
	JUMP	?CND1
?CCL30:	EQUAL?	HERO-CTR,5 \?CND1
	REMOVE	HERO
	PRINTI	"With a pent-up sigh, Nicholas forces himself away from you. ""Now is not the time or the place to advance my suit,"" he says, wistfully. ""But the night is still young and you are so beautiful! I must be gone, lest I lose my soul in you."""
	PRINT	HERO-LEAVES-FOLLY
?CND1:	INC	'HERO-CTR
	RETURN	HERO-CTR


	.FUNCT	HERO-TALKS
	PRINT	INDENT
	RANDOM	100
	LESS?	65,STACK /?CCL3
	LESS?	WHAT-HERO-SAYS,3 \?CCL3
	ZERO?	WHAT-HERO-SAYS \?CCL8
	ZERO?	HDAD-SPEECH /?CCL8
	CALL	PICK-ONE,MANNERISMS
	PRINT	STACK
	PRINT	PCR
	RTRUE	
?CCL8:	GET	HERO-SPEECHES,WHAT-HERO-SAYS
	PRINT	STACK
	PRINT	PCR
	INC	'WHAT-HERO-SAYS
	RETURN	WHAT-HERO-SAYS
?CCL3:	CALL	PICK-ONE,MANNERISMS
	PRINT	STACK
	PRINT	PCR
	RTRUE	


	.FUNCT	RAPIER-F,OARG=0
	ZERO?	OARG /?CCL3
	EQUAL?	HERE,DUNGEON \FALSE
	EQUAL?	OARG,M-DESC? /TRUE
	PRINT	INDENT
	PRINTI	"A rapier lies in the half-dark of a corner."
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?TAKE \?CCL10
	FSET?	HERO,DEADBIT /?CCL13
	IN?	HERO,HERE \?CCL13
	PRINTR	"Jamison prevents you, ""This is not a weapon for ladies."""
?CCL13:	EQUAL?	HERE,DUNGEON \?CCL17
	IN?	CRULLEY,DUNGEON \?CCL17
	FSET?	RAPIER,TOUCHBIT /?CCL17
	CALL	ITAKE,FALSE-VALUE
	EQUAL?	STACK,M-FATAL,FALSE-VALUE /?CCL17
	PRINTI	"Taken. "
	PRINTD	CRULLEY
	PRINTR	" snorts, ""Be careful, you might hurt yer dearie."""
?CCL17:	IN?	RAPIER,COOKIE \FALSE
	PRINTD	COOKIE
	PRINTR	" objects. ""It ain't fer a lady."""
?CCL10:	EQUAL?	PRSA,V?PUT-THROUGH,V?PUT,V?THROW \?CCL25
	EQUAL?	PRSI,TRAP /?CTR24
	EQUAL?	PRSI,CRULLEY \?CCL25
	FSET?	CRULLEY,MUNGBIT \?CCL25
?CTR24:	PRINTR	"But you might need it later!"
?CCL25:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"Jamison's rapier is a dangerous looking sword with a narrow pointed blade"
	EQUAL?	HERE,CABIN,DEUX-DECK /?CND34
	PRINTI	". It is decorated with a big floppy ribbon"
?CND34:	PRINT	PCR
	RTRUE	

	.ENDI
