
 // RectButton but;
 // CheckBox ch;
 Keyboard kb;
 String st = "";

void setup () {
  //but = new RectButton (300, 200, 1500, 1000, "Test");
  //ch = new CheckBox  (300, 1200, 600, 1500);
  kb = new Keyboard ();
  kb.SetHide(false);
  
}

void draw () {
  background (0);
 
  //ch.display ();
  kb.display ();
  
  if (kb.Intro()) st = kb.GetString();
  //st = kb.GetString ();
  fill (255);
  if (!st.equals ("")) text (st, 50, 200); 
  //text (19272, 50, 400);
  
}

void mousePressed () {
  
  //ch.pressed ();
}

void mouseReleased () {
  kb.released ();
}