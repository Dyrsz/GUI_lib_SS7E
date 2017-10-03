
 public class UIClickable extends UIElement {

   // Parameters
   private boolean active = true;
   private color colorBackPressed = 100;
   private color colorBackOn = 0;
   // Auxiliars.
   private boolean _firstFramePressedSeg, _firstFrameOnSeg;
   private int _onMillisSincePressedSeg, _onMillisSinceOnSeg;
   private boolean _onRet, _onFirstFrameOnRet, _onFirstFramePressedRet;
   private boolean _onMillisSinceOnRet, _onMillisSincePressedRet, _pressedRet;
  
   public UIClickable () {
     MakeID ();
     UIType = "UIClickable";
   }
   
   public void display () {
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
     _onRet = false;
     if (active)
       if (x1 < mouseX && mouseX < x2)
         if (y1 < mouseY && mouseY < y2)
           _onRet = true;
     return _onRet;
   }
   
   public boolean onFirstFrameOn () {
     _onFirstFrameOnRet = false;
     if (active) {
       if (on ()) {
         if (!_firstFrameOnSeg) {
           _firstFrameOnSeg = true;
           _onFirstFrameOnRet = true;
         }
       } else {
         _firstFrameOnSeg = false;
       }
     }
     return _onFirstFrameOnRet;
   }
   
   public boolean onFirstFramePressed () {
     _onFirstFramePressedRet = false;
     if (active) {
       if (pressed ()) {
         if (!_firstFramePressedSeg) {
           _firstFramePressedSeg = true;
           _onFirstFramePressedRet = true;
         }
       } else {
         _firstFramePressedSeg = false;
       }
     }
     return _onFirstFramePressedRet;
   }
   
   public boolean onMillisSinceOn (int tmillis) {
     _onMillisSinceOnRet = false;
     if (onFirstFrameOn()) _onMillisSinceOnSeg = millis ();
     if (on ()) {
       if (millis () - _onMillisSinceOnSeg >= tmillis) _onMillisSinceOnRet = true;
     } else {
       _onMillisSinceOnRet = false;
     }
     return _onMillisSinceOnRet;
   }
   
   public boolean onMillisSincePressed (int tmillis) {
     _onMillisSincePressedRet = false;
     if (onFirstFramePressed()) _onMillisSincePressedSeg = millis ();
     if (pressed ()) {
       if (millis () - _onMillisSincePressedSeg >= tmillis) _onMillisSincePressedRet = true;
     } else {
       _onMillisSincePressedRet = false;
     }
     return _onMillisSincePressedRet;
   }
   
   public boolean pressed () {
     _pressedRet = false;
     if (active)
       if (mousePressed)
         if (x1 < mouseX && mouseX < x2)
           if (y1 < mouseY && mouseY < y2)
             _pressedRet = true;
     return _pressedRet;
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