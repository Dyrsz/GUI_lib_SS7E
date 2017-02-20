
 class TextBox {
   int x1;
   int y1;
   int x2;
   int y2;
   int ts; // Tamaño letra.
   boolean hide;
   boolean active = true;
   boolean on;
   boolean ffseg; // firstFramePr seg.
   boolean ffoseg; // firstFrameOn seg.
   color cFillPressed = 0;
   color cFillOn = 0;
   color cBackground = 0;
   String str = ""; // Entrada.
   
   TextBox (int tx1, int ty1, int tx2, int ty2) {
     x1 = tx1;
     x2 = tx2;
     y1 = ty1;
     y2 = ty2;
     ts = 30;
   }
   
   TextBox (int tx1, int ty1, int tx2, int ty2, int tts) {
     x1 = tx1;
     x2 = tx2;
     y1 = ty1;
     y2 = ty2;
     ts = tts;
   }
   
   void display () {
     if (!hide) {
       stroke (180);
       fill(cBackground);
       if (pressed ()) {
         fill (cFillPressed);
       } else if (on ()) {
         fill (cFillOn);
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
   
 }