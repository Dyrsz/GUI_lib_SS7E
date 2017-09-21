
 /* Pendientes:
   
   // UIElement.
   
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
 
 //PositionGuide pg;
 UIButton but; // = new RectButton [10];
 SelectParameter pp, spX, spY, spNP, spTS;
 // CheckBox ch;
 // Keyboard kb;
 // TextBox tb;
 int x, y, ts;
 String np;

void setup () {
  //ch = new CheckBox  (300, 1200, 600, 1500);
  orientation (PORTRAIT); // LANDSCAPE si no.
  // kb = new Keyboard ();
  // tb = new TextBox (kb, 300, 700, 600, 1000, 60);
  /*
  pg = new PositionGuide ("Column", "Relative", "UniformDistribution");
  pg.SetOffset (0.35, 0.35, 0.2, 0.2);
  pg.SetColumnLength (10);
  pg.Generate ();
  //Relative.onSetup (this);
  for (int i = 0; i<10; i++) but [i] = new RectButton (pg.GetColumnCoord (i), str(i));
  */
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
  
  /*
  for (int i = 0; i < 10; i++) {
    but [i].display ();
    if (but[i].sincePressedMillisMod (50*i +50)) {
      fill (200, 0, 0);
      rect (1000, i*200, 300, 150);
    }
  }
  */
  //println (height + "; " + width);
}

void mousePressed () {
  
  //ch.pressed ();
}

void mouseReleased () {
  // kb.released ();
  // tb.released ();
}