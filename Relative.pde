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
   
   public static RectButton RectButton (float x1, float y1, 
   float x2, float y2, String title) {
     return s.new RectButton (int(Math.round (_width*x1)), 
     int(Math.round (_height*y1)), int(Math.round (_width*x2)), 
     int(Math.round (_height*y2)), title);
   }
   
   public static RectButton RectButton (float [] position, String title) {
     if (position.length == 4) {
       return s.new RectButton (int(Math.round (_width*position [0])), 
       int(Math.round (_height*position [1])), int(Math.round (_width*position [2])), 
       int(Math.round (_height*position [3])), title);
     } else {
       println ("Bad input on Relative.RectButton (float [], String). Bad array input.");
       return null;
     }
   }
   
 }