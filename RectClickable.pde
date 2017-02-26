
 class RectClickable {
   int x1;
   int x2;
   int y1;
   int y2;
   String text = "";
   int ts; // Tamaño de letra
   boolean active = true;
   boolean ffseg; // firstFramePr seg.
   boolean ffoseg; // firstFrameOn seg.
   int mspseg; // onMillisSincePressed seg.
   int msoseg; // onMillisSinceOn seg.
   color cBackPressed = 100;
   boolean hide;
   color cBackground = 0;
   color cBackOn = 0;
  
   public void drawBasics () {
     if (!hide) {
       stroke (180);
       fill(cBackground);
       if (pressed ()) {
         fill (cBackPressed);
       } else if (on ()) {
         fill (cBackOn);
       }
       rect (x1, y1, x2-x1, y2-y1);
       if (!text.equals ("")) {
         textAlign (CENTER);
         textSize (ts);
         fill (200);
         if (ts >= 15) {
           text (text, (x1+x2)/2, (y1+y2)/2+10+ts/5);
         } else {
           text (text, (x1+x2)/2, (y1+y2)/2+ts/3);
         }
         textAlign (LEFT);
       }
     }
   }
   
   public color GetColorBackground () {
     return cBackground;
   }
   
   public color GetColorBackPressed () {
     return cBackPressed;
   }
   
   public color GetColorBackOn () {
     return cBackOn;
   }
   
   public String GetText () {
     return text;
   }
   
   public int GetTextSize () {
     return ts;
   }
   
   public boolean isActive () {
     return active;
   }
    
   public boolean isHide () {
     return hide;
   }
   
   public boolean on () {
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
   
   public boolean onFirstFrameOn () {
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
   
   public boolean onFirstFramePressed () {
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
   
   public boolean onMillisSinceOn (int tmillis) {
     boolean r = false;
     if (onFirstFrameOn()) msoseg = millis ();
     if (on ()) {
       if (millis () - msoseg >= tmillis) r = true;
     } else {
       r = false;
     }
     return r;
   }
   
   public boolean onMillisSincePressed (int tmillis) {
     boolean r = false;
     if (onFirstFramePressed()) mspseg = millis ();
     if (pressed ()) {
       if (millis () - mspseg >= tmillis) r = true;
     } else {
       r = false;
     }
     return r;
   }
   
   public boolean pressed () {
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
   
   public void SetActive (boolean sActive) {
     active = sActive;
   }
    
   public void SetColorBackground (color tcolor) {
     cBackground = tcolor;
   }
    
   public void SetColorBackPressed (color tcolor) {
     cBackPressed = tcolor;
   }
   
   public void SetColorBackOn (color tcolor) {
     cBackOn = tcolor;
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
   
   public void SetText (String tt) {
     text = tt;
   }
   
   public void SetTextSize (int tts) {
     ts = tts;
   }
   
 }