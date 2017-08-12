
 /* Pendientes:
   - Tecla back en el teclado.
   - Vibración en el teclado.
   
   Poca prioridad:
   - Arreglar TextBox.
   - Booleano para el teclado sobre los
   saltos de línea = Shift+Intro.
   
   Bugs:
   
 */
 
 RectButton[] but = new RectButton [10];
 // CheckBox ch;
 // Keyboard kb;
 // TextBox tb;

void setup () {
  //ch = new CheckBox  (300, 1200, 600, 1500);
  orientation (PORTRAIT); // LANDSCAPE si no.
  // kb = new Keyboard ();
  // tb = new TextBox (kb, 300, 700, 600, 1000, 60);
  Relative.onSetup (this);
  for (int i = 0; i<10; i++) but [i] = Relative.RectButton (0.3, i*0.08, 0.6, i*0.08+0.07, str(i));
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