
 class UILayer extends UIElement {
   
   // UIText, UIForm lists.
   
   // Parameters
   // Aclare this:
   private boolean hideName = false;
   private int numberLayer = 0;
   private boolean isSpecialLayer = false;
   private boolean active = true;
   private boolean hideable = false;
   private boolean transpose = false;
   private IntList elements = new IntList ();
   private int numberElements = 0;
   private IntList sublayers = new IntList ();
   private int numberSubLayers = 0;
   private IntList sublayerButtons = new IntList ();
   private boolean fixElementsPosition = true;
   private PositionGuide pg;
   private int subLayerLevel = 1;
   private boolean autoColor = true;
   
   // Sobreescribo isHide, isActive y el resto de métodos necesarios.
   // Afectan a la capa pero también a todos sus elementos, y subcapas.
   
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
   
   public void ActualizeProperties (boolean fixElements) {
     // subLayerLevel
     if (autoColor)
       // change colorBackground.
     if (fixElements && numberElements > 0) {
       pg = new PositionGuide ("Matrix", "Relative");
       pg.SetOffSet (x1, Relative._width - x2, y1, Relative._height -y2);
       pg.AutoWithNumberElements (numberElements);
       for (int i = 0; i < numberElements; i++)
         GetElement (i).SetPosition (pg.GetMatrixCoordOnArray (i, transpose));
     }
     if (!hideName) {
       SetTextYPosition (y1 + textSize + 10);
   }
   
   public void AddButtonToSubLayer (UILayer lay) {
     if (sublayers.hasValue (lay.GetUI_ID ())) {
       AddButtonToSubLayerFromID (lay.GetUI_ID ());
     } else {
       println ("Bad input on UILayer.AddButtonToSubLayer");
     }
   }
   
   public void AddButtonToSubLayer (int index) {
     if (index >= 0 && index < numberSubLayers) {
       if (sublayerButtons.get (index) == 0) {
         UIButton but = new UIButton ();
         if (text.equals ("")) {
           but.SetText ("Next sublayer");
         } else {
           but.SetText (text);
         }
         GetSubLayer (index).SetHide (true);
         int k = getIndexOf (elements, sublayers.get (index));
         elements.remove (k);
         elements.append (but.GetUI_ID ());
         sublayerButtons.remove (index);
         sublayerButtons.add (index, but.GetUI_ID ());
         but.AddSuperLayerFromID (id);
       } else {
         println ("You are adding a button to a sublayer that already have it.");
       }
     } else {
       println ("Bad call on UILayer.AddButtonTuSubLayer ();");
     }
   }
   
   public void AddButtonToSubLayerFromID (int ID) {
     if (ID > 0 && sublayers.hasValue (ID)) {
       AddButtonToSubLayer (getIndexOf (sublayers, ID));
     } else {
       println ("Invalid ID on UILayer.AddButtonToSubLayerFromID ().");
     }
   }
   
   public void AddElement (UIElement elem) {
     if (elem.GetUIType ().equals ("UILayer")) {
       AddSubLayerFromElem (elem);
     } else {
       elements.append (elem.GetUI_ID ());
       numberElements++;
       elem.AddSuperLayerFromID (id);
     }
   }
   
   public void AddElement (UIElement elem, boolean addButton) {
     if (elem.GetUIType ().equals ("UILayer")) {
       AddSubLayerFromElem (elem, addButton);
     } else {
       elements.append (elem.GetUI_ID ());
       numberElements++;
       elem.AddSuperLayerFromID (id);
     }
   }
   
   public void AddElements (UIElement [] elems) {
     int siz = elems.length;
     for (int i = 0; i < siz; i++)
       AddElement (elems [i]);
   }
   
   public void AddElements (UIElement [] elems, boolean addButton) {
     int siz = elems.length;
     for (int i = 0; i < siz; i++)
       AddElement (elems [i], addButton);
   }
   
   public void AddSubLayer (UILayer lay) {
     AddSubLayerFromID (lay.GetUI_ID ());
   }
   
   public void AddSubLayer (UILayer lay, boolean addButton) {
     AddSubLayerFromID (lay.GetUI_ID (), addButton);
   }
   
   protected void AddSubLayerFromElem (UIElement elem) {
     UILayer lay = (UILayer) elem;
     AddSubLayer (lay);
   }
   
   protected void AddSubLayerFromElem (UIElement elem, boolean addButton) {
     UILayer lay = (UILayer) elem;
     AddSubLayer (lay, addButton);
   }
   
   public void AddSubLayerFromID (int ID) {
     if (ID > 0) {
       elements.append (ID);
       numberElements++;
       sublayers.append (ID); 
       sublayerButtons.append (0);
       numberSubLayers++;
       GetSubLayer (numberSubLayers-1).AddSuperLayerFromID (id);
     } else {
       println ("Invalid ID on UILayer.AddSubLayerFromID ().");
     }
   }
   
   public void AddSubLayerFromID (int ID, boolean addButton) {
     if (ID > 0) {
       sublayers.append (ID);
       if (addButton) {
         UIButton but = new UIButton ();
         if (text.equals ("")) {
           but.SetText ("Next sublayer");
         } else {
           but.SetText (text);
         }
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
     } else {
       println ("Invalid ID on UILayer.AddSubLayerFromID ().");
     }
   }
   
   public void AddSubLayers (UILayer [] lays) {
     int siz = lays.length;
     for (int i = 0; i < siz; i++)
       AddSubLayerFromID (lays [i].GetUI_ID ());
   }
   
   public void AddSubLayers (UILayer [] lays, boolean addButton) {
     int siz = lays.length;
     for (int i = 0; i < siz; i++)
       AddSubLayerFromID (lays [i].GetUI_ID (), addButton);
   }
   
   public void ClearElements () {
     ClearSubLayers ();
     while (numberElements > 0)
       RemoveElementFromID (elements.get (numberElements-1));
   }
   
   public void ClearElements (boolean removeAllStructure) {
     ClearSubLayers (removeAllStructure);
     while (numberElements > 0)
       RemoveElementFromID (elements.get (numberElements-1));
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
   
   public void Destroy () {
     ClearElements ();
     UI_IDRecolector.DestroyLayerFromID_Intern (id);
     super.Destroy ();
   }
   
   // Test this.
   public void Destroy (boolean allElements) {
     if (allElements) {
       while (numberSubLayers > 0)
         GetSubLayer (numberSubLayers-1).Destroy (true);
       DestroyElements ();
       DestroySubLayers ();
     }
     Destroy ();
   }
   
   public void DestroyElement (int index) {
     if (index >= 0 && numberElements > 0 && index < numberElements) {
       GetElement (index).Destroy ();
     } else {
       println ("Bad input on UILayer.DestroyElement ().");
     }
   }
   
   public void DestroyElements () {
     while (numberElements > 0)
       DestroyLastElement ();
   }
   
   public void DestroyLastElement () {
     if (numberElements > 0) {
       GetElement (numberElements-1).Destroy ();
     } else {
       println ("Bad call on UILayer.DestroyLastElement (). Empty list.");
     }
   }
   
   public void DestroyLastSubLayer () {
     if (numberSubLayers > 0) {
       GetSubLayer (numberSubLayers-1).Destroy ();
     } else {
       println ("Bad call on UILayer.DestroyLastSubLayer (). Empty list.");
     }
   }
   
   public void DestroySubLayer (int index) {
     if (index >= 0 && numberSubLayers > 0 && index < numberSubLayers) {
       GetSubLayer (index).Destroy ();
     } else {
       println ("Bad input on UILayer.DestroySubLayer ().");
     }
   }
   
   public void DestroySubLayer (int index, boolean allElements) {
     if (index >= 0 && numberSubLayers > 0 && index < numberSubLayers) {
       if (allElements) {
         GetSubLayer (index).Destroy (true);
       } else {
         GetSubLayer (index).Destroy ();
       }
     } else {
       println ("Bad input on UILayer.DestroySubLayer ().");
     }
   }
   
   public void DestroySubLayers () {
     while (numberSubLayers > 0)
       DestroyLastSubLayer ();
   }
   
   // Test.
   public void DestroySubLayers (boolean allElements) {
     while (numberSubLayers > 0)
       if (allElements) {
         GetSubLayer (numberSubLayers-1).DestroySubLayers (true);
         DestroyLastSubLayer ();
       } else {
         DestroyLastSubLayer ();
       }
   }
   
   public void display () {
     // if (hideName...
     // drawText
     drawBasics ();
     if (numberElements > 0) 
       for (int i = 0; i < numberElements; i++)
         GetElement (i).display ();
     if (!hide) {
       if (hideable) if (onFirstFramePressedOut ())
         SetHide (true);
     // acciones de onfirstFramePressed en los botones de subcapas.
       }
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
   
   public PositionGuide GetPositionGuide () {
     return pg;
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
       } else {
         return (UIButton) UI_IDRecolector.SearchUIByID (sublayerButtons.get (i));
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
         ret [k] = (UIButton) UI_IDRecolector.SearchUIByID (sublayerButtons.get (i));
         k++;
       }
       return ret;
     } else {
       return null;
     }
   }
   
   public int GetSubmenuLevel () {
     return submenuLevel;
   }
   
   public boolean HasAutoColor () {
     return autoColor;
   }
   
   public boolean HasFixElementsPosition () {
     return fixElementsPosition;
   }
   
   public boolean HasHideName () {
     return hideName;
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
   
   public boolean IsTranspose () {
     return transpose;
   }
   
   // onFirstFrameHide ();
   
   public void onFirstFrameDisplay () {
     ActualizeProperties (fixElementsPosition);
     for (int i = 0; i < numberElements; i++) {
       GetElement (i).SetHide (false);
     }
   }
   
   public void RemoveButtonToSubLayer (UILayer lay) {
     if (sublayers.hasValue (lay.GetUI_ID ())) {
       RemoveButtonToSubLayerFromID (lay.GetUI_ID ());
     } else {
       println ("Bad input on UILayer.RemoveButtonToSubLayer().");
     }
   }
   
   public void RemoveButtonToSubLayer (int index) {
     if (0 <= index && index < numberSubLayers && numberSubLayers > 0) {
       RemoveButtonToSubLayerFromID (sublayers.get (index));
     } else {
       println  ("Bad input on UILayer.RemoveButtonToSubLayer().");
     }
   }
   
   public void RemoveButtonToSubLayerFromID (int ID) {
     if (ID > 0 && sublayers.hasValue(ID)) {
       int k = getIndexOf (sublayers, ID);
       int idButton = sublayerButtons.get(k);
       if (idButton != 0) {
         int m = getIndexOf (elements, sublayerButtons.get (k));
         elements.remove (m);
         elements.append (ID);
         sublayerButtons.remove (k);
         sublayerButtons.add (k, 0);
         UI_IDRecolector.SearchUIByID (idButton).Destroy ();
         GetSubLayer (k).SetHide (false);
       } else {
         println ("Bad input on UILayer.RemoveButtonToSubLayerFromID ().");
         println ("Button you are trying to remove does not exist.");
       }
     } else {
       println ("Bad input on UILayer.RemoveButtonToSubLayerFromID ().");
     }
   }
   
   public void RemoveElement (int index) {
     if (0 <= index && index < numberElements && numberElements > 0) {
       RemoveElementFromID (GetElement (index).GetUI_ID ());
     } else {
       println ("Bad index on UILayer.RemoveElement (index).");
     }
   }
   
   public void RemoveElement (UIElement elem) {
     if (elements.hasValue (elem.GetUI_ID ())) {
       RemoveElementFromID (elem.GetUI_ID ());
     } else {
       println ("Bad input on UILayer.RemoveElement (UIElement).");
     }
   }
   
   public void RemoveElementFromID (int ID) {
     if (ID > 0) {
       if (sublayers.hasValue(ID)) {
         RemoveSubLayerFromID (ID);
       } else {
         if (sublayerButtons.hasValue (ID)) {
           int k = getIndexOf (sublayerButtons, ID);
           int m = getIndexOf (elements, ID);
           GetSubLayer (k).RemoveSuperLayerFromID (id);
           GetSubLayerButton (k).RemoveSuperLayerFromID (id);
           sublayers.remove (k);
           sublayerButtons.remove (k);
           numberSubLayers--;
           elements.remove (m);
           numberElements--;
         } else if (elements.hasValue (ID)) {
           int k = getIndexOf (elements, ID);
           GetElement (k).RemoveSuperLayerFromID (id);
           elements.remove (k);
           numberElements--;
         } else {
           println ("Bad input on UILayer.RemoveElementFromID ().");
         }
       }
     } else {
       println ("Invalid ID on UILayer.RemoveElementFromID ().");
     
     }
   }
   
   public void RemoveLastElement () {
     if (numberElements > 0) {
       RemoveElementFromID (GetElement (numberElements-1).GetUI_ID ());
     } else {
       println ("Bad call on UILayer.RemoveLastElement (). Empty list.");
     }
   }
   
   public void RemoveLastSubLayer () {
     if (numberElements > 0 && numberSubLayers > 0) {
       RemoveSubLayerFromID (GetSubLayer (numberSubLayers-1).GetUI_ID ());
     } else {
       println ("Bad call on UILayer.RemoveLastSubLayer (). Empty list.");
     }
   }
   
   public void RemoveSubLayer (UILayer lay) {
     if (sublayers.hasValue (lay.GetUI_ID ())) {
       RemoveSubLayerFromID (lay.GetUI_ID ());
     } else {
       println ("Bad input on UILayer.RemoveSubLayer ().");
       println ("UILayer you want to remove is not inside the main UILayer.");
     }
   }
   
   public void RemoveSubLayerFromID (int ID) {
     if (ID > 0) {
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
     } else {
       println ("Invalid ID on UILayer.RemoveSubLayerFromID ().");
     }
   }
   
   public void SetActive (boolean sActive) {
     active = sActive;
   }
   
   public void SetAutoColor (boolean b) {
     autoColor = b;
   }
   
   public void SetElementsPositionByPositionGuide (PositionGuide tpg) {
     if (tpg.GetRowLength()*tpg.GetColumnLength >= numberElements && !fixElementsPosition) {
       pg = tpg;
     } else if (fixElementsPosition) {
       println ("Bad call on UILayer.SetElementsPositionByPositionGuide ().");
       println ("UILayer.fixElementsPosition is true. Change this with UILayer.SetFixElementsPosition ().");
     } else {
       println ("Bad call on UILayer.SetElementsPositionByPositionGuide ().");
       println ("PositionGuide you are adding is not big enough.");
     }
   }
   
   public void SetFixElementsPosition (boolean b) {
     fixElementsPosition = b;
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
   
   public void Transpose () {
     transpose = !transpose;
     if (fixElementsPosition) ActualizeProperties (true);
   }
   
 }