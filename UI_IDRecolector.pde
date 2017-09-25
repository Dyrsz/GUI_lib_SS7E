
 public static class UI_IDRecolector {
   
   private static int id = 0;
   private static int numberLayer = 0;
   private static int numberSpecialLayer = 0;
   private static ArrayList <UIElement> idElements = new ArrayList <UIElement>();
   // I could make a two-dimensional int array to store numberLayers,
   // including special layers and as many 'special' levels as I want.
   // But I dont expect to be complex here.
   private static ArrayList <UILayer> layerElements = new ArrayList <UILayer>();
   private static ArrayList <UILayer> layerSpecialElements = new ArrayList <UILayer>();
   
   public static int GetUI_Ids () {
     return id;
   }
   
   public static int GetUI_NumberLayers () {
     return numberLayer;
   }
   
   public static int GetUI_NumberSpecialLayers () {
     return numberSpecialLayer;
   }
   
   public static int SetUI_ID (UIElement elem) {
     id ++;
     idElements.add (elem);
     return id;
   }
   
   public static int SetUI_NumberLayer (UILayer lay) {
     numberLayer ++;
     layerElements.add (lay);
     return numberLayer;
   }
   
   public static int SetUI_NumberSpecialLayer (UILayer lay) {
     numberSpecialLayer ++;
     layerSpecialElements.add (lay);
     return numberSpecialLayer;
   }
   
   public static UILayer SearchUILayerByIndex (int i) {
     if (i > 0) {
       return layerElements.get (i-1);
     } else {
       println ("Invalid ID on UI_IDRecolector.SearchUILayerByIndex (ID).");
       println ("ID must be > 0.");
       return layerElements.get (0);
     }
   }
   
   public static UILayer SearchUISpecialLayerByIndex (int i) {
     if (i > 0) {
       return layerSpecialElements.get (i-1);
     } else {
       println ("Invalid ID on UI_IDRecolector.SearchUISpecialLayerByIndex (ID).");
       println ("ID must be > 0.");
       return layerSpecialElements.get (0);
     }
   }
   
   public static UIElement SearchUIByID (int i) {
     if (i > 0) {
       return idElements.get (i-1);
     } else {
       println ("Invalid ID on UI_IDRecolector.SearchUIByID (ID).");
       println ("ID must be > 0.");
       return idElements.get (0);
     }
   }
  
 }