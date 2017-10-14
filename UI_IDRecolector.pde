
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
   private static int numberNullElements = 0;
   
   // if destroy UILayer, remove numberLayer from list.
   
   public static void ChangeLayerOrder (UILayer lay, int index) {
     int s;
     if (lay.IsSpecialLayer ()) {
       layerSpecialElements.remove (lay);
       layerSpecialElements.add (index-1, lay);
       s = layerSpecialElements.size ();
       for (int i = 0; i < s; i++)
         layerSpecialElements.get (i).SetProtectedNumberLayer (i+1);
     } else {
       layerElements.remove (lay);
       layerElements.add (index-1, lay);
       s = layerElements.size ();
       for (int i = 0; i < s; i++)
         layerElements.get (i).SetProtectedNumberLayer (i+1);
     }
   }
   
   public static void DestroyElementFromID_Intern (int index) {
     idElements.remove (index-1);
     idElements.add (index-1, null);
     numberNullElements++;
   }
   
   public static void DestroyLayerFromID_Intern (int index) {
     if (layerElements.get (index).IsSpecialLayer ()) {
       layerSpecialElements.remove (index-1);
       numberSpecialLayer--;
     } else {
       layerElements.remove (index-1);
       numberLayer--;
     }
   }
   
   public static int GetUI_IDs () {
     return id;
   }
   
   public static int GetUI_NumberLayers () {
     return numberLayer;
   }
   
   public static int GetNumberNullElements () {
     return numberNullElements;
   }
   
   public static int GetUI_NumberSpecialLayers () {
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
   
   public static int SetUI_ID (UIElement elem) {
     if (numberNullElements > 0) {
       for (int i = 0; i < id; i++)
         if (idElements.get (i) == null) {
           idElements.remove (i);
           idElements.add (i, elem);
           numberNullElements--;
           return i+1;
         }
       println ("Internal problem here.");
       return 0;
     } else {
       id ++;
       idElements.add (elem);
       return id;
     }
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
   
   
  
 }