DECLARE SUB MouseInit ()
DECLARE SUB MouseReset ()
DECLARE SUB MouseHide ()
DECLARE SUB MouseShow ()
DECLARE FUNCTION MouseX% ()
DECLARE FUNCTION MouseY% ()
DECLARE FUNCTION MouseButtons% ()
DIM SHARED a%(34)
DIM B%(14, 10), c%(14, 10), d%(14, 10), e%(14, 10), buf1%(1 TO 500), buf2%(1 TO 500), im$(10), r%(10)
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
ON ERROR GOTO s1
OPEN "pamyt.dat" FOR INPUT AS #1
INPUT #1, maxig%
FOR i% = 0 TO maxig%: INPUT #1, im$(i%), r%(i%): NEXT
CLOSE #1
s1: CLS
PRINT "Кто сегодня играет ?"
FOR i% = 1 TO maxig%
 PRINT i%; ". "; im$(i%); ", личный рекорд:"; r%(i%); "мин.открытий"
NEXT
PRINT "-1 . Новый игрок"
INPUT ig%
IF ig% = -1 THEN maxig% = maxig% + 1: INPUT "Напишите как завут нового игрока"; im$(maxig%): GOTO s1
PRINT "Здравствуйте "; im$(ig%)
FOR t = 0 TO 90000: NEXT
CLS
RANDOMIZE TIMER
CALL MouseInit'          Иницылизацыя мышки
LINE (1, 1)-(39, 39), 15, BF
LINE (2, 2)-(39, 39), 8, BF
LINE (2, 2)-(38, 38), 7, BF
GET (0, 0)-(40, 40), buf1%
CLS
LINE (1, 1)-(39, 39), 15, BF
LINE (1, 1)-(38, 38), 0, BF
LINE (2, 2)-(38, 38), 7, BF
LINE (2, 2)-(37, 37), 8, BF
t% = 0
FOR y% = 3 TO 36
 FOR x% = 3 TO 36 STEP 2
  PSET (x% + t%, y%), 7
 NEXT
 t% = t% + 1
 IF t% = 2 THEN t% = 0
NEXT
GET (0, 0)-(40, 40), buf2%
CLS
FOR y% = 1 TO 10
 FOR x% = 1 TO 14
  B%(x%, y%) = 0: c%(x%, y%) = 0: d%(x%, y%) = 0: e%(x%, y%) = 1
 NEXT
NEXT
FOR i% = 1 TO 70
 DO
  x% = INT(RND(1) * 14 + 1)
  y% = INT(RND(1) * 10 + 1)
 LOOP WHILE B%(x%, y%) <> 0
 B%(x%, y%) = i%
 DO
  x% = INT(RND(1) * 14 + 1)
  y% = INT(RND(1) * 10 + 1)
 LOOP WHILE B%(x%, y%) <> 0
 B%(x%, y%) = i%
NEXT
LINE (0, 0)-(639, 479), 2, BF
LINE (35, 35)-(605, 445), 0, BF
LINE (35, 35)-(604, 444), 7, BF
LINE (36, 36)-(603, 443), 8, BF
LINE (36, 36)-(603, 443), 15, BF
LINE (37, 37)-(602, 442), 7, BF
GOSUB pok1
CALL MouseShow'          Показать курсор
l% = 0
LOCATE 1, 2: PRINT "http:\\www.kas-cor.boom.ru"
LOCATE 2, 2: PRINT "http:\\www.kas-cor.narod.ru"
DO
 x% = MouseX%'           Координат Х
 y% = MouseY%'           Координат Y
 k% = MouseButtons%'     Покозатели кнопок 1-левая, 2-правая, 3-нажаты две
 IF x% > 40 AND x% < 600 AND y% > 40 AND y% < 440 THEN
  IF k% = 1 AND l% = 1 AND c%(x% \ 40, y% \ 40) = 0 THEN
   CALL MouseHide
   c%(x% \ 40, y% \ 40) = 1
   GOSUB pok1
   a1% = x% \ 40: b1% = y% \ 40
   DO
    k% = MouseButtons%
   LOOP WHILE k% <> 0
   IF B%(a%, B%) <> B%(a1%, b1%) THEN
    c%(a%, B%) = 0: c%(a1%, b1%) = 0
    d%(a%, B%) = d%(a%, B%) + 1
    d%(a1%, b1%) = d%(a1%, b1%) + 1
    FOR t = 0 TO 1000: NEXT
    GOSUB pok1
   END IF
   CALL MouseShow
   l% = 0
  END IF
  IF k% = 1 AND l% = 0 AND c%(x% \ 40, y% \ 40) = 0 THEN
   CALL MouseHide
   c%(x% \ 40, y% \ 40) = 1
   GOSUB pok1
   CALL MouseShow
   DO
    k% = MouseButtons%
   LOOP WHILE k% <> 0
   l% = 1: a% = x% \ 40: B% = y% \ 40
  END IF
 END IF
 d3% = 0
 FOR y% = 1 TO 10
  FOR x% = 1 TO 14
   IF c%(x%, y%) = 0 THEN d3% = 1
  NEXT
 NEXT
 IF d3% = 0 THEN GOTO en
LOOP WHILE INKEY$ <> CHR$(27)
GOTO en
pok1:
FOR y3% = 1 TO 10
 FOR x3% = 1 TO 14
  IF e%(x3%, y3%) <> c%(x3%, y3%) THEN
   IF c%(x3%, y3%) = 0 THEN
    PUT (x3% * 40, y3% * 40), buf1%, PSET
   END IF
   IF c%(x3%, y3%) = 1 THEN x1% = x3% * 40: y1% = y3% * 40: GOSUB pok
  END IF
 NEXT
NEXT
FOR y3% = 1 TO 10
 FOR x3% = 1 TO 14
  e%(x3%, y3%) = c%(x3%, y3%)
 NEXT
NEXT
RETURN
pok:
PUT (x3% * 40, y3% * 40), buf2%, PSET
f% = B%(x3%, y3%)
IF f% = 1 THEN LINE (x1% + 5, y1% + 5)-(x1% + 35, y1% + 35), 15, B
IF f% = 2 THEN LINE (x1% + 5, y1% + 5)-(x1% + 35, y1% + 35), 15, BF
IF f% = 3 THEN CIRCLE (x1% + 20, y1% + 20), 15, 15
IF f% = 4 THEN CIRCLE (x1% + 20, y1% + 20), 15, 15: PAINT (x1% + 20, y1% + 20), 15, 15
IF f% = 5 THEN LINE (x1% + 20, y1% + 5)-(x1% + 35, y1% + 35), 15: LINE (x1% + 20, y1% + 5)-(x1% + 5, y1% + 35), 15: LINE (x1% + 5, y1% + 35)-(x1% + 35, y1% + 35), 15
IF f% = 6 THEN LINE (x1% + 20, y1% + 5)-(x1% + 35, y1% + 35), 15: LINE (x1% + 20, y1% + 5)-(x1% + 5, y1% + 35), 15: LINE (x1% + 5, y1% + 35)-(x1% + 35, y1% + 35), 15: PAINT (x1% + 20, y1% + 20), 15, 15
IF f% = 7 THEN
 FOR i% = 0 TO 15 STEP 4
  CIRCLE (x1% + 20, y1% + 20), i%, 15
 NEXT
END IF
IF f% = 8 THEN
 CIRCLE (x1% + 20, y1% + 20), 15, 15: PAINT (x1% + 20, y1% + 20), 15, 15
 FOR i% = 0 TO 15 STEP 4
  CIRCLE (x1% + 20, y1% + 20), i%, 0
 NEXT
END IF
IF f% = 9 THEN
 FOR i% = 5 TO 19 STEP 4
  LINE (x1% + i%, y1% + i%)-(x1% + 40 - i%, y1% + 40 - i%), 15, B
 NEXT
END IF
IF f% = 10 THEN PSET (x1% + 5, y1% + 20): DRAW "c15m+15,-15m+15,+15m-15,+15m-15,-15"
IF f% = 11 THEN PSET (x1% + 5, y1% + 20): DRAW "c15m+15,-15m+15,+15m-15,+15m-15,-15": PAINT (x1% + 20, y1% + 20), 15, 15
IF f% = 12 THEN LINE (x1% + 20, y1% + 35)-(x1% + 35, y1% + 5), 15: LINE (x1% + 20, y1% + 35)-(x1% + 5, y1% + 5), 15: LINE (x1% + 5, y1% + 5)-(x1% + 35, y1% + 5), 15
IF f% = 13 THEN LINE (x1% + 20, y1% + 35)-(x1% + 35, y1% + 5), 15: LINE (x1% + 20, y1% + 35)-(x1% + 5, y1% + 5), 15: LINE (x1% + 5, y1% + 5)-(x1% + 35, y1% + 5), 15: PAINT (x1% + 20, y1% + 20), 15, 15
IF f% = 14 THEN LINE (x1% + 15, y1% + 5)-(x1% + 25, y1% + 35), 15, BF: LINE (x1% + 5, y1% + 15)-(x1% + 35, y1% + 25), 15, BF
IF f% = 15 THEN LINE (x1% + 15, y1% + 5)-(x1% + 25, y1% + 35), 15, B: LINE (x1% + 5, y1% + 15)-(x1% + 35, y1% + 25), 15, B
IF f% = 16 THEN LINE (x1% + 15, y1% + 5)-(x1% + 25, y1% + 35), 15, BF
IF f% = 17 THEN LINE (x1% + 15, y1% + 5)-(x1% + 25, y1% + 35), 15, B
IF f% = 18 THEN LINE (x1% + 5, y1% + 15)-(x1% + 35, y1% + 25), 15, BF
IF f% = 19 THEN LINE (x1% + 5, y1% + 15)-(x1% + 35, y1% + 25), 15, B
IF f% = 20 THEN
 FOR i% = 0 TO 15 STEP 4
  CIRCLE (x1% + 20, y1% + 20), i%, 15, , , .5
 NEXT
END IF
IF f% = 21 THEN
 FOR i% = 0 TO 15 STEP 4
  CIRCLE (x1% + 20, y1% + 20), i%, 15, , , 1.5
 NEXT
END IF
IF f% = 22 THEN CIRCLE (x1% + 20, y1% + 20), 15, 15, , , .5
IF f% = 23 THEN CIRCLE (x1% + 20, y1% + 20), 15, 15, , , 1.5
IF f% = 24 THEN CIRCLE (x1% + 20, y1% + 20), 15, 15, , , .5: PAINT (x1% + 20, y1% + 20), 15, 15
IF f% = 25 THEN CIRCLE (x1% + 20, y1% + 20), 15, 15, , , 1.5: PAINT (x1% + 20, y1% + 20), 15, 15
IF f% = 26 THEN
 CIRCLE (x1% + 20, y1% + 20), 15, 15, , , .5: PAINT (x1% + 20, y1% + 20), 15, 15
 FOR i% = 0 TO 15 STEP 4
  CIRCLE (x1% + 20, y1% + 20), i%, 0, , , .5
 NEXT
END IF
IF f% = 27 THEN
 CIRCLE (x1% + 20, y1% + 20), 15, 15, , , 1.5: PAINT (x1% + 20, y1% + 20), 15, 15
 FOR i% = 0 TO 15 STEP 4
  CIRCLE (x1% + 20, y1% + 20), i%, 0, , , 1.5
 NEXT
END IF
IF f% = 28 THEN
 FOR i% = 0 TO 10 STEP 2
  LINE (x1% + 15 + i%, y1% + 5 + i%)-(x1% + 25 - i%, y1% + 35 - i%), 15, B
 NEXT
END IF
IF f% = 29 THEN
 FOR i% = 0 TO 10 STEP 2
  LINE (x1% + 5 + i%, y1% + 15 + i%)-(x1% + 35 - i%, y1% + 25 - i%), 15, B
 NEXT
END IF
IF f% = 30 THEN LINE (x1% + 5, y1% + 5)-(x1% + 35, y1% + 20), 15: LINE (x1% + 5, y1% + 35)-(x1% + 35, y1% + 20), 15: LINE (x1% + 5, y1% + 35)-(x1% + 5, y1% + 5), 15
IF f% = 31 THEN LINE (x1% + 5, y1% + 5)-(x1% + 35, y1% + 20), 15: LINE (x1% + 5, y1% + 35)-(x1% + 35, y1% + 20), 15: LINE (x1% + 5, y1% + 35)-(x1% + 5, y1% + 5), 15: PAINT (x1% + 20, y1% + 20), 15, 15
IF f% = 32 THEN LINE (x1% + 35, y1% + 5)-(x1% + 5, y1% + 20), 15: LINE (x1% + 35, y1% + 35)-(x1% + 5, y1% + 20), 15: LINE (x1% + 35, y1% + 35)-(x1% + 35, y1% + 5), 15
IF f% = 33 THEN LINE (x1% + 35, y1% + 5)-(x1% + 5, y1% + 20), 15: LINE (x1% + 35, y1% + 35)-(x1% + 5, y1% + 20), 15: LINE (x1% + 35, y1% + 35)-(x1% + 35, y1% + 5), 15: PAINT (x1% + 20, y1% + 20), 15, 15
IF f% = 34 THEN PSET (x1% + 5, y1% + 10), 15: DRAW "c15e5f10e10f5g10f10g5h10g10h5e10h10"
IF f% = 35 THEN PSET (x1% + 5, y1% + 10), 15: DRAW "c15e5f10e10f5g10f10g5h10g10h5e10h10": PAINT (x1% + 20, y1% + 20), 15, 15
IF f% > 35 AND f% < 63 THEN
 LOCATE 1, 1: PRINT CHR$(f% - 34 + 127)
 FOR y7% = 0 TO 15
  FOR x7% = 0 TO 7
   IF POINT(x7%, y7%) <> 0 THEN LINE (x7% * 2 + x1% + 10, y7% * 2 + y1% + 5)-(x7% * 2 + x1% + 12, y7% * 2 + y1% + 7), 15, BF
  NEXT
 NEXT
 LINE (0, 0)-(7, 15), 2, BF
END IF
IF f% > 62 THEN
 LOCATE 1, 1: PRINT CHR$(f% - 63 + 48)
 FOR y7% = 0 TO 15
  FOR x7% = 0 TO 7
   IF POINT(x7%, y7%) <> 0 THEN LINE (x7% * 2 + x1% + 10, y7% * 2 + y1% + 5)-(x7% * 2 + x1% + 12, y7% * 2 + y1% + 7), 15, BF
  NEXT
 NEXT
 LINE (0, 0)-(7, 15), 2, BF
END IF
RETURN
en:
CALL MouseHide: CLS
max% = 0: min% = 1000: v% = 0
FOR y% = 1 TO 10
 FOR x% = 1 TO 14
  IF c%(x%, y%) = 1 THEN v% = v% + 1
  IF d%(x%, y%) > max% THEN max% = d%(x%, y%)
  IF d%(x%, y%) < min% THEN min% = d%(x%, y%)
 NEXT
NEXT
IF v% = 140 THEN LOCATE 10, 1: PRINT "                        Поздравляю, вы всё раскрыли"
IF v% < 140 THEN LOCATE 10, 1: PRINT "                    Всего открыто "; INT((v% / 140) * 100); "% всего поля."
PRINT : PRINT "  В этот раз, максимальное количество открывания одной и той же карточке равно"
PRINT "                                     "; max%
PRINT : PRINT "  А, миниманое  количество  открывания   одной  и  той же   карточке   равно"
PRINT "                                     "; min%
PRINT : PRINT "  Среднее    количество   открывания    одной   и   той же   карточке   равно"
PRINT "                                     "; (max% + min%) \ 2
IF v% = 140 AND max% < r%(ig%) THEN r%(ig%) = max%
OPEN "pamyt.dat" FOR OUTPUT AS #1
WRITE #1, maxig%
FOR i% = 0 TO maxig%: WRITE #1, im$(i%), r%(i%): NEXT
CLOSE #1
f$ = INPUT$(1)
END

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

