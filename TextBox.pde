
 /*
  Poner la longitud de los guiones en la
  longitud del texto.
  ^ No era eso. Tiene que contar la
  longitud de la última línea únicamente.
  Si la longitud es 0, comprueba cuántas
  líneas vacías hay antes de ella.
  Voy a pasar de esto y dejarlo así.
  
  (Tendría que calcular calcLinSel primero
  y a partir de ahí el número de líneas.
  Para hacerlo más ligero debería dejar
  que se fuera calculando automáticamente
  según la entrada. Como digo, como de
  momento quiero probar más cosas, de
  momento no me interesa)
  
  - Máscara, scrollbar. A palo seco.  -No.
  Poner flechitas indicadoras.
  - En CalcLinSel:
  Debería poner una excepción si el
  tamaño de una palabra es mayor que
  lo que ocupe una línea (if Sel), 
  donde se separaría con guion la
  palabra o algo así. No me merece
  la pena pararme por sílabas.
  - Poner el texto por párrafos si !Sel. -No.
  - Pinchar en la posición del texto     -No.
  (si Sel) para introducir allí el cursor.
 */
 
 /*
 
 class TextBox extends RectClickable {
   boolean selected;
   color cBackSelected = 20;
   int tsSel;
   int x1Sel, x2Sel, y1Sel, y2Sel;
   int xOffSetSel = int (0.03*width);
   int nls = 1; // NumLinSelected.
   int i1, i2, i3, i4; // Auxiliares. 
   int nlsA = 1; // NumLinSelected anterior.
   int numGuiones = 0;
   boolean nlsC; // Verdadero si cambian las lineas.
   String [] lin;
   String [] words;
   String [] wordsLastLin;
   String textNoSel; // Auxiliar, si !Sel
   
   TextBox (Keyboard kb, int tx1, int ty1, int tx2, int ty2) {
     x1 = tx1;
     x2 = tx2;
     y1 = ty1;
     y2 = ty2;
     ts = 30;
     tsSel = ts;
     x1Sel = int (0.15*width);
     y1Sel = int (0.15*height);
     x2Sel = int (0.85*width);
     y2Sel = int (0.5*height);
   }
   
   TextBox (Keyboard kb, int tx1, int ty1, int tx2, int ty2, int tts) {
     x1 = tx1;
     x2 = tx2;
     y1 = ty1;
     y2 = ty2;
     ts = tts;
     tsSel = ts;
     x1Sel = int (0.15*width);
     y1Sel = int (0.15*height);
     x2Sel = int (0.85*width);
     y2Sel = int (0.5*height);
   }
   
   void calcLastLin () {
     if (words != null) {
       i2 = 0;
       for (int i = 0; i < i4; i++)
         i2 += words [i].length () +1;
       lin [nls-1] = text.substring (i2);
     }
   }
   
   void calcLinSel () {
     lin = new String [nls];
     for (int i = 0; i < nls; i++) lin [i] = "";
     words = split (text, ' ');
     if (words != null) {
       textSize (tsSel);
       i1 = words.length;
       numGuiones = 0;
       for (int i = 0; i < i1; i++) {
         if (textWidth (words [i]) > x2Sel-x1Sel-2*xOffSetSel) {
           numGuiones ++;
           String word1 = "";
           String [] words1 = new String [i1+1];;
           word1 = TextUntilWidth (tsSel, words [i], int (x2Sel-x1Sel-2*xOffSetSel-textWidth ("-")-3));
           for (int j = 0; j < i; j++) words1[j] = words [j];
           words1 [i] = word1 + "-";
           words1 [i+1] = words [i].substring (words1[i].length (), words [i].length ());
           if (i+2 < i1) for (int j = i+2; j < i1 +1; j++) words1 [j] = words [j-1];
           words = new String [i1+1];
           for (int j = 0; j < i1+1; j++) words [j] = words1 [j];
           i1++;
         }
       }
     }
     i2 = 0;
     i3 = 0;
     i4 = 0;
     if (words != null) {
       for (int i = 0; i < i1; i++) {
         if (i3 < nls-1) {
           i2 += textWidth (words [i]) + textWidth (" ");
           if (i2 >= x2Sel-x1Sel-2*xOffSetSel) {
             for (int j = i4; j < i; j++)
               lin [i3] = lin [i3] + words [j] + " ";
             i3++;
             i2 = 0;
             i4 = i;
             i--;       
           }
         }
       }
     }
   }
   
   void calcNumLinSel () {
     textSize (tsSel);
     nlsA = nls;
     //if (textWidth (lineaDondeEstaElCursor) >= x2Sel-x1Sel-2*xOffSetSel) {
     if (textWidth(text)/(x2Sel-x1Sel-2*xOffSetSel) > 1) {
       nls = int (textWidth (text)/(x2Sel-x1Sel-2*xOffSetSel)) +1;
     } else {
       nls = 1;
     }
     if (nlsA == nls) {
       nlsC = false;
     } else {
       nlsC = true;
     }
   }
   
   public void display () {
     if (!selected) {
       if (!hide) {
         textSize (ts);
         if (textWidth(text) > x2-x1-7) {
           stroke (180);
           fill(cBackground);
           if (pressed ()) {
             fill (cBackPressed);
           } else if (on ()) {
             fill (cBackOn);
           }
           rect (x1, y1, x2-x1, y2-y1);
           if (!text.equals ("")) {
             textAlign (LEFT);
             textSize (ts);
             fill (200);
             if (ts >= 15) {
               text (textNoSel, x1+3, (y1+y2)/2+10+ts/5);
             } else {
               text (textNoSel, x1+3, (y1+y2)/2+ts/3);
             }
           }
         } else {
           drawBasics ();
         }
       }
     } else {
       fill (cBackSelected);
       rect (x1Sel, y1Sel, x2Sel-x1Sel, y2Sel-y1Sel);
       text = kb.GetString ();
       if (text == null) text = "";
       calcNumLinSel ();
       if (nlsC) calcLinSel ();
       calcLastLin ();
       if (!text.equals ("")) {
         textAlign (CENTER);
         textSize (tsSel);
         fill (200);  
         if (nls == 1) {
           if (tsSel >= 15) {
             text (text, (width)/2, (0.5*height)/2+10+ts/5);
           } else { // Sin comprobar.
             text (text, (width)/2, (0.5*height)/2+ts/3);
           }
         } else {
           for (int i = 0; i < nls; i++) {
             if (tsSel >= 15) {
               text (lin [i], (width)/2, (0.5*height)/2+10+ts/5-ts*(nls-1)+i*ts);
             } else { // Sin comprobar.
               text (lin [i], (width)/2, (0.5*height)/2+ts/3+10-ts*(nls-1)+i*ts);
             }
           }
         }
         textAlign (LEFT);
       }
       if (millis ()%1000 < 600) {
         if (nls > 1) {
           line (textWidth(lin [nls-1])/2 + (width)/2 + 5, (0.5*height)/2+10+ts/5 + 3, textWidth(lin [nls-1])/2 + (width)/2 + 5, (0.5*height)/2+10+ts/5 - ts - 3);
         } else {
           line (textWidth (text)/2 + (width)/2 + 5, (0.5*height)/2+10+ts/5 + 3, textWidth(text)/2 + (width)/2 + 5, (0.5*height)/2+10+ts/5 - ts - 3);
         }
       }
     }
   }
   
   public color GetColorBackSelected () {
     return cBackSelected;
   }
   
   public int GetTextSizeSelected () {
     return tsSel;
   }
   
   public boolean isSelected () {
     return selected;
   }
   
   public void released () {
     if (active) {
       if (!selected && x1 < mouseX && mouseX < x2 && y1 < mouseY && mouseY < y2) {
         selected = true;
         kb.SetHide(false);
         kb.SetString (text);
       } else if (selected) {
         if (mouseY < 0.59*height) {
           selected = false;
           kb.SetHide(true);
           textNoSel = TextUntilWidth (ts, text, x2-x1-7);
         }
       }
     }
   }
    
   public void SetColorBackSelected (color c) {
     cBackSelected = c;
   }
    
   public void SetSelected (boolean b) {
     selected = b;
   }
   
   public void SetTextSizeSelected (int ttsS) {
     tsSel = ttsS;
   }
   
   String TextUntilWidth (int tts, String ttext, int tw) {
     String st = "";
     int ii = 0;
     textSize (tts);
     while (ii < ttext.length ()) {
       if (textWidth (st) + textWidth (ttext.charAt (ii)) < tw) {
         st = st + ttext.charAt (ii);
         ii++;
       } else {
         ii = ttext.length ();
       }
     }
     return st;
   }
 }
 */