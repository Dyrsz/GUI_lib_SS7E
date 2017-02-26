
 /* Pendientes:
   Arreglar TextBox.
   Saltos de línea automáticos.
   Booleano para el teclado sobre los
   saltos de línea = Shift+Intro.
   Tecla back en el teclado.
   Vibración en el teclado.
   
   Bugs:
   
 */
 
 RectButton[] but = new RectButton [10];
 // CheckBox ch;
 Keyboard kb;
 TextBox tb;

void setup () {
  //ch = new CheckBox  (300, 1200, 600, 1500);
  kb = new Keyboard ();
  tb = new TextBox (kb, 300, 700, 600, 1000, 60);
  //for (int i = 0; i<10; i++) but [i] = new RectButton (300, i*200, 700, i*200+150, str(i));
}

void draw () {
  background (0);
 
  //ch.display ();
  kb.display ();
  //kb.SetHide (false);
  tb.display ();
  /*
  for (int i = 0; i <10; i++) {
    but [i].display ();
    if (but[i].sincePressedMillisMod (50*i +50)) {
      fill (200, 0, 0);
      rect (1000, i*200, 300, 150);
    }
  }
  */
}

void mousePressed () {
  
  //ch.pressed ();
}

void mouseReleased () {
  kb.released ();
  tb.released ();
}