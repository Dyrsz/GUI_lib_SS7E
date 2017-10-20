
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
   private boolean showingTitle = false;
   
   private IntList elements = new IntList ();
   private int numberElements = 0;
   private IntList sublayers = new IntList ();
   private int numberSubLayers = 0;
   
   // Destroy this variable. Ill use sublayerButtons as ID, 0 if no button.
   // Repase all methods again.
   //private ArrayList<Boolean> hasSublayerButton = new ArrayList<Boolean> ();
   private IntList sublayerButtons = new IntList ();
   // this is not necessary, I think. Maybe yes.
   private IntList superlayerButtons;
   
   
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
   
   public void AddButtonToSubLayer () {
     
   }
   
   // Ok.
   public void AddElement (UIElement elem) {
     if (elem.GetUIType ().equals ("UILayer")) {
       AddSubLayerFromElem (elem);
     } else {
       elements.append (elem.GetUI_ID ());
       numberElements++;
       elem.AddSuperLayerFromID (id);
     }
   }
   
   // Ok.
   public void AddElement (UIElement elem, boolean addButton) {
     if (elem.GetUIType ().equals ("UILayer")) {
       AddSubLayerFromElem (elem, addButton);
     } else {
       elements.append (elem.GetUI_ID ());
       numberElements++;
       elem.AddSuperLayerFromID (id);
     }
   }
   
   // Ok.
   public void AddElements (UIElement [] elems) {
     int siz = elems.length;
     for (int i = 0; i < siz; i++)
       AddElement (elems [i]);
   }
   
   // Ok.
   public void AddSubLayer (UILayer lay) {
     AddSubLayerFromID (lay.GetUI_ID ());
   }
   
   // Ok.
   public void AddSubLayer (UILayer lay, boolean addButton) {
     AddSubLayerFromID (lay.GetUI_ID (), addButton);
   }
   
   // Ok.
   protected void AddSubLayerFromElem (UIElement elem) {
     UILayer lay = (UILayer) elem;
     AddSubLayer (lay);
   }
   
   // Ok.
   protected void AddSubLayerFromElem (UIElement elem, boolean addButton) {
     UILayer lay = (UILayer) elem;
     AddSubLayer (lay, addButton);
   }
   
   // Ok.
   public void AddSubLayerFromID (int ID) {
     elements.append (ID);
     numberElements++;
     sublayers.append (ID); 
     sublayerButtons.append (0);
     numberSubLayers++;
     GetSubLayer (numberSubLayers-1).AddSuperLayerFromID (id);
   }
   
   // Ok.
   public void AddSubLayerFromID (int ID, boolean addButton) {
     sublayers.append (ID);
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
       but.AddSuperLayerFromID (id);
       numberSubLayers++;
       GetSubLayer (numberSubLayers-1).AddSuperLayerFromID (id);
       GetSubLayer (numberSubLayers-1).SetHide (true);
     } else {
       sublayerButtons.append (0);
       elements.append (ID);
       numberSubLayers++;
       GetSubLayer (numberSubLayers-1).AddSuperLayerFromID (id);
     }
     numberElements++;
   }
   
   // Ok.
   public void AddSubLayers (UILayer [] lays) {
     int siz = lays.length;
     for (int i = 0; i < siz; i++)
       AddSubLayerFromID (lays [i].GetUI_ID ());
   }
   
   // Ok.
   public void AddSubLayers (UILayer [] lays, boolean addButton) {
     int siz = lays.length;
     for (int i = 0; i < siz; i++)
       AddSubLayerFromID (lays [i].GetUI_ID (), addButton);
   }
   
   // Repasar. Ya puedo.
   public void ClearElements () {
     if (numberElements > 0)
       for (int = 0; i < numberElements; i++)
         RemoveElementFromId (elements.get (i));
     elements.clear ();
     numberElements = 0;
     if (numberSubLayers > 0) {
       for (int i = 0; i < numberSubLayers; i++)
         GetSubLayer (i).RemoveSuperLayer (this);
       sublayers.clear ();
       numberSubLayers = 0;
     }
   }
   
   // Repasar.
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
   
   // Ok.
   public void ClearSubLayers () {
     while (numberSubLayers > 0)
       RemoveLastSubLayer ();
   }
   
   // Ok.
   public void ClearSubLayers (boolean removeAllStructure) {
     while (numberSubLayers > 0) {
       if (removeAllStructure) GetSubLayer (numberSubLayers-1).ClearSubLayers (true);
       RemoveLastSubLayer ();
     }
   }
   
  // Ok.
   protected void MakeLayer () {
     numberLayer = UI_IDRecolector.SetUI_NumberLayer (this);
   }
   
   // Ok.
   protected void MakeSpecialLayer () {
     numberLayer = UI_IDRecolector.SetUI_NumberSpecialLayer (this);
   }
   
   // Ok.
   protected void MakeSubmenuLevel (int t) {
     submenuLevel = t;
     ActualizeProperties ();
   }
   
   // Not sure, but yes.
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
   
   // Ok.
   public UIElement GetElement (int i) {
     if (0 <= i && i < numberElements) {
       return UI_IDRecolector.SearchUIByID (elements.get (i));
     } else {
       println ("Bad input on UILayer.GetElement (i).");
       return null;
     }
   }
   
   // Ok.
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
   
   public UIButton GetSubLayerButton (int i) {
     if (0 <= i && i < numberSubLayers) {
       if (sublayerButtons.get (i) == 0) { 
         println ("Bad input on UILayer.GetSubLayerButton (). No button on this index.");
         return null;
         // If isn't permited, return new button.
       } else {
         return (UIButton) UI_IDRecolector.SearchUIByID (sublayersButtons.get (i));
       }
     } else {
       println ("Bad input on UILayer.GetSubLayerButton (i).");
       return null;
     }
   }
   
   public UIButton [] GetSubLayerButtons () {
     int k = 0;
     for (int i = 0; i < numberSubLayers; i++)
       if (sublayerButtons.get (i) != 0) {
         k++;
       }
     if (k > 0) {
       UIButton [] ret = new UIButton [k];
       k = 0;
       for (int i = 0; i < numberSubLayers; i++)
       if (sublayerButtons.get (i) != 0) {
         ret [k] = UI_IDRecolector.SearchUIByID (sublayersButtons.get (i));
         k++;
       }
       return ret;
     } else {
       UIButton [] noButtons;
       return noButtons;
     }
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
   
   public void RemoveButtonToSubLayer () {
     
   }
   
   // Ok.
   public void RemoveElement (int index) {
     if (0 <= index && index < numberElements && numberElements > 0) {
       RemoveElementFromID (GetElement (index).GetUI_ID ());
     } else {
       println ("Bad index on UILayer.RemoveElement (index).");
     }
   }
   
   // Ok.
   public void RemoveElement (UIElement elem) {
     if (elements.hasValue (elem.GetUI_ID ())) {
       RemoveElementsFromID (elem.GetUI_ID ());
     } else {
       println ("Bad input on UILayer.RemoveElement (UIElement).");
     }
   }
   
   // Ok.
   public void RemoveElementFromID (int ID) {
     if (sublayers.hasValue(ID)) {
       RemoveSubLayerFromID (ID);
     } else {
       if (sublayerButtons.hasValue (ID)) {
         int k = getIndexOf (sublayerButtons, ID);
         int m = getIndexOf (elements, ID);
         GetSubLayer (k).RemoveSuperLayerFromID (id);
         GetSubLayerButton (k).RemoverSuperLayerFromID (id);
         sublayers.remove (k);
         sublayerButtons.remove (k);
         numberSubLayers--;
         elements.remove (m);
         numberElements--;
       } else if (elements.hasValue (ID)) {
         int k = getIndexOf (elements, ID);
         elements.get (k).RemoveSuperLayerFromID (id);
         elements.remove (k);
         numberElements--;
       } else {
         println ("Bad input on UILayer.RemoveElementFromID ().");
       }
     }
   }
   
   // Ok.
   public void RemoveLastElement () {
     if (numberElements > 0) {
       RemoveElementFromID (GetElement (numberElements-1).GetUI_ID ());
     } else {
       println ("Bad call on UILayer.RemoveLastElement (). Empty list.");
     }
   }
   
   // Ok.
   public void RemoveLastSubLayer () {
     if (numberElements > 0 && numberSubLayers > 0) {
       RemoveSubLayerFromID (GetSubLayer (numberSubLayers-1).GetUI_ID ());
     } else {
       println ("Bad call on UILayer.RemoveLastSubLayer (). Empty list.");
     }
   }
   
   // Ok.
   public void RemoveSubLayer (UILayer lay) {
     if (sublayers.hasValue (lay.GetUI_ID ())) {
       RemoveSubLayerFromID (lay.GetUI_ID ());
     } else {
       println ("Bad input on UILayer.RemoveSubLayer ().");
       println ("UILayer you want to remove is not inside the main UILayer.");
     }
   }
   
   // Ok.
   public void RemoveSubLayerFromID (int ID) {
     if (sublayers.hasValue (ID)) {
       int k = getIndexOf (sublayers, ID);
       if (sublayerButtons.get (k) != 0) {
         GetSubLayerButton (k).Destroy ();
       } else {
         int m = getIndexOf (elements, ID);
         GetSubLayer (k).RemoveSuperLayerFromID (id);
         sublayers.remove (k);
         numberSubLayers--;
         elements.remove (m);
         numberElements--;
       }
     } else {
       println ("Bad input on UILayer.RemoveSubLayerFromID ().");
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