DECLARE SUB MouseInit ()
DECLARE SUB MouseReset ()
DECLARE SUB MouseHide ()
DECLARE SUB MouseShow ()
DECLARE FUNCTION MouseX% ()
DECLARE FUNCTION MouseY% ()
DECLARE FUNCTION MouseButtons% ()
DIM SHARED a%(34)
DIM B%(15), c%(31)
DEF SEG = VARSEG(a%(0))
FOR i% = 0 TO 63
 READ d%
 POKE VARPTR(a%(0)) + i%, d%
NEXT i%
DEF SEG
DATA 0, 0
DATA 0, 0
DATA 0, 0
DATA &hb8,0,0
DATA &hcd,&h33
DATA &h3d,&hff,&hff
DATA &h75,&h0d
DATA &h0e
DATA &h07
DATA &hba,&h24,0
DATA &hb9,&hff,&hff
DATA &hb8,&h0c,0
DATA &hcd,&h33
DATA &hcb
DATA &hb8,0,0
DATA &hcd,&h33
DATA &hcb
DATA &h2e,&h89,&h0e,0,0
DATA &h2e,&h89,&h16,2,0
DATA &h2e,&h89,&h1e,4,0
DATA &hcb
DATA &hb8,1,0
DATA &hcd,&h33
DATA &hcb
DATA &hb8,2,0
DATA &hcd,&h33
DATA &hcb
SCREEN 12
p1% = 0: p2% = 0
CALL MouseInit
na: CLS
tur% = tur% + 1: s% = 0
FOR i = 0 TO 15: B%(i) = 0: NEXT
FOR i = 0 TO 31: c%(i) = 0: NEXT
FOR B% = 0 TO 31
 PRINT CHR$(B% + 128);
NEXT
B% = 0
FOR y% = 1 TO 16
 FOR x% = 0 TO 32 * 8
  IF POINT(x%, y%) <> 0 THEN LINE (a, B% + 430)-(a + 2, B% + 432), 10, BF
  a = a + 639 / (32 * 8)
 NEXT
 a = 0: B% = B% + 3
NEXT
LINE (0, 428)-(639, 428), 5
LINE (0, 470)-(639, 470), 5
LOCATE 1, 1: PRINT "                                              "
RANDOMIZE (TIMER)
t = INT(RND(1) * 9 + 1)
IF t = 1 THEN RESTORE dat1
IF t = 2 THEN RESTORE dat2
IF t = 3 THEN RESTORE dat3
IF t = 4 THEN RESTORE dat4
IF t = 5 THEN RESTORE dat5
IF t = 6 THEN RESTORE dat6
IF t = 7 THEN RESTORE dat7
IF t = 8 THEN RESTORE dat8
IF t = 9 THEN RESTORE dat9
READ tem$
kol% = 0
DO
 kol% = kol% + 1
 READ m$
LOOP WHILE m$ <> "-1"
IF t = 1 THEN RESTORE dat1
IF t = 2 THEN RESTORE dat2
IF t = 3 THEN RESTORE dat3
IF t = 4 THEN RESTORE dat4
IF t = 5 THEN RESTORE dat5
IF t = 6 THEN RESTORE dat6
IF t = 7 THEN RESTORE dat7
IF t = 8 THEN RESTORE dat8
IF t = 9 THEN RESTORE dat9
READ tem$
LOCATE 1, 37: PRINT tur%; "’γΰ"
LOCATE 3, 31: PRINT "’…€ ƒ›: "; tem$
t = RND(1) * kol% + 1: FOR i = 1 TO t - 1: READ a$: NEXT
GOSUB nadp
z = 639 / (32 * 8) * 8
MouseShow
LOCATE 1, 75: PRINT "‚λε®¤!"
LINE (591, 0)-(639, 16), 10, B
LOCATE 1, 1: PRINT "http:\\www.kas-cor.boom.ru ¨ http:\\www.kas-cor.narod.ru"
DO
 x% = MouseX%
 y% = MouseY%
 k% = MouseButtons%
 IF k% = 1 AND x% > 591 AND y% > 0 AND x% < 639 AND y% < 16 THEN END
 IF k% = 1 AND y% > 430 AND c%(x% \ z) = 0 THEN
  n$ = CHR$(x% \ z + 128)
  u% = 0
  FOR i% = 1 TO LEN(a$)
   IF MID$(a$, i%, 1) = n$ THEN B%(i%) = 1: u% = 1
  NEXT
  CALL MouseHide
  LINE ((x% \ z) * z, 430)-((x% \ z) * z + z, 468), 0, BF: c%(x% \ z) = 1
  GOSUB nadp
  IF u% = 0 THEN LOCATE 15, 1: PRINT STRING$(80, " "): s% = s% + 1: ON s% GOSUB v1, v2, v3, v4, v5, v6, v7
  d% = 0
  FOR i% = 1 TO LEN(a$)
   IF B%(i%) = 0 THEN d% = 1: EXIT FOR
  NEXT
  IF d% = 0 THEN GOTO en
  CALL MouseShow
 END IF
LOOP WHILE INKEY$ <> CHR$(27)
f$ = INPUT$(1)
END
nadp:
a1% = 319 - (8 * LEN(a$) * 2) / 2
LOCATE 1, 1: PRINT a$
FOR i% = 1 TO LEN(a$)
 IF B%(i%) = 0 THEN LOCATE 1, i%: PRINT CHR$(254)
NEXT
FOR y% = 0 TO 16
 FOR x% = 0 TO LEN(a$) * 8
  LINE (x% * 2 + a1%, y% * 2 + 100)-(x% * 2 + a1% + 2, y% * 2 + 102), POINT(x%, y%)
 NEXT
NEXT
LOCATE 1, 1: PRINT "                  "
RETURN
v1: DRAW "c8bm279,250d90u90r10d90g30r10e25h5g5h5g5f5bf5f5d10l10u10e5f15r10h20l10"
LOCATE 15, 1: PRINT "                              ‚®β ¨ ―¥ΰΆλ© αβ®«΅."
RETURN
v2: DRAW "c8bm349,250d90u90r10d90g30r10e25h5g5h5g5f5bf5f5d10l10u10e5f15r10h20l10"
LOCATE 15, 1: PRINT "              ‚®β ¨ Άβ®ΰ®© γ¦¥ ―®αβ Ά¨«¨, ­¥¤®«£® β¥΅¥ ®αβ «®αμ."
RETURN
v3: DRAW "c8bm269,260r100d10l100u10r10f10l10e10r60f10l10e10"
LOCATE 15, 1: PRINT "                  € νβ® ―¥ΰ¥ª« ¤¨­  ­  ª®β®ΰ®© β¥΅ο ―®Ά¥αοβ."
RETURN
v4: LINE (319, 260)-(319, 290), 8: CIRCLE (319, 295), 5, 8
LOCATE 15, 1: PRINT "                              ‚®β ¨ ―¥β«ξ ―®Ά¥α¥«¨."
RETURN
v5: CIRCLE (319, 310), 10, 8, , , 1.7: LINE (319, 300)-(306, 307), 8: LINE (320, 300)-(331, 306), 8
LOCATE 15, 1: PRINT "                          „ - -  ¥ι¥ ηγβμ-ηγβμ ®αβ «®αμ."
RETURN
v6: LINE (317, 319)-(309, 335), 8: LINE (321, 319)-(329, 335), 8
LOCATE 15, 1: PRINT "                  ‚®β βλ γ¦¥ ¨ Ά¨α¨θμ, ®αβ «αο ―®α«¥¤­¨© θ ­α."
RETURN
v7:
FOR i = 0 TO 30
 LINE (309 + i / 3, 370 - i)-(329 - i / 3, 370 - i), 4
 FOR t = 0 TO 2000: NEXT
NEXT
FOR i% = 1 TO LEN(a$): B%(i%) = 1: NEXT: GOSUB nadp: LOCATE 8, 10: PRINT "β®:"
LOCATE 15, 1: PRINT "                          ’  λ    ―  ®  £  ®  ΰ  ¥  « ."
p2% = p2% + 1
GOTO fi
en:
LOCATE 13, 1: PRINT "         ®  §  ¤  ΰ     Ά  «  ο  ξ    α    ―  ®  ΅  ¥  ¤  ®  ©    !  !  !"
p1% = p1% + 1
fi: f$ = INPUT$(1): IF tur% <> 5 THEN GOTO na
CLS
PRINT "’ƒ ’‰ ƒ›:"
PRINT "®΅¥¤:      "; p1%
PRINT "®ΰ ¦¥­¨©:  "; p2%
IF p1% > p2% THEN PRINT "®§¤ΰ Ά«οξ α ®ª®­η β¥«μ­®© ―®΅¥¤®© !!!" ELSE PRINT " α®¦ «¥­¨ξ γ Ά α ―®΅¥¤ ¬¥­μθ¥ η¥¬ ―®ΰ ¦¥­¨©, §­ η¨β Άλ ―ΰ®¨£ΰ «¨ Άα¥."
END
dat1: DATA †¨Ά®β­λ¥,‹‘€,‚‹,…„‚…„,‹‘,‡€–,“–€,‹…,ƒ…€,“‰‚‹,›‘,‹…‚,‚‹,“‹,‹€„,€€,’ƒ,‹…€„,-1
dat2: DATA ¥΅¥«μ,‘’‹,‘’“‹,€”,‚€’,’€“…’€,…‘‹,‘”€,’“—€,„‘‚…—,—€‘›,‹€,‡…€‹,-1
dat3: DATA „¥ΰ¥Άμο,……‡€,„“,‘‘€,…‹,€€,€‹€,‘…,‹…,…„,‹‘’‚…–€,‚€,-1
dat4: DATA ΰªβ¥ε­¨ª ,’,‹€‚’“€,’…,‘€…,›,‚,–…‘,„‘‚„,„‘,„†‰‘’,’…‹,‹,-1
dat5: DATA ‘βΰ ­λ,‘‘,‘€,€ƒ‹,”€–,’€‹,€,ƒ„,ƒ…,€‹†,€‚‘’€‹,‚€’€,ƒ…–,-1
dat6: DATA  ΅®β ,‘’’…‹,……„†…,‚,“—’…‹,‚€•’…,„’,…„‘…‘’€,…„€„,‹–…,‚€—,ƒ‹ƒ,€ƒ‘’,„‚,‘,„•‡‰€,…‡€’›‰,‚€,”–€’,‘……’€,-1
dat7: DATA ƒ §¥βλ,,’“„,€‚„€,‹…,-1
dat8: DATA ¨­®δ¨«μ¬λ,‡,€€,€‚„……,€‘€,’…€’,,”€’€‘,€€,‚€’,‡,ƒ‹€,…’›,€…‘€,‹–…‰‘‰,ƒ…–,—€„…,‹‡–›,…„…,€‘’…‰„,€€ƒ…„„,‚‹„€‚,€‹›,‡‹„…‰€,€‘€,ƒ…,€‘’,…ƒ‹…–,…ƒ‹…–›
DATA ‡›ƒ›,…ƒ,-1
dat9: DATA ‘―®ΰβ,”“’‹,€‘…’‹,‚‹…‰‹,•…‰,…‰‘‹,-1
'dat10: DATA
'dat11: DATA

FUNCTION MouseButtons%
 MouseButtons% = a%(2)
END FUNCTION

SUB MouseHide
 DEF SEG = VARSEG(a%(0))
 CALL absolute(VARPTR(a%(0)) + &H3A)
 DEF SEG
END SUB

SUB MouseInit
 DEF SEG = VARSEG(a%(0))
 CALL absolute(VARPTR(a%(0)) + 6)
 DEF SEG
END SUB

SUB MouseReset
 DEF SEG = VARSEG(a%(0))
 CALL absolute(VARPTR(a%(1)) + &H1E)
 DEF SEG
END SUB

SUB MouseShow
 DEF SEG = VARSEG(a%(0))
 CALL absolute(VARPTR(a%(0)) + &H34)
 DEF SEG
END SUB

FUNCTION MouseX%
 MouseX% = a%(0)
END FUNCTION

FUNCTION MouseY%
 MouseY% = a%(1)
END FUNCTION

