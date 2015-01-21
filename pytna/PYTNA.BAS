DECLARE SUB MouseInit ()
DECLARE SUB MouseReset ()
DECLARE SUB MouseHide ()
DECLARE SUB MouseShow ()
DECLARE FUNCTION MouseX% ()
DECLARE FUNCTION MouseY% ()
DECLARE FUNCTION MouseButtons% ()
DIM SHARED a%(34)
DIM b%(6, 6), k%(1 TO 10000), im$(10), r%(10)
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
OPEN "record3.dat" FOR INPUT AS #1
INPUT #1, maxig%
FOR i% = 0 TO maxig%: INPUT #1, im$(i%), r%(i%): NEXT
CLOSE #1
s1: CLS
PRINT "Кто сегодня играет ?"
FOR i% = 1 TO maxig%
 PRINT i%; ". "; im$(i%); ", личный рекорд:"; r%(i%); "ход."
NEXT
PRINT "-1 . Новый игрок"
INPUT ig%
IF ig% = -1 THEN maxig% = maxig% + 1: INPUT "Напишите как завут нового игрока"; im$(maxig%): GOTO s1
PRINT "Здравствуйте "; im$(ig%)
FOR t = 0 TO 90000: NEXT
CLS
CALL MouseInit
na: h = 0: CLS
FOR y% = 0 TO 3
 FOR x% = 1 TO 4
  LINE (x% * 110 + 2, y% * 110 + 2)-(x% * 110 + 108, y% * 110 + 108), 10, B
  LINE (x% * 110 + 10, y% * 110 + 10)-(x% * 110 + 100, y% * 110 + 100), 10, B
  LINE (x% * 110 + 2, y% * 110 + 2)-(x% * 110 + 10, y% * 110 + 10), 10
  LINE (x% * 110 + 108, y% * 110 + 108)-(x% * 110 + 100, y% * 110 + 100), 10
  LINE (x% * 110 + 108, y% * 110 + 2)-(x% * 110 + 100, y% * 110 + 10), 10
  LINE (x% * 110 + 2, y% * 110 + 108)-(x% * 110 + 10, y% * 110 + 100), 10
  CIRCLE (x% * 110 + 55, y% * 110 + 55), 30, 10
  PAINT (x% * 110 + 12, y% * 110 + 12), 3, 10
  PAINT (x% * 110 + 4, y% * 110 + 3), 7, 10
  PAINT (x% * 110 + 3, y% * 110 + 4), 7, 10
  PAINT (x% * 110 + 105, y% * 110 + 107), 8, 10
  PAINT (x% * 110 + 107, y% * 110 + 105), 8, 10
 NEXT
NEXT
LINE (0, 460)-(639, 460), 10
PAINT (0, 0), 2, 10
LINE (0, 460)-(639, 460), 0
LINE (109, -1)-(551, 441), 0, B
LOCATE 30, 1: PRINT "Производство KAS-cor. http:\\www.kas-cor.boom.ru и http:\\www.kas-cor.narod.ru";
RANDOMIZE (TIMER)
FOR y% = 1 TO 4
 FOR x% = 1 TO 4
  b%(x%, y%) = 0
 NEXT
NEXT
FOR i% = 0 TO 15
 DO
  x% = INT(RND(1) * 4 + 1)
  y% = INT(RND(1) * 4 + 1)
 LOOP WHILE b%(x%, y%) <> 0
 b%(x%, y%) = i%
 LOCATE y% * 7 - 3, x% * 14 + 5: PRINT i%
NEXT
FOR y% = 1 TO 4
 FOR x% = 1 TO 4
  IF b%(x%, y%) = 0 THEN x1% = x%: y1% = y%
 NEXT
NEXT
LINE (x1% * 110, (y1% - 1) * 110)-(x1% * 110 + 110, (y1% - 1) * 110 + 110), 0, BF
CALL MouseShow
LOCATE 1, 75: PRINT "Выход!"
LINE (591, 0)-(639, 16), 10, B
DO
 x% = MouseX%
 y% = MouseY%
 k% = MouseButtons%
 IF k% = 1 AND x% > 591 AND y% > 0 AND x% < 639 AND y% < 16 THEN END
 a% = (x% \ 110) - x1%: b% = (y% \ 110) - (y1% - 1)
 IF a% = 0 OR b% = 0 THEN
   IF b%(x% \ 110, y% \ 110 + 1) <> 0 AND k% = 1 THEN
   CALL MouseHide
   x4% = x%: y4% = y%
   IF a% < 0 AND b% = 0 THEN GET ((x% \ 110) * 110, (y% \ 110) * 110)-(x1% * 110, (y1% - 1) * 110 + 110), k%: p% = 1: x2% = (x% \ 110) * 110: y2% = (y% \ 110) * 110
   IF a% > 0 AND b% = 0 THEN GET ((x% \ 110) * 110 + 110, (y% \ 110) * 110 + 110)-(x1% * 110 + 110, (y1% - 1) * 110), k%: p% = 2: x2% = x1% * 110 + 110: y2% = (y1% - 1) * 110
   IF a% = 0 AND b% < 0 THEN GET ((x% \ 110) * 110, (y% \ 110) * 110)-(x1% * 110 + 110, (y1% - 1) * 110), k%: p% = 3: x2% = (x% \ 110) * 110: y2% = (y% \ 110) * 110
   IF a% = 0 AND b% > 0 THEN GET ((x% \ 110) * 110 + 110, (y% \ 110) * 110 + 110)-(x1% * 110, (y1% - 1) * 110 + 110), k%: p% = 4: x2% = x1% * 110: y2% = (y1% - 1) * 110 + 110
   x3% = x2%: y3% = y2%
   IF p% = 1 THEN r% = ABS(a%)
   IF p% = 2 THEN r% = a%
   IF p% = 3 THEN r% = ABS(b%)
   IF p% = 4 THEN r% = b%
   PUT (x3%, y3%), k%
   FOR i% = 1 TO 110 STEP 5
    PUT (x3%, y3%), k%
    FOR t = r% * 500 TO 1500: NEXT
    PUT (x3%, y3%), k%
    IF p% = 1 THEN x3% = x3% + 5
    IF p% = 2 THEN x3% = x3% - 5
    IF p% = 3 THEN y3% = y3% + 5
    IF p% = 4 THEN y3% = y3% - 5
   NEXT
   PUT (x3%, y3%), k%
   x3% = x1%: y3% = y1%
   x2% = x2% \ 110: y2% = y2% \ 110
   FOR i% = 1 TO r%
    IF p% = 1 THEN b%(x3%, y3%) = b%(x3% - 1, y3%): x3% = x3% - 1
    IF p% = 2 THEN b%(x3%, y3%) = b%(x3% + 1, y3%): x3% = x3% + 1
    IF p% = 3 THEN b%(x3%, y3%) = b%(x3%, y3% - 1): y3% = y3% - 1
    IF p% = 4 THEN b%(x3%, y3%) = b%(x3%, y3% + 1): y3% = y3% + 1
   NEXT
   b%(x4% \ 110, y4% \ 110 + 1) = 0: x1% = x4% \ 110: y1% = y4% \ 110 + 1
   CALL MouseShow
   h = h + 1
   LOCATE 29, 38: PRINT " Ход "; CHR$(252); h;
  END IF
 END IF
 w% = 0: o% = 0
 FOR y% = 1 TO 4
  FOR x% = 1 TO 4
   w% = w% + 1
   IF w% = 16 THEN w% = 0
   IF b%(x%, y%) <> w% THEN o% = 1
  NEXT
 NEXT
 IF o% = 0 THEN GOTO pobeda
LOOP WHILE INKEY$ <> CHR$(27)
CHAIN "games3.bas"
pobeda:
CALL MouseHide
LOCATE 30, 1: PRINT "             П  о  з  д  р  а  в  л  я  ю     с     п  о  б  е  д  о  й";
IF record% > h THEN
 r%(im%) = h
 OPEN "record3.dat" FOR OUTPUT AS #1
 WRITE #1, maxig%
 FOR i% = 0 TO maxig%: WRITE #1, im$(i%), r%(i%): NEXT
 CLOSE #1
 ELSE f$ = INPUT$(1)
END IF
CLS
LOCATE 16, 5: PRINT "Абсолютный рекорд пренадлежит "; a$; "он победил за"; record%; "ходов."
LOCATE 17, 35: PRINT "Ещё хочешь ?"; : f$ = INPUT$(1)
IF f$ = "d" OR f$ = "l" OR f$ = "д" OR f$ = "в" THEN GOTO na
CHAIN "games3.bas"

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

