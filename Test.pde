
 /* Pendientes:
   - Tecla back en el teclado.
   - Vibración en el teclado.
   
   Poca prioridad:
   - Arreglar TextBox.
   - Booleano para el teclado sobre los
   saltos de línea = Shift+Intro.
   
   Esto es una prueba de escritura con el teclado
   Byone. Mola muchisimo. Aunque parece que no
   puedo escribir las tildes bien aquí.
   Bugs:
   
 */
 
 PositionGuide pg;
 RectButton[] but = new RectButton [10];
 // CheckBox ch;
 // Keyboard kb;
 // TextBox tb;

void setup () {
  //ch = new CheckBox  (300, 1200, 600, 1500);
  orientation (PORTRAIT); // LANDSCAPE si no.
  // kb = new Keyboard ();
  // tb = new TextBox (kb, 300, 700, 600, 1000, 60);
  pg = new PositionGuide ("Column", "Relative", "UniformDistribution");
  pg.SetOffset (0.35, 0.35, 0.2, 0.2);
  pg.Generate ();
  //Relative.onSetup (this);
  for (int i = 0; i<10; i++) but [i] = RectButton (pg.GetColumnCoord (i), str(i));
}

void draw () {
  background (0);
 
  // ch.display ();
  // kb.display ();
  // kb.SetHide (false);
  // tb.display ();
  
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