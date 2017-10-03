
 class UIForm {
   
   // This class could be bigger, but I think it is not necessary.
   private String form;
   private int v1, v2, v3, v4, strokeSize;
   private color fillColor, strokeColor;
   
   public UIForm (String tform, int t1, int t2, int t3, int t4) {
     String f = tform;
     if (f.equals("Line") || f.equals ("Rect") || f.equals ("Ellipse")) {
       form = f;
     } else {
       println ("Fatal error on UIForm constructor.");
     }
     v1 = t1;
     v2 = t2;
     v3 = t3;
     v4 = t4;
     fillColor = color (0);
     strokeColor = color (200);
     strokeSize = 5;
   }
   
   public void display () {
     fill (fillColor);
     stroke (strokeColor);
     strokeWeight (strokeSize);
     if (form.equals ("Line")) {
       line (v1, v2, v3, v4);
     } else if (form.equals ("Rect")) {
       rect (v1, v2, v3, v4);
     } else if (form.equals ("Ellipse")) {
       ellipse (v1, v2, v3, v4);
     }
   }
   
   public String GetForm () {
     return form;
   }
   
   public color GetFillColor () {
     return fillColor;
   }
   
   public color GetStrokeColor () {
     return strokeColor;
   }
   
   public int GetStrokeSize () {
     return strokeSize;
   }
   
   public int [] GetVariables () {
     int [] ret = {v1, v2, v3, v4};
     return ret;
   }
   
   public void SetForm (String tf) {
     String f = tf;
     if (f.equals("Line") || f.equals ("Rect") || f.equals ("Ellipse") || f.equals ("Arc")) {
       form = f;
     } else {
       println ("Bad input on UIForm.SetForm (String).");
       println ("Forms types are 'Line', 'Rect', 'Ellipse', 'Arc'.");
     }
   }
   
   public void SetFillColor (color c) {
     fillColor = c;
   }
   
   public void SetStrokeColor (color c) {
     strokeColor = c;
   }
   
   public void SetStrokeSize (int t) {
     strokeSize = t;
   }
   
   public void SetVariables (int t1, int t2, int t3, int t4) {
     v1 = t1;
     v2 = t2;
     v3 = t3;
     v4 = t4;
   }
   
   public void SetVariables (int [] vt) {
     int [] v = vt;
     if (v.length == 4) {
       v1 = v [0];
       v2 = v [1];
       v3 = v [2];
       v4 = v [3];
     } else {
       println ("Bad input on UIForm.SetVariables (int []).");
     }
   }
   
 }