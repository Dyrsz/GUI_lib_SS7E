
 class UILayer extends UIElement {
   
   // Always: SetTextYPosition
   
   // SetNumberLayer, ...
   // This, and a Segurity function
   private int numberLayer = 0;
   private int numberSpecialLayer = 0;
   private int maxLayers;
   private int maxSpecialLayers;
   private boolean isSpecialLayer = false;
   
   // Constructor that... ¿search for the rest?
   
   public UILayer () {
     MakeID ();
     MakeLayer ();
   }
   
   public UILayer (String type) {
     if (type.equals ("Special")) {
       MakeSpecialLayer ();
       isSpecialLayer = true;
     } else {
       MakeLayer ();
       println ("Warning on new UILayer (String).");
       println ("This method is for String to be 'Special' and it is not.");
     }
     MakeID ();
   }
   
   protected void ActualizeMaxNumberLayers () {
     maxLayers = UI_IDRecolector.GetUI_NumberLayers ();
   }
   
   protected void ActualizeMaxNumberSpecialLayers () {
     maxSpecialLayers = UI_IDRecolector.GetUI_NumberSpecialLayers ();
   }
   
   protected void MakeLayer () {
     numberLayer = UI_IDRecolector.SetUI_NumberLayer (this);
   }
   
   protected void MakeSpecialLayer () {
     numberLayer = UI_IDRecolector.SetUI_NumberSpecialLayer (this);
   }
   
   public int GetMaxNumberLayers () {
     return maxLayers;
   }
   
   public int GetMaxNumberSpecialLayers () {
     return maxSpecialLayers;
   }
   
   public int GetNumberLayer () {
     return numberLayer;
   }
   
   public int GetNumberSpecialLayer () {
     return numberSpecialLayer;
   }
   
   public boolean IsSpecialLayer () {
     return isSpecialLayer;
   }
   
 }