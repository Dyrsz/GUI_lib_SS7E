
 public class UIElement {

   protected int x1 = 0;
   protected int x2 = 100;
   protected int y1 = 0;
   protected int y2 = 100;
   private int lengthX = 100;
   private int lengthY = 100;
   protected String text = "";
   private int textSize = 50;
   private int textx = 50;
   private int texty = 70;
   protected boolean hide = false;
   private String form = "Rect"; // Round, Ghost.
   private color colorBackground = 0;
   private boolean transparentBackground = false;
   private IntList superlayers = new IntList();
   private int numberSuperLayers = 0;
   protected int id = 0;
   protected String UIType = "UIElement";
   // Auxiliars.
   private boolean _firstFrameDisplaySeg, _firstFrameHideSeg;
   
   public UIElement () {
     MakeID ();
   }
   
   public UIElement (int cx1, int cy1, int cx2, int cy2) {
     MakeID ();
     SetPosition (cx1, cy1, cx2, cy2);
   }
   
   public UIElement (int [] position) {
     int [] tposition = position;
     if (tposition.length == 4) {
       SetPosition (tposition);
     } else {
       println ("Bad call on UIElement (int [] position). Bad array input.");
     }
     MakeID ();
   }
   
   // What with this? I think there are no changes.
   protected void AddSuperLayer (UILayer lay) {
     superlayers.append (lay.GetUI_ID ());
     numberSuperLayers++;
   }
   
   protected void AddSuperLayerFromID (int idt) {
     if (idt > 0) {
       superlayers.append (idt);
       numberSuperLayers++;
     } else {
       println ("Crucial error on UIElement.AddSuperLayerFromID (0).");
     }
   }
   
   /*
   protected void AddSuperLayer (UILayer lay, boolean addButton) {
     superlayers.append (lay.GetUI_ID ());
     numberSuperLayers++;
   }
   */
   
   public void display () {
     drawBasics ();
   }
   
   public void ClearSuperLayers () {
     while (numberSuperLayers > 0)
       GetSuperLayer (numberSuperLayers-1).ClearSubLayers ();
   }
   
   public void ClearSuperLayers (boolean removeAllStructure) {
     while (numberSuperLayers > 0) {
       if (removeAllStructure) GetSuperLayer (numberSuperLayers-1).ClearSuperLayers (true);
       GetSuperLayer (numberSuperLayers-1).ClearSubLayers ();
     }
   }
   
   public void Destroy () {
     if (id > 0) {
       if (numberSuperLayers > 0) for (int i = 0; i < numberSuperLayers; i++)
         GetSuperLayer (i).RemoveElementFromID (id);
       superlayers.clear ();
       numberSuperLayers = 0;
       UI_IDRecolector.DestroyElementFromID_Intern (id);
     }
     id = 0;
     SetHide (true);
   }
   
   protected void DestroyFromLayer () {
     if (id > 0) {
       superlayers.clear ();
       numberSuperLayers = 0;
       UI_IDRecolector.DestroyElementFromID_Intern (id);
     }
     id = 0;
     SetHide(true);
   }
   
   public void drawBasics () {
     if (!hide) {
       if (!_firstFrameDisplaySeg) {
         _firstFrameDisplaySeg = true;
         _firstFrameHideSeg = false;
         OnFirstFrameDisplay ();
       }
       stroke (180);
       if (!transparentBackground) {
         fill(colorBackground);
         if (form.equals ("Rect")) {
           rect (x1, y1, lengthX, lengthY);
         } else {
           //
           rect (x1, y1, lengthX, lengthY);
         }
       }
       if (!text.equals ("")) {
         textAlign (CENTER);
         textSize (textSize);
         fill (200);
         text (text, textx, texty);
         textAlign (LEFT);
       }
     } else {
       if (!_firstFrameHideSeg) {
         _firstFrameHideSeg = true;
         _firstFrameDisplaySeg = false;
         OnFirstFrameHide ();
       }
     }
   }
   
   public void drawBasics (color c) {
     if (!hide) {
       if (!_firstFrameDisplaySeg) {
         _firstFrameDisplaySeg = true;
         _firstFrameHideSeg = false;
         OnFirstFrameDisplay ();
       }
       stroke (180);
       if (!transparentBackground) {
         fill(c);
         if (form.equals ("Rect")) {
           rect (x1, y1, lengthX, lengthY);
         } else {
           //
           rect (x1, y1, lengthX, lengthY);
         }
       }
       if (!text.equals ("")) {
         textAlign (CENTER);
         textSize (textSize);
         fill (200);
         text (text, textx, texty);
         textAlign (LEFT);
       }
     } else {
       if (!_firstFrameHideSeg) {
         _firstFrameHideSeg = true;
         _firstFrameDisplaySeg = false;
         OnFirstFrameHide ();
       }
     }
   }
   
   public void AdjustTextPosition () {
     textx = (x1+x2)/2;
     if (textSize >= 15) {
       texty = (y1+y2+textSize)/2 - textSize/5;
     } else {
       texty = (y1+y2)/2+textSize/3;
     }
   }
   
   protected void MakeID () {
     id = UI_IDRecolector.SetUI_ID (this);
   }
   
   public color GetColorBackground () {
     return colorBackground;
   }
   
   public String GetForm () {
     return form;
   }
   
   protected int getIndexOf (IntList ls, int val) {
     int k = 0;
     if (ls.hasValue (val)) {
       int s = ls.size ();
       for (int i = 0; i < s; i++)
         if (ls.get (i) == val) {
           k = i;
           i = s;
         }
     } else {
       println ("Intern error. Code A.");
     }
     return k;
   }
   
   public int GetLengthX () {
     return lengthX;
   }
   
   public int GetLengthY () {
     return lengthY;
   }
   
   public int GetNumberSuperLayers () {
     return numberSuperLayers;
   }
   
   public int [] GetPosition () {
     int [] r = {x1, x2, y1, y2};
     return r;
   }
   
   public UILayer GetSuperLayer (int i) {
     if (0 <= i && i < numberSuperLayers) {
       return (UILayer) UI_IDRecolector.SearchUIByID (superlayers.get (i));
     } else {
       println ("Bad input on UILayer.GetSuperLayer (i).");
       return null;
     }
   }
   
   public UILayer [] GetSuperLayers () {
     UILayer [] ret = new UILayer [numberSuperLayers];
     if (numberSuperLayers > 0)
       for (int i = 0; i < numberSuperLayers; i++)
         ret [i] = GetSuperLayer (i);
     return ret;
   }
   
   public String GetText () {
     return text;
   }
   
   public int [] GetTextPosition () {
     int [] r = {textx, texty};
     return r;
   }
   
   public int GetTextSize () {
     return textSize;
   }
   
   public int GetUI_ID () {
     return id;
   }
   
   public String GetUIType () {
     return UIType;
   }
    
   public boolean IsHide () {
     return hide;
   }
   
   public boolean IsTransparentBackground () {
     return transparentBackground;
   }
   
   public void OnFirstFrameDisplay () {};
   
   public void OnFirstFrameHide () {};
   
   protected void RemoveSuperLayer (UILayer lay) {
     RemoveSuperLayerFromID (lay.GetUI_ID ());
   }
   
   protected void RemoveSuperLayerFromID (int ID) {
     if (superlayers.hasValue (ID)) {
       int k = getIndexOf (superlayers, ID);
       superlayers.remove (k);
       numberSuperLayers--;
     } else {
       println ("Crucial error on UILayer.RemoveSuperLayer().");
     }
   }
   
   public void SetColorBackground (color tcolor) {
     colorBackground = tcolor;
   }
   
   public void SetFixedLengthX (int length) {
     int tlengthX = length;
     textSize (textSize);
     if (textWidth (text) +10 > tlengthX) {
       lengthX = int (textWidth (text)+10);
     } else {
       lengthX = tlengthX;
     }
     x2 = x1 + lengthX;
     AdjustTextPosition ();
   }
   
   public void SetFixedLengthY (int length) {
     int tlengthY = length;
     if (textSize +10 > tlengthY) {
       lengthY = textSize + 10;
     } else {
       lengthY = tlengthY;
     }
     y2 = y1 + lengthY;
     AdjustTextPosition ();
   }
   
   public void SetForm (String tform) {
     String ttform = tform;
     if (ttform.equals ("Rect") || ttform.equals ("Round")) {
       form = ttform;
     } else {
       println ("Bad input on UIClickable.SetForm (String).");
       println ("Avaiable forms are 'Rect' or 'Round'.");
     }
   }
   
   public void SetHide (boolean sHide) {
     hide = sHide;
   }
   
   public void SetLengthX (int length) {
     lengthX = length;
     textSize (textSize);
     while (textWidth (text) +10 > lengthX) {
       textSize --;
       textSize (textSize);
     }
     x2 = x1 + lengthX;
     AdjustTextPosition ();
   }
   
   public void SetLengthY (int tlengthY) {
     lengthY = tlengthY;
     if (textSize + 10 > lengthY) {
       textSize = lengthY -10;
     }
     y2 = y1 + lengthY;
     AdjustTextPosition ();
   }
   
   public void SetPosition (int tx1, int ty1, int tx2, int ty2) {
     x1 = tx1;
     x2 = tx2;
     y1 = ty1;
     y2 = ty2;
     lengthX = x2 - x1;
     lengthY = y2 - y1;
     AdjustTextPosition ();
   }
   
   public void SetPosition (int [] position) {
     int [] tposition = position;
     if (tposition.length == 4) {
       x1 = tposition [0];
       y1 = tposition [1];
       x2 = tposition [2];
       y2 = tposition [3];
       lengthX = x2 - x1;
       lengthY = y2 - y1;
     } else {
       println ("Bad input on UIClickable.SetPosition (int []).");
       println ("Input array must have length == 4.");
     }
     AdjustTextPosition ();
   }
   
   public void SetText (String tt) {
     text = tt;
   }
   
   public void SetTextPosition (int tx, int ty) {
     textx = tx;
     texty = ty;
   }
   
   public void SetTextPosition (int [] ts) {
     int [] tp = ts;
     if (tp.length == 2) {
       textx = tp [0];
       texty = tp [1];
     } else {
       println ("Bad input on UIClickable.SetTextPosition (int []).");
       println ("Input array must have length == 2.");
     }
   }
   
   public void SetTextXPosition (int tx) {
     textx = tx;
   }
   
   public void SetTextYPosition (int ty) {
     texty = ty;
   }
   
   public void SetTextSize (int ts) {
     textSize = ts;
     textSize (textSize);
     if (textWidth (text) +10 > lengthX) SetLengthX (int (textWidth (text)+10));
     if (textSize +10 > lengthY) SetLengthY (textSize + 10);
     AdjustTextPosition ();
   }
   
   public void SetTransparentBackground (boolean b) {
     transparentBackground = b;
   }
   
 }