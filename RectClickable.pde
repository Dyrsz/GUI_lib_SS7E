
 public class RectClickable {
   // RelativePosition
   
   private int x1, x2, y1, y2, textSize;
   private String text = "";
   private boolean active = true;
   private boolean hide, _firstFramePressedSeg, _firstFrameOnSeg;
   private int _onMillisSincePressedSeg, _onMillisSinceOnSeg;
   private color colorBackPressed = 100;
   private color colorBackground = 0;
   private color colorBackOn = 0;
  
   /* I think this is not necessary.
   RectClickable (int tx1, int ty1, int tx2, int ty2, String ttitle) {
      x1 = tx1;
      x2 = tx2;
      y1 = ty1;
      y2 = ty2;
      text = ttitle;
      ts = 30;
    }
  
   RectClickable (int tx1, int ty1, int tx2, int ty2, String ttitle, int tts) {
     x1 = tx1;
     x2 = tx2;
     y1 = ty1;
     y2 = ty2;
     text = ttitle;
     ts = tts;
   }
   */
  
   public void drawBasics () {
     if (!hide) {
       stroke (180);
       fill(colorBackground);
       if (pressed ()) {
         fill (colorBackPressed);
       } else if (on ()) {
         fill (colorBackOn);
       }
       rect (x1, y1, x2-x1, y2-y1);
       if (!text.equals ("")) {
         textAlign (CENTER);
         textSize (textSize);
         fill (200);
         if (textSize >= 15) {
           text (text, (x1+x2)/2, (y1+y2)/2+10+textSize/5);
         } else {
           text (text, (x1+x2)/2, (y1+y2)/2+textSize/3);
         }
         textAlign (LEFT);
       }
     }
   }
   
   public color GetColorBackground () {
     return colorBackground;
   }
   
   public color GetColorBackPressed () {
     return colorBackPressed;
   }
   
   public color GetColorBackOn () {
     return colorBackOn;
   }
   
   public int [] GetPosition () {
     int [] r = {x1, x2, y1, y2};
     return r;
   }
   
   public String GetText () {
     return text;
   }
   
   public int GetTextSize () {
     return textSize;
   }
   
   public boolean IsActive () {
     return active;
   }
    
   public boolean IsHide () {
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
         if (!_firstFrameOnSeg) {
           _firstFrameOnSeg = true;
           r = true;
         }
       } else {
         _firstFrameOnSeg = false;
       }
     }
     return r;
   }
   
   public boolean onFirstFramePressed () {
     boolean r = false;
     if (active) {
       if (pressed ()) {
         if (!_firstFramePressedSeg) {
           _firstFramePressedSeg = true;
           r = true;
         }
       } else {
         _firstFramePressedSeg = false;
       }
     }
     return r;
   }
   
   public boolean onMillisSinceOn (int tmillis) {
     boolean r = false;
     if (onFirstFrameOn()) _onMillisSinceOnSeg = millis ();
     if (on ()) {
       if (millis () - _onMillisSinceOnSeg >= tmillis) r = true;
     } else {
       r = false;
     }
     return r;
   }
   
   public boolean onMillisSincePressed (int tmillis) {
     boolean r = false;
     if (onFirstFramePressed()) _onMillisSincePressedSeg = millis ();
     if (pressed ()) {
       if (millis () - _onMillisSincePressedSeg >= tmillis) r = true;
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
     colorBackground = tcolor;
   }
    
   public void SetColorBackPressed (color tcolor) {
     colorBackPressed = tcolor;
   }
   
   public void SetColorBackOn (color tcolor) {
     colorBackOn = tcolor;
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
   
   public void SetPosition (int tx1, int ty1, int tx2, int ty2) {
     x1 = tx1;
     x2 = tx2;
     y1 = ty1;
     y2 = ty2;
   }
   
   public void SetText (String tt) {
     text = tt;
   }
   
   public void SetTextSize (int ts) {
     textSize = ts;
   }
   
 }