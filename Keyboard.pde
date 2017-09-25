  
  class Keyboard {
    // Vertical orientation
    // private boolean show; later
    private UIButton [] buttons = new UIButton [115];
    private float height_exterior = 0.6;
    private float height_interior = 0.4;
    // No me pongo a sustituir, que sería una pérdida de tiempo.
    // Busco alguna captura que tuviera y me apaño con PositionGuides.
    private PositionGuide pg_numbers;
    // Arreglar todo esto...
    int time;
    byte shift;
    boolean sym;
    boolean [] til = new boolean [10];
    int [] indTil = {20, 12, 17, 18, 16, 54, 46, 51, 52, 50};
    int indTilLen = indTil.length;
    char [] qwe = {'q','w','e','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','ñ','z','x','c','v','b','n','m'};
    char [] QWE = {'Q','W','E','R','T','Y','U','I','O','P','A','S','D','F','G','H','J','K','L','Ñ','Z','X','C','V','B','N','M'};
    char [] csym = {'+','×','÷','=','%','_','€','¡','!','-','@','#','$','/','^','&','*','¿','?','~','(',')','"','<','>','[',']','{','}'};
    //char [] ctil = {'á','é','í','ó','ú','Á','��','Í','Ó','Ú'};
    String sal = "";
    boolean intro;
    boolean hideable;
    // Auxiliars.
    //private int i1;
    
    Keyboard () {
      float widthOffSet = 2.0 / (11.0 * 13.0);
      int buttonsHeight = int (height*height_interior/6.0);
      pg_numbers = new PositionGuide ("Row", "Relative", "UniformDistribution");
      pg_numbers.SetOffset (widthOffSet, widthOffSet, height_exterior + 2*height_interior/(6*11), 0);
      pg_numbers.SetRowLength (10);
      pg_numbers.Generate ();
      
      buttons [0] = new UIButton (pg_numbers.GetRowCoord (9), "0");
      for (int i = 1; i < 10; i++) {
        buttons [i] = new UIButton (pg_numbers.GetRowCoord (i-1), str (i));
      }
      
      for (int i = 0; i < 10; i++) {
        buttons [i].SetLengthY (buttonsHeight);
        buttons [i].SetTextSize (80);
      }
      /*
      // First row. Numbers.
      for (float i = 0; i < 10; i++) {
        i1 = int (i);
        if (i1 == 0) {
          buttons [0] = new RectButton (int (2*w/(11*13)+9*(w/11+w/(11*13))), int (height_exterior + 2*hi/(6*11)), int (2*w/(11*13)+w/11+9*(w/11+w/(11*13))), int (height_exterior + 2*hi/(6*11) + hi/6), "0", 80);
        } else {
          buttons [i1] = new RectButton (int (2*w/(11*13)+(i-1)*(w/11+w/(11*13))), int (height_exterior + 2*hi/(6*11)), int (2*w/(11*13)+w/11+(i-1)*(w/11+w/(11*13))), int (height_exterior + 2*hi/(6*11) + hi/6), str (i1), 80);
        }
      }
      // Is not like the Android Keyboard.
      for (float i = 0; i < 10; i++) {
        i1 = int (i);
        buttons [i1+10] = new RectButton (int (2*w/(11*13)+i*(w/11+w/(11*13))), int (height_exterior + 4*hi/(6*11) + hi/6), int (2*w/(11*13)+w/11+i*(w/11+w/(11*13))), int (height_exterior + 4*hi/(6*11) + 2*hi/6), str (qwe [i1]), 80);
        buttons [i1+20] = new RectButton (int (2*w/(11*13)+i*(w/11+w/(11*13))), int (height_exterior + 5*hi/(6*11) + 2*hi/6), int (2*w/(11*13)+w/11+i*(w/11+w/(11*13))), int (height_exterior + 5*hi/(6*11) + 3*hi/6), str (qwe [i1+10]), 80);
        if (i < 7) buttons [i1+30] = new RectButton (int (4*w/(11*13) + 19*w/143 + i*(w/11+w/(11*13))), int (height_exterior + 6*hi/(6*11) + 3*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143+i*(w/11+w/(11*13))), int (height_exterior + 6*hi/(6*11) + 4*hi/6), str (qwe [i1+20]), 80);
        buttons [i1+44] = new RectButton (int (2*w/(11*13)+i*(w/11+w/(11*13))), int (height_exterior + 4*hi/(6*11) + hi/6), int (2*w/(11*13)+w/11+i*(w/11+w/(11*13))), int (height_exterior + 4*hi/(6*11) + 2*hi/6), str (QWE [i1]), 80);
        buttons [i1+54] = new RectButton (int (2*w/(11*13)+i*(w/11+w/(11*13))), int (height_exterior + 5*hi/(6*11) + 2*hi/6), int (2*w/(11*13)+w/11+i*(w/11+w/(11*13))), int (height_exterior + 5*hi/(6*11) + 3*hi/6), str (QWE [i1+10]), 80);
        if (i < 7) buttons [i1+64] = new RectButton (int (4*w/(11*13) + 19*w/143 + i*(w/11+w/(11*13))), int (height_exterior + 6*hi/(6*11) + 3*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143+i*(w/11+w/(11*13))), int (height_exterior + 6*hi/(6*11) + 4*hi/6), str (QWE [i1+20]), 80);
      }
      // These are shown always.
      buttons [37] = new RectButton (int (4*w/(11*13) + 19*w/143 + w/11 + w/(11*13)), int (height_exterior + 7*hi/(6*11) + 4*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143 + 5*(w/11+w/(11*13))), int (height_exterior + 7*hi/(6*11) + 5*hi/6), "");
      buttons [38] = new RectButton (int (w - (2*w/(11*13) + 19*w/143)), int (height_exterior + 7*hi/(6*11) + 4*hi/6), int (w - 2*w/(11*13)), int (height_exterior + 7*hi/(6*11) + 5*hi/6), "Intro", 50);
      buttons [39] = new RectButton (int (w - (2*w/(11*13) + 19*w/143)), int (height_exterior + 6*hi/(6*11) + 3*hi/6), int (w - 2*w/(11*13)), int (height_exterior + 6*hi/(6*11) + 4*hi/6), "《--", 70);
      // shift = 0, !sym:
      buttons [40] = new RectButton (int (2*w/(11*13)), int (he + 6*hi/(6*11) + 3*hi/6), int (2*w/(11*13) + 19*w/143), int (height_exterior + 6*hi/(6*11) + 4*hi/6), "Shift", 50);
      buttons [41] = new RectButton (int (2*w/(11*13)), int (he + 7*hi/(6*11) + 4*hi/6), int (2*w/(11*13) + 19*w/143), int (height_exterior + 7*hi/(6*11) + 5*hi/6), "Sym", 60);
      buttons [42] = new RectButton (int (4*w/(11*13) + 19*w/143), int (he + 7*hi/(6*11) + 4*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143), int (height_exterior + 7*hi/(6*11) + 5*hi/6), ",", 100);
      buttons [43] = new RectButton (int (4*w/(11*13) + 19*w/143 + 6*(w/11+w/(11*13))), int (height_exterior + 7*hi/(6*11) + 4*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143+6*(w/11+w/(11*13))), int (height_exterior + 7*hi/(6*11) + 5*hi/6), ".", 100);
      // shift = 1, !sym:
      buttons [71] = new RectButton (int (4*w/(11*13) + 19*w/143), int (height_exterior + 7*hi/(6*11) + 4*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143), int (height_exterior + 7*hi/(6*11) + 5*hi/6), ";", 100);
      buttons [72] = new RectButton (int (4*w/(11*13) + 19*w/143 + 6*(w/11+w/(11*13))), int (height_exterior + 7*hi/(6*11) + 4*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143+6*(w/11+w/(11*13))), int (height_exterior + 7*hi/(6*11) + 5*hi/6), ":", 100);
      // sym:
      for (float i = 0; i < 10; i++) {
        i1 = int (i);
        buttons [i1+73] = new RectButton (int (2*w/(11*13)+i*(w/11+w/(11*13))), int (height_exterior + 4*hi/(6*11) + hi/6), int (2*w/(11*13)+w/11+i*(w/11+w/(11*13))), int (height_exterior + 4*hi/(6*11) + 2*hi/6), str (csym [i1]), 80);
        buttons [i1+83] = new RectButton (int (2*w/(11*13)+i*(w/11+w/(11*13))), int (height_exterior + 5*hi/(6*11) + 2*hi/6), int (2*w/(11*13)+w/11+i*(w/11+w/(11*13))), int (height_exterior + 5*hi/(6*11) + 3*hi/6), str (csym [i1+10]), 80);
        if (i < 7) buttons [i1+93] = new RectButton (int (4*w/(11*13) + 19*w/143 + i*(w/11+w/(11*13))), int (height_exterior + 6*hi/(6*11) + 3*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143+i*(w/11+w/(11*13))), int (height_exterior + 6*hi/(6*11) + 4*hi/6), str (csym [i1+20]), 80);
      }
      buttons [100] = new RectButton (int (4*w/(11*13) + 19*w/143), int (height_exterior + 7*hi/(6*11) + 4*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143), int (height_exterior + 7*hi/(6*11) + 5*hi/6), str (csym [27]), 100);
      buttons [101] = new RectButton (int (4*w/(11*13) + 19*w/143 + 6*(w/11+w/(11*13))), int (height_exterior + 7*hi/(6*11) + 4*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143+6*(w/11+w/(11*13))), int (height_exterior + 7*hi/(6*11) + 5*hi/6), str (csym [28]), 100);
      buttons [102] = new RectButton (int (2*w/(11*13)), int (height_exterior + 7*hi/(6*11) + 4*hi/6), int (2*w/(11*13) + 19*w/143), int (height_exterior + 7*hi/(6*11) + 5*hi/6), "ABC", 60);
      buttons [103] = new RectButton (int (2*w/(11*13)), int (height_exterior + 6*hi/(6*11) + 3*hi/6), int (2*w/(11*13) + 19*w/143), int (height_exterior + 6*hi/(6*11) + 4*hi/6), "", 50);
      // shift, capital letters (shift = 2)
      buttons [104] = new RectButton (int (2*w/(11*13)), int (height_exterior + 6*hi/(6*11) + 3*hi/6), int (2*w/(11*13) + 19*w/143), int (height_exterior + 6*hi/(6*11) + 4*hi/6), "Shift", 50);
      buttons [104].SetColorBackground (150);
      buttons [104].SetColorBackOn (150);
      // Accent marks.
      buttons [105] = new RectButton (int (2*w/(11*13)), int (height_exterior + 5*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11), int (he + 5*hi/(6*11) + 3*hi/6 - 10*hi/(6*11)), "á", 80);
      buttons [106] = new RectButton (int (2*w/(11*13)+2*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11+2*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), "é", 80);
      buttons [107] = new RectButton (int (2*w/(11*13)+7*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11+7*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), "í", 80);
      buttons [108] = new RectButton (int (2*w/(11*13)+8*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11+8*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), "ó", 80);
      buttons [109] = new RectButton (int (2*w/(11*13)+6*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11+6*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), "ú", 80);
      buttons [110] = new RectButton (int (2*w/(11*13)), int (he + 5*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11), int (he + 5*hi/(6*11) + 3*hi/6 - 10*hi/(6*11)), "Á", 80);
      buttons [111] = new RectButton (int (2*w/(11*13)+2*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11+2*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), "É", 80);
      buttons [112] = new RectButton (int (2*w/(11*13)+7*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11+7*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), "Í", 80);
      buttons [113] = new RectButton (int (2*w/(11*13)+8*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11+8*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), "Ó", 80);
      buttons [114] = new RectButton (int (2*w/(11*13)+6*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11+6*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), "Ú", 80);
      for (int i = 0; i < 115; i++) buttons [i].SetHide (true);
      */
    
    }
    
    public void display () {
      for (int i = 0; i < 10; i++) buttons [i].display ();
      
      /*
      if (show) {
        fill (0);
        noStroke ();
        rect (0,0.59*height,width, 0.42*height);
        for (int i = 0; i < 115; i++) buttons [i].display ();
        for (int i = 0; i < 10; i++) buttons [i].SetHide(false);
        for (int i = 37; i < 40; i++) buttons [i].SetHide (false);
        if (shift == 0 && !sym) {
          for (int i = 10; i < 37; i++) buttons [i].SetHide (false);
          for (int i = 40; i < 44; i++) buttons [i].SetHide (false);
          for (int i = 44; i < 73; i++) buttons [i].SetHide (true);
          for (int i = 73; i < 105; i++) buttons [i].SetHide (true);
        } else if (shift == 1 && !sym) {
          for (int i = 10; i < 37; i++) buttons [i].SetHide (true);
          buttons [40].SetHide (false);
          buttons [41].SetHide (false);
          buttons [42].SetHide (true);
          buttons [43].SetHide (true);
          for (int i = 44; i < 73; i++) buttons [i].SetHide (false);
          for (int i = 73; i < 105; i++) buttons [i].SetHide (true);
        } else if (shift == 2 && !sym) {
          for (int i = 10; i < 37; i++) buttons [i].SetHide (true);
          buttons [40].SetHide (true);
          buttons [41].SetHide (false);
          buttons [42].SetHide (true);
          buttons [43].SetHide (true);
          for (int i = 44; i < 73; i++) buttons [i].SetHide (false);
          for (int i = 73; i < 104; i++) buttons [i].SetHide (true);
          buttons [104].SetHide (false);
        } else if (sym) {
          for (int i = 10; i < 37; i++) buttons [i].SetHide (true);
          for (int i = 40; i < 73; i++) buttons [i].SetHide (true);
          for (int i = 73; i < 104; i++) buttons [i].SetHide (false);
          buttons [104].SetHide (true);
        } 
        for (int i = 0; i < 10; i++) {
          if (til [i]) {
            buttons [105+i].SetHide (false);
          } else {
            buttons [105+i].SetHide (true);
          }
        }
        line (100, 3*height/5, width-100, 3*height/5);
      }
      // Conditionals:
      if (show) {
        // Layers for accent marks' buttons.
        for (int i = 105; i < 115; i++) {
          if (buttons [i].pressed()) {
            if (i == 105) buttons [10].SetActive (false);
            if (i == 106 || i == 111) buttons [3].SetActive (false);
            if (i == 107 || i == 112) buttons [8].SetActive (false);
            if (i == 108 || i == 113) buttons [9].SetActive (false);
            if (i == 109 || i == 114) buttons [7].SetActive (false);
            if (i == 110) buttons [44].SetActive (false);
          }
        }
        for (int i = 0; i < 105; i++) {
          if (buttons [i].onFirstFramePressed ()) {
            time = millis ();
            // Dissable accent marks.
            if (i < 105) for (int j = 0; j < 10; j++) { // ?
              if (til [j]) til [j] = false;
            }
          }
          if (buttons [i].pressed ()) {
          // Enable accent marks.
            for (int j = 0; j < indTilLen; j++) {
              if (i == indTil [j]) {
                if (millis () > time+400) {
                  til [j] = true;
                }
              }
            }
          }
          if (buttons [39].onMillisSincePressed (500)) {
            if (buttons [39].sincePressedMillisMod (80)) pressDelete ();
          }
        }
        
      }
      */
    }
    
    /*
    public String GetString () {
      return sal;
    }
    
    public boolean Intro () {
      return intro;
    }
    
    public boolean isHide () {
      return !show;
    }
    
    public boolean isHideable () {
      return hideable;
    }
    
    public void pressDelete () {
      int l = 0;
      if (sal != null) l = sal.length ();
      if (l == 1) {
        sal = "";
      } else if (l > 1) {
        char [] wc = new char [l-1];
        for (int j = 0; j < l-1; j++) wc [j] = sal.charAt (j);
        sal = str (wc [0]);
        for (int j = 1; j < l-1; j++) sal = sal + wc [j];
      }
    }
    
    public void released () {
      if (show) {
        intro = false;
        if (buttons [40].on ()) {
          if (shift == 0) {
            shift = 1;
          } else {
            shift = 2;
          }
        }
        if (buttons [104].on ()) {
          shift = 0;
        }
        if (buttons [41].on ()) {
          sym = true;
          shift = 0;
        }
        if (buttons [102].on ()) {
          sym = false;
        }
        for (int i = 0; i < 10; i++)
          if (buttons [i].on ()) sal = sal + str (i);
        for (int i = 0; i < 27; i++) {
          if (buttons [10+i].on ()) sal = sal + qwe [i];
          if (buttons [44+i].on ()) {
            sal = sal + QWE [i];
            if (shift == 1) shift = 0;
          }
          if (buttons [73+i].on ()) sal = sal + csym [i];
        }
        if (buttons [37].on ()) sal = sal + ' ';
        if (buttons [38].on ()) intro = true; // Intro.
        if (buttons [39].on ()) pressDelete ();
        if (buttons [42].on ()) sal = sal + ',';
        if (buttons [43].on ()) sal = sal + '.';
        if (buttons [71].on ()) {
          sal = sal + ';';
          if (shift == 1) shift = 0;
        }
        if (buttons [72].on ()) {
          sal = sal + ':';
          if (shift == 1) shift = 0;
        }
        if (buttons [100].on ()) sal = sal + csym [27];
        if (buttons [101].on ()) sal = sal + csym [28];
        for (int i = 0; i < 10; i++)
          if (buttons [105+i].on ()) sal = sal + ctil [i];
        if (hideable) {
          if (mouseY < 0.59*height) show = false;
        }
      }
      for (int i = 0; i < 10; i++) til [i] = false;
    }
    
    public void SetHide (boolean sbol) {
      show = !sbol;
    }
    
    public void SetHideable (boolean sbol) {
      hideable = sbol;
    }
    
    public void SetString (String stri) {
      sal = stri;
    }
    */
  }