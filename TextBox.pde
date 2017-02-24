
 class TextBox {
   int x1;
   int y1;
   int x2;
   int y2;
   int ts; // Tamaño letra.
   boolean hide;
   boolean active = true;
   boolean on;
   boolean selected;
   boolean ffseg; // firstFramePr seg.
   boolean ffoseg; // firstFrameOn seg.
   color cBackPressed = 0;
   color cBackOn = 0;
   color cBackground = 0;
   color cBackSelected = 40;
   String str = ""; // Entrada.
   // String kstr = ""; // Salida del teclado.
   
   TextBox (Keyboard kb, int tx1, int ty1, int tx2, int ty2) {
     x1 = tx1;
     x2 = tx2;
     y1 = ty1;
     y2 = ty2;
     ts = 30;
   }
   
   TextBox (Keyboard kb, int tx1, int ty1, int tx2, int ty2, int tts) {
     x1 = tx1;
     x2 = tx2;
     y1 = ty1;
     y2 = ty2;
     ts = tts;
   }
   
   void display () {
     if (!hide) {
       stroke (180);
       if (!selected) {
         fill (cBackground);
         if (pressed ()) {
           fill (cBackPressed);
         } else if (on ()) {
           fill (cBackOn);
         }
         rect (x1, y1, x2-x1, y2-y1);
         textAlign (CENTER);
         textSize (ts);
         fill (200);
         if (ts >= 15) {
           text (str, (x1+x2)/2, (y1+y2)/2+10+ts/5);
         } else {
           text (str, (x1+x2)/2, (y1+y2)/2+ts/3);
         }
         textAlign (LEFT);
       } else {
         fill (cBackSelected);
         rect (0.15*width, 0.15*height, 0.7*width, 0.35*height);
         textAlign (CENTER);
         textSize (ts);
         fill (200);
         if (ts >= 15) {
           text (str, (0.85*width)/2, (0.5*height)/2+10+ts/5);
         } else {
           text (str, (0.85*width)/2, (0.5*height)/2+ts/3);
         }
         textAlign (LEFT);
         if (millis ()%1000 < 600) line (textWidth(str) + 5 + (0.85*width)/2, (0.5*height)/2+10+ts/5 + 3, textWidth(str) + 5 + (0.85*width)/2, (0.5*height)/2+10+ts/5 - ts - 3);
         str = kb.GetString ();
       }
     }
   }
   
   void released () {
     if (active) {
       if (x1 < mouseX && mouseX < x2 && y1 < mouseY && mouseY < y2) {
         selected = true;
         kb.SetHide(false);
         kb.SetString (str);
       } else if (selected && mouseY < 0.59*height) {
         selected = false;
         kb.SetHide(true);
         // str = kb.GetString();
       }
     }
   }
   
   boolean pressed () {
     if (active) {
       if (x1 < mouseX && mouseX < x2 && y1 < mouseY && mouseY < y2 && mousePressed) {
         return true;
       } else {
         return false;
       }
     } else {
       return false;
     }
   }
   
   boolean on () {
     if (active) {
       if (x1 < mouseX && mouseX < x2 && y1 < mouseY && mouseY < y2) {
         return true;
       } else {
         return false;
       }
     } else {
       return false;
     }
   }
    
   boolean onFirstFramePressed () {
     boolean r = false;
     if (active) {
       if (pressed ()) {
         if (!ffseg) {
           ffseg = true;
           r = true;
         }
       } else {
         ffseg = false;
       }
     }
     return r;
   }
    
   boolean onFirstFrameOn () {
     boolean r = false;
     if (active) {
       if (on ()) {
         if (!ffoseg) {
           ffoseg = true;
           r = true;
         }
       } else {
         ffoseg = false;
       }
     }
     return r;
   }
   
   public void SetSelected (boolean b) {
     selected = b;
   }
   
   boolean isActive () {
      return active;
    }
    
    boolean isHide () {
      return hide;
    }
    
    public void SetActive (boolean sActive) {
      active = sActive;
    }
    
    public void SetColorBackground (color tcolor) {
      cBackground = tcolor;
    }
    
    public void SetBackPressed (color c) {
      cBackPressed = c;
    }
    
    public void SetBackOn (color c) {
      cBackOn = c;
    }
    
    public void SetBackSelected (color c) {
      cBackSelected = c;
    }
    
    public void SetHide (boolean sHide) {
      if (sHide) {
        hide = true;
        active = false;
      } else {
        hide = false;
        active = true;
      }
    }
    
 }