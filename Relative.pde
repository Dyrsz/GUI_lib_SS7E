 public static class Relative {
   
   private static float _height = 2560;
   private static float _width = 1440;
   private static LibGUIProcessing s;
   
   public static void onSetup (LibGUIProcessing ts) {
     s = ts;
   }
   
   public static void onSetup (LibGUIProcessing ts, int theight, int twidth) {
     s = ts;
     _height = theight;
     _width = twidth;
   }
   
   public static UIButton UIButton (float x1, float y1, 
   float x2, float y2, String title) {
     return s.new UIButton (int(Math.round (_width*x1)), 
     int(Math.round (_height*y1)), int(Math.round (_width*x2)), 
     int(Math.round (_height*y2)), title);
   }
   
   public static UIButton UIButton (float [] position, String title) {
     float [] tposition = position;
     if (tposition.length == 4) {
       return s.new UIButton (int(Math.round (_width*tposition [0])), 
       int(Math.round (_height*tposition [1])), int(Math.round (_width*tposition [2])), 
       int(Math.round (_height*tposition [3])), title);
     } else {
       println ("Bad input on Relative.UIButton (float [], String). Bad array input.");
       return null;
     }
   }
   
 }