
 RectButton[] but = new RectButton [10];
 // CheckBox ch;
 // Keyboard kb;
 String st = "Hola";

void setup () {
  //but = new RectButton (300, 200, 1500, 1000, "Test");
  //ch = new CheckBox  (300, 1200, 600, 1500);
  //kb = new Keyboard ();
  //kb.SetHide(false);
  for (int i = 0; i < 10; i++) {
    but [i] = new RectButton (100, (i+1)*height/12, width-100, (i+2)*height/12, st, 10*(i+1));
  }
  
}

void draw () {
  background (0);
 for (int i = 0; i < 10; i++) but [i].display ();
  //ch.display ();
  //kb.display ();
  //st = kb.GetString ();
  //fill (255);
  //if (!st.equals ("")) text (st, 50, 200); 
  
}

void mousePressed () {
  
  //ch.pressed ();
}

void mouseReleased () {
  //kb.released ();
}