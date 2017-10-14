
 class UILayer extends UIElement {
   
   // Parameter adding sublayers: create aditional button.
   // I am reviewing all the methods to fix it.
   
   // Function (onConstructor) that: ActualizeProperties.
   // Always: SetTextYPosition
   // Detect submenu level (and set it) and change colorBackground.
   // UIText, UIForm lists.
   
   // Parameters
   // Aclare this:
   private boolean hideName = false;
   private int numberLayer = 0;
   private boolean isSpecialLayer = false;
   private boolean active = true;
   private boolean hideable = false;
   // getters, setters.
   private boolean showTitle = false;
   
   // --> IMPORTANT: I will convert all ArrayList on IntList: save only IDs for reference.
   
   private IntList elements;
   private int numberElements = 0;
   private IntList sublayers;
   private int numberSubLayers = 0;
   // boolean with layers: Each sublayer has a respective boolean.
   // if true: it has a Button too, but the layer is hide.
   // if false: not button (inside the superlayer)
   
   // Destroy this variable. Ill use sublayerButtons as ID, 0 if no button.
   // Repase all methods again.
   //private ArrayList<Boolean> hasSublayerButton = new ArrayList<Boolean> ();
   private IntList sublayerButtons;
   private IntList superlayers;
   // this is not necessary, I think. Maybe yes.
   private IntList superlayerButtons;
   private int numberSuperLayers = 0;
   
   
   private int submenuLevel = 0;
   // Auxiliars
   private boolean _pressedOutRet, _onFirstFramePressedOutRet;
   private boolean _firstFramePressedOutSeg;
   
   // Sobreescribo isHide, isActive y el resto de métodos necesarios.
   // Afectan a la capa pero también a todos sus elementos, y subcapas y elementos de subcapas.
   
   public UILayer () {
     super ();
     MakeLayer ();
     UIType = "UILayer";
   }
   
   public UILayer (String title) {
     super ();
     MakeLayer ();
     UIType = "UILayer";
     text = title;
   }
   
   public UILayer (int cx1, int cy1, int cx2, int cy2) {
     super (cx1, cy1, cx2, cy2);
     MakeLayer ();
     UIType = "UILayer";
   }
   
   public UILayer (String title, int cx1, int cy1, int cx2, int cy2) {
     super (cx1, cy1, cx2, cy2);
     MakeLayer ();
     UIType = "UILayer";
     text = title;
   }
   
   public UILayer (int [] position) {
      super (position);
      MakeLayer ();
      UIType = "UILayer";
    }
    
    public UILayer (String title, int [] position) {
      super (position);
      MakeLayer ();
      UIType = "UILayer";
      text = title;
    }
   
   public UILayer (boolean isSpecial) {
     super ();
     if (isSpecial) {
       MakeSpecialLayer ();
       isSpecialLayer = true;
     } else {
       MakeLayer ();
     }
     UIType = "UILayer";
   }
   
   // Maybe this is not necessary.
   public void ActualizeProperties () {
     if (numberElements > 0) {
       submenuLevel = 0;
       for (int i = 0; i < numberElements; i++) {
         if (GetElement (i).GetUIType ().equals ("UILayer")) {
           //if (element.get (i).)
         }
       }
     }
   }
   
   public void AddElement (UIElement elem) {
     if (elem.GetUIType ().equals ("UILayer")) {
       AddSubLayerFromElem (elem);
     } else {
       elements.append (elem.GetUI_ID ());
       numberElements++;
     }
   }
   
   public void AddElement (UIElement elem, boolean addButton) {
     if (elem.GetUIType ().equals ("UILayer")) {
       AddSubLayerFromElem (elem, addButton);
     } else {
       elements.append (elem.GetUI_ID ());
       numberElements++;
     }
   }
   
   public void AddElements (UIElement [] elems) {
     int siz = elems.length;
     for (int i = 0; i < siz; i++)
       AddElement (elems [i]);
   }
   
   public void AddSubLayer (UILayer lay) {
     elements.append (lay.GetUI_ID ());
     numberElements++;
     lay.AddSuperLayer (this);
     sublayers.append (lay.GetUI_ID ()); 
     sublayerButtons.append (0);
     numberSubLayers++;
   }
   
   public void AddSubLayer (UILayer lay, boolean addButton) {
     //lay.AddSuperLayer (this, addButton);
     lay.AddSuperLayer (this);
     sublayers.append (lay.GetUI_ID ());
     if (addButton) {
       UIButton but = new UIButton ();
       if (text.equals ("")) {
         but.SetText ("Next sublayer");
       } else {
         but.SetText (text);
       }
       lay.SetHide (true);
       elements.append (but.GetUI_ID ());
       sublayerButtons.append (but.GetUI_ID ());
     } else {
       sublayerButtons.append (0);
       elements.append (lay.GetUI_ID ());
     }
     numberSubLayers++;
     numberElements++;
   }
   
   protected void AddSubLayerFromElem (UIElement elem) {
     UILayer lay = (UILayer) elem;
     AddSubLayer (lay);
   }
   
   protected void AddSubLayerFromElem (UIElement elem, boolean addButton) {
     UILayer lay = (UILayer) elem;
     AddSubLayer (lay, addButton);
   }
   
   public void AddSubLayers (UILayer [] lays) {
     int siz = lays.length;
     for (int i = 0; i < siz; i++)
       AddSubLayer (lays [i]);
   }
   
   public void AddSubLayers (UILayer [] lays, boolean addButton) {
     int siz = lays.length;
     for (int i = 0; i < siz; i++)
       AddSubLayer (lays [i], addButton);
   }
   
   // What with this? I think there are no changes.
   protected void AddSuperLayer (UILayer lay) {
     superlayers.append (lay.GetUI_ID ());
     numberSuperLayers++;
   }
   
   /*
   protected void AddSuperLayer (UILayer lay, boolean addButton) {
     superlayers.append (lay.GetUI_ID ());
     numberSuperLayers++;
   }
   */
   
   public void ClearElements () {
     elements.clear ();
     numberElements = 0;
     if (numberSubLayers > 0) {
       for (int i = 0; i < numberSubLayers; i++)
         GetSubLayer (i).RemoveSuperLayer (this);
       sublayers.clear ();
       numberSubLayers = 0;
     }
   }
   
   public void ClearElements (boolean removeAllStructure) {
     elements.clear ();
     numberElements = 0;
     if (numberSubLayers > 0) {
       for (int i = 0; i < numberSubLayers; i++) {
         if (removeAllStructure) GetSubLayer (i).ClearElements (true);
         GetSubLayer (i).RemoveSuperLayer (this);
       }
       sublayers.clear ();
       numberSubLayers = 0;
     }
   }
   
   public void ClearSubLayers () {
     while (numberSubLayers > 0)
       RemoveLastSubLayer ();
   }
   
   public void ClearSubLayers (boolean removeAllStructure) {
     while (numberSubLayers > 0) {
       if (removeAllStructure) GetSubLayer (numberSubLayers-1).ClearSubLayers (true);
       RemoveLastSubLayer ();
     }
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
   
   protected void MakeLayer () {
     numberLayer = UI_IDRecolector.SetUI_NumberLayer (this);
   }
   
   protected void MakeSpecialLayer () {
     numberLayer = UI_IDRecolector.SetUI_NumberSpecialLayer (this);
   }
   
   protected void MakeSubmenuLevel (int t) {
     submenuLevel = t;
     ActualizeProperties ();
   }
   
   // Ep.
   public void Destroy () {
     UI_IDRecolector.DestroyLayerFromID_Intern (id);
     super.Destroy ();
     ClearElements ();
   }
   
   // Test this.
   public void Destroy (boolean allElements) {
     if (allElements) {
       if (numberElements > 0) for (int i = 0; i < numberElements; i++)
         GetElement (i).Destroy ();
       if (numberSubLayers > 0) for (int i = 0; i < numberSubLayers; i++)
         GetSubLayer (i).Destroy ();
       UI_IDRecolector.DestroyLayerFromID_Intern (id);
       super.Destroy ();
       ClearElements ();
     } else {
       Destroy ();
     }
   }
   
   public void display () {
     if (!hide) {
       // if (hideName...
       drawBasics ();
       if (numberElements > 0) 
         for (int i = 0; i < numberElements; i++)
           GetElement (i).display ();
       // onFirstFrameDisplay:
       //  - coloco botones y botones de subcapas.
       //  - si estaban hides: hide = false.
       if (hideable) if (onFirstFramePressedOut ())
         SetHide (true);
       // en el cuerpo:
       // acciones de onfirstFramePressed en los botones de subcapas.
         
     }
   }
   
   public UIElement GetElement (int i) {
     if (0 <= i && i < numberElements) {
       return UI_IDRecolector.SearchUIByID (elements.get (i));
     } else {
       println ("Bad input on UILayer.GetElement (i).");
       return null;
     }
   }
   
   public UIElement [] GetElements () {
     UIElement [] ret = new UIElement [numberElements];
     for (int i = 0; i < numberElements; i++)
       ret [i] = GetElement (i);
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
   
   public UILayer GetSubLayer (int i) {
     if (0 <= i && i < numberSubLayers) {
       return (UILayer) UI_IDRecolector.SearchUIByID (sublayers.get (i));
     } else {
       println ("Bad input on UILayer.GetSubLayer (i).");
       return null;
     }
   }
   
   public UILayer [] GetSubLayers () {
     UILayer [] ret = new UILayer [numberSubLayers];
     if (numberSubLayers > 0)
      for (int i = 0; i < numberSubLayers; i++)
        ret [i] = GetSubLayer (i);
     return ret;
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
   
   public int GetSubmenuLevel () {
     return submenuLevel;
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
   
   public boolean IsActive () {
     return active;
   }
   
   public boolean IsHideable () {
     return hideable;
   }
   
   public boolean IsHideName () {
     return hideName;
   }
   
   public boolean IsSpecialLayer () {
     return isSpecialLayer;
   }
   
   // onFirtsFrameDisplay (); onFirstFrameHide ();
   // In these methods, create PositionGuide.
   // Before, subMenuLevel.
   
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
   
   // RemoveSubLayers with buttons...
   public void RemoveElement (int index) {
     if (0 <= index && index < numberElements && numberElements > 0) {
       if (GetElement (index).GetUIType ().equals ("UILayer")) {
         // Esto está mal.
         // Primero tengo que aclararme con AddSuperLayer.
         // Hago RemoveSubLayer.
         
         UILayer lay = (UILayer) GetElement (index);
         lay.RemoveSuperLayer (this);
         
         int indexLayer = getIndexOf (sublayers, lay.GetUI_ID ());
         if (sublayerButtons.get (indexLayer) != 0) {
           // Button of the Layer?
           //elements.get ();
         } else {
           elements.remove (index);
           numberElements--;
         }
         //sublayers.remove (lay);
         numberSubLayers--;
       }
       elements.remove (index);
       numberElements--;
     } else {
       println ("Bad index on UILayer.RemoveElement (index).");
     }
   }
   
   // Mal.
   public void RemoveElement (UIElement elem) {
     if (elements.hasValue (elem.GetUI_ID ())) {
       if (elem.GetUIType ().equals ("UILayer")) {
         UILayer lay = (UILayer) elem;
         lay.RemoveSuperLayer (this);
         //sublayers.remove (lay);
         numberSubLayers--;
       }
       //elements.remove (elem);
       numberElements--;
     } else {
       println ("Bad input on UILayer.RemoveElement (UIElement).");
     }
   }
   
   // Im here. Next, RemoveSubLayer.
   public void RemoveElementFromID (int ID) {
     // if element is layer, else remove element.
     if (elements.hasValue (ID)) {
       int k = getIndexOf (elements, ID);
       
     }
   }
   
   // Call RemoveElement.
   public void RemoveLastElement () {
     if (numberElements > 0) {
       if (GetElement (numberElements-1).GetUIType ().equals ("UILayer")) {
         //sublayers.get (numberSubLayers-1).RemoveSuperLayer (this);
         sublayers.remove (numberSubLayers-1);
         numberSubLayers--;
       }
       elements.remove(numberElements-1);
       numberElements--;
     } else {
       println ("Bad call on UILayer.RemoveLastElement (). Empty list.");
     }
   }
   
   // Call RemoveSubLayer.
   public void RemoveLastSubLayer () {
     if (numberElements > 0 && numberSubLayers > 0) {
       RemoveElement (sublayers.get (numberSubLayers-1));
     } else {
       println ("Bad call on UILayer.RemoveLastSubLayer (). Empty list.");
     }
   }
   
   // Im here.
   public void RemoveSubLayer (UILayer lay) {
     if (sublayers.hasValue (lay.GetUI_ID ())) {
       int k = getIndexOf (sublayers, lay.GetUI_ID ());
       if (sublayerButtons.get (k) != 0) {
         RemoveElement (sublayerButtons.get (k));
         // Destroy that button.
       } else {
       
       }
     } else {
       println ("Bad input on UILayer.RemoveSubLayer ().");
       println ("UILayer you want to remove is not inside the main UILayer.");
     }
   }
   
   protected void RemoveSuperLayer (UILayer lay) {
     if (superlayers.hasValue (lay.GetUI_ID ())) {
       //superlayers.remove (lay);
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
       GetElement (i).SetHide (hide);
   }
   
   public void SetHideable (boolean b) {
     hideable = b;
   }
   
   public void SetHideName (boolean b) {
     hideName = b;
   }
   
   public void SetNumberSpecialLayer (int i) {
     if (!isSpecialLayer) {
       println ("Bad call on UILayer.SetNumberSpecialLayer ().");
       println ("The layer you are trying to access is not special. Use SetNumberLayer instead.");
     } else {
       if (i > 0)
         UI_IDRecolector.ChangeLayerOrder (this, i);
     }
   }
   
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