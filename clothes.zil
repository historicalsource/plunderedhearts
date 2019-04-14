"CLOTHES for
		      PLUNDERED HEARTS
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<OBJECT PANTS
	(IN SLEEPING-CUPBOARD)
	(DESC "breeches")
	(SYNONYM BREECHES PANTS CLOTHES BRITCHES)
	(ADJECTIVE BREEKS)
	(FLAGS TAKEBIT WEARBIT PLURALBIT ;BURNBIT NDESCBIT)
	(GENERIC GEN-CLOTHES)
	(ACTION GARMENT-F)>

<OBJECT SHIRT
	(IN SLEEPING-CUPBOARD)
	(DESC "shirt")
	(SYNONYM SHIRT CLOTHES)
	(ADJECTIVE WHITE)
	(FLAGS TAKEBIT WEARBIT ;BURNBIT NDESCBIT)
	(GENERIC GEN-CLOTHES)
	(ACTION GARMENT-F)>

<OBJECT PILE-OF-CLOTHES
	(IN CUPBOARD-OBJECT)
	(DESC "pile of clothes")
	(FDESC "Kicked into a far corner is a pile of clothes.")
	(SYNONYM CLOTHES)
	(ADJECTIVE PILE)
	(SIZE 10)
	(FLAGS TRYTAKEBIT TAKEBIT WEARBIT)
	(GENERIC GEN-CLOTHES)
	(ACTION PILE-OF-CLOTHES-F)>

<ROUTINE PILE-OF-CLOTHES-F ()
	 <COND (<VERB? TAKE EXAMINE PUT-ON WEAR>
		<COND (<EQUAL? ,HERE ,LANDING ,CAPT-QUARTERS>
		       <CANT-REACH ,PRSO>
		       ;<TELL ,YOU-CANT "quite reach them from here." CR>)
		      (<NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>
		       <REMOVE ,PILE-OF-CLOTHES>
		       <FSET ,PILE-OF-CLOTHES ,TOUCHBIT>
		       <MOVE ,SHIRT ,PROTAGONIST>
		       <MOVE ,PANTS ,PROTAGONIST>
		       <FCLEAR ,SHIRT ,NDESCBIT>
		       <FCLEAR ,PANTS ,NDESCBIT>
		       <FSET ,SHIRT ,TOUCHBIT>
		       <FSET ,PANTS ,TOUCHBIT>
		       <SETG SCORE <+ ,SCORE 1>>
		       <COND (<VERB? EXAMINE>
			      <TELL "To get a better look, y">)
			     (T
			      <TELL "Y">)>
		       <TELL
"ou pick up" T ,PILE-OF-CLOTHES ". It separates into a
pair of " D ,PANTS " and" AR ,SHIRT>)>)>>

<ROUTINE GEN-CLOTHES ()
	 <COND (<EQUAL? ,W?CLOTHES <GET ,P-NAMW 0> <GET ,P-NAMW 1>>
		<COND (<AND <EQUAL? ,HERE ,SLEEPING-CUPBOARD>
			    <NOT <FSET? ,SHIRT ,TOUCHBIT>>
			    <NOT <FSET? ,PANTS ,TOUCHBIT>>>
		       ,PILE-OF-CLOTHES)
		      (<VERB? REMOVE TAKE-OFF>
		       <COND (<PRE-DOFF>
			      <RETURN ,NOT-HERE-OBJECT>)
			     (T
			      <REMOVE-CLOTHES T>
			      <RETURN ,NOT-HERE-OBJECT>)>
		       ;<COND (<NOT <PRE-DOFF>>
			      <REMOVE-CLOTHES T>
			      <RETURN ,NOT-HERE-OBJECT>)
			     (T
			      <RFALSE>)>)>)
	       (<EQUAL? ,W?DRESS <GET ,P-NAMW 0> <GET ,P-NAMW 1>>
		<COND (<VERB? REMOVE TAKE-OFF>
		       <COND (<PRE-DOFF>
			      <RETURN ,NOT-HERE-OBJECT>)
			     (T
			      <REMOVE-CLOTHES T>
			      <RETURN ,NOT-HERE-OBJECT>)>
		       ;<COND (<NOT <PRE-DOFF>>
			      <REMOVE-CLOTHES T>
			      <RETURN ,NOT-HERE-OBJECT>)
			     (T
			      <RFALSE>)>)
		      (<VERB? DROP>
		       <COND (<AND <FSET? ,GOWN ,WORNBIT>
				   <HELD? ,DRESS>>
			      <TELL "[" D ,DRESS "]" CR>
			      <RETURN ,DRESS>)
			     (<AND <FSET? ,DRESS ,WORNBIT>
				   <HELD? ,GOWN>>
			      <TELL "[" D ,GOWN "]" CR>
			      <RETURN ,GOWN>)
			     (T
			      <DO-FIRST "remove">
			      <RETURN ,NOT-HERE-OBJECT>)>)
		      
		      (T
		       <RFALSE>)>)
	       (T
		<RFALSE>)>>

<OBJECT DRESS                      ;"MUNGBIT = rip dress the first time"
	(IN PROTAGONIST)
	(DESC "cotton frock")
	(SYNONYM CLOTHES DRESS FROCK)
	(ADJECTIVE COTTON)
	(FLAGS TAKEBIT WEARBIT WORNBIT ;BURNBIT)
	(SIZE 5)
	(GENERIC GEN-CLOTHES)
	(ACTION GARMENT-F)>

<OBJECT GOWN
	(IN BEDROOM) 
	(DESC "beautiful ball gown")
	(FDESC "Draped across the bed is a lovely cream colored watered silk
gown. It looks about your size.")
	(SYNONYM GOWN DRESS CLOTHES)
	(ADJECTIVE BALL SILK)
	(FLAGS TAKEBIT WEARBIT ;BURNBIT)
	(GENERIC GEN-CLOTHES)
	(ACTION GARMENT-F)>

<GLOBAL WET-RAG <>>
<GLOBAL WET-DRESS <>>
<GLOBAL BOY-DRESS? <>>
<GLOBAL GOWN-POINT <>>

<ROUTINE GARMENT-F ()         ;"For all clothes but chemise,shoes,hoops."
	 <COND (<VERB? EXAMINE>
		<COND (<PRSO? ,DRESS>
		       <COND (,WET-DRESS
			      <WET-DESC ,DRESS>
			      <RTRUE>)
			     (T 
			      <TELL
"It is your favorite old frock, looking rather bedraggled without its hoops">
			      <COND (<NOT <FSET? ,DRESS ,EVERYBIT>>
				     <FSET ,DRESS ,EVERYBIT>
				     <TELL
", which you hadn't time to put on during the pirate attack">)>
			      <TELL ". ">
			      <COND (<FSET? ,DRESS ,MUNGBIT>
			             <TELL
"There is a tear out of the skirt">)
				    (T
				     <TELL
"The worn fabric of the skirt often catches on things, tearing">)>
			      <TELL ,PCR>)>)
		      (<PRSO? ,GOWN>
		       <TELL
"Of cream silk, heavily embroidered on the stiffened skirt and stomacher,"
T ,GOWN " is a work of art" ,PCR>)
		      (<PRSO? ,SHIRT>
		       <TELL CTHE ,SHIRT " is clean and not too big">
		       <COND (<FSET? ,SHIRT ,MUNGBIT>
			      <TELL ,TEAR>)>
		       <TELL ,PCR>)
		      (T
		       <TELL CTHE ,PANTS " are about your size." CR>)>)
	       (<AND <VERB? LOOK-INSIDE LOOK-UNDER>
		     <FSET? ,PRSO ,WORNBIT>>
		<TELL "Just" A ,CHEMISE ", and a couple fleas" ,PCR>)
	       (<VERB? WEAR>
		<COND (<OR <AND <PRSO? ,DRESS ,GOWN>
				<OR <FSET? ,SHIRT ,WORNBIT>
				    <FSET? ,PANTS ,WORNBIT>>>
			   <AND <PRSO? ,SHIRT ,PANTS>
				<OR <FSET? ,DRESS ,WORNBIT>
				    <FSET? ,GOWN ,WORNBIT>>>>
		       <TELL
CTHE ,PRSO " doesn't fit over what you are already wearing" ,PCR>)
		      (<AND ,WET-DRESS
			    <PRSO? ,DRESS>>
		       <TELL
"The clammy cotton makes it too uncomfortable to wear." CR>) 
		      (T
		       <FSET ,PRSO ,WORNBIT>
		       <MOVE ,PRSO ,PROTAGONIST>
		       <COND (<AND <PRSO? ,PANTS ,SHIRT>
				   <IN? ,PILE-OF-CLOTHES ,SLEEPING-CUPBOARD>>
			      <FSET ,PILE-OF-CLOTHES ,TOUCHBIT>
			      <REMOVE ,PILE-OF-CLOTHES>
			      <SETG SCORE <+ ,SCORE 1>>)>
		       <COND (<PRSO? ,PANTS>
			      <TELL "You tuck" T ,CHEMISE>
			      <COND (<FSET? ,SHIRT ,WORNBIT>
				     <SETG BOY-DRESS? T>
				     <FSET ,CHEMISE ,EVERYBIT>
				     <TELL " and" T ,SHIRT>)>
			      <TELL
" into the pants. You look a little fat, but now you can move freely" ,PCR>)
			     (<PRSO? ,SHIRT>
			      <COND (<FSET? ,PANTS ,WORNBIT>
				     <FSET ,CHEMISE ,EVERYBIT>
				     <SETG BOY-DRESS? T>)>
			      <TELL
"It fits loosely, masking your figure" ,PCR>)
			     (T
			      <FSET ,CHEMISE ,EVERYBIT>
			      <COND (<AND <NOT ,GOWN-POINT>
					  <PRSO? ,GOWN>>
				     <SETG GOWN-POINT T>
				     <SETG SCORE <+ ,SCORE 1>>
				     <TELL
CTHE ,GOWN " fits perfectly, the creamy silk bringing a
glow to your cheeks. You comb your hair with your fingers and
bite your lips to make them red" ,PCR>)
				    (T
				     <TELL "You don" TR ,PRSO>)>)>)>)
	       (<AND <VERB? TAKE-OFF REMOVE>
		     <FSET? ,PRSO ,WORNBIT>>
		<COND ;(<CHECK-STRIP>
		       <RTRUE>)
		      (<EQUAL? ,PRSO ,DRESS>
		       <FCLEAR ,PRSO ,WORNBIT>
		       <FCLEAR ,CHEMISE ,EVERYBIT>
		       <TELL "You take off" T ,DRESS>
		       ;<COND (<FSET? ,HOOPS ,WORNBIT>
			      <TELL
", but are inclined to giggle at the sight of"
T ,HOOPS " swinging nakedly over your chemise">)>
		       <TELL ,PCR>)
		      (T
		       <COND (<PRSO? ,SHIRT ,PANTS>
			      <SETG BOY-DRESS? <>>)>
		       <FCLEAR ,PRSO ,WORNBIT>
		       <FCLEAR ,CHEMISE ,EVERYBIT>
	               <TELL
"You remove" T ,PRSO ", exposing your ">
		       <COND (<PRSO? ,PANTS>
			      <TELL "ankles">)
			     (<PRSO? ,SHIRT>
			      <TELL "elbows">)
			     (T
			      <TELL D ,CHEMISE>)>
		       <TELL ,PCR>)>)
	       (<OR <VERB? RIP>
		    <AND <VERB? CUT>
			 <HELD? ,DAGGER>>>
		<COND (<PRSO? ,DRESS>
		       <COND (<NOT <LOC ,RAG>>
			               
				;"returns <> when REMOVEd."

			      <MOVE ,RAG ,PROTAGONIST>
			      <COND (<EQUAL? ,WET-DRESS ,WATER>
				     <SETG WET-RAG ,WATER>)
				    (<EQUAL? ,WET-DRESS ,RUM>
				     <SETG WET-RAG ,RUM>)
				    (T
				     <SETG WET-RAG <>>)>
			      <FSET ,RAG ,TOUCHBIT>
			      <COND (<NOT <FSET? ,DRESS ,MUNGBIT>>
				     <FSET ,DRESS ,MUNGBIT>
				     
				     ;"Can be ripped automatically now"
				     ;<SETG SCORE <+ ,SCORE 1>>)>
			      
			      <TELL "You ">
			      <COND (<VERB? CUT>
				     <MOVE ,DAGGER ,PROTAGONIST>
				     <TELL "cut">)
				    (T
				     <TELL "rip">)>
			      <TELL " a large rag out of" TR ,DRESS>)
			     (<NOT <HELD? ,RAG>>
			      <TELL
"There already is a rag around here somewhere" ,PCR>)
			     (T 
			      <TELL ,YOU-HAVE-ALREADY AR ,RAG>)>)
		      (<PRSO? ,GOWN>
		       <TELL CTHE ,GOWN " is too fine to ruin" ,PCR>)
		      (T
		       <TELL "The fabric is too tightly woven" ,PCR>)>)
	       ;(<old-VERB? RIP CUT>
		<COND (<PRSO? ,DRESS>
		       <COND (<NOT <LOC ,RAG>>
			               
				;"returns <> when REMOVEd."

			      <MOVE ,RAG ,PROTAGONIST>
			      <COND (<EQUAL? ,WET-DRESS ,WATER>
				     <SETG WET-RAG ,WATER>)
				    (<EQUAL? ,WET-DRESS ,RUM>
				     <SETG WET-RAG ,RUM>)
				    (T
				     <SETG WET-RAG <>>)>
			      <FSET ,RAG ,TOUCHBIT>
			      <COND (<NOT <FSET? ,DRESS ,MUNGBIT>>
				     <FSET ,DRESS ,MUNGBIT>
				     <SETG SCORE <+ ,SCORE 1>>)>
			      <TELL "You ">
			      <COND (<VERB? CUT>
				     <TELL "cut">)
				    (T
				     <TELL "rip">)>
			      <TELL " a large rag out of" TR ,DRESS>)
			     (<NOT <HELD? ,RAG>>
			      <TELL
"There already is a rag around here somewhere" ,PCR>)
			     (T 
			      <TELL ,YOU-HAVE-ALREADY AR ,RAG>)>)
		      (<PRSO? ,GOWN>
		       <TELL CTHE ,GOWN " is too fine to ruin" ,PCR>)
		      (T
		       <TELL "The fabric is too tightly woven" ,PCR>)>)
	       (<AND <VERB? TAKE>
		     <PRSO? ,SHIRT ,PANTS>
		     <IN? ,PILE-OF-CLOTHES ,HERE>>
		<PERFORM ,V?TAKE ,PILE-OF-CLOTHES>
		<RTRUE>)>>

<OBJECT RAG
	(DESC "rag")
	(SYNONYM RAG CLOTH)
	(ADJECTIVE WET SCRAP PIECE)
	(FLAGS TAKEBIT)
	(ACTION RAG-F)>

<ROUTINE RAG-F ()
	 <COND (<VERB? SOAK>
		<COND (<EQUAL? ,HERE ,BY-SHIP ,LAGOON ,SHALLOWS 
			       ,BEACH ,MAIN-DECK>
		       <DIP-DRESS>)
		      (T
		       <PROPOSE>)>)
	       (<AND <ADJ-USED ,A?WET>
		     <NOT ,WET-RAG>>
		<TELL ,YOU-CANT-SEE-ANY "wet rag here" ,PCR>)
	       (<VERB? EXAMINE>
		<COND (<NOT ,WET-RAG>
		       <TELL
"It is a fairly hefty scrap of fabric" ,PCR>)
		      (T
		       <WET-DESC ,RAG>)>) 
	       (<VERB? RIP>
		<WASTES>)
	       (<VERB? TIE>
		<TELL "It won't stay tied" ,PCR>)
	       (<VERB? PUT>
		<COND (<PRSI? ,FENCE ,GATE>
		       <WASTES>)
		      (<PRSI? ,FUSE>
		       <PROPOSE>)>)
	       (<AND <VERB? THROW>
		     <PRSI? ,FUSE>>
		<PERFORM ,V?THROW-OVER ,RAG ,FENCE>
		<RTRUE>)>>

; "The rag, or alternately, the dress, is set to SEA if it is dipped in water
of any kind (easier to type). Then it is described as wet. If the dress is
wet and THEN the rag is ripped out, the rag will still be wet. You can get as
many rags as you like, with access to only one at a time. If it works." 

<ROUTINE WET-DESC (OBJ)
	 <TELL
"The " D .OBJ " is soaked and dripping with ">
	 <COND (<OR <AND <EQUAL? .OBJ ,RAG>
			 <EQUAL? ,WET-RAG ,RUM>>
		    <AND <EQUAL? .OBJ ,DRESS>
			 <EQUAL? ,WET-DRESS ,RUM>>>
		<TELL "rum">)
	       (<OR <AND <EQUAL? .OBJ ,RAG>
			 <EQUAL? ,WET-RAG ,WATER>>
		    <AND <EQUAL? .OBJ ,DRESS>
			 <EQUAL? ,WET-DRESS ,WATER>>>
		<TELL "water">)>
	 <TELL ,PCR>>

;<OBJECT HOOPS
	(IN PROTAGONIST)
	(DESC "your hoops")
	(SYNONYM HOOPS)
	(FLAGS TAKEBIT WEARBIT WORNBIT PLURALBIT VOWELBIT NARTICLEBIT)
	(ACTION HOOPS-F)>

;<GLOBAL HEAVY " heavy and uncomfortable">

;<ROUTINE HOOPS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The whalebone hoops">
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL "," ,HEAVY ", are tied around your waist">
		       <COND (<FSET? ,DRESS ,WORNBIT>
			      <TELL " under" T ,DRESS>)>)
		      (T
		       <TELL " are" ,HEAVY>)>
		<TELL ,PCR>)
	       (<AND <VERB? LOOK-INSIDE LOOK-UNDER>
		     <FSET? ,PRSO ,WORNBIT>>
		<TELL ,YOU-SEE " your stockinged legs, and" TR ,SHOES>)
	       (<VERB? WEAR>
		<COND ;(<OR <FIND-IN ,HERE ,ACTORBIT "in front of">
			   <EQUAL? ,HERE ,ORCHESTRA ;,SUPPER-ROOM>>
		       <TELL ,POLITE-SOCIETY>)
		      ;(<EQUAL? ,HERE ,ON-LADDER ,RIGGING-ROOM>
		       <TELL ,YOU-CANT "get dressed here!" CR>)
		      (T
		       <FSET ,HOOPS ,WORNBIT>
		       <MOVE ,HOOPS ,PROTAGONIST>
		       <TELL "You tie on" T ,HOOPS>
		       <COND (<FSET? ,PANTS ,WORNBIT>
			      <TELL " over" TR ,PANTS>)
			     (<OR <FSET? ,DRESS ,WORNBIT>
				  <FSET? ,GOWN ,WORNBIT>>
			      <TELL " under your skirts" ,PCR>)
			     (T
			      <TELL " around your waist" ,PCR>)>)>)
	       (<AND <VERB? PUT PUT-THROUGH THROW>
		     <PRSI? ,RETICULE ,WATER-BARREL ,RUM-BARREL ,CASK
			    ,LIB-WINDOW ,HOLE ,GATE ,LEDGE ,WINDOW>>
		<TELL "Your hoops are too wide to fit into" TR ,PRSI>)
	       (<VERB? UNTIE>
		<PERFORM ,V?REMOVE ,HOOPS>
		<RTRUE>)>>

<CONSTANT TEAR ". There is a tear at the bottom">

<OBJECT CHEMISE                    ;"EVERYBIT = covered by other clothes"
	(IN PROTAGONIST)           ;"MUNGBIT = rag automatically torn from it"
	(DESC "linen chemise")
	(SYNONYM CLOTHES CHEMISE SLIP PETTICOAT)
	(ADJECTIVE LINEN)
	(FLAGS TAKEBIT WEARBIT WORNBIT EVERYBIT)
	(GENERIC GEN-CLOTHES)
	(ACTION CHEMISE-F)>

<OBJECT SHOES
	(IN PROTAGONIST)
	(DESC "your kid slippers")
	(SYNONYM SHOES SLIPPERS)
	(ADJECTIVE KID)
	(FLAGS WEARBIT WORNBIT PLURALBIT NARTICLEBIT)
	(ACTION CHEMISE-F)>

<ROUTINE CHEMISE-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<PRSO? ,CHEMISE>
		       <COND (<FSET? ,CHEMISE ,EVERYBIT>
			      <TELL "It's covered by other clothes" ,PCR>)
			     (T
			      <TELL
CTHE ,CHEMISE ", kneelength and sleeveless,
clings damply to your legs and torso">
			      <COND (<FSET? ,CHEMISE ,MUNGBIT>
				     <TELL ,TEAR>)>
			      <TELL ,PCR>)>)
		      (<PRSO? ,SHOES>
		       <TELL
"They are dainty yet practical kidskin shoes" ,PCR>)>)
	       (<VERB? LOOK-INSIDE LOOK-UNDER>
		<COND (<PRSO? ,CHEMISE>
		       <TELL "Just you and your " D ,UNMENTIONABLES ,PCR>)
		      (T
		       <TELL "Your feet are in" TR ,SHOES>)>)
	       (<VERB? TAKE-OFF REMOVE>
		<TELL "But">
		<COND (<PRSO? ,SHOES>
		       <TELL T ,PRSO " are so comfortable">)
		      (T <TELL " that wouldn't be decent">)>
	        <TELL "!" CR>)
	       (<VERB? RIP CUT>
		<TELL ,YOU-CANT "bring yourself to ruin" TR ,CHEMISE>)>>

<GLOBAL PENULTIM-POINT <>>

<OBJECT GARTER
	(IN LUCY)
	(DESC "garter")
	(SYNONYM GARTER SLING SLINGSHOT)
	(ADJECTIVE RED)
	(FLAGS TAKEBIT WEARBIT ;BURNBIT INVISIBLE CONTBIT 
	               TRANSBIT SEARCHBIT INBIT OPENBIT)
	(CAPACITY 1)
	(SIZE 2)
	(ACTION GARTER-F)>

<ROUTINE GARTER-F ()
	 <COND (<VERB? WEAR>
		<COND (,MUZZLED
		       <PERFORM ,V?TAKE ,GARTER>
		       <RTRUE>)
		      (<FSET? ,PANTS ,WORNBIT>
		       <TELL
"One doesn't wear" A ,GARTER " over " D ,PANTS "!" CR>)
		      (T
		       <FSET ,GARTER ,WORNBIT>
		       <MOVE ,GARTER ,PROTAGONIST>
		       <TELL
"You slide" T ,GARTER " up around your thigh" ,PCR>)>)
	       (<AND <VERB? REMOVE TAKE>
		     ,MUZZLED>
		<COND (<NOT ,CROC-SLEEP>
		       <TELL
"The reptile surges forward as you remove" T ,GARTER>
;<TELL "As you remove" T ,GARTER ", the reptile surges forward.">
		       <JIGS-UP ". You are pulled struggling into the pool.">)
		      (T
		       <SETG MUZZLED <>>
		       <FCLEAR ,GARTER ,TRYTAKEBIT> ;"stop implicit take"
		       <FSET ,GARTER ,TAKEBIT>
		       <MOVE ,GARTER ,PROTAGONIST>
		       <TELL "You slip it off the scaly snout." CR>)>)
	       (<VERB? TAKE>
		<COND (<AND <NOT <FSET? ,GARTER ,TOUCHBIT>>
			    <EQUAL? ,HERE ,KITCHEN>
			    <NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>>
		
		;"It's poss to finish w/o garter!"
		;<SETG SCORE <+ ,SCORE 1>>
  
		            <TELL
"Taken.|
   Lucy kisses " D ,HEAD " and returns to the fire, humming" ,PCR>)
		      (<IN? ,GARTER ,DAD>
		       <MOVE ,GARTER ,PROTAGONIST>
		       <TELL "\"Take it, dear,\" Papa says." CR>)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,GARTER>>
		<COND (<NOT <IN? ,GARTER ,PROTAGONIST>>
		       <TELL ,YNH TR ,GARTER>)
		      (<AND <EQUAL? ,P-PRSA-WORD ,W?THROW>
			    <PRSO? ,STONE>>
		       <PERFORM ,V?THROW ,STONE ,GARTER>
		       <RTRUE>)
		      (<PRSO? ,STONE>
		       <COND (<FSET? ,GARTER ,WORNBIT>
			      <TELL "Not while you're wearing" TR ,GARTER>)
			     (T
			      <MOVE ,STONE ,GARTER>
			      
                              ;"LOAD GUN/PUT STONE IN GARTER"
			      <COND (<NOT ,PENULTIM-POINT>
				     <SETG PENULTIM-POINT T>
				     <SETG SCORE <+ ,SCORE 1>>)>
			      <TELL "You slip" T ,STONE " into" TR ,GARTER>)>)
		      (T
		       <TELL "It falls through" TR ,GARTER>)>)
	       (<AND <VERB? KILL>
		     <OR <FSET? ,PRSO ,ACTORBIT>
			 <PRSO? ,CROC>>>
		<PROPOSE>)
	       (<VERB? THROW SHOOT>
		<COND (<IN? ,STONE ,GARTER>
		       <COND (<NOT ,PRSI>
			      <PERFORM ,V?SHOOT ,STONE>
			      <RTRUE>)
			     (T
			      <WASTES>)>)
		      (T
		       <COND (<AND <NOT ,PRSI>
				   <VERB? THROW>>
			      <MOVE ,GARTER ,HERE>
			      <TELL "Thrown." CR>)
			     (<PRSO? ,STONE>
			      <DO-FIRST "put the stone in" ,GARTER>)
			     (T
			      <RFALSE>)>)>)
	       (<AND <VERB? SSHOOT>
		     <PRSO? ,GARTER>
		     <HELD? ,STONE>>
		<PERFORM ,V?SHOOT ,PRSI ,STONE>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL CTHE ,GARTER " is ">
		<COND (,MUZZLED
		       <TELL
"stretched taut around the jaws of" T ,CROC ,PCR>)
		      (T
		       <TELL
"made of abnormally strong, red, stretchy lace" ,PCR>)>)>>

<OBJECT UNMENTIONABLES
	(IN GLOBAL-OBJECTS)
	(DESC "unmentionables")
	(SYNONYM UNMENTIONABLES SMALLS)
	(FLAGS NARTICLEBIT NDESCBIT)
	(ACTION UNMENTIONABLES-F)>

<ROUTINE UNMENTIONABLES-F ()
	 <TELL
"Shh! Why do you think they're called " D ,UNMENTIONABLES "?" CR>>

<OBJECT RETICULE
	(IN PROTAGONIST)
	(DESC "your reticule")
	(SYNONYM RETICULE)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT CONTBIT OPENBIT SEARCHBIT ;BURNBIT WEARBIT)
	(CAPACITY 50)
	(ACTION RETICULE-F)>

<ROUTINE RETICULE-F ()
	 <COND (<AND <VERB? DROP REMOVE PUT PUT-ON PUT-THROUGH PUT-UNDER
			    THROW THROW-AT THROW-TO GIVE>
		     <PRSO? ,RETICULE>>
		<TELL "A lady is never without her reticule" ,PCR>)
	       ;(<AND <VERB? KILL>
		     <PRSO? ,CRULLEY>
		     <IN? ,COFFER ,RETICULE>>
		<PERFORM ,V?KILL ,CRULLEY ,RETICULE>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSO? ,COFFER ,RAPIER>>
		<TELL CTHE ,PRSO " won't fit in" TR ,RETICULE>)
	       (<VERB? EXAMINE>
		<TELL
"You and Mama made the little drawstring bag a few months before
she passed on. It's amazing how much it can hold" ,PCR>)>>

<OBJECT BANKNOTE
	(IN RETICULE)
	(DESC "banknote")
	(SYNONYM MONEY NOTE BANKNOTE)
	(ADJECTIVE FIFTY GUINEA FRONT BACK)
	(FLAGS TAKEBIT)
	(SIZE 1)
	(ACTION BANKNOTE-F)>

<ROUTINE BANKNOTE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "This is" T ,BANKNOTE>
		<IN-PACKAGE>
	        ;<TELL 
"The banknote pictures a fashionably dressed man, his eyes shadowed by
the brim of a flamboyant feathered hat. He is standing at ease in front
of an artist's drapery, holding a book, \"Treatise of Power.\" His other
hand rests on, or rather, grips a world globe; in fact, his thumb is on
the tiny golden crescent that represents " D ,ISLAND  ". The man's smile
closely resembles a sneer, and you don't feel quite comfortable in his
painted gaze. At the base of the painting is a scroll reading
\"Jean Lafond, King of the Caribbean.\"" CR>
		;<TELL "[This will be in the game package.]" CR>)
	       (<AND <VERB? WAVE POINT>
		     <IN? ,BUTLER ,HERE>         ;"In case of WAVE MONEY"
		     <NOT <FSET? ,BUTLER ,DEADBIT>>>
		<BRIBE-BUTLER ,PRSO>)>>

<OBJECT SALTS
	(IN RETICULE)
	(DESC "smelling salts")
	(SYNONYM SALTS CARBONATE TAG)
	(ADJECTIVE SMELLING AMMONIA)
	(FLAGS PLURALBIT TAKEBIT)
	(SIZE 3)
	(ACTION SALTS-F)>

<ROUTINE SALTS-F ("AUX" (PER <>))
	 <COND (<VERB? SMELL>
		<TELL
"You jerk" T ,SALTS " away from your nose after one brief ammoniac whiff.
Your burning nostrils make you feel more alert" ,PCR>)
	       (<VERB? WAVE>
		<COND (<AND <EQUAL? ,HERE ,DUNGEON>
			    <FSET? ,HERO ,DEADBIT>>
		       <PERFORM ,V?ALARM ,HERO ,SALTS>
		       <RTRUE>)
		      (T
		       <PERFORM ,V?SMELL ,SALTS>
		       <RTRUE>)>)
	       (<VERB? USE>
		<COND (<NOT ,PRSI>
		       <COND (<AND <SET PER <FIND-IN ,HERE ,ACTORBIT "on">>
				   <NOT <EQUAL? .PER ,CRULLEY>>>
			      <PERFORM ,V?ALARM .PER ,SALTS>
			      <RTRUE>)
			     (T
			      <PERFORM ,V?SMELL ,SALTS>
			      <RTRUE>)>)
		      (<FSET? ,PRSI ,ACTORBIT>
		       <PERFORM ,V?ALARM ,PRSI ,SALTS>
		       <RTRUE>)
		      (T
		       <TELL ,HUH>)>)
	       (<AND <VERB? PUT-UNDER PUT-ON>
		     <FSET? ,PRSI ,ACTORBIT>>
		<PERFORM ,V?ALARM ,PRSI ,SALTS>
		<RTRUE>)
	       (<VERB? GIVE>
		<PERFORM ,V?ALARM ,PRSI ,SALTS>
		<RTRUE>)
	       (<VERB? ALARM SGIVE>
		<COND (<PRSO? ,HERO>
		       <REVIVE-HERO>)
		      (<PRSO? ,ME>
		       <PERFORM ,V?SMELL ,SALTS>
		       <RTRUE>)
		      (<AND <PRSO? ,BUTLER>
			    <FSET? ,BUTLER ,DEADBIT>>
		       <TELL ,YOU-CANT "wake him" ,PCR>)
		      (<AND <PRSO? ,CRULLEY>
			    <FSET? ,CRULLEY ,DEADBIT>>
		       <SETG AWAITING-REPLY 2>
		       <QUEUE I-REPLY 2>
		       <TELL "Are you sure that's really wise?" CR>)
		      (T
		       <PRONOUN>
		       ;<COND (<PRSO? ,LUCY>
			      <TELL "She">)
			     (<FSET? ,PRSO ,ACTORBIT>
			      <TELL "He">)
			     (T
			      <TELL CTHE ,PRSO>)>
		       <TELL " doesn't need reviving" ,PCR>)>)
	       (<VERB? EXAMINE>
		<TELL
"You always carry your " D ,SALTS ", for emergencies. There is a small tag
on one side of them" ,PCR>)
	       (<VERB? READ>
		<TELL
"It says, \"For cases of vapors, hysteria or collapse,
revive persons with the smelling salts.\"" CR>)>>

<ROUTINE REVIVE-HERO ()
	 <COND (<FSET? ,HERO ,DEADBIT>
		<SETG SCORE <+ ,SCORE 1>>
		<FCLEAR ,HERO ,DEADBIT>
		<TELL
"You wave" T ,SALTS " under Nicholas's nose. He stirs, sneezes and looks
at you blearily. \"How --?\" he says, bewildered. \"Lafond, did he --?\" He ">
		<COND (<NOT <FSET? ,CHEMISE ,EVERYBIT>>
		       <TELL
"looks at you in growing horror,
glancing from your chemise to your face, and ">)>
		<TELL
"straightens. \"Darling, you are an angel, to have gone through all this
and then rescue me. Your ravisher will not go unpunished.\" He squares
his shoulders. \"For my brother, his wife, and your honor, I will
kill Jean Lafond.\"" CR>
		<COND (<IN? ,HERO ,MANACLES>
		       <SETG AWAITING-REPLY 13>
		       <QUEUE I-REPLY 2>
		       <TELL ,INDENT
"He tugs at his chains with a wry smile.
\"But I must get free first. Have you the key?\"" CR>)
		      (T
		       <NICK-RUNS-OFF>)>)
	       (T
		<TELL
"Jamison brushes you away, \"Thank you,
but I'm not having the vapors.\"" CR>)>>

<OBJECT BOTTLE
	(IN CREWS-QUARTERS)
	(DESC "leather bottle")
	(FDESC "A small bottle has been dropped nearby.")
	(SYNONYM BOTTLE LABEL)
	(ADJECTIVE BROWN SMALL LEATHER)
	(FLAGS TAKEBIT CONTBIT ;OPENBIT SEARCHBIT TRANSBIT)
	(ACTION BOTTLE-F)>

<GLOBAL LAUD-LEFT 5>  ;"Now you have five squeezes on the bottle." 
;<GLOBAL BOTTLE-EMPTY "The bottle is empty.|">

<ROUTINE BOTTLE-F ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL 
"This is a squeezable bottle. You don't need to open or close it" ,PCR>)
	       (<AND <VERB? TAKE>
		     <NOT <FSET? ,BOTTLE ,TOUCHBIT>>
		     <NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>>
		<SETG SCORE <+ ,SCORE 1>>
		<TELL "Taken." CR>)
	       (<AND <VERB? POUR PUT>
		     <PRSI? ,BOTTLE>>
		<PERFORM ,V?FILL ,BOTTLE ,PRSO>
		<RTRUE>)
	       (<AND <VERB? DRINK-FROM WRING ;TASTE>
		     <PRSO? ,BOTTLE>>
		<SQUEEZE-BOTTLE>
		;<COND (<NOT ,PRSI>
		       <MOVE ,BOTTLE ,PROTAGONIST>
		       <COND (,LAUD-LEFT
			      <TELL
"A bubble of " D ,LAUD " forms on the tip of"
T ,BOTTLE " then slurps back in." CR>)
			     ;(T
			      <TELL ,BOTTLE-EMPTY>)>)
		      (<PRSI? ,BOTTLE>
		       <IMPOSSIBLES>)
		      (<FSET? ,PRSI ,ACTORBIT>
		       <TELL ,POLITE>)
		      (<PRSI? ,CROC>
		       <PERFORM ,V?PUT ,BOTTLE ,CROC>
		       <RTRUE>)
		      (<AND <L? ,LAUD-LEFT 3>
			    <NOT <EQUAL? ,HERE ,LAFS-ROOM>>>
		       <TELL
"You stop, deciding you might need some later." CR>)
		      (<EQUAL? ,LAUD-LEFT 0>
		       <TELL "There's no " D ,LAUD " left." CR>)
		      (<G? <SETG LAUD-LEFT <- ,LAUD-LEFT 1>> 0>
		       <MOVE ,BOTTLE ,PROTAGONIST>
		       <COND (<PRSI? ,MOUTH ,ME>
			      <QUEUE I-SLEEP 2>
			      <TELL ,SQUEEZE-DROPS "into" T ,MOUTH ".">)
			     (<PRSI? ,FLAGON>
			      <SETG FLAGON-POISONED T>
;"*********** CUT"            <DOPE-WINE>)
			     (<PRSI? ,PORK>
			      <SETG PORK-DOPED T>
			      <TELL ,SQUEEZE-DROPS "onto" T ,PORK
". A patch of salt dissolves as" T ,LAUD " absorbs into the meat.">) 
			     (<PRSI? ,BLUE-GLASS ,GREEN-GLASS>
			      <PUTP ,PRSI ,P?CONTENTS 
				    <+ <GETP ,PRSI ,P?CONTENTS> ,POISONED>>
			      <DOPE-WINE>)
			     (T
			      <TELL ,SQUEEZE-DROPS "into" T ,PRSI ".">
			      <COND (<FSET? ,PRSI ,WEARBIT>
				     <TELL  " It evaporates quickly.">)>)>
		       <COND (<ZERO? ,LAUD-LEFT>
			      <TELL
" From the feel of it, the bottle is now empty.">)>
		       <CRLF>
		       <RTRUE>)>)
	       (<AND <VERB? POUR-FROM WRING>
		     <PRSO? ,LAUD>>
		<SPECIFY-WHAT "put" ,LAUD>
		;<TELL
,YOULL-HAVE-TO "specify what you want to put" T ,LAUD " into" ,PCR>)
	       (<VERB? DRINK-FROM>              ;"BOTTLE is prsi"
		<PERFORM ,V?WRING ,LAUD ,MOUTH>
		<RTRUE>)
	       (<VERB? FILL>
		<COND (<PRSI? ,BOTTLE>
		       <PERFORM ,V?POUR ,PRSI ,PRSO>
		       <RTRUE>)
		      (T
		       <TELL ,YOU-CANT "get anything into" TR ,BOTTLE>)>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"It's a small leather bottle, with a tiny label on one side">
		<COND (<G? ,LAUD-LEFT 0>
		       <TELL ". It appears to be almost empty">)>
		<TELL ,PCR>)
	       (<VERB? READ>
		<TELL 
"The label reads, \"Laudanum drops. Squeeze into a glass of wine
to sleep free of pain and mental anguish.\"" CR>)>>


<OBJECT LAUD                      ;"LAUDanum"
	(IN BOTTLE)
	(DESC "laudanum")
	(SYNONYM LAUDANUM LIQUID DRUG DROPS)
	(ADJECTIVE LAUD)
	(FLAGS TRYTAKEBIT NDESCBIT)
	(SIZE 1)
	(ACTION LAUD-F)>

<ROUTINE LAUD-F ()
	 <COND (<AND <VERB? POUR PUT WRING PUT-ON>
		     <PRSO? ,LAUD>>
		<SQUEEZE-BOTTLE>)
	       (<VERB? TAKE>
		<TELL "If you intend to drink" T ,LAUD ", say so." CR>)
	       (<VERB? EAT DRINK ;TASTE>
		<PERFORM ,V?WRING ,BOTTLE ,ME>
		<RTRUE>)
	       (<PRSO? ,LAUD>
		<PERFORM-PRSA ,BOTTLE ,PRSI>
		<RTRUE>)
	       (<PRSI? ,LAUD>
		<PERFORM-PRSA ,PRSO ,BOTTLE>
		<RTRUE>)
	       ;(<VERB? POUR PUT>
		<PERFORM ,V?POUR ,BOTTLE ,PRSI>
		<RTRUE>)>>

<ROUTINE SQUEEZE-BOTTLE ()
	 <COND ;(<NOT ,PRSI>             ;"checks for LAUD-LEFT in pre-action"
		<MOVE ,BOTTLE ,PROTAGONIST>
		<TELL
"A bubble of " D ,LAUD " forms on the tip of"
T ,BOTTLE " then slurps back in." CR>)
	       (<PRSI? ,BOTTLE>
		<IMPOSSIBLES>)
	       (<FSET? ,PRSI ,ACTORBIT>
		<TELL ,POLITE>)
	       (<PRSI? ,CROC>
		<PERFORM ,V?PUT ,BOTTLE ,CROC>
		<RTRUE>)
	       (<AND <L? ,LAUD-LEFT 3>
		     <NOT <EQUAL? ,HERE ,LAFS-ROOM>>>
		<TELL
"You stop, deciding you might need some later." CR>)
	       ;(<EQUAL? ,LAUD-LEFT 0>           ;"checked in pre-action"
		<TELL "There's no " D ,LAUD " left." CR>)
	       (<G? <SETG LAUD-LEFT <- ,LAUD-LEFT 1>> 0>
		<MOVE ,BOTTLE ,PROTAGONIST>
		<COND (<PRSI? ;,MOUTH ,ME>
		       <COND ;(<QUEUED? ,I-SLEEP>   ;"checked in PRE-POUR"
			      <TELL ,YOU-HAVE-ALREADY
" taken some. Any more might be dangerous!" CR>)
			     (T
			      <QUEUE I-SLEEP 2>
			      <PUTP ,ME ,P?CONTENTS ,POISONED>
			      <TELL ,SQUEEZE-DROPS "into" T ,MOUTH ".">)>)
		      (<PRSI? ,FLAGON>
		       <PUTP ,FLAGON ,P?CONTENTS ,POISONED>
		       <DOPE-WINE>)
		      (<PRSI? ,PORK>
		       <SETG PORK-DOPED T>
		       <TELL ,SQUEEZE-DROPS "onto" T ,PORK
". A patch of salt dissolves as" T ,LAUD " absorbs into the meat.">)
		      (<PRSI? ,BLUE-GLASS ,GREEN-GLASS>
		       <PUTP ,PRSI ,P?CONTENTS
			     <+ <GETP ,PRSI ,P?CONTENTS> ,POISONED>>
		       <DOPE-WINE>)
		      (T
		       <TELL ,SQUEEZE-DROPS "into" T ,PRSI ".">
		       <COND (<FSET? ,PRSI ,WEARBIT>
			      <TELL  " It evaporates quickly.">)>)>
		<COND (<ZERO? ,LAUD-LEFT>
		       <TELL
" From the feel of it, the bottle is now empty.">)>
		<CRLF>
		<RTRUE>)>>

<ROUTINE DOPE-WINE ()
	 <SETG USED-LAUD T>
	 <TELL ,SQUEEZE-DROPS "into" T ,PRSI ".">
	 <COND (<IN? ,LAFOND ,HERE>
		<TELL " You sense Lafond hesitate, then continue primping.">)>
	 <RTRUE>>

<GLOBAL SQUEEZE-DROPS "You squeeze three colorless drops ">

<OBJECT JEWEL
        (DESC "jewelled brooch")
	(SYNONYM BROOCH PIN CLASP)
	(ADJECTIVE JEWELLED DIAMOND SAPPHI RUBY)
	(FLAGS WEARBIT TAKEBIT)
	(ACTION JEWEL-F)>

<ROUTINE JEWEL-F ()
	 <COND (<OR <VERB? WEAR>
		    <AND <VERB? PUT-ON>
			 <PRSI? ,ME>>>
		<TELL CTHE ,JEWEL " won't stay clasped" ,PCR>)
	       (<VERB? EXAMINE>
		<TELL
"All diamonds winking fire, tears of sapphire and crushed rubies in an oval
setting, it is a pity that the clasp of" T ,JEWEL " has broken. The gold pin
at the back swings about uselessly" ,PCR>)
	       (<VERB? FIX>
		<TELL "That will have to be done by a goldsmith." CR>)
	       ;(<AND <VERB? TAKE WEAR>
		     <FSET? ,MANACLES ,MUNGBIT>>
		<CANT-REACH ,JEWEL>)>>

<OBJECT HAT
	(IN LIBRARY)     ;"EVERYBIT means it is on the knob."
	(DESC "hat")
	(DESCFCN HAT-F)
        (SYNONYM HAT TRICORNE QUILL)
	(ADJECTIVE PLUMED WHITE)
	(FLAGS WEARBIT TAKEBIT SEARCHBIT EVERYBIT)
	(CAPACITY 2)
	(ACTION HAT-F)>

<ROUTINE HAT-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<FSET? ,HAT ,EVERYBIT>
		       <COND (<EQUAL? .OARG ,M-DESC?>
			      <RTRUE>)>
		       <TELL ,INDENT
"An expensive hat is hanging on" A ,KNOB ".">)
		      (T
		       <RFALSE>)>)
	       (<VERB? EXAMINE>
		<COND (<NOUN-USED ,W?QUILL ,HAT>
		       <TELL "It's a curling ostrich plume." CR>)
		      (T
		       <TELL
"It is a crimson tricorne with a
curling ostrich plume stuck in the crown." CR>)>)
	       (<VERB? TAKE WEAR>
		<COND (<NOUN-USED ,W?QUILL ,HAT>
		       <TELL
CTHE ,HAT " looks so drab without its plume that you cannot bear to." CR>)
		      (<FSET? ,HAT ,EVERYBIT>
		       <FCLEAR ,KNOB ,DEADBIT>
		       <FSET ,KNOB ,EVERYBIT>
		       <FCLEAR ,HAT ,EVERYBIT>
		       <MOVE ,HAT ,PROTAGONIST>
		       <FSET ,HAT ,TOUCHBIT>
		       <COND (<VERB? WEAR>
			      <FSET ,HAT ,WORNBIT>)>
		       <KNOB-CAUSES-TINGLE "As you lift the hat from its">)
		      (T
		       <RFALSE>)>)
	       ;(<AND <VERB? PUT>
		     <PRSO? ,QUILL>>
		<MOVE ,QUILL ,HAT>
		<TELL
CTHE ,QUILL " adds just that extra spark of style to" TR ,HAT>)
	       (<AND <VERB? REMOVE TAKE-OFF>
		     <FSET? ,HAT ,WORNBIT>>
		<FCLEAR ,HAT ,WORNBIT>
		<TELL "Doffed" ,PCR>)
	       (<AND <VERB? PUT-ON>
		     <PRSO? ,HAT>>
		<COND (<PRSI? ,ME ,HEAD>
		       <PERFORM ,V?WEAR ,HAT>
		       <RTRUE>)
		      (<FSET? ,PRSI ,ACTORBIT>
		       <COND (<FSET? ,PRSI ,DEADBIT>
			      <TELL "It slides off." CR>)
			     (T
			      <TELL CTHE ,HAT " doesn't go with what ">
			      <COND (<PRSI? ,LUCY>
				     <TELL "s">)>
			      <TELL "he's wearing." CR>)>)
		      (T
		       <WASTES>)>)>>

<ROUTINE KNOB-CAUSES-TINGLE (STRING)
	 <TELL .STRING " knob on the wall, a low vibration tingles up your
legs from the floor" ,PCR>>

;<OBJECT QUILL
	(IN HAT)
	(DESC "feather plume")
	(SYNONYM FEATHER QUILL PLUME SMOKE)
	(ADJECTIVE OSTRICH)
	(FLAGS TAKEBIT NDESCBIT ;BURNBIT)
	(SIZE 2)
	(ACTION QUILL-F)>

;<ROUTINE QUILL-F ()
	 <COND (<AND <VERB? TAKE REMOVE>
		     <IN? ,QUILL ,HAT>
		     <NOT <EQUAL? <ITAKE <>> ,M-FATAL <>>>>
		<TELL CTHE ,HAT " looks quite drab without" TR ,QUILL>)
	       ;(<VERB? WEAR>
		<TELL
"Sally Bowes won't be born for 200 years: you'd best wait" ,PCR>)
	       ;(<VERB? BURN>
		<COND (<NOT <EQUAL? <LOC ,QUILL> ,PROTAGONIST>>
		       <TELL "You'd best be holding it" ,PCR>)
		      (T
		       <FSET ,QUILL ,MUNGBIT>
		       <QUEUE I-QUILL-BURNING 2>
		       <COND (<GLOBAL-IN? ,TORCH ,HERE>
			      <TELL
"Standing on tiptoe to reach" T ,TORCH ", y">)
			     (<EQUAL? ,HERE ,KITCHEN>
			      <TELL "Y">)
			     (T
			      <CANT-REACH "any fire">
			      <RTRUE>)>  
		       <TELL
"ou set fire to" T ,QUILL ". It shrivels into
a wallop of dusky, evil-smelling smoke" ,PCR>)>)
	       (<VERB? ALARM>
		<COND (<PRSO? ,HERO>
		       <COND (<FSET? ,QUILL ,MUNGBIT>
			      <REVIVE-HERO ,QUILL>)
			     (T
			      <TELL
"You tickle Jamison under his nose with" T ,QUILL ". ">
			      <COND (<FSET? ,HERO ,DEADBIT>
				     <TELL ,DOESNT-RESPOND>)
				    (T
				     <TELL "He sneezes" ,PCR>)>)>)
		      (T
		       <WASTES>)>)>>

;<ROUTINE I-QUILL-BURNING ()
	 <REMOVE ,QUILL>
	 <TELL ,INDENT
"With a soft curse you let go of" T ,QUILL " as it burns down to your
fingers. The fine black ashes swirl away" ,PCR>>