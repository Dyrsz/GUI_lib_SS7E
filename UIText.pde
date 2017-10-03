
 class UIText {
   
   private String text, align;
   private int x, y, textSize, textWidth;
   private color _color;
   
   public UIText (String txt, int cx, int cy) {
     text = txt;
     x = cx;
     y = cy;
     textSize = 50;
     _color = color (200);
     align = "Left";
     textSize (textSize);
     textWidth = int (textWidth (text));
   }
   
   public void display () {
     stroke (_color);
     if (align.equals ("Left")) {
       textAlign (LEFT);
     } else if (align.equals ("Center")) {
       textAlign (CENTER);
     } else if (align.equals ("Right")) {
       textAlign (RIGHT);
     }
     textSize (textSize);
     text (text, x, y);
   }
   
   public String GetAlign () {
     return align;
   }
   
   public color GetColor () {
     return _color;
   }
   
   public int [] GetPosition () {
     int [] ret = {x, y};
     return ret;
   }
   
   public String GetText () {
     return text;
   }
   
   public int GetTextSize () {
     return textSize;
   }
   
   public int GetWidth () {
     textSize (textSize);
     textWidth = int (textWidth (text));
     return textWidth;
   }
   
   public int GetXPosition () {
     return x;
   }
   
   public int GetYPosition () {
     return y;
   }
   
   public void SetAlign (String al) {
     String a = al;
     if (a.equals ("Left") || a.equals ("Center") || a.equals ("Right")) {
       align = a;
     } else {
       println ("Bad input on UIText.SetAlign (String).");
     }
   }
   
   public void SetColor (color c) {
     _color = c;
   }
   
   public void SetPosition (int cx, int cy) {
     x = cx;
     y = cy;
   }
   
   public void SetXPosition (int t) {
     x = t;
   }
   
   public void SetYPosition (int t) {
     y = t;
   }
   
   public void SetPosition (int [] p) {
     int [] tp = p;
     if (tp.length == 2) {
       x = p [0];
       y = p [1];
     } else {
       println ("Bad input on UIText.SetPosition (int [])");
     }
   }
   
   public void SetText (String t) {
     text = t;
   }
   
   public void SetTextSize (int t) {
     textSize = t;
   }
   
 }