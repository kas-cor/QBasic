DECLARE SUB MouseInit ()
DECLARE SUB MouseReset ()
DECLARE SUB MouseHide ()
DECLARE SUB MouseShow ()
DECLARE FUNCTION MouseX% ()
DECLARE FUNCTION MouseY% ()
DECLARE FUNCTION MouseButtons% ()
DECLARE FUNCTION MouseChoice% ()
DECLARE SUB title (t$, x0!, y0!)
DECLARE SUB charcir (c$, x0!, y0!, r!, c!)
DIM SHARED a%(34)
DIM B%(50, 50), m1%(0 TO 500), c%(10), a$(10)
DEF SEG = VARSEG(a%(0))
ON ERROR GOTO e1
OPEN "rekord.dat" FOR INPUT AS #1
FOR i% = 0 TO 9
 INPUT #1, a$(i%), c%(i%)
NEXT
CLOSE #1
e1:
RANDOMIZE (TIMER)
FOR i% = 0 TO 63
 READ D%
 POKE VARPTR(a%(0)) + i%, D%
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
GOSUB na
SCREEN 12: CLS
CALL MouseInit
CALL MouseShow
LOCATE 13, 1: PRINT "                       Введите уровень игры от 1 до 10"
a = 1
FOR i% = 1 TO 9
 LOCATE 15, a + 3: PRINT i%
 a = a + 9
NEXT
LOCATE 1, 75: PRINT "Выход!"
LINE (591, 0)-(639, 16), 10, B
DO
 x% = MouseX%
 y% = MouseY%
 k% = MouseButtons%
 IF k% = 1 AND x% > 591 AND y% > 0 AND x% < 639 AND y% < 16 THEN END
 CIRCLE ((x% \ 72) * 72 + 35, 230), 15, 3
 CIRCLE ((x% \ 72) * 72 + 35, 230), 15, 0
LOOP WHILE k% <> 1
CALL MouseHide
CIRCLE ((x% \ 72) * 72 + 35, 230), 15, 3
u = x% \ 72 + 1
FOR t = 0 TO 50000: NEXT: CLS
CLS
FOR i% = 0 TO 120
 CIRCLE (RND(1) * 400, RND(1) * 400), RND(1) * 50, 10
NEXT
FOR x% = 0 TO 351
 FOR y% = 0 TO 351
  IF POINT(x%, y%) = 0 THEN PAINT (x%, y%), RND(1) * 15 + 1, 10
 NEXT
NEXT
i% = 0
FOR y% = 1 TO 10
 FOR x% = 1 TO 10
  B%(x%, y%) = i%
  LINE (x% * 32, y% * 32)-(x% * 32 + 32, y% * 32 + 32), 3, B
  i% = i% + 1
 NEXT
NEXT
LINE (33, 33)-(63, 63), 0, BF
LINE (0, 0)-(639, 31), 0, BF
LINE (0, 0)-(31, 479), 0, BF
LINE (353, 0)-(639, 479), 0, BF
LINE (0, 353)-(639, 479), 0, BF
LOCATE 1, 75: PRINT "Выход!"
LINE (591, 0)-(639, 16), 10, B
FOR x% = 32 TO 352
 FOR y% = 32 TO 352
  IF POINT(x%, y%) <> 0 THEN PSET (x% / 1.5 + 352, y% / 1.5 + 32), POINT(x%, y%)
 NEXT
NEXT
LOCATE 18, 55: PRINT u; "Уровень"
LOCATE 24, 19: PRINT "Запомнили ?"
f$ = INPUT$(1)
LOCATE 24, 19: PRINT "           "
x3% = 32: y3% = 32
FOR i% = 0 TO u * 10
m4:
 x% = INT(RND(1) * 10 + 1) * 32
 y% = INT(RND(1) * 10 + 1) * 32
 IF B%(x% \ 32, y% \ 32) = 0 THEN GOTO m4
 GET (x%, y%)-(x% + 32, y% + 32), m1%
 LINE (x% + 1, y% + 1)-(x% + 31, y% + 31), 0, BF
 c1 = (x3% - x%) / 20
 c2 = (y3% - y%) / 20
 x1 = x%: y1 = y%
 FOR i = 0 TO 21
  PUT (x1, y1), m1%
  PUT (x1, y1), m1%
  x1 = x1 + c1: y1 = y1 + c2
  PUT (x1, y1), m1%
  PUT (x1, y1), m1%
 NEXT
 LINE (x3%, y3%)-(x3% + 32, y3% + 32), 0, BF
 PUT (x3%, y3%), m1%
 B%(x3% \ 32, y3% \ 32) = B%(x% \ 32, y% \ 32): B%(x% \ 32, y% \ 32) = 0
 x3% = x%: y3% = y%
NEXT
CALL MouseShow
t1$ = TIME$
 LOCATE 21, 47: PRINT "http:\\www.kas-cor.boom.ru"
 LOCATE 22, 47: PRINT "http:\\www.kas-cor.narod.ru"
DO
 x% = MouseX%
 y% = MouseY%
 k% = MouseButtons%
 IF k% = 1 AND x% > 591 AND y% > 0 AND x% < 639 AND y% < 16 THEN GOTO m3
 LOCATE 20, 53: PRINT "Время: "; TIME$
 n% = 0: w% = 0
 FOR y1% = 1 TO 10
  FOR x1% = 1 TO 10
   IF n% <> B%(x1%, y1%) THEN w% = 1
   n% = n% + 1
  NEXT
 NEXT
 IF k% = 2 OR INKEY$ = "p" THEN GOSUB pause
 IF w% = 0 THEN GOTO m2
 IF B%(x% \ 32, y% \ 32) <> 0 AND k% = 1 AND x% > 32 AND x% < 352 AND y% > 32 AND y% < 352 THEN
  CALL MouseHide
  x% = (x% \ 32) * 32: y% = (y% \ 32) * 32
  GET (x%, y%)-(x% + 32, y% + 32), m1%
  LINE (x% + 1, y% + 1)-(x% + 31, y% + 31), 0, BF
  c1 = (x3% - x%) / 100
  c2 = (y3% - y%) / 100
  x1 = x%: y1 = y%
  FOR i = 0 TO 101
   PUT (x1, y1), m1%
   FOR t = 0 TO 10: NEXT
   PUT (x1, y1), m1%
   x1 = x1 + c1: y1 = y1 + c2
   PUT (x1, y1), m1%
   FOR t = 0 TO 10: NEXT
   PUT (x1, y1), m1%
  NEXT
  LINE (x3%, y3%)-(x3% + 32, y3% + 32), 0, BF
  PUT (x3%, y3%), m1%
  B%(x3% \ 32, y3% \ 32) = B%(x% \ 32, y% \ 32): B%(x% \ 32, y% \ 32) = 0
  x3% = x%: y3% = y%
  CALL MouseShow
  h = h + 1
  LOCATE 24, 19: PRINT "Ход "; CHR$(252); h
 END IF
LOOP WHILE INKEY$ <> CHR$(27)
GOTO m3
m2: LOCATE 26, 1: PRINT "П  о  з  д  р  а  в  л  я  ю     с     п  о  б  е  д  о  й    !  !  !"
t1% = VAL(MID$(TIME$, 4, 2)) - VAL(MID$(t1$, 4, 2))
t2% = VAL(MID$(TIME$, 7, 2)) - VAL(MID$(t1$, 7, 2))
PRINT "                         Продолжительность игры "; ABS(t1%); ":"; ABS(t2%)
IF c%(u) > h THEN
 INPUT "Как вас завут "; n$
 a$(u) = n$: c%(u) = h
 OPEN "rekord.dat" FOR OUTPUT AS #1
 FOR i% = 0 TO 9
  WRITE #1, a$(i%), c%(i%)
 NEXT
 CLOSE #1
 ELSE f$ = INPUT$(1)
END IF
m3: CLS
PRINT : PRINT "                     Д о с к а    п о ч ё т а  ! ! !"
FOR i% = 0 TO 9
 IF a$(i% + 1) = "" THEN a$(i% + 1) = "Никто"
 PRINT i% + 1; "Уровень        выиграл       "; a$(i% + 1); "     за      "; c%(i% + 1); "       ходов."
NEXT
CALL MouseReset
f$ = INPUT$(1)
END
na: SCREEN 9: CLS
title "  Автор:   KAS-cor   ", 120, 220
charcir " ****  Мозаика  ****  ", 310, 180, 120, 13
LOCATE 25, 1: PRINT "                      "
f$ = INPUT$(1)
RETURN
pause: CALL MouseHide
GET (305, 220)-(355, 243), m1%
LOCATE 15, 40: PRINT "ПАУЗА"
f$ = INPUT$(1)
PUT (305, 220), m1%, PSET
CALL MouseShow
RETURN

SUB charcir (c$, x0, y0, r, c)
 LOCATE 25, 1
 PRINT c$;
 FOR y% = 0 TO 11
  yr = 3 * y% + r
  FOR x% = 0 TO 319
   IF POINT(x%, 349 - y%) <> 0 THEN
    w = .01964 * x%
    xc = x0 - 1.5 * yr * COS(w)
    yc = y0 - yr * SIN(w)
    LINE (xc, yc)-(xc + 2, yc + 2), c, BF
   END IF
  NEXT x%
 NEXT y%
END SUB

FUNCTION MouseButtons%
 MouseButtons% = a%(2)
END FUNCTION

FUNCTION MouseChoice%
 mx% = MouseX%: my% = MouseY%
 IF (mx% < 220) OR (my% < 76) OR (mx% >= 420) OR (my% >= 166) THEN
  MouseChoice% = 0
 ELSEIF (my% < 106) THEN
  MouseChoice% = 1
 ELSEIF (my% > 136) THEN
  MouseChoice% = 3
 ELSE
  MouseChoice% = 2
 END IF
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

SUB title (t$, x0, y0)
 LOCATE 25, 1
 PRINT t$;
 FOR y% = 0 TO 11
  dx = .6 * y% + x0: dy = 2 * y%
  FOR x% = 0 TO 319
   z = POINT(x%, 349 - y%)
   IF z <> 0 THEN
    xi = dx + 2 * x%
    LINE (xi, y0 - dy)-(xi - 1, y0 + 2 - dy), 11
   END IF
  NEXT x%
 NEXT y%
END SUB

