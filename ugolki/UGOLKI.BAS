DECLARE SUB MouseInit ()
DECLARE SUB MouseReset ()
DECLARE SUB MouseHide ()
DECLARE SUB MouseShow ()
DECLARE FUNCTION MouseX% ()
DECLARE FUNCTION MouseY% ()
DECLARE FUNCTION MouseButtons% ()
DIM SHARED a%(34)
DIM b%(10, 10)
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
SCREEN 12: CLS
a = 639 / 10: b = 479 / 10: t% = 0: h% = 1
FOR y% = 1 TO 9
 FOR x% = 1 TO 9
  IF t% = 0 THEN c%(x%, y%) = 1
  t% = t% + 1: IF t% = 2 THEN t% = 0
 NEXT
 t1% = t1% + 1: IF t1% = 2 THEN t1% = 0
 t% = t1%
NEXT
FOR y% = 0 TO 10
 FOR x% = 0 TO 10
  b%(x%, y%) = 0
 NEXT
NEXT
FOR y% = 0 TO 2
 FOR x% = 0 TO 2
  b%(x% + 1, y% + 6) = 1
  b%(x% + 6, y% + 1) = 2
 NEXT
NEXT
GOSUB pok
CALL MouseInit
CALL MouseShow
LOCATE 1, 1: PRINT "Производство KAS-cor. http:\\www.kas-cor.boom.ru и http:\\www.kas-cor.narod.ru"
DO
 x% = MouseX%
 y% = MouseY%
 k% = MouseButtons%
 IF k% = 1 AND l% = 1 AND x% \ a = a1% AND y% \ b = b1% THEN
  FOR y% = 0 TO 10
   FOR x% = 0 TO 10
    d%(x%, y%) = 0
   NEXT
  NEXT
  CALL MouseHide
  GOSUB pok
  CALL MouseShow
  l% = 0
  DO
   k% = MouseButtons%
  LOOP WHILE k% <> 0
 END IF
 IF k% = 1 AND l% = 1 AND d%(x% \ a, y% \ b) <> 0 THEN
  CALL MouseHide
  b%(x% \ a, y% \ b) = b%(a1%, b1%)
  b%(a1%, b1%) = 0
  h% = h% + 1: IF h% = 3 THEN h% = 1
  GOSUB pok
  CALL MouseShow
  DO
   k% = MouseButtons%
  LOOP WHILE k% <> 0
  l% = 0
 END IF
 IF k% = 1 AND l% = 0 AND b%(x% \ a, y% \ b) = h% THEN
  CALL MouseHide
  CIRCLE ((x% \ a) * a + a / 2, (y% \ b) * b + b / 2), 15, 15
  a1% = x% \ a: b1% = y% \ b
  FOR y% = 0 TO 10
   FOR x% = 0 TO 10
    d%(x%, y%) = 0
   NEXT
  NEXT
  q1% = 0
  IF b%(a1% + 1, b1%) = 0 THEN d%(a1% + 1, b1%) = 1
  IF b%(a1% - 1, b1%) = 0 THEN d%(a1% - 1, b1%) = 1
  IF b%(a1%, b1% + 1) = 0 THEN d%(a1%, b1% + 1) = 1
  IF b%(a1%, b1% - 1) = 0 THEN d%(a1%, b1% - 1) = 1
  IF b%(a1% + 1, b1%) <> 0 AND b%(a1% + 2, b1%) = 0 THEN d%(a1% + 2, b1%) = 2: q1% = 1
  IF b%(a1%, b1% + 1) <> 0 AND b%(a1%, b1% + 2) = 0 THEN d%(a1%, b1% + 2) = 2: q1% = 1
  IF a1% <> 1 THEN
   IF b%(a1% - 1, b1%) <> 0 AND b%(a1% - 2, b1%) = 0 THEN d%(a1% - 2, b1%) = 2: q1% = 1
  END IF
  IF b1% <> 1 THEN
   IF b%(a1%, b1% - 1) <> 0 AND b%(a1%, b1% - 2) = 0 THEN d%(a1%, b1% - 2) = 2: q1% = 1
  END IF
  IF q1% = 1 THEN GOSUB q1
  q% = 0
  FOR y% = 1 TO 8
   FOR x% = 1 TO 8
    IF d%(x%, y%) <> 0 THEN LINE (x% * a + 10, y% * b + 10)-(x% * a + a - 10, y% * b + b - 10), 10: LINE (x% * a + a - 10, y% * b + 10)-(x% * a + 10, y% * b + b - 10), 10: q% = 1
   NEXT
  NEXT
  IF q% = 0 THEN
   GOSUB pok
   LOCATE 29, 29: PRINT "Для этой фишки нет хода.";
   FOR t = 0 TO 100000: NEXT
   GOSUB pok
  END IF
  DO
   k% = MouseButtons%
  LOOP WHILE k% <> 0
  IF q% = 1 THEN l% = 1 ELSE l% = 0
  CALL MouseShow
 END IF
LOOP WHILE INKEY$ <> CHR$(27)
f$ = INPUT$(1)
END
pok:
FOR y% = b TO 479 - b STEP b
 FOR x% = a TO 639 - a STEP a
  LINE (x% + 1, y% + 1)-(x% + a - 1, y% + b - 1), 0, BF
  IF c%(x% \ a, y% \ b) = 1 THEN LINE (x% + 1, y% + 1)-(x% + a - 1, y% + b - 1), 8, BF
  LINE (x%, y%)-(x% + a, y% + b), 15, B
  IF b%(x% \ a, y% \ b) <> 0 THEN
   FOR i% = 0 TO 10
    IF b%(x% \ a, y% \ b) = 1 THEN CIRCLE (x% + (a \ 2), y% + (b \ 2)), i%, 15
    IF b%(x% \ a, y% \ b) = 2 THEN CIRCLE (x% + (a \ 2), y% + (b \ 2)), i%, 7
   NEXT
  END IF
 NEXT
NEXT
d1% = 0: d2% = 0
FOR y% = 0 TO 2
 FOR x% = 0 TO 2
  IF b%(x% + 1, y% + 6) <> 2 THEN d1% = 1
  IF b%(x% + 6, y% + 1) <> 1 THEN d2% = 1
 NEXT
NEXT
IF d1% = 0 OR d2% = 0 THEN GOTO en
LOCATE 29, 1: PRINT STRING$(80, 32);
LOCATE 29, 35: PRINT "Ходят ";
IF h% = 1 THEN PRINT "белые.";
IF h% = 2 THEN PRINT "чёрные.";
RETURN
en:
LOCATE 29, 30
PRINT "Выиграли ";
IF d1% = 0 THEN PRINT "чёрные ";
IF d2% = 0 THEN PRINT "белые ";
PRINT "фишки.";
END
q1:
FOR w% = 0 TO 4
 FOR y% = 1 TO 8
  FOR x% = 1 TO 8
   IF d%(x%, y%) = 2 THEN
    IF b%(x% + 1, y%) <> 0 AND b%(x% + 2, y%) = 0 THEN d%(x% + 2, y%) = 2
    IF b%(x%, y% + 1) <> 0 AND b%(x%, y% + 2) = 0 THEN d%(x%, y% + 2) = 2
    IF x% <> 1 THEN
     IF b%(x% - 1, y%) <> 0 AND b%(x% - 2, y%) = 0 THEN d%(x% - 2, y%) = 2
    END IF
    IF y% <> 1 THEN
     IF b%(x%, y% - 1) <> 0 AND b%(x%, y% - 2) = 0 THEN d%(x%, y% - 2) = 2
    END IF
   END IF
  NEXT
 NEXT
NEXT
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

