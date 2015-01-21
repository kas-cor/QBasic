DECLARE SUB MouseInit ()
DECLARE SUB MouseReset ()
DECLARE SUB MouseHide ()
DECLARE SUB MouseShow ()
DECLARE FUNCTION MouseX% ()
DECLARE FUNCTION MouseY% ()
DECLARE FUNCTION MouseButtons% ()
DIM SHARED a%(34), x%(0 TO 1000), y%(0 TO 1000), l%(0 TO 2000), t%(0 TO 1000)
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
PRINT "  1 . Сделать мультик"
PRINT "  2 . Посмотреть мультик"
INPUT c%
IF c% = 2 THEN GOTO pro2
PRINT "   ИНСТРУКЦИЯ:"
PRINT "   Для того чтобы поставить узел надо: направить курсор на нужное место и нажать на две кнопки одновременно(или на среднию)."
PRINT "   Для того чтобы подвинуть узел надо: направить курсор на любой узел и не отпуская левой клавиши мыши передвигайть узел."
PRINT "   Для того чтобы протянуть линию между узлами надо: направить курсор на лыбой узел и не отпуская правою клавишу мыши направить курсор на другой любой узел после отпустить клавишу мыши."
PRINT "   Для того чтобы удолить линию между узлами надо: нажать на клавиотуре клавишу Delete при этом в верхнем левом углу экрана появится натпись'УДАЛЕНИЕ ЛИНИИ'";
PRINT "после этого направте курсор на лыбой узел и не отпуская правою клавишу мыши направить курсор на другой любой узел после отпустить клавишу мыши при этом линия и натпись удалятся."
PRINT "   Для удобства перетаскивания узлов их можно увеличивать(клавиша'+')или уменьшать(клавиша'-')."
PRINT "   Для того чтобы подвинуть сразу несколько узлов надо: нажать на клавиотуре клавишу'd'при этом в верхнем левом углу экрана появится натпись'ВЫДЕЛЕНИЕ ГРУППЫ'после направте курсор на нужное место и нажамите на левую клавишу мыши, и удерживая её отпустите в другом месте(при этом курсор должен двигатся на право вниз)при этом узлы выделяются кружками";
PRINT "большего размера, после того как узлы отметятся направте курсор на один из выделиных узлов и не отпуская левой клавиши мыши отпустить её в другом месте при этом все отмечение узлы последуют за ним."
PRINT "   Для того чтобы записать кадр надо: нажать клавишу'S'при этом в верхнем левом углу экрана появится звёздочка(это значит что кадр записался)после нажмите любую клавишу для возврата в режим редактирования."
PRINT "   ВНИМАНИЕ !  Узлы не записываются в мультик т.к.они не являются частью рисунка а используются для перетаскивания линий."
PRINT "Производство KAS-cor. http:\\www.kas-cor.boom.ru и http:\\www.kas-cor.narod.ru";
f$ = INPUT$(1)
CLS
ON ERROR GOTO e1
FILES "*.mul"
e1:
INPUT "Напишите название мультика"; n$
CLS
OPEN n$ + ".mul" FOR OUTPUT AS #1
CALL MouseInit'          Иницылизацыя мышки
CALL MouseShow'          Показать курсор
e% = 5: d% = 0
DO
m2: x% = MouseX%
 y% = MouseY%
 k% = MouseButtons%
 i$ = INKEY$
 IF i$ <> "" THEN
  IF i$ = "-" THEN e% = e% - 1
  IF i$ = "+" THEN e% = e% + 1
  IF e% = 0 THEN e% = 1
  IF e% = 21 THEN e% = 20
  IF i$ = "s" OR i$ = "S" THEN GOSUB sav
  IF i$ = "d" AND d% = 0 THEN d% = 1: i$ = ""
  IF i$ = "d" AND d% = 1 THEN d% = 0: i$ = ""
  IF i$ = CHR$(0) + "S" AND de% = 0 THEN de% = 1: i$ = ""
  IF i$ = CHR$(0) + "S" AND de% = 1 THEN de% = 0: i$ = ""
  GOSUB pok
 END IF
 IF k% = 1 AND d% = 1 THEN
  a% = x%: b% = y%
  DO
   k% = MouseButtons%
  LOOP WHILE k% = 1
  FOR i% = 0 TO w%: t%(i%) = 0: NEXT
  y% = MouseY%
  x% = MouseX%
  FOR y1% = b% TO y%
   FOR x1% = a% TO x%
    FOR i% = 0 TO w%
     IF x1% = x%(i%) AND y1% = y%(i%) THEN t%(i%) = 1: CIRCLE (x%(i%), y%(i%)), e% + 2, 15
    NEXT
   NEXT
  NEXT
m4: y% = MouseY%
  x% = MouseX%
  t% = -1
  FOR i% = 0 TO w%
   IF x% > x%(i%) - e% AND x% < x%(i%) + e% AND y% > y%(i%) - e% AND y% < y%(i%) + e% THEN t% = i%
  NEXT
  IF t% = -1 OR MouseButtons% <> 1 THEN GOTO m4
  IF t%(t%) = 0 THEN GOTO m4
  DO
   k% = MouseButtons%
  LOOP WHILE k% = 1
  y% = MouseY%
  x% = MouseX%
  x1% = x%(t%) - x%: y1% = y%(t%) - y%
  FOR i% = 0 TO w%
   IF t%(i%) = 1 THEN x%(i%) = x%(i%) - x1%: y%(i%) = y%(i%) - y1%
  NEXT
  d% = 0
  GOSUB pok
 END IF
m3:
 IF k% = 1 THEN
  t% = -1
  FOR i% = 0 TO w%
   IF x% > x%(i%) - e% AND x% < x%(i%) + e% AND y% > y%(i%) - e% AND y% < y%(i%) + e% THEN t% = i%
  NEXT
  IF t% = -1 THEN GOTO m2
  x%(t%) = MouseX%: y%(t%) = MouseY%
  DO
   k% = MouseButtons%
  LOOP WHILE k% <> 1
  GOSUB pok
 END IF
 IF k% = 2 AND de% = 0 THEN
  t% = -1
  FOR i% = 0 TO w%
   IF x% > x%(i%) - e% AND x% < x%(i%) + e% AND y% > y%(i%) - e% AND y% < y%(i%) + e% THEN t% = i%
  NEXT
  IF t% = -1 THEN GOTO m2
  l%(max%) = t%: max% = max% + 1
  DO
   k% = MouseButtons%
  LOOP WHILE k% <> 0
  x% = MouseX%
  y% = MouseY%
  t% = -1
  FOR i% = 0 TO w%
   IF x% > x%(i%) - e% AND x% < x%(i%) + e% AND y% > y%(i%) - e% AND y% < y%(i%) + e% THEN t% = i%
  NEXT
  IF t% = -1 THEN max% = max% - 1: GOTO m2
  l%(max%) = t%: max% = max% + 1
  GOSUB pok
 END IF
 IF k% = 2 AND de% = 1 THEN
  t% = -1
  FOR i% = 0 TO w%
   IF x% > x%(i%) - e% AND x% < x%(i%) + e% AND y% > y%(i%) - e% AND y% < y%(i%) + e% THEN t% = i%
  NEXT
  IF t% = -1 THEN GOTO m2
  t1% = t%
  DO
   k% = MouseButtons%
  LOOP WHILE k% <> 0
  x% = MouseX%
  y% = MouseY%
  t% = -1
  FOR i% = 0 TO w%
   IF x% > x%(i%) - e% AND x% < x%(i%) + e% AND y% > y%(i%) - e% AND y% < y%(i%) + e% THEN t% = i%
  NEXT
  IF t% = -1 THEN GOTO m2
  t2% = t%
  FOR i% = 0 TO max% STEP 2
   IF l%(i%) = t1% AND l%(i% + 1) = t2% THEN l%(i%) = 0: l%(i% + 1) = 0
   IF l%(i%) = t2% AND l%(i% + 1) = t1% THEN l%(i%) = 0: l%(i% + 1) = 0
  NEXT
  de% = 0
  GOSUB pok
 END IF
 IF k% = 3 THEN
  w% = w% + 1
  x%(w%) = x%: y%(w%) = y%
  DO
   k% = MouseButtons%
  LOOP WHILE k% <> 0
  GOSUB pok
 END IF
LOOP WHILE INKEY$ <> CHR$(27)
WRITE #1, -500, -500, -500, z%
WRITE #1, -500, -500, -500, z%
CLOSE #1
END
pok: CALL MouseHide: CLS
FOR i% = 0 TO w%
 CIRCLE (x%(i%), y%(i%)), e%, 15
NEXT
FOR i% = 0 TO max% STEP 2
 LINE (x%(l%(i%)), y%(l%(i%)))-(x%(l%(i% + 1)), y%(l%(i% + 1))), 15
NEXT
IF d% = 1 THEN PRINT "Выделение группы"
IF de% = 1 THEN PRINT "Удаление линии"
CALL MouseShow
RETURN
sav: LOCATE 1, 1: PRINT CHR$(15): z% = z% + 1
FOR i% = 0 TO max% STEP 2
 WRITE #1, x%(l%(i%)), y%(l%(i%)), x%(l%(i% + 1)), y%(l%(i% + 1))
NEXT
WRITE #1, -1000, -1000, -1000, z%
f$ = INPUT$(1)
LOCATE 1, 1: PRINT z%; "Кадр."
RETURN
pro2: CLS : FILES "*.mul"
INPUT "Какой мультик"; n$
pro: CLS
OPEN n$ + ".mul" FOR INPUT AS #1
na1: INPUT #1, a%, b%, x%, y%
IF a% = -500 AND b% = -500 AND x% = -500 THEN GOTO pro1
IF a% = -1000 AND b% = -1000 AND x% = -1000 THEN PRINT y%; "Кадр. Для выхода нажмите Ctrl+Break": f$ = INPUT$(1): CLS : INPUT #1, a%, b%, x%, y%
LINE (a%, b%)-(x%, y%), 15
GOTO na1
pro1: CLOSE #1
GOTO pro

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

