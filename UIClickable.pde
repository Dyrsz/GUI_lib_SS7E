
 public class UIClickable extends UIElement {

   private boolean active = true;
   private boolean _firstFramePressedSeg, _firstFrameOnSeg;
   private int _onMillisSincePressedSeg, _onMillisSinceOnSeg;
   private color colorBackPressed = 100;
   private color colorBackOn = 0;
  
   public void onDraw () {
     if (pressed ()) {
       drawBasics (colorBackPressed);
     } else if (on ()) {
       drawBasics (colorBackOn);
     } else {
       drawBasics ();
     }
   }
   
   public color GetColorBackPressed () {
     return colorBackPressed;
   }
   
   public color GetColorBackOn () {
     return colorBackOn;
   }
   
   public boolean IsActive () {
     return active;
   }
   
   public boolean on () {
     boolean r = false;
     if (active)
       if (x1 < mouseX && mouseX < x2)
         if (y1 < mouseY && mouseY < y2)
           r = true;
     return r;
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
     boolean r = false;
     if (active)
       if (mousePressed)
         if (x1 < mouseX && mouseX < x2)
           if (y1 < mouseY && mouseY < y2)
             r = true;
     return r;
   }
   
   public void SetActive (boolean sActive) {
     active = sActive;
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
   
 }