"MISC for
		      PLUNDERED HEARTS
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

;"macros"

<TELL-TOKENS (CRLF CR)   <CRLF>
	     D *	 <PRINTD .X>
	     A *	 <APRINT .X>
	     T ,PRSO 	 <TPRINT-PRSO>
	     T ,PRSI	 <TPRINT-PRSI>
	     T *	 <TPRINT .X>
	     AR *	 <ARPRINT .X>
	     TR *	 <TRPRINT .X>
	     N *	 <PRINTN .X>
	     C *         <PRINTC .X>
	     CTHE *	 <CTPRINT .X>>

<DEFMAC VERB? ("ARGS" ATMS)
	<MULTIFROB PRSA .ATMS>>

<DEFMAC PRSO? ("ARGS" ATMS)
	<MULTIFROB PRSO .ATMS>>

<DEFMAC PRSI? ("ARGS" ATMS)
	<MULTIFROB PRSI .ATMS>>

<DEFMAC ROOM? ("ARGS" ATMS)
	<MULTIFROB HERE .ATMS>>

<DEFINE MULTIFROB (X ATMS "AUX" (OO (OR)) (O .OO) (L ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .OO 1> <ERROR .X>)
				       (<LENGTH? .OO 2> <NTH .OO 2>)
				       (ELSE <CHTYPE .OO FORM>)>>)>
		<REPEAT ()
			<COND (<EMPTY? .ATMS> <RETURN!->)>
			<SET ATM <NTH .ATMS 1>>
			<SET L
			     (<COND (<TYPE? .ATM ATOM>
				     <CHTYPE <COND (<==? .X PRSA>
						    <PARSE
						     <STRING "V?"
							     <SPNAME .ATM>>>)
						   (ELSE .ATM)> GVAL>)
				    (ELSE .ATM)>
			      !.L)>
			<SET ATMS <REST .ATMS>>
			<COND (<==? <LENGTH .L> 3> <RETURN!->)>>
		<SET O <REST <PUTREST .O
				      (<FORM EQUAL? <CHTYPE .X GVAL> !.L>)>>>
		<SET L ()>>>

<DEFMAC BSET ('OBJ "ARGS" BITS)
	<MULTIBITS FSET .OBJ .BITS>>

<DEFMAC BCLEAR ('OBJ "ARGS" BITS)
	<MULTIBITS FCLEAR .OBJ .BITS>>

<DEFMAC BSET? ('OBJ "ARGS" BITS)
	<MULTIBITS FSET? .OBJ .BITS>>

<DEFINE MULTIBITS (X OBJ ATMS "AUX" (O ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .O 1> <NTH .O 1>)
				       (<EQUAL? .X FSET?> <FORM OR !.O>)
				       (ELSE <FORM PROG () !.O>)>>)>
		<SET ATM <NTH .ATMS 1>>
		<SET ATMS <REST .ATMS>>
		<SET O
		     (<FORM .X
			    .OBJ
			    <COND (<TYPE? .ATM FORM> .ATM)
				  (ELSE <FORM GVAL .ATM>)>>
		      !.O)>>>

<DEFMAC RFATAL ()
	'<PROG () <PUSH 8> <RSTACK>>>

<DEFMAC PROB ('BASE?)
	<FORM NOT <FORM L? .BASE? '<RANDOM 100>>>>

<DEFMAC GET/B ('TBL 'PTR)
	<COND ;(<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
	       <FORM GET .TBL .PTR>)
	      (T <FORM GETB .TBL .PTR>)>>

<DEFMAC PUT/B ('TBL 'PTR 'OBJ)
	<COND ;(<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
	       <FORM PUT .TBL .PTR .OBJ>)
	      (T <FORM PUTB .TBL .PTR .OBJ>)>>

<DEFMAC ZMEMQ/B ('OBJ 'TBL)
	<COND ;(<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
	       <FORM ZMEMQ .OBJ .TBL>)
	      (T <FORM ZMEMQB .OBJ .TBL>)>>

;<ROUTINE ;PICK-ONE (FROB)
	 <GET .FROB <RANDOM <GET .FROB 0>>>>

;"this new PICK-ONE won't begin repeating any of the items in the table until
  they've all been used."
<ROUTINE PICK-ONE (TBL "AUX" LENGTH CNT RND MSG RFROB)
	 <SET LENGTH <GET .TBL 0>>
	 <SET CNT <GET .TBL 1>>
	 <SET LENGTH <- .LENGTH 1>>
	 <SET TBL <REST .TBL 2>>
	 <SET RFROB <REST .TBL <* .CNT 2>>>
	 <SET RND <RANDOM <- .LENGTH .CNT>>>
	 <SET MSG <GET .RFROB .RND>>
	 <PUT .RFROB .RND <GET .RFROB 1>>
	 <PUT .RFROB 1 .MSG>
	 <SET CNT <+ .CNT 1>>
	 <COND (<==? .CNT .LENGTH> 
		<SET CNT 0>)>
	 <PUT .TBL 0 .CNT>
	 .MSG>

;<ROUTINE DPRINT (OBJ)
	 <COND ;(<EQUAL? .OBJ ,SULTANS-WIFE>
		<TELL "Sultan">
		<COND (,MALE
		       <TELL "'s wife #">)
		      (T
		       <TELL "ess' husband #">)>
		<PRINTN ,CHOICE-NUMBER>)
	       ;(<FSET? .OBJ ,UNTEEDBIT>
		<TELL <GETP .OBJ ,P?NO-T-DESC>>)
	       (<GETP .OBJ ,P?SDESC>
	        <TELL <GETP .OBJ ,P?SDESC>>)
	       (T
	        <PRINTD .OBJ>)>>

;<ROUTINE DPRINT-SIDEKICK ()
	 <DPRINT ,SIDEKICK>>

<ROUTINE APRINT (OBJ)
	 <COND (<OR <FSET? .OBJ ,NARTICLEBIT>
		    <EQUAL? .OBJ ,PANTS ,RUM ,SALTS>>
		<TELL " ">)
	       (<FSET? .OBJ ,VOWELBIT>
		<TELL " an ">)
	       (T
		<TELL " a ">)>
	 <PRINTD .OBJ>>

<ROUTINE TPRINT (OBJ)
	 <COND (<FSET? .OBJ ,NARTICLEBIT>
		<TELL " ">)
	       (T
		<TELL " the ">)>
	 <PRINTD .OBJ>>

<ROUTINE CTPRINT (OBJ)
	 <TELL "The ">
	 <PRINTD .OBJ>>

<ROUTINE TPRINT-PRSO ()
	 <TPRINT ,PRSO>>

<ROUTINE TPRINT-PRSI ()
	 <TPRINT ,PRSI>>

<ROUTINE ARPRINT (OBJ)
	 <APRINT .OBJ>
	 <TELL ,PCR>>

<ROUTINE TRPRINT (OBJ)
	 <TPRINT .OBJ>
	 <TELL ,PCR>>

<DEFINE PSEUDO ("TUPLE" V)
	<MAPF ,PLTABLE
	      <FUNCTION (OBJ)
		   <COND (<N==? <LENGTH .OBJ> 3>
			  <ERROR BAD-THING .OBJ>)>
		   <MAPRET <COND (<NTH .OBJ 2>
				  <VOC <SPNAME <NTH .OBJ 2>> NOUN>)>
			   <COND (<NTH .OBJ 1>
				  <VOC <SPNAME <NTH .OBJ 1>> ADJECTIVE>)>
			   <3 .OBJ>>>
	      .V>>

;"MAIN-LOOP and associated routines"

<CONSTANT M-BEG 1>
<CONSTANT M-ENTER 2>
<CONSTANT M-LOOK 3>
<CONSTANT M-FLASH 4>
<CONSTANT M-OBJDESC 5>
<CONSTANT M-END 6>
;<CONSTANT M-SMELL 7>
<CONSTANT M-FATAL 8>
<CONSTANT M-DESC? 9>
<CONSTANT M-EXDESC 10>

<ROOM FRONTISPIECE
      (IN ROOMS)
      ;(DESC "THE CARIBBEAN, 16--")
      ;(DESC ">SHOOT THE PIRATE")
      (DESC "Plundered Hearts")
      (NW "You can't go that way.")
      (SW "You can't go that way.")
      (SYNONYM ZZMGCK) ;"No, this synonym doesn't need to exist... sigh">

<GLOBAL EYES-RAKE " his eyes rake over your inadequately dressed body, the
damp chemise clinging to your legs and heaving bosom, your gleaming hair">

<ZSTART GO> ;"else, ZIL gets confused between verb-word GO and routine GO"

<ROUTINE GO () ;"NOTE: this routine CANNOT have any local variables" 
	 ;<SETG HERE ,FRONTISPIECE>
	 <TELL
">SHOOT THE PIRATE|
Trembling, you fire the heavy arquebus. You hear its loud report over the
roaring wind, yet the dark figure still approaches. The gun falls from your
nerveless hands.|
   \"You won't kill me,\" he says, stepping over the weapon. \"Not when I am
the only protection you have from Jean Lafond.\"|
   " ,NUTBROWN "Lips curving," ,EYES-RAKE ". You are intensely aware of the
strength of his hard seaworn body, of the deep sea blue of his eyes. And
then his mouth is on yours, lips parted, demanding, and you arch into his
kiss...|
   He presses you against him, head bent. \"But who, my dear,\" he whispers
into your hair, \"will protect you from me?\"|">
	 ;<CLEAR-SCREEN 5>
	 <TELL CR ,HIT-RETURN "begin.]" CR> 
	 <READ ,P-INBUF ,P-LEXV>
	 <USL>
	 <CLEAR-SCREEN 11>
	 ;<SETG WINNER ,PROTAGONIST>
	 <SETG HERE ,CABIN>
	 ;<MOVE ,PROTAGONIST ,CABIN-BED>
	 <USL>
	 <V-VERSION>    
	 <CRLF>
	 <TELL "LATE ONE SPRING NIGHT IN THE WEST INDIES...||
   A crash overhead! Pirates are boarding the Lafond Deux!
The first mate hurries you into Captain Davis's cabin.|
   \"Good, you brought the girl,\" Davis smirks. \"She'll keep the
pirates busy. She was only a tool of Lafond's, anyway. Let me just find
that cof--\" A man on deck screams in agony and Davis starts. \"Let's
go.\" The captain thrusts you on the bed and walks out, locking the door.|
   His laugh echoes. \"Best get comfortable, girl. You're likely to be
there for the rest of your life.\"" CR CR>
	 <V-LOOK>
	 ;<QUEUE I-PIRATE-ATTACK -1>
	 ;<QUEUE I-COFFER 5>
	 ;<QUEUE I-CRULLEY 9>
	 ;<QUEUE I-JIGS-UP-SNAFU 25>
	 <MAIN-LOOP>
	 <AGAIN>>

<ROUTINE CLEAR-SCREEN ("OPTIONAL" (CNT 24))
	 <REPEAT ()
		 <CRLF>
		 <SET CNT <- .CNT 1>>
		 <COND (<0? .CNT>
			<RETURN>)>>>

<ROUTINE MAIN-LOOP ("AUX" TRASH)
	 <REPEAT ()
		 <SET TRASH <MAIN-LOOP-1>>>>

<ROUTINE MAIN-LOOP-1 ("AUX" ICNT OCNT NUM (CNT 0) (OBJ <>) TBL
		            V (PTBL T) OBJ1 TMP ONUM)
  <COND (<SETG P-WON <PARSER>>
	 <SET ICNT <GET/B ,P-PRSI ,P-MATCHLEN>>
	 <SET OCNT <GET/B ,P-PRSO ,P-MATCHLEN>>
	 <COND (<AND ,P-IT-OBJECT
		     <ACCESSIBLE? ,P-IT-OBJECT>>
		<SET TMP <>>
		<REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .ICNT>
			<RETURN>)
		       (T
			<COND (<EQUAL? <GET/B ,P-PRSI .CNT> ,IT>
			       <COND (<TOO-DARK-FOR-IT?> <RTRUE>)>
			       <PUT/B ,P-PRSI .CNT ,P-IT-OBJECT>
			       <SET TMP T>
			       <RETURN>)>)>>
		<COND (<NOT .TMP>
		       <SET CNT 0>
		       <REPEAT ()
			<COND (<G? <SET CNT <+ .CNT 1>> .OCNT>
			       <RETURN>)
			      (T
			       <COND (<EQUAL? <GET/B ,P-PRSO .CNT> ,IT>
				      <COND (<TOO-DARK-FOR-IT?> <RTRUE>)>
				      <PUT/B ,P-PRSO .CNT ,P-IT-OBJECT>
				      <RETURN>)>)>>)>
		<SET CNT 0>)>
	 <SET ONUM <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
	 <SET NUM
		 <COND (<OR <ZERO? .OCNT>
			    <AND <ZERO? .ICNT>
				 <EQUAL? .ONUM 2>>>
			0)
		       (<G? .OCNT 1>
			<SET TBL ,P-PRSO>
			<COND (<ZERO? .ICNT> <SET OBJ <>>)
			      (T <SET OBJ <GET/B ,P-PRSI 1>>)>
			.OCNT)
		       (<G? .ICNT 1>
			<SET PTBL <>>
			<SET TBL ,P-PRSI>
			<SET OBJ <GET/B ,P-PRSO 1>>
			.ICNT)
		       (T 1)>>
	 ;<SET NUM <COND (<0? .OCNT>
			 .OCNT)
		        (<G? .OCNT 1>
			 <SET TBL ,P-PRSO>
			 <COND (<0? .ICNT>
				<SET OBJ <>>)
			       (T
				<SET OBJ <GET/B ,P-PRSI 1>>)>
			 .OCNT)
		        (<G? .ICNT 1>
			 <SET PTBL <>>
			 <SET TBL ,P-PRSI>
			 <SET OBJ <GET/B ,P-PRSO 1>>
			 .ICNT)
		        (T
			 1 ;.ICNT)>>
	 <COND (<AND <NOT .OBJ>
		     <1? .ICNT>>
		<SET OBJ <GET/B ,P-PRSI 1>>)>
	 <COND (<EQUAL? ,PRSA ,V?WALK>
		<SET V <PERFORM-PRSA ,PRSO>>)
	       (<0? .NUM>
		<COND (<0? <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
		       <SET V <PERFORM-PRSA>>
		       <SETG PRSO <>>)
		      ;(<NOT ,LIT>
		       <TELL ,TOO-DARK CR>
		       <STOP>)
		      (T
		       <TELL "There isn't anything to ">
		       <SET TMP <GET ,P-ITBL ,P-VERBN>>
		       <COND (<VERB? TELL>
			      <TELL "talk to">)
			     (<OR ,P-OFLAG ,P-MERGED>
			      <PRINTB <GET .TMP 0>>)
			     (T
			      <WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>)>
		       <TELL "!" CR>
		       <SET V <>>
		       <STOP>)>)
	       (T
		<SETG P-NOT-HERE 0>
		<SETG P-MULT <>>
		<COND (<G? .NUM 1>
		       <SETG P-MULT T>)>
		<SET TMP <>>
		<REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .NUM>
			<COND (<G? ,P-NOT-HERE 0>
			       <TELL "[The ">
			       <COND (<NOT <EQUAL? ,P-NOT-HERE .NUM>>
				      <TELL "other ">)>
			       <TELL "object">
			       <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
				      <TELL "s">)>
			       <TELL " that you mentioned ">
			       <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
				      <TELL "are">)
				     (T
				      <TELL "is">)>
			       <TELL "n't here.]" CR>)
			      (<NOT .TMP>
			       <REFERRING>)>
			<RETURN>)
		       (T
			<COND (.PTBL
			       <SET OBJ1 <GET/B ,P-PRSO .CNT>>)
			      (T
			       <SET OBJ1 <GET/B ,P-PRSI .CNT>>)>
			<SETG PRSO <COND (.PTBL
					  .OBJ1)
					 (T
					  .OBJ)>>
			<SETG PRSI <COND (.PTBL
					  .OBJ)
					 (T
					  .OBJ1)>>
			<COND (<OR <G? .NUM 1>
				   <EQUAL? <GET <GET ,P-ITBL ,P-NC1> 0>
					,W?ALL
					,W?EVERYT>>
			       <COND (<DONT-ALL .OBJ1>
				      <AGAIN>)
				     (T
				      <COND (<EQUAL? .OBJ1 ,IT>
					     <TELL D ,P-IT-OBJECT>)
					    (<EQUAL? .OBJ1 ,HIM>
					     <TELL D ,P-HIM-OBJECT>)
					    (<EQUAL? .OBJ1 ,HER>
					     <TELL D ,P-HER-OBJECT>)
					    (T
					     <TELL D .OBJ1>)>
				      <TELL ": ">)>)>
			<SET TMP T>
			<SET V <PERFORM-PRSA ,PRSO ,PRSI>>
			<COND (<EQUAL? .V ,M-FATAL>
			       <RETURN>)>)>>)>
	 <COND (<EQUAL? .V ,M-FATAL>
		<SETG P-CONT <>>)>
	 <COND (<AND <CLOCKER-VERB?>
		     <NOT <VERB? TELL>>
		     ,P-WON ;"fake YOU CANT SEE responses set P-WON to false">
		<SET V <APPLY <GETP ,HERE ,P?ACTION> ,M-END>>)>)
	(T
	 <SETG P-CONT <>>)>
  <COND (,P-WON
	 <COND (<CLOCKER-VERB?>
		<SET V <CLOCKER>>)>
	 <SETG PRSA <>>
	 <SETG PRSO <>>
	 <SETG PRSI <>>)>
  ;<COND (<AND ,AWAITING-FAKE-ORPHAN
	      <NOT ,P-OFLAG>>
	 <ORPHAN-VERB>)>>

<ROUTINE TOO-DARK-FOR-IT? ()
	 <COND (<AND <NOT ,LIT>
		     <NOT <HELD? ,P-IT-OBJECT ,WINNER>>
		     <NOT <IN? ,WINNER ,P-IT-OBJECT>>>
		<TELL ,TOO-DARK CR>
		<RTRUE>)>>

<ROUTINE DONT-ALL (OBJ1 "AUX" (L <LOC .OBJ1>))
	 ;"RFALSE if OBJ1 should be included in the ALL, otherwise RTRUE"
	 <COND (<EQUAL? .OBJ1 ,NOT-HERE-OBJECT>
		<SETG P-NOT-HERE <+ ,P-NOT-HERE 1>>
		<RTRUE>)
	       (<AND <VERB? TAKE>;"TAKE prso FROM prsi and prso isn't in prsi"
		     ,PRSI
		     <NOT <IN? ,PRSO ,PRSI>>>
		<RTRUE>)
	       (<NOT <ACCESSIBLE? .OBJ1>> ;"can't get at object"
		<RTRUE>)
	       (<EQUAL? ,P-GETFLAGS ,P-ALL> ;"cases for ALL"
		<COND (<AND ,PRSI
			    <PRSO? ,PRSI>>
		       <RTRUE>)
		      (<VERB? TAKE> 
		       ;"TAKE ALL and object not accessible or takeable"
		       <COND (<AND <NOT <FSET? .OBJ1 ,TAKEBIT>>
				   <NOT <FSET? .OBJ1 ,TRYTAKEBIT>>>
			      <RTRUE>)
			     (<AND <NOT <EQUAL? .L ,WINNER ,HERE ,PRSI>>
				   <NOT <EQUAL? .L <LOC ,WINNER>>>>
			      <COND (<AND <FSET? .L ,SURFACEBIT>
				     	  <NOT <FSET? .L ,TAKEBIT>>> ;"tray"
				     <RFALSE>)
				    (T
				     <RTRUE>)>)
			     (<EQUAL? .OBJ1 ,BOOKS-GLOBAL ,POWER>
			      <RTRUE>)
			     (<AND <NOT ,PRSI>
				   <HELD? ,PRSO>> ;"already have it"
			      <RTRUE>)
			     (T
			      <RFALSE>)>)
		      (<AND <VERB? DROP PUT PUT-ON GIVE SGIVE>
			    ;"VERB ALL, object not held"
			    <NOT <IN? .OBJ1 ,WINNER>>>
		       <RTRUE>)
		      (<AND <VERB? PUT PUT-ON> ;"PUT ALL IN X,obj already in x"
			    <NOT <IN? ,PRSO ,WINNER>>
			    <HELD? ,PRSO ,PRSI>>
		       <RTRUE>)>)>>

<ROUTINE CLOCKER-VERB? ()
	 <COND (<VERB? VERSION HELP $RECORD $UNRECORD $COMMAND $RANDOM
		       ;$DEBUG SAVE RESTORE RESTART QUIT SCRIPT UNSCRIPT
		       BRIEF SUPER-BRIEF VERBOSE SCORE>
		<RFALSE>)
	       (T
		<RTRUE>)>>

<GLOBAL P-WON <>>

<GLOBAL P-MULT <>>

<GLOBAL P-NOT-HERE 0>

<ROUTINE FAKE-ORPHAN ("OPTIONAL" (IT-WAS-USED <>) "AUX" TMP)
	 <ORPHAN ,P-SYNTAX <>>
	 <SET TMP <GET ,P-OTBL ,P-VERBN>>
	 <TELL "[Be specific: Wh">
	 <COND (.IT-WAS-USED
		<TELL "at object">)
	       (T
		<TELL "o">)>
	 <TELL ,DO-YOU-WANT>
	 <COND (<EQUAL? .TMP 0>
		<TELL "tell">)
	       (<0? <GETB ,P-VTBL 2>>
		<PRINTB <GET .TMP 0>>)
	       (T
		<WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>
		<PUTB ,P-VTBL 2 0>)>
	 <SETG P-OFLAG T>
	 <SETG P-WON <>>
	 <PREP-PRINT <GETB ,P-SYNTAX ,P-SPREP1>>
	 <TELL "?]" CR>>

<ROUTINE PERFORM-PRSA ("OPTIONAL" (O <>) (I <>))
	 <PERFORM ,PRSA .O .I>
	 <RTRUE>>

<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI)
	;<COND (,DEBUG
	       <TELL "[Perform: ">
	       %<COND (<GASSIGNED? ZILCH>
		       '<TELL N .A>)
		      (T
		       '<PRINC <NTH ,ACTIONS <+ <* .A 2> 1>>>)>
	       <COND (.O
		      <TELL " / PRSO = ">
		      <COND (<NOT <EQUAL? .A ,V?WALK>>
			     <TELL D .O>)
			    (T
			     <TELL N .O>)>)>
	       <COND (.I <TELL " / PRSI = " D .I>)>
	       <TELL "]" CR>)>
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<SETG PRSA .A>
	<COND (<AND <EQUAL? ,IT .O .I>
		    <NOT <EQUAL? .A ,V?WALK>>>
	       <COND (<VISIBLE? ,P-IT-OBJECT>
		      <COND (<EQUAL? ,IT .O>
			     <SET O ,P-IT-OBJECT>)
			    (T
			     <SET I ,P-IT-OBJECT>)>)
		     (T
		      <COND (<NOT .I>
			     <FAKE-ORPHAN T>)
			    (T
			     <REFERRING>)>
		      <RFATAL>)>)>
	<COND (<AND <EQUAL? ,HIM .O .I>
		    <NOT <EQUAL? .A ,V?WALK>>>
	       <COND (<VISIBLE? ,P-HIM-OBJECT>
		      <COND (<EQUAL? ,HIM .O>
			     <SET O ,P-HIM-OBJECT>)
			    (T
			     <SET I ,P-HIM-OBJECT>)>)
		     (T
		      <COND (<NOT .I>
			     <FAKE-ORPHAN>)
			    (T
			     <REFERRING T>)>
		      <RFATAL>)>)>
	<COND (<AND <EQUAL? ,HER .O .I>
		    <NOT <EQUAL? .A ,V?WALK>>>
	       <COND (<VISIBLE? ,P-HER-OBJECT>
		      <COND (<EQUAL? ,HER .O>
			     <SET O ,P-HER-OBJECT>)
			    (T
			     <SET I ,P-HER-OBJECT>)>)
		     (T
		      <COND (<NOT .I>
			     <FAKE-ORPHAN>)
			    (T
			     <REFERRING T>)>
		      <RFATAL>)>)>
	<SETG PRSO .O>
	<SETG PRSI .I>
	<COND (<AND <NOT <EQUAL? .A ,V?WALK>>
		    <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
		    <SET V <D-APPLY "Not Here" ,NOT-HERE-OBJECT-F>>>
	       <SETG P-WON <>>)
	      (T
	       <SET O ,PRSO>
	       <SET I ,PRSI>
	       <THIS-IS-IT ,PRSI>
	       <THIS-IS-IT ,PRSO>
	       <COND (<SET V <D-APPLY "Actor" <GETP ,WINNER ,P?ACTION>>>
		      T)
		     (<SET V <D-APPLY "M-Beg" <GETP <LOC ,WINNER> ,P?ACTION>
                                                                    ,M-BEG>>
		      T)
		     (<SET V <D-APPLY "Preaction" <GET ,PREACTIONS .A>>>
		      T)
		     (<AND .I <SET V <D-APPLY "PRSI" <GETP .I ,P?ACTION>>>>
		      T)
		     ;(<AND .O
			   <NOT <EQUAL? .A ,V?WALK>>
			   <LOC .O>
			   <GETP <LOC .O> ,P?CONTFCN>
			   <SET V <D-APPLY "Cont" <GETP <LOC .O> ,P?CONTFCN>>>>
		       T) 
		     (<AND .O
			   <NOT <EQUAL? .A ,V?WALK>>
			   <SET V <D-APPLY "PRSO" <GETP .O ,P?ACTION>>>>
		      T)
		     (<SET V <D-APPLY <> <GET ,ACTIONS .A>>>
		      T)>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>

<ROUTINE D-APPLY (STR FCN "OPTIONAL" (FOO <>) "AUX" RES)
	<COND (<NOT .FCN> <>)
	      (T
	       ;<COND (,DEBUG
		      <COND (<NOT .STR>
			     <TELL "  Default ->" CR>)
			    (T
			     <TELL "  " .STR " -> ">)>)>
	       <SET RES <COND (.FOO
			       <APPLY .FCN .FOO>)
			      (T
			       <APPLY .FCN>)>>
	       ;<COND (<AND ,DEBUG
			   .STR>
		      <COND (<EQUAL? .RES ,M-FATAL>
			     <TELL "Fatal" CR>)
			    (<NOT .RES>
			     <TELL "Not handled">)
			    (T <TELL "Handled" CR>)>)>
	       .RES)>>

;"CLOCKER and related routines"

<GLOBAL C-TABLE <TABLE 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
	I-CRULLEY 9
	I-COFFER 5
	I-PIRATE-ATTACK -1>	;30
		;%<COND (<GASSIGNED? ZILCH>
			 '<ITABLE NONE 30>)
			(T
			 '<ITABLE NONE 60>)>>

<GLOBAL CLOCK-WAIT <>>

<GLOBAL C-INTS <- 60 <* 3 4>>>

<GLOBAL C-MAXINTS 60>

<GLOBAL CLOCK-HAND <>>

<CONSTANT C-TABLELEN 60>
<CONSTANT C-INTLEN 4>	;"length of an interrupt entry"
<CONSTANT C-RTN 0>	;"offset of routine name"
<CONSTANT C-TICK 1>	;"offset of count"

<ROUTINE DEQUEUE (RTN)
	 <COND (<SET RTN <QUEUED? .RTN>>
		<PUT .RTN ,C-RTN 0>)>>

<ROUTINE QUEUED? (RTN "AUX" C E)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<RFALSE>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<COND (<ZERO? <GET .C ,C-TICK>>
			       <RFALSE>)
			      (T
			       <RETURN .C>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

<ROUTINE RUNNING? (RTN "AUX" C)
	 <COND (<AND <SET C <QUEUED? .RTN>>
		     <NOT <G? <GET .C ,C-TICK> 1>>>
		<RTRUE>)>>

;<ROUTINE RUNNING? (RTN "AUX" C E)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<RFALSE>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<COND (<OR <ZERO? <GET .C ,C-TICK>>
				   <G? <GET .C ,C-TICK> 1>>
			       <RFALSE>)
			      (T
			       <RTRUE>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

<ROUTINE QUEUE (RTN TICK "AUX" C E (INT <>)) ;"automatically enables as well"
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<COND (.INT
			       <SET C .INT>)
			      (T
			       <COND (<L? ,C-INTS ,C-INTLEN>
				      <TELL "**Too many ints!**" CR>)>
			       <SETG C-INTS <- ,C-INTS ,C-INTLEN>>
			       <COND (<L? ,C-INTS ,C-MAXINTS>
				      <SETG C-MAXINTS ,C-INTS>)>
			       <SET INT <REST ,C-TABLE ,C-INTS>>)>
			<PUT .INT ,C-RTN .RTN>
			<RETURN>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<SET INT .C>
			<RETURN>)
		       (<ZERO? <GET .C ,C-RTN>>
			<SET INT .C>)>
		 <SET C <REST .C ,C-INTLEN>>>
	 <COND (<AND ,CLOCK-HAND
		     %<COND (<GASSIGNED? ZILCH>
			     '<G? .INT ,CLOCK-HAND>)
			    (T
			     '<L? <LENGTH .INT> <LENGTH ,CLOCK-HAND>>)>>
		<SET TICK <- <+ .TICK 3>>>)>
	 <PUT .INT ,C-TICK .TICK>
	 .INT>

<ROUTINE CLOCKER ("AUX" E TICK RTN (FLG <>) (Q? <>) OWINNER)
	 <COND (,CLOCK-WAIT
		<SETG CLOCK-WAIT <>>
		<RFALSE>)>
	 <SETG CLOCK-HAND <REST ,C-TABLE ,C-INTS>>
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET OWINNER ,WINNER>
	 <SETG WINNER ,PROTAGONIST>
	 <REPEAT ()
		 <COND (<EQUAL? ,CLOCK-HAND .E>
			<SETG CLOCK-HAND .E>
			<SETG MOVES <+ ,MOVES 1>>
			<SETG WINNER .OWINNER>
			<RETURN .FLG>)
		       (<NOT <ZERO? <GET ,CLOCK-HAND ,C-RTN>>>
			<SET TICK <GET ,CLOCK-HAND ,C-TICK>>
			<COND (<L? .TICK -1>
			       <PUT ,CLOCK-HAND ,C-TICK <- <- .TICK> 3>>
			       <SET Q? ,CLOCK-HAND>)
			      (<NOT <ZERO? .TICK>>
			       <COND (<G? .TICK 0>
				      <SET TICK <- .TICK 1>>
				      <PUT ,CLOCK-HAND ,C-TICK .TICK>)>
			       <COND (<NOT <ZERO? .TICK>>
				      <SET Q? ,CLOCK-HAND>)>
			       <COND (<NOT <G? .TICK 0>>
				      <SET RTN
					   %<COND (<GASSIGNED? ZILCH>
						   '<GET ,CLOCK-HAND ,C-RTN>)
						  (ELSE
						   '<NTH ,CLOCK-HAND
							 <+ <* ,C-RTN 2>
							    1>>)>>
				      <COND (<ZERO? .TICK>
					     <PUT ,CLOCK-HAND ,C-RTN 0>)>
				      <COND (<APPLY .RTN>
					     <SET FLG T>)>
				      <COND (<AND <NOT .Q?>
						  <NOT
						   <ZERO?
						    <GET ,CLOCK-HAND
							 ,C-RTN>>>>
					     <SET Q? T>)>)>)>)>
		 <SETG CLOCK-HAND <REST ,CLOCK-HAND ,C-INTLEN>>
		 <COND (<NOT .Q?>
			<SETG C-INTS <+ ,C-INTS ,C-INTLEN>>)>>>

;<GLOBAL TOD 0>

;<ROUTINE I-TIME ()
	  <COND (<G? <SETG TOD <+ ,TOD 1>> 127>
		 <SETG TOD 0>
		 <TELL "TOD just went to 128. Whoopee!"CR>)>>