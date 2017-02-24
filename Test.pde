
 /* Pendientes:
   Inheritance de RectButton y TextBox.
  
   Bugs:
   El shift2 del teclado no se ilumuna.
 */
 
 RectButton[] but = new RectButton [10];
 // CheckBox ch;
 Keyboard kb;
 TextBox tb;
 //String st = "Hola";

void setup () {
  //but = new RectButton (300, 200, 1500, 1000, "Test");
  //ch = new CheckBox  (300, 1200, 600, 1500);
  kb = new Keyboard ();
  tb = new TextBox (kb, 300, 700, 600, 1000, 60);
}

void draw () {
  background (0);
 
  //ch.display ();
  kb.display ();
  tb.display ();
  //st = kb.GetString ();
  //fill (255);
  //if (!st.equals ("")) text (st, 50, 200); 
  
}

void mousePressed () {
  
  //ch.pressed ();
}

void mouseReleased () {
  kb.released ();
  tb.released ();
}