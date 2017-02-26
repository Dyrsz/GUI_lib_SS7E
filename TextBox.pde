
 // Ponerle a cada una de estas una máscara
 // negra hasta la derecha.
 
 // Si el texto no cabe cuando no está
 // seleccionado, cambiar la alineación
 // del texto a la izquierda.

 class TextBox extends RectClickable {
   boolean selected;
   color cBackSelected = 20;
   int tsSel;
   int xOffSet = int (0.03*width);
   int nls = 1; // NumLinSelected.
   String [] lin;
   String [] words;
   String ttext; // Variable auxiliar. 
   
   TextBox (Keyboard kb, int tx1, int ty1, int tx2, int ty2) {
     x1 = tx1;
     x2 = tx2;
     y1 = ty1;
     y2 = ty2;
     ts = 30;
     tsSel = ts;
   }
   
   TextBox (Keyboard kb, int tx1, int ty1, int tx2, int ty2, int tts) {
     x1 = tx1;
     x2 = tx2;
     y1 = ty1;
     y2 = ty2;
     ts = tts;
     tsSel = ts;
   }
   
   void calcLinSel () {
     lin = new String [nls];
     
   }
   
   void calcNumLinSel () {
     if (textWidth (text) >= x2-x1-2*xOffSet) {
       nls = int (textWidth (text)/(x2-x1-2*xOffSet)) +1;
     }
   }
   
   public void display () {
     if (!selected) {
       drawBasics ();
     } else {
       fill (cBackSelected);
       rect (0.15*width, 0.15*height, 0.7*width, 0.35*height);
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
           if (tsSel >= 15) {
             text (text, (width)/2, (0.5*height)/2+10+ts/5);
           } else { // Sin comprobar.
             text (text, (width)/2, (0.5*height)/2+ts/3);
           }
         }
         textAlign (LEFT);
       }
       if (millis ()%1000 < 600) line (textWidth(text)/2 + (width)/2 + 5, (0.5*height)/2+10+ts/5 + 3, textWidth(text)/2 + (width)/2 + 5, (0.5*height)/2+10+ts/5 - ts - 3);
       text = kb.GetString ();
       calcNumLinSel ();
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
       if (x1 < mouseX && mouseX < x2 && y1 < mouseY && mouseY < y2) {
         selected = true;
         kb.SetHide(false);
         kb.SetString (text);
       } else if (selected) {
         if (mouseY < 0.59*height) {
           selected = false;
           kb.SetHide(true);
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
 }