DECLARE SUB MouseInit ()
DECLARE SUB MouseReset ()
DECLARE SUB MouseHide ()
DECLARE SUB MouseShow ()
DECLARE FUNCTION MouseX% ()
DECLARE FUNCTION MouseY% ()
DECLARE FUNCTION MouseButtons% ()
DIM SHARED a%(34)
DIM B%(10, 40), c%(10, 40), f%(10, 40), d%(10, 40), buf%(1 TO 5000), buf1%(1 TO 4000), buf2%(1 TO 4000), e%(40), rec%(100)
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
t = 0
FOR y = 0 TO 150
 FOR x = 0 TO 63 STEP 2
  PSET (x + t, y), 15
 NEXT
 t = t + 1: IF t = 2 THEN t = 0
NEXT
GET (0, 0)-(63, 150), buf%
FOR i = 20 TO 100 STEP .5
 CIRCLE (30, 70), i, 0
NEXT
GET (10, 50)-(50, 90), buf1%
CLS
FOR y7% = 0 TO 40
 FOR x7% = 0 TO 63
  IF SQR(ABS((30) - x7%) ^ 2 + ABS(40 - y7%) ^ 2) < 20 AND RND(1) * 50 < 25 THEN PSET (x7%, y7%), 8
 NEXT
NEXT
GET (0, 0)-(40, 40), buf2%
CALL MouseInit'          Иницылизацыя мышки
CALL MouseShow
na: CLS
FOR y% = 0 TO 40
 FOR x% = 0 TO 10
  B%(x%, y%) = 0: c%(x%, y%) = 0: d%(x%, y%) = 0: e%(y%) = 0
 NEXT
NEXT
CALL MouseHide
live% = 4
LOCATE 13, 1
PRINT "                              Сыграть в другом доме"
PRINT : PRINT "                                Сделать новый дом"
PRINT : PRINT "                              Исправить  старый дом"
PRINT : PRINT "                                  Удалить  дом"
PRINT : PRINT "                                      Выход"
CALL MouseShow
red1% = 0
DO
 x% = MouseX%
 y% = MouseY%
 k% = MouseButtons%
 t% = y% \ 16 + 1
 IF t% < 13 THEN t% = 13
 IF t% > 21 THEN t% = 21
 LOCATE t%, 28: PRINT CHR$(205); CHR$(205); CHR$(16)
 LOCATE t%, 52: PRINT CHR$(17); CHR$(205); CHR$(205)
 FOR t = 0 TO 300: NEXT
 LOCATE t%, 28: PRINT "   "
 LOCATE t%, 52: PRINT "   "
 IF k% = 1 AND t% = 13 THEN GOSUB zapi: IF a3% <> 1 THEN GOTO ig: IF a3% = 1 THEN GOTO na
 IF k% = 1 AND t% = 15 THEN GOTO red
 IF k% = 1 AND t% = 17 THEN GOSUB zapi: a5% = 1: GOTO red
 IF k% = 1 AND t% = 19 THEN GOSUB del
 IF k% = 1 AND t% = 21 THEN END
 a5% = 0
LOOP WHILE INKEY$ <> CHR$(27)
CALL MouseReset
f$ = INPUT$(1)
END
ig: CLS : ka% = 1: f2% = 0: f3% = 0
RANDOMIZE TIMER
FOR i% = 1 TO bomb%
nz: x% = RND(1) * 9
 y% = RND(1) * (ek% - 2) + 1
 IF d%(x%, y%) <> 0 OR B%(x%, y%) = 2 OR B%(x%, y%) = 1 THEN GOTO nz
 d% = 0
 IF B%(x%, y%) = 3 THEN d% = RND(1) * 6 + 1
 IF B%(x%, y%) = 4 THEN d% = 1
 IF B%(x%, y%) = 5 THEN d% = 1
 IF B%(x%, y%) = 6 THEN d% = 1
 IF B%(x%, y%) = 7 THEN d% = 1
 IF B%(x%, y%) = 8 THEN d% = 1
 IF B%(x%, y%) = 9 THEN d% = 1
 IF B%(x%, y%) = 10 THEN d% = 1
 IF B%(x%, y%) = 11 THEN d% = 1
 IF B%(x%, y%) = 12 THEN d% = RND(1) * 2 + 1
 IF B%(x%, y%) = 13 THEN d% = 1
 IF B%(x%, y%) = 14 THEN d% = 1
 IF B%(x%, y%) = 15 THEN d% = 1
 IF B%(x%, y%) = 16 THEN d% = RND(1) * 2 + 1
 IF B%(x%, y%) = 17 THEN d% = 1
 IF B%(x%, y%) = 18 THEN d% = RND(1) * 3 + 1
 d%(x%, y%) = d%
NEXT
FOR i% = 1 TO 1
nx: x% = RND(1) * 9
 y% = RND(1) * (ek% - 2) + 1
 IF d%(x%, y%) = 0 THEN GOTO nx
 f%(x%, y%) = 1
NEXT
bo1% = 0: b2% = 0
FOR y% = 0 TO ek%
 FOR x% = 0 TO 9
  IF d%(x%, y%) <> 0 AND f%(x%, y%) = 0 THEN b2% = b2% + 1
 NEXT
NEXT
FOR y% = 1 TO ek%
 d% = 0
 FOR x% = 0 TO 9
  IF B%(x%, y%) = 9 THEN d% = 1
 NEXT
 IF d% = 0 THEN e%(y%) = 1
NEXT
IF ek% = 0 THEN ek% = 10
e% = ek% - 2
PRINT "Здравствуйте, зто программа сапёр она поможет вам развлечтся на досуге."
PRINT : PRINT "     В полицию позвонил аноним и сообщил что в жилом здание заложена взрывчатка, из здания вывели всех людей и послали вас на задание обезвредить здание."
PRINT "     Да кстати, терарист позвонил и потребовал выкуп в размере 1000000 долоров, и дал"; min%; ":"; sec%; "на выполнение требованей."
PRINT "     Будте осторожны ваш зашитный костюм выдержит только три взрыва."
f$ = INPUT$(1)
CLS
GOSUB pok
DO
 IF e%(e% + 1) = 1 AND f3% = 0 THEN f3% = 1: CALL MouseHide: PUT (((x4% - 20) \ 2) * 2, ((y4% - 20) \ 2) * 2), buf1%: CALL MouseShow
 IF e%(e% + 1) <> 1 AND f3% = 1 THEN f3% = 0
 IF f2% = 1 AND f3% = 1 AND e%(e% + 1) = 1 THEN CALL MouseHide: PUT (((x4% - 20) \ 2) * 2, ((y4% - 20) \ 2) * 2), buf1%: CALL MouseShow
 x% = MouseX%
 y% = MouseY%
 k% = MouseButtons%
 IF f2% = 1 AND f3% = 1 AND e%(e% + 1) = 1 THEN
  IF x% < 20 THEN x% = 20
  IF x% > 619 THEN x% = 619
 END IF
 x4% = x%: y4% = y%
 IF f2% = 1 AND f3% = 1 AND e%(e% + 1) = 1 THEN CALL MouseHide: PUT (((x4% - 20) \ 2) * 2, ((y4% - 20) \ 2) * 2), buf1%: CALL MouseShow
 IF k% = 3 THEN GOSUB kart
 GOSUB nad: GOSUB tim
 IF k% = 1 AND y% > 150 AND y% < 300 THEN
  CALL MouseHide
  IF f2% = 1 AND f3% = 1 AND e%(e% + 1) = 1 THEN PUT (((x4% - 20) \ 2) * 2, ((y4% - 20) \ 2) * 2), buf1%
  LOCATE 1, 1: PRINT POINT(x%, y%)
  IF d%(x% \ 63.9, e% + 1) <> 0 AND POINT(x%, y%) = 4 THEN a1% = x% \ 63.9: b1% = e% + 1: GOSUB bomb: k% = 0
  CALL MouseShow
 END IF
 IF k% = 1 OR k% = 2 THEN
  IF y% > 150 AND y% < 300 THEN
   f% = B%(x% \ 63.9, e% + 1)
   x1% = (x% \ 63.9) * 63.9 + 5: y1% = (y% \ 150) * 150 + 5
   x2% = (x% \ 63.9) * 63.9 + 63.9: y2% = (y% \ 150) * 150 + 145
   IF f% = 1 THEN GOSUB dou
   IF f% = 2 THEN GOSUB u
   IF f% > 2 THEN
    IF k% = 1 THEN c%(x% \ 63.9, e% + 1) = c%(x% \ 63.9, e% + 1) + 1
    IF k% = 2 THEN c%(x% \ 63.9, e% + 1) = c%(x% \ 63.9, e% + 1) - 1
   END IF
   IF f% > 2 THEN GOSUB pok
  END IF
 END IF
LOOP WHILE INKEY$ <> CHR$(27)
GOTO na
pok: CALL MouseHide
LINE (1, 6)-(638, 145), 0, BF
LINE (1, 156)-(638, 296), 0, BF
LINE (1, 306)-(638, 445), 0, BF
LINE (0, 0)-(639, 450), 15, B
LINE (0, 0)-(639, 5), 15, BF
LINE (0, 146)-(639, 155), 15, BF
LINE (0, 296)-(639, 305), 15, BF
LINE (0, 446)-(639, 450), 15, BF
FOR y% = 0 TO 2
 FOR x% = 0 TO 9
  x1% = 63.9 * x% + 5: y1% = y% * 150 + 5
  x2% = 63.9 * x% + 63.9: y2% = y% * 150 + 145
  IF B%(x%, y% + e%) = 1 THEN 'Лесница вверх
   FOR i% = y1% TO y2% STEP 10
    LINE (x1%, i% - 5)-(x2%, i% + 5), 7, BF
    LINE (x1% + 3, i% - 2)-(x2% - 3, i% + 2), 0, BF
   NEXT
  END IF
  IF B%(x%, y% + e%) = 2 THEN 'Лесница вниз
   FOR i% = y2% TO y1% + 100 STEP -10
    LINE (x1%, i% - 5)-(x2%, i% + 5), 7, BF
    LINE (x1% + 3, i% - 2)-(x2% - 3, i% + 2), 0, BF
   NEXT
  END IF
  IF B%(x%, y% + e%) = 3 THEN 'Шкаф
   IF c%(x%, y% + e%) = 7 THEN c%(x%, y% + e%) = 6
   IF c%(x%, y% + e%) = -1 THEN c%(x%, y% + e%) = 0
   LINE (x1%, y1% + 20)-(x2%, y2%), 8, BF
   LINE (x1%, y1% + 20)-(x2%, y2%), 7, B
   LINE (x1%, y1% + 60)-(x2%, y1% + 60), 7
   LINE (x1%, y2% - 20)-(x2%, y2% - 20), 7
   LINE (x1% + 30, y1% + 20)-(x1% + 30, y2%), 7
   CIRCLE (x1% + 15, y2% - 10), 1, 7
   CIRCLE (x2% - 15, y2% - 10), 1, 7
   CIRCLE (x1% + 26, y1% + 40), 1, 7
   CIRCLE (x2% - 25, y1% + 40), 1, 7
   IF c%(x%, y% + e%) > 0 THEN
    LINE (x1% - 30, y1% + 20)-(x1%, y1% + 59), 7, BF
    LINE (x1% + 1, y1% + 21)-(x1% + 29, y1% + 59), 8, BF
    LINE (x1%, y1% + 40)-(x1% + 30, y1% + 40), 7
   END IF
   IF c%(x%, y% + e%) > 1 THEN
    LINE (x2%, y1% + 20)-(x2% + 30, y1% + 59), 7, BF
    LINE (x1% + 31, y1% + 21)-(x2% - 1, y1% + 59), 8, BF
    LINE (x1% + 30, y1% + 40)-(x2%, y1% + 40), 7
   END IF
   IF c%(x%, y% + e%) > 2 THEN
    LINE (x1% - 30, y1% + 61)-(x1%, y2% - 20), 7, BF
    LINE (x1%, y1% + 80)-(x1% + 30, y1% + 80), 7
    LINE (x1%, y1% + 100)-(x1% + 30, y1% + 100), 7
   END IF
   IF c%(x%, y% + e%) > 3 THEN
    LINE (x2%, y1% + 61)-(x2% + 30, y2% - 20), 7, BF
    LINE (x1% + 30, y1% + 80)-(x2%, y1% + 80), 7
    LINE (x1% + 30, y1% + 100)-(x2%, y1% + 100), 7
   END IF
   IF c%(x%, y% + e%) > 4 THEN
    LINE (x1% - 3, y2% - 11)-(x1% + 27, y2% + 9), 8, BF
    LINE (x1% - 3, y2% - 11)-(x1% + 27, y2% + 9), 7, B
    LINE (x1% - 3, y2% - 11)-(x1%, y2% - 20), 7
    FOR i% = 0 TO 20
     LINE (x1% + 27, y2% - 11 + i%)-(x1% + 30, y2% - 20 + i%), 7
    NEXT
    CIRCLE (x1% + 12, y2%), 1, 7
   END IF
   IF c%(x%, y% + e%) > 5 THEN
    LINE (x2% + 3, y2% - 11)-(x1% + 33, y2% + 9), 8, BF
    LINE (x2% + 3, y2% - 11)-(x1% + 33, y2% + 9), 7, B
    LINE (x2% + 3, y2% - 11)-(x2%, y2% - 20), 7
    FOR i% = 0 TO 20
     LINE (x1% + 33, y2% - 11 + i%)-(x1% + 30, y2% - 20 + i%), 7
    NEXT
    CIRCLE (x2% - 12, y2%), 1, 7
   END IF
   IF d%(x%, y% + e%) = 1 AND c%(x%, y% + e%) > 0 THEN LINE (x1% + 5, y1% + 35)-(x1% + 15, y1% + 39), 4, BF
   IF d%(x%, y% + e%) = 2 AND c%(x%, y% + e%) > 1 THEN LINE (x1% + 35, y1% + 35)-(x1% + 45, y1% + 39), 4, BF
   IF d%(x%, y% + e%) = 3 AND c%(x%, y% + e%) > 2 THEN LINE (x1% + 10, y1% + 95)-(x1% + 20, y1% + 99), 4, BF
   IF d%(x%, y% + e%) = 4 AND c%(x%, y% + e%) > 3 THEN LINE (x1% + 40, y1% + 115)-(x1% + 50, y1% + 119), 4, BF
   IF d%(x%, y% + e%) = 5 AND c%(x%, y% + e%) > 4 THEN LINE (x1% + 12, y2% - 19)-(x1% + 22, y2% - 15), 4, BF
   IF d%(x%, y% + e%) = 6 AND c%(x%, y% + e%) > 5 THEN LINE (x2% - 12, y2% - 19)-(x2% - 22, y2% - 15), 4, BF
  END IF
  IF B%(x%, y% + e%) = 4 THEN 'Тумбочка
   IF c%(x%, y% + e%) = 2 THEN c%(x%, y% + e%) = 1
   IF c%(x%, y% + e%) = -1 THEN c%(x%, y% + e%) = 0
   LINE (x1%, y2% - 40)-(x2%, y2%), 8, BF
   LINE (x1%, y2% - 40)-(x2%, y2%), 7, B
   CIRCLE (x2% - 5, y2% - 20), 1, 7
   IF c%(x%, y% + e%) = 1 THEN
    LINE (x1%, y2% - 40)-(x1% - 63, y2%), 7, BF
    LINE (x1% + 1, y2% - 39)-(x2% - 1, y2% - 1), 8, BF
    LINE (x1%, y2% - 20)-(x2%, y2% - 20), 7
   END IF
   IF d%(x%, y% + e%) = 1 AND c%(x%, y% + e%) > 0 THEN LINE (x1% + 20, y2% - 25)-(x1% + 30, y2% - 21), 4, BF
  END IF
  IF B%(x%, y% + e%) = 5 THEN 'Картина
   IF c%(x%, y% + e%) = 2 THEN c%(x%, y% + e%) = 1
   IF c%(x%, y% + e%) = -1 THEN c%(x%, y% + e%) = 0
   LINE (x1% + 5, y1% + 30)-(x2% - 5, y1% + 70), 8, BF
   LINE (x1% + 5, y1% + 30)-(x2% - 5, y1% + 70), 7, B
   LINE (x1% + 9, y1% + 34)-(x2% - 9, y1% + 66), 9, BF
   LINE (x1% + 9, y1% + 34)-(x2% - 9, y1% + 66), 7, B
   LINE (x1% + 10, y1% + 54)-(x2% - 10, y1% + 65), 1, BF
   CIRCLE (x1% + 29, y1% + 44), 4, 14
   PAINT (x1% + 29, y1% + 44), 14, 14
   IF c%(x%, y% + e%) = 1 THEN
    LINE (x1% + 5, y1% + 30)-(x2% - 5, y1% + 70), 8, BF
    LINE (x1% + 5, y1% + 30)-(x2% - 5, y1% + 70), 7, B
   END IF
   IF d%(x%, y% + e%) = 1 AND c%(x%, y% + e%) > 0 THEN LINE (x1% + 20, y1% + 40)-(x1% + 30, y1% + 45), 4, BF
  END IF
  IF B%(x%, y% + e%) = 6 THEN 'батарея
   LINE (x1%, y1% - 5)-(x1% + 5, y2% - 60), 7, BF
   LINE (x2%, y2% + 5)-(x2% - 5, y2% - 10), 7, BF
   LINE (x1% + 5, y2% - 60)-(x2% - 5, y2% - 55), 7, BF
   LINE (x1% + 2, y2% - 15)-(x2% - 5, y2% - 10), 7, BF
   CIRCLE (x1% + 5, y2% - 60), 5, 7, 3.14, 0
   CIRCLE (x2% - 5, y2% - 10), 5, 7, 0, 3.14
   PAINT (x1% + 4, y2% - 59), 7, 7
   PAINT (x2% - 4, y2% - 11), 7, 7
   FOR i% = x1% + 5 TO x2% - 10 STEP 10
    LINE (i%, y2% - 60)-(i% + 6, y2% - 10), 15, BF
    CIRCLE (i% + 3, y2% - 60), 3, 15
    CIRCLE (i% + 3, y2% - 10), 3, 15
    PAINT (i% + 3, y2% - 61), 15, 15
    PAINT (i% + 3, y2% - 9), 15, 16
   NEXT
   IF d%(x%, y% + e%) = 1 THEN LINE (x1% + 25, y2% - 20)-(x1% + 35, y2% - 24), 4, BF
  END IF
  IF B%(x%, y% + e%) = 7 THEN 'Коробка
   IF c%(x%, y% + e%) = 2 THEN c%(x%, y% + e%) = 1
   IF c%(x%, y% + e%) = -1 THEN c%(x%, y% + e%) = 0
   LINE (x1% + 2, y2% - 50)-(x2% - 2, y2%), 8, BF
   LINE (x1% + 2, y2% - 50)-(x2% - 2, y2%), 7, B
   LINE (x1% + 2, y2% - 50)-(x1% + 25, y2% - 55), 7
   LINE (x2% - 2, y2% - 50)-(x1% + 35, y2% - 55), 7
   IF c%(x%, y% + e%) > 0 THEN
    LINE (x1% + 2, y2% - 55)-(x2% - 2, y2%), 0, BF
    LINE (x1% + 2, y2% - 50)-(x2% - 2, y2%), 8, BF
    LINE (x1% + 2, y2% - 50)-(x2% - 2, y2%), 7, B
    LINE (x1% + 7, y2% - 40)-(x2% - 7, y2% - 3), 7, B
    LINE (x1%, y2% - 51)-(x1% + 2, y2% - 1), 7, BF
    LINE (x2% - 2, y2% - 51)-(x2%, y2% - 1), 7, BF
    LINE (x1% + 2, y2% - 50)-(x1% + 7, y2% - 40), 7
    LINE (x2% - 2, y2%)-(x2% - 7, y2% - 3), 7
    LINE (x2% - 2, y2% - 50)-(x2% - 7, y2% - 40), 7
    LINE (x1% + 7, y2% - 3)-(x1% + 2, y2%), 7
   END IF
   IF d%(x%, y% + e%) = 1 AND c%(x%, y% + e%) > 0 THEN LINE (x1% + 25, y2% - 8)-(x1% + 35, y2% - 4), 4, BF
  END IF
  IF B%(x%, y% + e%) = 8 THEN 'Кровать
   IF c%(x%, y% + e%) = 2 THEN c%(x%, y% + e%) = 1
   IF c%(x%, y% + e%) = -1 THEN c%(x%, y% + e%) = 0
   LINE (x1%, y2% - 50)-(x2%, y2% - 20), 8, BF
   LINE (x1%, y2% - 50)-(x2%, y2% - 20), 7, B
   LINE (x1%, y2% - 45)-(x2%, y2% - 45), 7
   LINE (x1%, y2% - 20)-(x1% + 5, y2%), 8, BF
   LINE (x2% - 5, y2% - 20)-(x2%, y2%), 8, BF
   LINE (x1%, y2% - 20)-(x1% + 5, y2%), 7, B
   LINE (x2% - 5, y2% - 20)-(x2%, y2%), 7, B
   IF c%(x%, y% + e%) > 0 THEN
    LINE (x1%, y2% - 100)-(x2%, y2%), 8, BF
    LINE (x1%, y2% - 100)-(x2%, y2%), 7, B
    LINE (x1%, y2% - 100)-(x2%, y2% - 98), 7, B
    LINE (x1%, y2% - 3)-(x2%, y2%), 7, B
    LINE (x1% + 3, y2% - 98)-(x1%, y2% - 3), 7, B
    LINE (x2% - 3, y2% - 98)-(x2%, y2% - 3), 7, B
    FOR i% = x1% + 3 TO x2% - 3 STEP 2
     LINE (i%, y2% - 98)-(i%, y2% - 3), 7
    NEXT
    FOR i% = y2% - 98 TO y2% - 3 STEP 2
     LINE (x1% + 3, i%)-(x2% - 3, i%), 7
    NEXT
    LINE (x1% + 4, y2% - 97)-(x1% + 8, y2% - 92), 8, BF
    LINE (x2% - 8, y2% - 97)-(x2% - 4, y2% - 92), 8, BF
    LINE (x1% + 4, y2% - 4)-(x1% + 8, y2% - 8), 8, BF
    LINE (x2% - 8, y2% - 4)-(x2% - 4, y2% - 8), 8, BF
   END IF
   IF d%(x%, y% + e%) = 1 AND c%(x%, y% + e%) > 0 THEN LINE (x1% + 25, y2% - 50)-(x1% + 35, y2% - 54), 4, BF
  END IF
  IF B%(x%, y% + e%) = 9 THEN 'Люстра
   IF c%(x%, y% + e%) = 2 THEN c%(x%, y% + e%) = 1
   IF c%(x%, y% + e%) = -1 THEN c%(x%, y% + e%) = 0
   CIRCLE (x1% + 30, y1%), 4, 7, 3.14, 0
   LINE (x1% + 27, y1%)-(x1% + 33, y1%), 7
   PAINT (x1% + 30, y1% + 1), 7, 7
   LINE (x1% + 30, y1%)-(x1% + 30, y1% + 20), 7
   CIRCLE (x1% + 30, y1% + 20), 30, 11, 3.14, 0, .3
   LINE (x1%, y1% + 20)-(x2% + 1, y1% + 20), 11
   PAINT (x1% + 30, y1% + 22), 11, 11
   IF c%(x%, y% + e%) > 0 THEN
    LINE (x1%, y1% + 20)-(x2%, y1% + 30), 0, BF
    CIRCLE (x1% + 30, y1% + 20), 30, 7, , , .4
    LINE (x1% + 30, y1%)-(x1% + 30, y1% + 22), 7
    PAINT (x1% + 20, y1% + 20), 11, 7
    r = 2
    FOR i% = 0 TO 5
     r = r * 2
     CIRCLE (x1% + 30, y1% + 20), r / 7, 7, , , .4
    NEXT
   END IF
   IF d%(x%, y% + e%) = 1 AND c%(x%, y% + e%) > 0 THEN LINE (x1% + 15, y1% + 20)-(x1% + 25, y1% + 24), 4, BF
  END IF
  IF B%(x%, y% + e%) = 10 THEN 'Дверь
   IF c%(x%, y% + e%) = 2 THEN c%(x%, y% + e%) = 1
   IF c%(x%, y% + e%) = -1 THEN c%(x%, y% + e%) = 0
   LINE (x1%, y1% + 10)-(x2%, y2%), 8, BF
   LINE (x1%, y1% + 10)-(x2%, y2%), 7, B
   LINE (x1% + 5, y1% + 15)-(x2% - 5, y2% - 5), 7, B
   LINE (x1%, y1% + 10)-(x1% + 5, y1% + 15), 7
   LINE (x2%, y1% + 10)-(x2% - 5, y1% + 15), 7
   LINE (x1%, y2%)-(x1% + 5, y2% - 5), 7
   LINE (x2%, y2%)-(x2% - 5, y2% - 5), 7
   CIRCLE (x2% - 15, y1% + 80), 2, 7
   IF c%(x%, y% + e%) = 1 THEN
    LINE (x1% - 53, y1% + 15)-(x1% + 5, y2% - 5), 7, BF
    LINE (x1% + 6, y1% + 16)-(x2% - 6, y2% - 6), 8, BF
   END IF
   IF d%(x%, y% + e%) = 1 AND c%(x%, y% + e%) > 0 THEN LINE (x1% + 25, y2% - 10)-(x1% + 35, y2% - 6), 4, BF
  END IF
  IF B%(x%, y% + e%) = 11 THEN 'Стол
   IF c%(x%, y% + e%) = 2 THEN c%(x%, y% + e%) = 1
   IF c%(x%, y% + e%) = -1 THEN c%(x%, y% + e%) = 0
   LINE (x1%, y1% + 80)-(x2%, y1% + 85), 8, BF
   LINE (x1% + 3, y1% + 85)-(x2% - 3, y1% + 95), 15, BF
   LINE (x1% + 5, y1% + 95)-(x1% + 10, y2%), 15, BF
   LINE (x2% - 5, y1% + 95)-(x2% - 10, y2%), 15, BF
   LINE (x1% + 3, y1% + 85)-(x2% - 3, y1% + 95), 7, B
   LINE (x1%, y1% + 80)-(x2%, y1% + 85), 7, B
   LINE (x1% + 5, y1% + 95)-(x1% + 10, y2%), 7, B
   LINE (x2% - 5, y1% + 95)-(x2% - 10, y2%), 7, B
   IF c%(x%, y% + e%) > 0 THEN
    LINE (x1%, y1% + 80)-(x2%, y2%), 0, BF
    LINE (x1%, y2% - 60)-(x2%, y2%), 8, BF
    LINE (x1%, y2% - 60)-(x2%, y2%), 7, B
    LINE (x1% + 5, y2% - 55)-(x2% - 5, y2% - 5), 8, BF
    LINE (x1% + 5, y2% - 55)-(x2% - 5, y2% - 5), 7, BF
    LINE (x1% + 7, y2% - 53)-(x2% - 7, y2% - 7), 8, B
    LINE (x1% + 7, y2% - 53)-(x1% + 12, y2% - 48), 8, BF
    LINE (x2% - 12, y2% - 12)-(x2% - 7, y2% - 7), 8, BF
    LINE (x1% + 7, y2% - 12)-(x1% + 12, y2% - 7), 8, BF
    LINE (x2% - 12, y2% - 53)-(x2% - 7, y2% - 48), 8, BF
   END IF
   IF d%(x%, y% + e%) = 1 AND c%(x%, y% + e%) > 0 THEN LINE (x1% + 25, y2% - 25)-(x1% + 35, y2% - 21), 4, BF
  END IF
  IF B%(x%, y% + e%) = 12 THEN 'Плита
   IF c%(x%, y% + e%) = 3 THEN c%(x%, y% + e%) = 2
   IF c%(x%, y% + e%) = -1 THEN c%(x%, y% + e%) = 0
   LINE (x1%, y2% - 70)-(x2%, y2%), 15, BF
   LINE (x1%, y2% - 70)-(x2%, y2%), 7, B
   LINE (x1%, y2% - 60)-(x2%, y2% - 55), 8, B
   LINE (x1%, y2% - 25)-(x2%, y2% - 20), 8, B
   LINE (x1% + 2, y2% - 54)-(x2% - 2, y2% - 26), 7, BF
   FOR i% = x1% + 10 TO x2% - 5 STEP 10
    CIRCLE (i%, y2% - 65), 3, 7
   NEXT
   IF c%(x%, y% + e%) > 0 THEN
    LINE (x1%, y2% - 25)-(x2%, y2% - 20), 8, BF
    LINE (x1%, y2% - 25)-(x2%, y2% - 20), 7, B
    LINE (x1% + 5, y2% - 54)-(x2% - 5, y2% - 26), 8, BF
    LINE (x1% + 4, y2% - 40)-(x2% - 4, y2% - 42), 7, B
   END IF
   IF c%(x%, y% + e%) > 1 THEN
    LINE (x1% + 1, y2% - 19)-(x2% - 1, y2% - 1), 8, BF
    LINE (x1%, y2% - 4)-(x2%, y2%), 15, BF
    LINE (x1%, y2% - 4)-(x2%, y2%), 7, B
   END IF
   IF d%(x%, y% + e%) = 1 AND c%(x%, y% + e%) > 0 THEN LINE (x1% + 25, y2% - 43)-(x1% + 35, y2% - 48), 4, BF
   IF d%(x%, y% + e%) = 2 AND c%(x%, y% + e%) > 1 THEN LINE (x1% + 15, y2% - 9)-(x1% + 25, y2% - 5), 4, BF
  END IF
  IF B%(x%, y% + e%) = 13 THEN 'Унитаз
   IF c%(x%, y% + e%) = 2 THEN c%(x%, y% + e%) = 1
   IF c%(x%, y% + e%) = -1 THEN c%(x%, y% + e%) = 0
   LINE (x1% + 23, y2%)-(x2% - 23, y2% - 10), 15, BF
   CIRCLE (x1% + 30, y2% - 25), 20, 7, 3.14, 0, 1.4
   LINE (x1% + 14, y2% - 30)-(x2% - 14, y2% - 25), 15, BF
   LINE (x1% + 14, y2% - 30)-(x2% - 14, y2% - 25), 7, B
   PAINT (x1% + 30, y2% - 20), 15, 7
   LINE (x1% + 18, y2% - 50)-(x2% - 18, y2% - 50), 7
   LINE (x1% + 18, y2% - 50)-(x1% + 20, y2% - 30), 7
   LINE (x2% - 18, y2% - 50)-(x2% - 21, y2% - 30), 7
   PAINT (x1% + 20, y2% - 45), 15, 7
   CIRCLE (x1% + 30, y2% - 50), 2, 7, 0, 3.14569
   PAINT (x1% + 30, y2% - 51), 15, 7
   IF c%(x%, y% + e%) > 0 THEN
    LINE (x1% + 18, y2% - 51)-(x2% - 18, y2% - 52), 0, BF
    CIRCLE (x1% + 30, y2% - 55), 12, 7, , , .4
    PAINT (x1% + 30, y2% - 55), 15, 7
   END IF
   IF d%(x%, y% + e%) = 1 AND c%(x%, y% + e%) > 0 THEN LINE (x1% + 25, y2% - 53)-(x1% + 35, y2% - 56), 4, BF
  END IF
  IF B%(x%, y% + e%) = 14 THEN 'Раковина
   IF c%(x%, y% + e%) = 2 THEN c%(x%, y% + e%) = 1
   IF c%(x%, y% + e%) = -1 THEN c%(x%, y% + e%) = 0
   LINE (x1% + 25, y2% - 30)-(x2% - 24, y2%), 8, BF
   LINE (x1% + 25, y2% - 30)-(x2% - 24, y2%), 7, B
   LINE (x1% + 25, y2% - 20)-(x2% - 24, y2% - 20), 7
   CIRCLE (x1% + 30, y2% - 20), 5, 7, 3.14159, 0
   CIRCLE (x1% + 30, y2% - 40), 25, 7, 3.14159, 0, .4
   LINE (x1%, y2% - 45)-(x2%, y2% - 40), 15, BF
   LINE (x1%, y2% - 45)-(x2%, y2% - 40), 7, B
   PAINT (x1% + 30, y2% - 38), 15, 7
   LINE (x1% + 27, y2% - 55)-(x2% - 28, y2% - 45), 8, BF
   LINE (x1% + 27, y2% - 55)-(x2% - 28, y2% - 45), 7, B
   IF c%(x%, y% + e%) > 0 THEN
    LINE (x1% + 25, y2% - 30)-(x2% - 24, y2%), 8, BF
    LINE (x1% + 25, y2% - 30)-(x2% - 24, y2%), 7, B
    LINE (x1% + 25, y2% - 20)-(x2% - 24, y2% - 20), 7
    CIRCLE (x1% + 30, y2% - 6), 5, 7, 3.14159, 0
    LINE (x1% + 25, y2% - 6)-(x2% - 24, y2% - 6), 7
   END IF
   IF d%(x%, y% + e%) = 1 AND c%(x%, y% + e%) > 0 THEN LINE (x1% + 28, y2% - 19)-(x2% - 28, y2% - 12), 4, BF
  END IF
  IF B%(x%, y% + e%) = 15 THEN 'Ванная
   IF c%(x%, y% + e%) = 2 THEN c%(x%, y% + e%) = 1
   IF c%(x%, y% + e%) = -1 THEN c%(x%, y% + e%) = 0
   CIRCLE (x1% + 30, y2% - 40), 40, 7, 3.14159, 0, 1.5
   LINE (x1%, y2% - 45)-(x2%, y2% - 40), 15, BF
   LINE (x1%, y2% - 45)-(x2%, y2% - 40), 7, B
   PAINT (x1% + 30, y2% - 35), 15, 7
   LINE (x1% + 10, y2% - 14)-(x1% + 5, y2%), 7
   LINE (x1% + 13, y2% - 8)-(x1% + 5, y2%), 7
   LINE (x2% - 10, y2% - 14)-(x2% - 5, y2%), 7
   LINE (x2% - 13, y2% - 8)-(x2% - 5, y2%), 7
   PAINT (x1% + 11, y2% - 8), 15, 7
   PAINT (x2% - 11, y2% - 8), 15, 7
   IF c%(x%, y% + e%) > 0 THEN
    LINE (x1%, y2% - 45)-(x2%, y2%), 0, BF
    CIRCLE (x1% + 30, y2% - 30), 30, 7, 3.14159, 0
    CIRCLE (x1% + 30, y1% + 45), 30, 7, 0, 3.14159
    LINE (x1%, y1% + 45)-(x2% + 1, y2% - 30), 15, BF
    LINE (x2% + 1, y1% + 45)-(x2% + 1, y2% - 30), 7
    LINE (x1%, y1% + 45)-(x1%, y2% - 30), 7
    PAINT (x1% + 30, y2% - 25), 15, 7
    PAINT (x1% + 30, y1% + 40), 15, 7
    r = 2: s = 3
    FOR i% = 0 TO 4
     r = r * 2
     CIRCLE (x1% + 30, y2% - 30), r / s, 7, 3.14159, 0
     CIRCLE (x1% + 30, y1% + 45), r / s, 7, 0, 3.14159
     LINE (x2% - (29 - r / s), y1% + 45)-(x2% - (29 - r / s), y2% - 30), 7
     LINE (x1% + (30 - r / s), y1% + 45)-(x1% + (30 - r / s), y2% - 30), 7
    NEXT
    LINE (x1% + 10, y1% + 45)-(x1% + 15, y1% + 50), 8, BF
    LINE (x2% - 10, y1% + 45)-(x2% - 15, y1% + 50), 8, BF
    LINE (x1% + 10, y2% - 30)-(x1% + 15, y2% - 35), 8, BF
    LINE (x2% - 10, y2% - 30)-(x2% - 15, y2% - 35), 8, BF
   END IF
   IF d%(x%, y% + e%) = 1 AND c%(x%, y% + e%) > 0 THEN LINE (x1% + 28, y2% - 50)-(x2% - 38, y2% - 54), 4, BF
  END IF
  IF B%(x%, y% + e%) = 16 THEN 'Холодильник
   IF c%(x%, y% + e%) = 3 THEN c%(x%, y% + e%) = 2
   IF c%(x%, y% + e%) = -1 THEN c%(x%, y% + e%) = 0
   LINE (x1%, y1% + 40)-(x2%, y2%), 15, BF
   LINE (x1%, y1% + 40)-(x2%, y2%), 7, B
   LINE (x1%, y1% + 40)-(x2%, y1% + 45), 7, B
   LINE (x1% + 5, y1% + 55)-(x1% + 7, y1% + 95), 7, BF
   IF c%(x%, y% + e%) > 0 THEN
    LINE (x2% + 63, y1% + 45)-(x2%, y2%), 15, BF
    LINE (x2% + 63, y1% + 45)-(x2%, y2%), 7, B
    LINE (x1% + 1, y1% + 46)-(x2% - 1, y2% - 1), 15, BF
    LINE (x1% + 5, y1% + 45)-(x2% - 5, y1% + 65), 7, B
    LINE (x1%, y1% + 65)-(x2% + 63, y1% + 65), 7
    LINE (x1%, y1% + 85)-(x2% + 63, y1% + 105), 7, B
    LINE (x1%, y1% + 125)-(x2% + 63, y1% + 125), 7
    LINE (x1% + 30, y1% + 125)-(x1% + 30, y2%), 7
    LINE (x2% - 12, y1% + 48)-(x2% - 11, y1% + 55), 7, B
   END IF
   IF c%(x%, y% + e%) > 1 THEN
    LINE (x1% - 45, y1% + 45)-(x1% + 5, y1% + 65), 15, BF
    LINE (x1% - 45, y1% + 45)-(x1% + 5, y1% + 65), 7, B
    LINE (x1% + 5, y1% + 45)-(x2% - 5, y1% + 65), 7, BF
   END IF
   IF d%(x%, y% + e%) = 1 AND c%(x%, y% + e%) > 0 THEN LINE (x1% + 43, y1% + 80)-(x1% + 53, y1% + 84), 4, BF
   IF d%(x%, y% + e%) = 2 AND c%(x%, y% + e%) > 1 THEN LINE (x1% + 10, y1% + 60)-(x1% + 20, y1% + 64), 4, BF
  END IF
  IF B%(x%, y% + e%) = 17 THEN 'Стул
   IF c%(x%, y% + e%) = 2 THEN c%(x%, y% + e%) = 1
   IF c%(x%, y% + e%) = -1 THEN c%(x%, y% + e%) = 0
   LINE (x1%, y1% + 80)-(x1% + 3, y2%), 8, BF
   LINE (x1%, y1% + 80)-(x1% + 3, y2%), 7, B
   LINE (x1% + 30, y1% + 115)-(x1% + 33, y2%), 8, BF
   LINE (x1% + 30, y1% + 115)-(x1% + 33, y2%), 7, B
   LINE (x1% + 3, y1% + 105)-(x1% + 33, y1% + 115), 2, BF
   LINE (x1% + 3, y1% + 105)-(x1% + 33, y1% + 115), 7, B
   LINE (x1% + 3, y1% + 80)-(x1% + 6, y1% + 95), 8, BF
   LINE (x1% + 3, y1% + 80)-(x1% + 6, y1% + 95), 7, B
   IF c%(x%, y% + e%) > 0 THEN
    LINE (x1%, y1% + 80)-(x2%, y2%), 0, BF
    LINE (x1%, y2% - 35)-(x1% + 35, y2%), 8, BF
    LINE (x1%, y2% - 35)-(x1% + 35, y2%), 7, B
    LINE (x1%, y2% - 35)-(x1% + 4, y2% - 31), 7, BF
    LINE (x1% + 35, y2%)-(x1% + 31, y2% - 4), 7, BF
    LINE (x1% + 35, y2% - 35)-(x1% + 31, y2% - 31), 7, BF
    LINE (x1%, y2%)-(x1% + 4, y2% - 4), 7, BF
   END IF
   IF d%(x%, y% + e%) = 1 AND c%(x%, y% + e%) > 0 THEN LINE (x1% + 15, y2% - 15)-(x1% + 19, y2% - 17), 4, BF
  END IF
  IF B%(x%, y% + e%) = 18 THEN 'Заркало
   IF c%(x%, y% + e%) = 4 THEN c%(x%, y% + e%) = 3
   IF c%(x%, y% + e%) = -1 THEN c%(x%, y% + e%) = 0
   LINE (x1%, y2% - 40)-(x2%, y2% - 5), 8, BF
   LINE (x1%, y2% - 40)-(x2%, y2% - 5), 7, B
   LINE (x1%, y2% - 40)-(x1% + 30, y2% - 20), 7, B
   LINE (x1%, y2% - 40)-(x1% + 30, y2% - 5), 7, B
   CIRCLE (x1% + 15, y2% - 30), 1, 7
   CIRCLE (x1% + 15, y2% - 12), 1, 7
   CIRCLE (x1% + 35, y2% - 25), 1, 7
   LINE (x1% + 10, y2% - 40)-(x2% - 8, y2% - 100), 8, BF
   LINE (x1% + 10, y2% - 40)-(x2% - 8, y2% - 100), 7, B
   CIRCLE (x1% + 30, y2% - 70), 23, 7, , , 1.4
   PAINT (x1% + 30, y2% - 70), 0, 7
   LINE (x1% + 25, y2% - 85)-(x1% + 21, y2% - 80), 7
   LINE (x1% + 30, y2% - 85)-(x1% + 23, y2% - 75), 7
   LINE (x1% + 5, y2% - 5)-(x1% + 10, y2%), 7
   LINE (x1% + 15, y2% - 5)-(x1% + 10, y2%), 7
   LINE (x2% - 5, y2% - 5)-(x2% - 10, y2%), 7
   LINE (x2% - 15, y2% - 5)-(x2% - 10, y2%), 7
   PAINT (x1% + 10, y2% - 3), 8, 7
   PAINT (x2% - 10, y2% - 3), 8, 7
   IF c%(x%, y% + e%) > 0 THEN
    LINE (x2% + 30, y2% - 40)-(x2%, y2% - 5), 7, BF
    LINE (x1% + 31, y2% - 39)-(x2% - 1, y2% - 6), 8, BF
    LINE (x1% + 30, y2% - 20)-(x2%, y2% - 20), 7
   END IF
   IF c%(x%, y% + e%) > 1 THEN
    LINE (x1% - 3, y2% - 13)-(x1% + 27, y2% + 5), 8, BF
    LINE (x1% - 3, y2% - 13)-(x1% + 27, y2% + 5), 7, B
    LINE (x1% - 3, y2% - 13)-(x1%, y2% - 20), 7
    FOR i% = 0 TO 17
     LINE (x1% + 27, y2% - 13 + i%)-(x1% + 30, y2% - 20 + i%), 7
    NEXT
    CIRCLE (x1% + 12, y2% - 3), 1, 7
   END IF
   IF c%(x%, y% + e%) > 2 THEN
    LINE (x1% - 3, y2% - 31)-(x1% + 27, y2% - 11), 8, BF
    LINE (x1% - 3, y2% - 31)-(x1% + 27, y2% - 11), 7, B
    LINE (x1% - 3, y2% - 31)-(x1%, y2% - 40), 7
    FOR i% = 0 TO 19
     LINE (x1% + 27, y2% - 31 + i%)-(x1% + 30, y2% - 40 + i%), 7
    NEXT
    CIRCLE (x1% + 12, y2% - 20), 1, 7
   END IF
   IF d%(x%, y% + e%) = 1 AND c%(x%, y% + e%) > 0 THEN LINE (x1% + 43, y2% - 25)-(x1% + 53, y2% - 21), 4, BF
   IF d%(x%, y% + e%) = 2 AND c%(x%, y% + e%) = 2 THEN LINE (x1% + 5, y2% - 19)-(x1% + 15, y2% - 15), 4, BF
   IF d%(x%, y% + e%) = 3 AND c%(x%, y% + e%) > 2 THEN LINE (x1% + 5, y2% - 39)-(x1% + 15, y2% - 35), 4, BF
  END IF
  IF B%(x%, y% + e%) = 19 THEN
   PUT (x1%, y2% - 40), buf2%
  END IF
  IF x% > 5 THEN t5% = 1 ELSE t5% = 0
  IF e%(y% + e%) = 1 THEN PUT (x1% - 5 + t5%, y1% - 5), buf%
  'IF d%(x%, y% + e%) <> 0 THEN CIRCLE (x1%, y1%), 2, 2
 NEXT
NEXT
FOR y% = 0 TO 144 STEP 2
 FOR x% = 0 TO 639 STEP 2
  PSET (x%, y%), 8
  PSET (x%, y% + 306), 8
 NEXT
NEXT
IF f2% = 1 AND f3% = 1 AND e%(e% + 1) = 1 THEN PUT (((x4% - 20) \ 2) * 2, ((y4% - 20) \ 2) * 2), buf1%
CALL MouseShow
IF bo1% = b2% AND red1% = 0 THEN GOTO vig
RETURN
dou: e% = e% - 1
IF e% < 0 THEN e% = 0: RETURN
GOSUB pok
RETURN
u: e% = e% + 1
IF e% > ek% - 2 THEN e% = ek% - 2: RETURN
GOSUB pok
RETURN
nad:
IF y% > 150 AND y% < 300 THEN f% = B%(x% \ 63.9, e% + 1)
LOCATE 30, 1
IF red1% = 0 THEN
 IF y% < 150 AND y% > 0 THEN o% = 1
 IF y% > 300 AND y% < 479 THEN o% = 1
 IF o% = 1 THEN
  GOSUB tim
  a1$ = STRING$(20, " ") + "Обезврежено" + STR$((bo1% / b2%) * 100) + "% всех бомб, осталось обезвредить" + STR$(100 - ((bo1% / b2%) * 100)) + "%. Для того что бы посмотреть карту нажмите две клавиши мышы. Производство KAS-cor. http:\\www.kas-cor.boom.ru и http:\\www.kas-cor.narod.ru"
  DO
   LOCATE 28, 25: PRINT " До взрыва осталось"; min%; "мин."; sec%; "сек. "
   LOCATE 30, 1: PRINT MID$(a1$, 1, 79);
   g% = g% + 1
   GOSUB tim
   IF g% = 100 THEN
    a1$ = MID$(a1$, 2) + MID$(a1$, 1, 1): g% = 0
   END IF
   y% = MouseY%
   IF y% > 150 AND y% < 300 THEN d% = 1 ELSE d% = 0
  LOOP WHILE d% <> 1
  f% = 0: o% = 0
  GOSUB pok
 END IF
END IF
IF f% = 1 THEN PRINT "Лестница наверх                                                                ";
IF f% = 2 THEN PRINT "Лестница вниз                                                                  ";
IF f% = 3 THEN PRINT "Шкаф                                                                           ";
IF f% = 4 THEN PRINT "Тумбочка                                                                       ";
IF f% = 5 THEN PRINT "Картина                                                                        ";
IF f% = 6 THEN PRINT "Батарея                                                                        ";
IF f% = 7 THEN PRINT "Коробка                                                                        ";
IF f% = 8 THEN PRINT "Кровать                                                                        ";
IF f% = 9 THEN PRINT "Люстра                                                                         ";
IF f% = 10 THEN PRINT "Дверь                                                                          ";
IF f% = 11 THEN PRINT "Стол                                                                           ";
IF f% = 12 THEN PRINT "Плита                                                                          ";
IF f% = 13 THEN PRINT "Унитаз                                                                         ";
IF f% = 14 THEN PRINT "Раковина                                                                       ";
IF f% = 15 THEN PRINT "Ванная                                                                         ";
IF f% = 16 THEN PRINT "Холодильник                                                                    ";
IF f% = 17 THEN PRINT "Стул                                                                           ";
IF f% = 18 THEN PRINT "Зеркало                                                                        ";
IF f% = 19 THEN PRINT "Кучка пепла от взорвоного предмета интерьера                                   ";
RETURN
kart: CLS
CALL MouseHide
IF e% < 0 THEN e% = 0
IF e% > ek% - 2 THEN e% = ek% - 2
t% = 0
FOR i% = 0 TO 460 STEP 470 / ek%
 IF e% = t% THEN
  LINE (200, i%)-(450, i% + (479 / ek%)), 15, BF
  LOCATE 15, 1: PRINT "Вы здесь": LOCATE (i% + (479 / ek%)) / 16, 58: PRINT ek% - e%; "Этаж";
  LINE (64, 233)-(200, i% + (479 / ek%) / 2), 10
 END IF
 t% = t% + 1
 LINE (200, i%)-(450, i% + (479 / ek%)), 8, B
NEXT
CALL MouseShow
IF ka% = 1 THEN f$ = INPUT$(1): GOTO w3
w2: IF MouseButtons% = 1 AND MouseY% > (e% * (470 / ek%)) + (479 / ek%) / 2 THEN CLS : e% = e% + 1: GOTO kart
IF MouseButtons% = 1 AND MouseY% < (e% * (470 / ek%)) + (479 / ek%) / 2 THEN CLS : e% = e% - 1: GOTO kart
IF MouseButtons% <> 2 THEN GOTO w2
w3: CLS
GOSUB pok
RETURN
red: CLS
RANDOMIZE TIMER
e% = 1: red1% = 1
e1:
IF a5% = 0 THEN
 INPUT "Сколько этажей (3-40)"; ek%
 IF ek% > 40 OR ek% < 3 THEN GOTO e1
END IF
e2: PRINT "Сколько бомб спрятоть (1-"; (ek% - 2) * 10; ")";
 INPUT bomb%
 IF bomb% < 1 OR bomb% > (ek% - 2) * 10 THEN GOTO e2
e3: INPUT "Сколько отведёте времени (минуты,секунды)"; min%, sec%
 IF min% < 0 OR min% > 59 OR sec% < 0 OR sec% > 59 THEN GOTO e3
 INPUT "Вы уверены что всё правельно ввели (д,н)"; w$
 IF w$ = "н" OR w$ = "n" OR w$ = "N" OR w$ = "Н" THEN GOTO e2
IF ek% = 0 THEN ek% = 10
IF a5% = 0 THEN
 FOR i% = 0 TO ek% * 9
  B%(RND(1) * 9, RND(1) * (ek% - 1)) = RND(1) * 18
 NEXT
END IF
GOSUB pok
DO
 x% = MouseX%'           Координат Х
 y% = MouseY%'           Координат Y
 k% = MouseButtons%'     Покозатели кнопок 1-левая, 2-правая, 3-нажаты две
 IF k% = 1 AND y% > 0 AND y% < 150 THEN GOSUB dou
 IF k% = 1 AND y% > 300 AND y% < 479 THEN GOSUB u
 IF k% = 3 THEN GOSUB kart
 GOSUB nad
 IF y% > 150 AND y% < 300 THEN
  IF k% = 1 OR k% = 2 THEN
   a1% = x% \ 63.9
   IF k% = 1 THEN B%(a1%, e% + 1) = B%(a1%, e% + 1) + 1
   IF k% = 2 THEN B%(a1%, e% + 1) = B%(a1%, e% + 1) - 1
   IF B%(a1%, e% + 1) > 18 THEN B%(a1%, e% + 1) = 0
   IF B%(a1%, e% + 1) < 0 THEN B%(a1%, e% + 1) = 18
   GOSUB pok
  END IF
 END IF
LOOP WHILE INKEY$ <> CHR$(27)
CLS
LOCATE 15, 30: INPUT "Запомнить (д/н)"; a$
IF a$ = "d" OR a$ = "д" OR a$ = "l" OR a$ = "в" THEN GOSUB zap
red1% = 0
GOTO na
zap: IF a5% = 0 THEN LOCATE 17, 30: INPUT "Как назвать "; n$
OPEN n$ + ".dat" FOR OUTPUT AS #1
WRITE #1, ek%, bomb%, min%, sec%
FOR y% = 0 TO ek%
 FOR x% = 0 TO 9
  WRITE #1, B%(x%, y%)
 NEXT
NEXT
CLOSE #1
RETURN
zapi: CLS
FILES "*.dat"
n$ = "": a3% = 0
LOCATE 15, 30: INPUT "Как называется "; n$
IF n$ = "" THEN a3% = 1: RETURN
OPEN n$ + ".dat" FOR INPUT AS #1
INPUT #1, ek%, bomb%, min%, sec%
FOR y% = 0 TO ek%
 FOR x% = 0 TO 9
  INPUT #1, B%(x%, y%)
 NEXT
NEXT
CLOSE #1
RETURN
bomb: CLS
IF f%(x% \ 63.9, e% + 1) = 1 THEN
 LOCATE 15, 35: PRINT "Вы нашли фонарь.": f2% = 1
 PRINT "       Теперь вы без друда найдёте бомбы в мало освещённых комнатах"
 d%(a1%, b1%) = 0: f%(a1%, b1%) = 0
 f$ = INPUT$(1)
 GOSUB pok
 RETURN
END IF
RANDOMIZE TIMER
LINE (239, 189)-(399, 229), 15, BF
LINE (239, 249)-(399, 309), 14, BF
LINE (249, 259)-(389, 299), 4, BF
FOR i% = 249 TO 389 STEP 46
 LINE (i%, 230)-(i%, 248), RND(1) * 15 + 1
 LINE (i% + 1, 230)-(i% + 1, 248), RND(1) * 15 + 1
NEXT
CALL MouseShow
d$ = "0000"
FOR i% = 1 TO 4
za: r% = RND(1) * 4 + 1
 IF MID$(d$, r%, 1) <> "0" THEN GOTO za
 MID$(d$, r%, 1) = MID$(STR$(i%), 2)
NEXT
t2% = 0: st% = 6000
GOSUB tim
min1% = min%: sec1% = sec%
DO
 x% = MouseX%
 y% = MouseY%
 k% = MouseButtons%
 GOSUB tim2
 LOCATE 18, 37: PRINT min1%; ":"; sec1%
 IF min% < 1 AND sec% < 1 THEN GOSUB bum: EXIT DO
 IF k% = 1 AND x% > 244 AND x% < 391 AND y% > 231 AND y% < 245 THEN
  p% = VAL(MID$(d$, x% \ 46 - 4, 1))
  IF p% = 0 THEN GOTO q2
  CALL MouseHide
  LINE ((x% \ 46) * 46 + 6, 235)-((x% \ 46) * 46 + 40, 243), 0, BF
  CALL MouseShow
  IF p% = 1 THEN st% = st% \ 4: t2% = 0
  IF p% = 2 THEN st% = st% * 2: t2% = 0
  IF p% = 3 THEN d%(a1%, b1%) = 0: LOCATE 18, 1: bo1% = bo1% + 1: PRINT "                          Молодец, ты обезвредил эту бомбу": EXIT DO
  IF p% = 4 THEN GOSUB bum: EXIT DO
  MID$(d$, x% \ 46 - 4, 1) = "0"
q2:
 END IF
LOOP WHILE INKEY$ <> CHR$(27)
IF p% = 4 THEN
 d% = 0
 IF B%(a1%, b1%) <> 10 THEN B%(a1%, b1%) = 19
 FOR i% = 0 TO 9
  IF B%(i%, b1%) = 9 THEN d% = 1
 NEXT
 IF d% = 0 THEN e%(b1%) = 1
END IF
GOSUB pok
RETURN
tim:
IF INT(TIMER) <> ti THEN sec% = sec% - 1
IF sec% = -1 THEN sec% = 59: min% = min% - 1
IF min% < 1 AND sec% < 1 AND a5% = 0 THEN GOTO bum2
ti = INT(TIMER)
RETURN
tim2:
t2% = t2% + 1
IF t2% = st% THEN sec1% = sec1% - 1: t2% = 0
IF sec1% = -1 THEN sec1% = 59: min1% = min1% - 1
RETURN
bum:
FOR i% = 0 TO 639 STEP 3
 CIRCLE (319, 239), i%, RND(1) * 15
 FOR t = 0 TO 1000: NEXT
NEXT
live% = live% - 1
CLS
IF live% > 0 THEN LOCATE 18, 35: PRINT "У вас осталось"; live%; "жизни.": d%(a1%, b1%) = 0: bo1% = bo1% + 1: f$ = INPUT$(1): CLS : RETURN
LOCATE 5, 1: PRINT "Очень жаль, но ты невыполнел данного тебе задания и погиб в результате терарестического акта."
PRINT "Осталось обезвредить"; b2% - bo1%; "бом."
f$ = INPUT$(1)
END
bum2: CLS
CALL MouseHide
x1% = 200 / ek%
n1% = 319 - (x1% * 10) / 2
n2% = 319 + (x1% * 10) / 2
FOR i% = 0 TO 460 STEP 470 / ek%
 LINE (n1%, i%)-(n2%, i% + (470 / ek%)), 15, B
NEXT
FOR r% = 0 TO 470 / ek% / 2
 LOCATE 5, 1: PRINT "Взрывы на:"
 FOR x% = 0 TO 9
  FOR y% = 0 TO ek%
   IF d%(x%, y%) <> 0 THEN CIRCLE (n1% + (x1% * x%), y% * (470 / ek%) + (470 / ek%) / 2), r%, RND(1) * 15 + 1: PRINT ek% - y%
  NEXT
 NEXT
 PRINT "Этажах"
 FOR t = 0 TO 1000: NEXT
NEXT
CALL MouseShow
f$ = INPUT$(1)
CLS :
PRINT "У вас осталось"; live%; " жиз."
PRINT "Осталось обезвредить"; b2% - bo1%; " бом."
f$ = INPUT$(1)
GOTO na
vig: CLS
LOCATE 14, 35: PRINT "Вы обезвредели"; bo1%; "вомб."
LOCATE 15, 35: PRINT "Вы выиграли с"; live%; " Жиз."
f$ = INPUT$(1)
END
del:
LOCATE 1, 1
FILES "doma\*.dat"
n$ = ""
INPUT "Как называется "; n$
IF n$ = "" THEN RETURN
KILL "doma\" + n$ + ".dat"
PRINT n$; " Удалил."
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

