
 /* Pendientes:
 
   - Layers.
   
   - Arreglar teclado, teclado como Layer.
   
   - Tecla back en el teclado.
   - Vibración en el teclado.
   - Checkboxs.
   - Menús.
   
   - Animaciones.
   
   - ¿Alguna forma de hacer un enlace con SelectParameter?
   
   Poca prioridad:
   - Arreglar TextBox.
   - Booleano para el teclado sobre los
   saltos de línea = Shift+Intro.
   
   Bugs:
   
 */
 
 // Test Sub/Super Layers.
 UILayer [] lay = new UILayer [5];
 int [][][] subSupers;
 
 void setup () {
   orientation (PORTRAIT);
   
   for (int i = 0; i < 5; i++) {
    lay [i] = new UILayer (100, 100 + 200*i, 800, 250 + 200*i);
    lay [i].SetText ("Lay " + str (lay [i].GetUI_ID()));
   }
  
   UILayer [] lays = {lay [1], lay [3]};
   lay [0].AddElements (lays);
   lay [1].AddElement (lay [2]);
   lay [0].ClearElements (true);
  
   subSupers = new int [5][2][5];
   for (int i = 0; i < 5; i++)
     for (int j = 0; j < 5; j++) {
       if (j < lay [i].GetNumberSubLayers()) subSupers [i][0][j] = lay [i].GetSubLayers ()[j].GetUI_ID ();
       if (j < lay [i].GetNumberSuperLayers()) subSupers [i][1][j] = lay [i].GetSuperLayers ()[j].GetUI_ID ();
     }
   
 }
 
 void draw () {
   background (0);
  
   for (int i = 0; i < 5; i++) {
     lay [i].display ();
   }
   //UI_IDRecolector.SearchUIByID (1).SetColorBackground (color (50, 0, 0));
   //UI_IDRecolector.SearchUIByID (1).SetColorBackground (color (50, 0, 0));
  
   for (int i = 0; i < 5; i++) {
     text ("Lay " + str (i+1) + " sublayers: " , 200, 1200+150*i);
     text ("Lay " + str (i+1) + " superlayers: " , 200, 1270+150*i);
     for (int j = 0; j < 5; j++) {
       text (str (subSupers [i][0][j]), 700+50*j, 1200+150*i);
       text (str (subSupers [i][1][j]), 700+50*j, 1270+150*i);
     }
   }
  
   //text (str(UI_IDRecolector.GetUI_IDs ()), 300, 2200);
   
 }

 /*
 //PositionGuide pg;
 //UIButton but; // = new RectButton [10];
 //SelectParameter pp, spX, spY, spNP, spTS;
 // CheckBox ch;
 //Keyboard kb;
 // TextBox tb;
 //UIElement test;

 
 void setup () {
   //ch = new CheckBox  (300, 1200, 600, 1500);
   orientation (PORTRAIT); // LANDSCAPE si no.
   //kb = new Keyboard ();
   //test = UI_IDRecolector.SearchUIByID (1);
   //test.SetColorBackground (color (200, 0, 0));
   // tb = new TextBox (kb, 300, 700, 600, 1000, 60);
  
   pg = new PositionGuide ("Column", "Relative", "UniformDistribution");
   pg.SetOffset (0.35, 0.35, 0.2, 0.2);
   pg.SetColumnLength (10);
   pg.Generate ();
   //Relative.onSetup (this);
   for (int i = 0; i<10; i++) but [i] = new RectButton (pg.GetColumnCoord (i), str(i));
  
   x = 200;
   y = 100;
  
   but = new UIButton (500, 300, 500+x, 300+y, "Button");
   pp = new SelectParameter ("SelectParameter", "StringList", 500, 600);
  
   spX = new SelectParameter ("Length X", "Int", 300, 1200);
   spX.SetIntValue (x);
   spX.SetButtonsAceleration (60);
   spX.SetButtonsLimit (1);
   spY = new SelectParameter ("Length Y", "Int", 800, 1200);
   spY.SetIntValue (y);
   spY.SetButtonsAceleration (60);
   spY.SetButtonsLimit (1);
   spNP = new SelectParameter ("NamePosition", "StringList", 300, 1500);
   String [] st = {"Top", "Left"};
   spNP.SetStringList (st);
   spTS = new SelectParameter ("TextSize", "Int", 800, 1500);
   spTS.SetIntValue (but.GetTextSize ());
   spTS.SetButtonsAceleration (60);
   spTS.SetButtonsLimit (100);
  
 }

 void draw () {
   background (0);
  
   // ch.display ();
   // kb.display ();
   // kb.SetHide (false);
   // tb.display ();
   
   but.display ();
  
   pp.display ();
   spX.display ();
   if (spX.changeValue ()) {
     x = spX.GetIntValue ();
     but.SetLengthX (x);
   }
   spY.display ();
   if (spY.changeValue ()) {
     y = spY.GetIntValue ();
     but.SetLengthY (y);
   }
   spNP.display ();
   if (spNP.changeValue ()) {
     np = spNP.GetStringValue ();
     pp.SetNamePosition (np);
     pp.ActualizeElements ();
   }
   spTS.display ();
   if (spTS.changeValue ()) {
     ts = spTS.GetIntValue ();
     but.SetTextSize (ts);
   }
  
   for (int i = 0; i < 10; i++) {
     but [i].display ();
     if (but[i].sincePressedMillisMod (50*i +50)) {
       fill (200, 0, 0);
       rect (1000, i*200, 300, 150);
     }
   }
  //println (height + "; " + width);
 }

 void mousePressed () {
   //ch.pressed ();
 }

 void mouseReleased () {
   // kb.released ();
   // tb.released ();
 }
 */