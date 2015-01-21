DECLARE SUB MouseInit ()
DECLARE SUB MouseReset ()
DECLARE SUB MouseHide ()
DECLARE SUB MouseShow ()
DECLARE FUNCTION MouseX% ()
DECLARE FUNCTION MouseY% ()
DECLARE FUNCTION MouseButtons% ()
DIM SHARED a%(34)
DIM B%(5, 9), k%(1 TO 3000), c%(10)
ON ERROR GOTO e1
OPEN "rekord2.dat" FOR INPUT AS #1
FOR i% = 0 TO 9
 INPUT #1, a$(i%), c%(i%)
NEXT
CLOSE #1
e1:
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
CALL MouseInit'          Иницылизацыя мышки
na: h = 0: CLS
CALL MouseShow'          Показать курсор
LOCATE 13, 35: PRINT "Сколько колец ?"
a = 1
FOR i% = 1 TO 9
 LOCATE 15, a + 3: PRINT i%
 a = a + 9
NEXT
LOCATE 1, 75: PRINT "Выход!"
LINE (591, 0)-(639, 16), 10, B
DO
 x% = MouseX%'           Координат Х
 y% = MouseY%'           Координат Y
 k% = MouseButtons%'     Покозатели кнопок 1-левая, 2-правая, 3-нажаты две
 IF k% = 1 AND x% > 591 AND y% > 0 AND x% < 639 AND y% < 16 THEN GOTO en1
 CIRCLE ((x% \ 72) * 72 + 35, 230), 15, 3
 CIRCLE ((x% \ 72) * 72 + 35, 230), 15, 0
LOOP WHILE k% <> 1
CALL MouseHide
CIRCLE ((x% \ 72) * 72 + 35, 230), 15, 3
r% = x% \ 72 + 1
FOR t = 0 TO 50000: NEXT: CLS
a = 106
FOR i% = 1 TO 3
 CIRCLE (a, 100), 4, 7, , , 1.2
 PAINT (a, 100), 7, 7
 LINE (a - 3, 100)-(a + 3, 300), 7, BF
 IF i% = 1 THEN
  FOR y% = 1 TO r%
   B%(1, y%) = y%: B%(2, y%) = 0: B%(3, y%) = 0
   LINE (a - ((r% + 1 - y%) * 10), 300 - y% * 20)-(a + ((r% + 1 - y%) * 10), 315 - y% * 20), y% + 1, BF
  NEXT
 END IF
 a = a + 213
NEXT
LINE (0, 300)-(639, 310), 7, BF
CALL MouseShow
LOCATE 1, 75: PRINT "Выход!"
LINE (591, 0)-(639, 16), 10, B
LOCATE 1, 2: PRINT "http:\\www.kas-cor.boom.ru"
LOCATE 2, 2: PRINT "http:\\www.kas-cor.narod.ru"
DO
 x% = MouseX%'           Координат Х
 y% = MouseY%'           Координат Y
 IF j% = 0 THEN k% = MouseButtons% ELSE k% = 0: j1% = j1% + 1
 IF j1% > 5000 THEN j% = 0: j1% = 0
 IF k% = 1 AND x% > 591 AND y% > 0 AND x% < 639 AND y% < 16 THEN GOTO en1
 IF k% = 1 AND f% = 1 AND x% \ 213 + 1 <> x2% AND x% \ 213 + 1 <> 4 THEN
  CALL MouseHide
  y% = 0
  FOR i% = r% TO 1 STEP -1
   IF B%(x% \ 213 + 1, i%) <> 0 THEN y% = i%: EXIT FOR
  NEXT
  IF y% <> 0 THEN IF q% < y% THEN GOSUB m3: GOTO m4
  a% = (x% \ 213) * 213 + 106
  LINE (x4%, 50)-(x5%, 65), 0, BF
  LINE (a% - ((r% + 1 - y2%) * 10), 300 - y2% * 20)-(a% + ((r% + 1 - y2%) * 10), 315 - y2% * 20), y2% + 1, BF
  B%(x% \ 213 + 1, y2%) = q%
  B%(x2%, y2%) = 0: h = h + 1: LOCATE 22, 37: PRINT "Ход "; CHR$(252); h
m4: CALL MouseShow
  f% = 0
  k% = 0: j% = 1
  DO
   k% = MouseButtons%
  LOOP WHILE k% <> 0
 END IF
 IF k% = 1 AND f% = 0 THEN
  CALL MouseHide
  d% = 0
  FOR i% = 1 TO r%
   IF B%(x% \ 213 + 1, i%) <> 0 THEN d% = 1
  NEXT
  IF d% = 0 THEN GOTO m1
  FOR i% = r% TO 1 STEP -1
   IF B%(x% \ 213 + 1, i%) <> 0 THEN y% = i%: a% = (x% \ 213) * 213 + 106: EXIT FOR
  NEXT
  x4% = a% - ((r% + 1 - y%) * 10): y4% = 300 - y% * 20: x5% = a% + ((r% + 1 - y%) * 10): y5% = 315 - y% * 20
  LINE (x4%, y4%)-(x5%, y5%), 0, BF
  LINE (a% - 3, 300 - y% * 20)-(a% + 3, 300 - y% * 20 + 19), 7, BF
  LINE (x4%, 50)-(x5%, 65), y% + 1, BF
  f% = 1
  x2% = a% \ 213 + 1: y2% = y%: q% = B%(x2%, y2%)
m1:
  CALL MouseShow
  DO
   k% = MouseButtons%
  LOOP WHILE k% <> 0
 END IF
 g% = 0: v% = 0
 FOR B% = 1 TO r%
  v% = v% + 1
  IF B%(3, B%) <> v% THEN g% = 1
 NEXT
 IF g% = 0 THEN GOTO en
 IF g2% = 0 THEN
  g1% = 0: v1% = 0
  FOR B% = 1 TO r%
   v1% = v1% + 1
   IF B%(2, B%) <> v1% THEN g1% = 1
  NEXT
  IF g1% = 0 THEN LOCATE 24, 1: PRINT "                       Молодец, а теперь с второй на третью.": f$ = INPUT$(1): g2% = 1: LOCATE 24, 1: PRINT "                                                            "
 END IF
LOOP WHILE INKEY$ <> CHR$(27)
CALL MouseHide'          Убрать курсор
CALL MouseReset'         Сброс мышки
GOTO en1
en:
LOCATE 24, 1: PRINT "       П  о  з  д  р  а  в  л  я  ю    с    п  о  б  е  д  о  й    !  !  !"
IF c%(r%) > h THEN
 INPUT "Как вас завут "; n$
 a$(r%) = n$: c%(r%) = h
 OPEN "rekord2.dat" FOR OUTPUT AS #1
 FOR i% = 0 TO 9
  WRITE #1, a$(i%), c%(i%)
 NEXT
 CLOSE #1
 ELSE f$ = INPUT$(1)
END IF
CALL MouseHide
en1: CLS
PRINT : PRINT "                     Д о с к а    п о ч ё т а  ! ! !"
FOR i% = 0 TO 8
 IF a$(i% + 1) = "" THEN a$(i% + 1) = "Никто"
 PRINT "   На    "; i% + 1; "  кол.        выиграл       "; a$(i% + 1); "     за      "; c%(i% + 1); "       ходов."
NEXT
LOCATE 15, 35: PRINT "Ещё хочешь ?": f$ = INPUT$(1)
IF f$ = "d" OR f$ = "l" OR f$ = "д" OR f$ = "в" THEN GOTO na
END
m3:
LINE (x4%, 50)-(x5%, 65), 0, BF
LINE (x4%, y4%)-(x5%, y5%), y2% + 1, BF
RETURN

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

