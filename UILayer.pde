
 class UILayer extends UIElement {
   
   // Function (onConstructor) that: ActualizeProperties.
   // Always: SetTextYPosition
   // Detect submenu level (and set it) and change colorBackground.
   // UIText, UIForm lists.
   
   
   // Parameters
   private int numberLayer = 0;
   private boolean isSpecialLayer = false;
   private boolean active = true;
   private boolean hideable = false;
   private ArrayList <UIElement> elements = new ArrayList <UIElement>();
   private int numberElements = 0;
   // add methods for this.
   private ArrayList <UILayer> sublayers = new ArrayList <UILayer>();
   private int numberSubLayers = 0;
   // methods.
   private ArrayList <UILayer> superlayers = new ArrayList <UILayer>();
   private int numberSuperLayers = 0;
   
   private int submenuLevel = 0;
   // Auxiliars
   private boolean _pressedOutRet, _onFirstFramePressedOutRet;
   private boolean _firstFramePressedOutSeg;
   
   public UILayer () {
     MakeID ();
     MakeLayer ();
     UIType = "UILayer";
   }
   
   public UILayer (int cx1, int cy1, int cx2, int cy2) {
     MakeID ();
     MakeLayer ();
     SetPosition (cx1, cy1, cx2, cy2);
     UIType = "UILayer";
     
   }
   
   public UILayer (int [] position) {
      int [] tposition = position;
      if (tposition.length == 4) {
        SetPosition (tposition);
      } else {
        println ("Bad call on UILayer (int [] position). Bad array input.");
      }
      MakeID ();
      MakeLayer ();
      UIType = "UILayer";
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
     UIType = "UILayer";
   }
   
   public void ActualizeProperties () {
     if (numberElements > 0) {
       submenuLevel = 0;
       for (int i = 0; i < numberElements; i++) {
         if (elements.get (i).GetUIType ().equals ("UILayer")) {
           //if (element.get (i).)
         }
       }
     }
   }
   
   public void AddElement (UIElement elem) {
     elements.add (elem);
     numberElements++;
     if (elem.GetUIType ().equals ("UILayer")) {
       UILayer lay = (UILayer) elem;
       lay.AddSuperLayer (this);
       sublayers.add (lay); 
       numberSubLayers++;
     }
   }
   
   public void AddElements (UIElement [] elems) {
     int siz = elems.length;
     numberElements += siz;
     for (int i = 0; i < siz; i++) {
       elements.add (elems [i]);
       if (elems [i].GetUIType ().equals ("UILayer")) {
         UILayer lay = (UILayer) elems [i];
         lay.AddSuperLayer (this);
         sublayers.add (lay);
         numberSubLayers++;
       }
     }
   }
   
   protected void AddSuperLayer (UILayer lay) {
     superlayers.add (lay);
     numberSuperLayers++;
   }
   
   public void ClearElements () {
     elements.clear ();
     numberElements = 0;
     if (numberSubLayers > 0) {
       for (int i = 0; i < numberSubLayers; i++)
         sublayers.get (i).RemoveSuperLayer (this);
       sublayers.clear ();
       numberSubLayers = 0;
     }
   }
   
   public void ClearElements (boolean removeAllStructure) {
     elements.clear ();
     numberElements = 0;
     if (numberSubLayers > 0) {
       for (int i = 0; i < numberSubLayers; i++) {
         if (removeAllStructure) sublayers.get (i).ClearElements (true);
         sublayers.get (i).RemoveSuperLayer (this);
       }
       sublayers.clear ();
       numberSubLayers = 0;
     }
   }
   
   // ClearSublayers... (two methods)
   
   protected void MakeLayer () {
     numberLayer = UI_IDRecolector.SetUI_NumberLayer (this);
   }
   
   protected void MakeSpecialLayer () {
     numberLayer = UI_IDRecolector.SetUI_NumberSpecialLayer (this);
   }
   
   public void MakeSubmenuLevel (int t) {
     submenuLevel = t;
     ActualizeProperties ();
   }
   
   public void display () {
     if (!hide) {
       drawBasics ();
       if (numberElements > 0) 
         for (int i = 0; i < numberElements; i++)
           elements.get (i).display ();
       if (hideable) if (onFirstFramePressedOut ())
         SetHide (true);
     }
   }
   
   public UIElement [] GetElements () {
     UIElement [] ret = new UIElement [numberElements];
     for (int i = 0; i < numberElements; i++)
       ret [i] = elements.get (i);
     return ret;
   }
   
   public int GetNumberElements () {
     return numberElements;
   }
   
   public int GetNumberLayer () {
     return numberLayer;
   }
   
   public int GetNumberSubLayers () {
     return numberSubLayers;
   }
   
   public int GetNumberSuperLayers () {
     return numberSuperLayers;
   }
   
   public UILayer [] GetSubLayers () {
     UILayer [] ret = new UILayer [numberSubLayers];
     if (numberSubLayers > 0) {
      for (int i = 0; i < numberSubLayers; i++)
        ret [i] = sublayers.get (i);
     }
     return ret;
   }
   
   public UILayer [] GetSuperLayers () {
     UILayer [] ret = new UILayer [numberSuperLayers];
     if (numberSuperLayers > 0) {
       for (int i = 0; i < numberSuperLayers; i++)
         ret [i] = superlayers.get (i);
     }
     return ret;
   }
   
   public int GetSubmenuLevel () {
     return submenuLevel;
   }
   
   public boolean IsActive () {
     return active;
   }
   
   public boolean IsHideable () {
     return hideable;
   }
   
   public boolean IsSpecialLayer () {
     return isSpecialLayer;
   }
   
   // onFirtsFrameDisplay (); onFirstFrameHide ();
   
   public boolean onFirstFramePressedOut () {
     _onFirstFramePressedOutRet = false;
     if (active) {
       if (pressedOut ()) {
         if (!_firstFramePressedOutSeg) {
           _firstFramePressedOutSeg = true;
           _onFirstFramePressedOutRet = true;
         }
       } else {
         _firstFramePressedOutSeg = false;
       }
     }
     return _onFirstFramePressedOutRet;
   }
   
   public boolean pressedOut () {
     _pressedOutRet = false;
     if (active)
       if (mousePressed)
         if (x1 > mouseX || mouseX > x2)
           if (y1 > mouseY || mouseY > y2)
             _pressedOutRet = true;
     return _pressedOutRet;
   }
   
   public void RemoveLastElement () {
     if (numberElements > 0) {
       if (elements.get (numberElements-1).GetUIType ().equals ("UILayer")) {
         sublayers.get (numberSubLayers-1).RemoveSuperLayer (this);
         sublayers.remove (numberSubLayers-1);
         numberSubLayers--;
       }
       elements.remove(numberElements-1);
       numberElements--;
     } else {
       println ("Bad call on UILayer.RemoveLastElements (). Empty list.");
     }
   }
   
   public void RemoveElement (int index) {
     if (0 <= index && index < numberElements && numberElements > 0) {
       if (elements.get (index).GetUIType ().equals ("UILayer")) {
         UILayer lay = (UILayer) elements.get (index);
         lay.RemoveSuperLayer (this);
         sublayers.remove (lay);
         numberSubLayers--;
       }
       elements.remove (index);
       numberElements--;
     } else {
       println ("Bad index on UILayer.RemoveElement (index).");
     }
   }
   
   public void RemoveElement (UIElement elem) {
     if (elements.contains (elem)) {
       if (elem.GetUIType ().equals ("UILayer")) {
         UILayer lay = (UILayer) elem;
         lay.RemoveSuperLayer (this);
         sublayers.remove (lay);
         numberSubLayers--;
       }
       elements.remove (elem);
       numberElements--;
     } else {
       println ("Bad input on UILayer.RemoveElement (UIElement).");
     }
   }
   
   protected void RemoveSuperLayer (UILayer lay) {
     if (superlayers.contains (lay)) {
       superlayers.remove (lay);
       numberSuperLayers--;
     } else {
       println ("Crucial error on UILayer.RemoveSuperLayer().");
     }
   }
   
   public void SetActive (boolean sActive) {
     active = sActive;
   }
   
   public void SetHide (boolean sHide) {
     if (sHide) {
       hide = true;
       active = false;
     } else {
       hide = false;
       active = true;
     }
     for (int i = 0; i < numberElements; i++)
       elements.get (i).SetHide (hide);
   }
   
   public void SetHideable (boolean b) {
     hideable = b;
   }
   
   // Test this.
   public void SetNumberSpecialLayer (int i) {
     if (!isSpecialLayer) {
       println ("Bad call on UILayer.SetNumberSpecialLayer ().");
       println ("The layer you are trying to access is not special. Use SetNumberLayer instead.");
     } else {
       if (i > 0)
         UI_IDRecolector.ChangeLayerOrder (this, i);
     }
   }
   
   // Better test this.
   public void SetNumberLayer (int i) {
     if (isSpecialLayer) {
       println ("Bad call on UILayer.SetNumberLayer ().");
       println ("The layer you are trying to access is special. Use SetNumberSpecialLayer instead.");
     } else {
       if (i > 0)
         UI_IDRecolector.ChangeLayerOrder (this, i);
     }
   }
   
   protected void SetProtectedNumberLayer (int i) { // Do NOT use this method manually.
     numberLayer = i;
   }
   
 }