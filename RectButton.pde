
 public class RectButton extends RectClickable {
    
    private int _sincePressedMillisModSeg, _sinceOnMillisModSeg;
    
    // textsize is in the constructor because I have to adjust
    // it according to the button size. When I do that, I will remove it.
    public RectButton (int tx1, int ty1, int tx2, int ty2, String ttitle) {
      SetPosition (tx1, ty1, tx2, ty2);
      SetText (ttitle);
      SetTextSize (30);
    }
  
    public RectButton (int tx1, int ty1, int tx2, int ty2, String ttitle, int tts) {
      SetPosition (tx1, ty1, tx2, ty2);
      SetText (ttitle);
      SetTextSize (tts);
    }
    
    public RectButton (int [] tposition, String ttitle) {
      if (tposition.length == 4) {
        SetPosition (tposition [0], tposition [1], tposition [2], tposition [3]);
        SetText (ttitle);
        SetTextSize (30);
      } else {
        println ("Bad call on RectButton (int [], String). Bad array input.");
      }
    }
  
    public RectButton (int [] tposition, String ttitle, int tts) {
      if (tposition.length == 4) {
        SetPosition (tposition [0], tposition [1], tposition [2], tposition [3]);
        SetText (ttitle);
        SetTextSize (30);
      } else {
        println ("Bad call on RectButton (int [], String, int). Bad array input.");
      }
    }
    
    public void display () {
      drawBasics ();
    }
    
    public boolean sinceOnMillisMod (int tmod) {
      boolean r = false;
      if (onFirstFrameOn()) _sinceOnMillisModSeg = millis ();
      if (on ()) {
        if ((millis () - _sinceOnMillisModSeg) >= tmod) {
          _sinceOnMillisModSeg = millis ();
          r = true;
        }
      } else {
        r = false;
      }
      return r;
    }
    
    public boolean sincePressedMillisMod (int tmod) {
      boolean r = false;
      if (onFirstFramePressed()) _sincePressedMillisModSeg = millis ();
      if (pressed ()) {
        if ((millis () - _sincePressedMillisModSeg) >= tmod) {
          _sincePressedMillisModSeg = millis ();
          r = true;
        }
      } else {
        r = false;
      }
      return r;
    }
    
  }
  
  // Pendiente.
  /*
  class CheckBox  { // No hacer muy grande.
    int x1;
    int x2;
    int y1;
    int y2;
    boolean v;
    
    CheckBox (int tx1, int ty1, int tx2, int ty2) {
      x1 = tx1;
      x2 = tx2;
      y1 = ty1;
      y2 = ty2;
      v = false;
    }
    
    void display () {
      if (v) {
        stroke (180);
        fill (0);
        rect (x1, y1, x2-x1, y2-y1);
        fill (0, 150, 0);
        beginShape ();
          vertex (x1-5, (y2+y1)/2);
          vertex ((x1+x2)/2, y2+5);
          vertex (x2+10, y1-10);
          vertex ((x1+x2)/2, (y1+y2)/2 + 5);
        endShape ();
        fill (180);
      } else {
        stroke (180);
        fill (0);
        rect (x1, y1, x2-x1, y2-y1);
      }
    }
    
    void pressed () {
      if (x1 < mouseX && mouseX < x2 && y1 < mouseY && mouseY < y2 && mousePressed) {
        v = !v;
      }
    }
  }
  */
  
  