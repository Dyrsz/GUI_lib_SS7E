 // Hago una función TextDisplay o algo así
 // que reciba las coordenadas de un
 // cuadro de texto y allí va introduciendo
 // la string de salida.
 
 // Esa va en una clase a parte, TextBox.
 // Cuando se selecciona ese objeto,
 // aparece el teclado. Pilla la string
 // de texto de la caja y la modifica.
 
 // En el teclado me falta, entonces,
 // una función Set/GetString. Y la función
 // pulsar intro activa un booleano,
 // como en firstframePressed de los
 // RectButton, que depende de lo que
 // quiera hacer.
 
 // En la clase TextBox, función
 // SetText, GetText. Cuando On (), 
 // se activa el teclado que la edita.

  class Keyboard {
    // Orientado vertical
    boolean show;
    RectButton [] bt = new RectButton [115];
    float w = float (width);
    float h = float (height);
    float he = 3*h/5;
    float hi = 2*h/5;
    int i1;
    int time;
    byte shift;
    boolean sym;
    boolean [] til = new boolean [10];
    int [] indTil = {20, 12, 17, 18, 16, 54, 46, 51, 52, 50};
    int indTilLen = indTil.length;
    char [] qwe = {'q','w','e','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','ñ','z','x','c','v','b','n','m'};
    char [] QWE = {'Q','W','E','R','T','Y','U','I','O','P','A','S','D','F','G','H','J','K','L','Ñ','Z','X','C','V','B','N','M'};
    char [] csym = {'+','×','÷','=','%','_','€','¡','!','-','@','#','$','/','^','&','*','¿','?','~','(',')','"','<','>','[',']','{','}'};
    char [] ctil = {'á','é','í','ó','ú','Á','É','Í','Ó','Ú'};
    String sal = "";
    boolean intro;
    boolean hideable;
    
    Keyboard () {
      // 1a fila. Números.
      for (float i = 0; i < 10; i++) {
        i1 = int (i);
        if (i1 == 0) {
          bt [0] = new RectButton (int (2*w/(11*13)+9*(w/11+w/(11*13))), int (he + 2*hi/(6*11)), int (2*w/(11*13)+w/11+9*(w/11+w/(11*13))), int (he + 2*hi/(6*11) + hi/6), "0", 80);
        } else {
          bt [i1] = new RectButton (int (2*w/(11*13)+(i-1)*(w/11+w/(11*13))), int (he + 2*hi/(6*11)), int (2*w/(11*13)+w/11+(i-1)*(w/11+w/(11*13))), int (he + 2*hi/(6*11) + hi/6), str (i1), 80);
        }
      }
      // Decido no poner los botones como en el teclado de Android.
      for (float i = 0; i < 10; i++) {
        i1 = int (i);
        bt [i1+10] = new RectButton (int (2*w/(11*13)+i*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + hi/6), int (2*w/(11*13)+w/11+i*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + 2*hi/6), str (qwe [i1]), 80);
        bt [i1+20] = new RectButton (int (2*w/(11*13)+i*(w/11+w/(11*13))), int (he + 5*hi/(6*11) + 2*hi/6), int (2*w/(11*13)+w/11+i*(w/11+w/(11*13))), int (he + 5*hi/(6*11) + 3*hi/6), str (qwe [i1+10]), 80);
        if (i < 7) bt [i1+30] = new RectButton (int (4*w/(11*13) + 19*w/143 + i*(w/11+w/(11*13))), int (he + 6*hi/(6*11) + 3*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143+i*(w/11+w/(11*13))), int (he + 6*hi/(6*11) + 4*hi/6), str (qwe [i1+20]), 80);
        bt [i1+44] = new RectButton (int (2*w/(11*13)+i*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + hi/6), int (2*w/(11*13)+w/11+i*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + 2*hi/6), str (QWE [i1]), 80);
        bt [i1+54] = new RectButton (int (2*w/(11*13)+i*(w/11+w/(11*13))), int (he + 5*hi/(6*11) + 2*hi/6), int (2*w/(11*13)+w/11+i*(w/11+w/(11*13))), int (he + 5*hi/(6*11) + 3*hi/6), str (QWE [i1+10]), 80);
        if (i < 7) bt [i1+64] = new RectButton (int (4*w/(11*13) + 19*w/143 + i*(w/11+w/(11*13))), int (he + 6*hi/(6*11) + 3*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143+i*(w/11+w/(11*13))), int (he + 6*hi/(6*11) + 4*hi/6), str (QWE [i1+20]), 80);
      }
      // Estos salen siempre.
      bt [37] = new RectButton (int (4*w/(11*13) + 19*w/143 + w/11 + w/(11*13)), int (he + 7*hi/(6*11) + 4*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143 + 5*(w/11+w/(11*13))), int (he + 7*hi/(6*11) + 5*hi/6), "");
      bt [38] = new RectButton (int (w - (2*w/(11*13) + 19*w/143)), int (he + 7*hi/(6*11) + 4*hi/6), int (w - 2*w/(11*13)), int (he + 7*hi/(6*11) + 5*hi/6), "Intro", 50);
      bt [39] = new RectButton (int (w - (2*w/(11*13) + 19*w/143)), int (he + 6*hi/(6*11) + 3*hi/6), int (w - 2*w/(11*13)), int (he + 6*hi/(6*11) + 4*hi/6), "《--", 70);
      // shift = 0, !sym:
      bt [40] = new RectButton (int (2*w/(11*13)), int (he + 6*hi/(6*11) + 3*hi/6), int (2*w/(11*13) + 19*w/143), int (he + 6*hi/(6*11) + 4*hi/6), "Shift", 50);
      bt [41] = new RectButton (int (2*w/(11*13)), int (he + 7*hi/(6*11) + 4*hi/6), int (2*w/(11*13) + 19*w/143), int (he + 7*hi/(6*11) + 5*hi/6), "Sym", 60);
      bt [42] = new RectButton (int (4*w/(11*13) + 19*w/143), int (he + 7*hi/(6*11) + 4*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143), int (he + 7*hi/(6*11) + 5*hi/6), ",", 100);
      bt [43] = new RectButton (int (4*w/(11*13) + 19*w/143 + 6*(w/11+w/(11*13))), int (he + 7*hi/(6*11) + 4*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143+6*(w/11+w/(11*13))), int (he + 7*hi/(6*11) + 5*hi/6), ".", 100);
      // shift = 1, !sym:
      bt [71] = new RectButton (int (4*w/(11*13) + 19*w/143), int (he + 7*hi/(6*11) + 4*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143), int (he + 7*hi/(6*11) + 5*hi/6), ";", 100);
      bt [72] = new RectButton (int (4*w/(11*13) + 19*w/143 + 6*(w/11+w/(11*13))), int (he + 7*hi/(6*11) + 4*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143+6*(w/11+w/(11*13))), int (he + 7*hi/(6*11) + 5*hi/6), ":", 100);
      // sym:
      for (float i = 0; i < 10; i++) {
        i1 = int (i);
        bt [i1+73] = new RectButton (int (2*w/(11*13)+i*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + hi/6), int (2*w/(11*13)+w/11+i*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + 2*hi/6), str (csym [i1]), 80);
        bt [i1+83] = new RectButton (int (2*w/(11*13)+i*(w/11+w/(11*13))), int (he + 5*hi/(6*11) + 2*hi/6), int (2*w/(11*13)+w/11+i*(w/11+w/(11*13))), int (he + 5*hi/(6*11) + 3*hi/6), str (csym [i1+10]), 80);
        if (i < 7) bt [i1+93] = new RectButton (int (4*w/(11*13) + 19*w/143 + i*(w/11+w/(11*13))), int (he + 6*hi/(6*11) + 3*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143+i*(w/11+w/(11*13))), int (he + 6*hi/(6*11) + 4*hi/6), str (csym [i1+20]), 80);
      }
      bt [100] = new RectButton (int (4*w/(11*13) + 19*w/143), int (he + 7*hi/(6*11) + 4*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143), int (he + 7*hi/(6*11) + 5*hi/6), str (csym [27]), 100);
      bt [101] = new RectButton (int (4*w/(11*13) + 19*w/143 + 6*(w/11+w/(11*13))), int (he + 7*hi/(6*11) + 4*hi/6), int (w/11 + 4*w/(11*13) + 19*w/143+6*(w/11+w/(11*13))), int (he + 7*hi/(6*11) + 5*hi/6), str (csym [28]), 100);
      bt [102] = new RectButton (int (2*w/(11*13)), int (he + 7*hi/(6*11) + 4*hi/6), int (2*w/(11*13) + 19*w/143), int (he + 7*hi/(6*11) + 5*hi/6), "ABC", 60);
      bt [103] = new RectButton (int (2*w/(11*13)), int (he + 6*hi/(6*11) + 3*hi/6), int (2*w/(11*13) + 19*w/143), int (he + 6*hi/(6*11) + 4*hi/6), "", 50);
      // shift mayusc. (shift = 2)
      bt [104] = new RectButton (int (2*w/(11*13)), int (he + 6*hi/(6*11) + 3*hi/6), int (2*w/(11*13) + 19*w/143), int (he + 6*hi/(6*11) + 4*hi/6), "Shift", 50);
      bt [104].SetColorBackground (150);
      // Tildes
      bt [105] = new RectButton (int (2*w/(11*13)), int (he + 5*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11), int (he + 5*hi/(6*11) + 3*hi/6 - 10*hi/(6*11)), "á", 80);
      bt [106] = new RectButton (int (2*w/(11*13)+2*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11+2*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), "é", 80);
      bt [107] = new RectButton (int (2*w/(11*13)+7*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11+7*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), "í", 80);
      bt [108] = new RectButton (int (2*w/(11*13)+8*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11+8*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), "ó", 80);
      bt [109] = new RectButton (int (2*w/(11*13)+6*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11+6*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), "ú", 80);
      bt [110] = new RectButton (int (2*w/(11*13)), int (he + 5*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11), int (he + 5*hi/(6*11) + 3*hi/6 - 10*hi/(6*11)), "Á", 80);
      bt [111] = new RectButton (int (2*w/(11*13)+2*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11+2*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), "É", 80);
      bt [112] = new RectButton (int (2*w/(11*13)+7*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11+7*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), "Í", 80);
      bt [113] = new RectButton (int (2*w/(11*13)+8*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11+8*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), "Ó", 80);
      bt [114] = new RectButton (int (2*w/(11*13)+6*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + hi/6 -10*hi/(6*11)), int (2*w/(11*13)+w/11+6*(w/11+w/(11*13))), int (he + 4*hi/(6*11) + 2*hi/6 -10*hi/(6*11)), "Ú", 80);
    }
    
    void display () {
      if (show) {
        fill (0);
        noStroke ();
        rect (0,0.59*height,width, 0.42*height);
        for (int i = 0; i < 115; i++) bt [i].display ();
        for (int i = 0; i < 10; i++) bt[i].SetHide(false);
        for (int i = 37; i < 40; i++) bt [i].SetHide (false);
        if (shift == 0 && !sym) {
          for (int i = 10; i < 37; i++) bt [i].SetHide (false);
          for (int i = 40; i < 44; i++) bt [i].SetHide (false);
          for (int i = 44; i < 73; i++) bt [i].SetHide (true);
          for (int i = 73; i < 105; i++) bt [i].SetHide (true);
        } else if (shift == 1 && !sym) {
          for (int i = 10; i < 37; i++) bt [i].SetHide (true);
          bt [40].SetHide (false);
          bt [41].SetHide (false);
          bt [42].SetHide (true);
          bt [43].SetHide (true);
          for (int i = 44; i < 73; i++) bt [i].SetHide (false);
          for (int i = 73; i < 105; i++) bt [i].SetHide (true);
        } else if (shift == 2 && !sym) {
          for (int i = 10; i < 37; i++) bt [i].SetHide (true);
          bt [40].SetHide (true);
          bt [41].SetHide (false);
          bt [42].SetHide (true);
          bt [43].SetHide (true);
          for (int i = 44; i < 73; i++) bt [i].SetHide (false);
          for (int i = 73; i < 104; i++) bt [i].SetHide (true);
          bt [104].SetHide (false);
        } else if (sym) {
          for (int i = 10; i < 37; i++) bt [i].SetHide (true);
          for (int i = 40; i < 73; i++) bt [i].SetHide (true);
          for (int i = 73; i < 104; i++) bt [i].SetHide (false);
          bt [104].SetHide (true);
        } 
        for (int i = 0; i < 10; i++) {
          if (til [i]) {
            bt [105+i].SetHide (false);
          } else {
            bt [105+i].SetHide (true);
          }
        }
        line (100, 3*height/5, width-100, 3*height/5);
      }
      // Condicionales:
      if (show) {
        // Capas para los botones de tildes.
        for (int i = 105; i < 115; i++) {
          if (bt [i].pressed()) {
            if (i == 105) bt [10].SetActive (false);
            if (i == 106 || i == 111) bt [3].SetActive (false);
            if (i == 107 || i == 112) bt [8].SetActive (false);
            if (i == 108 || i == 113) bt [9].SetActive (false);
            if (i == 109 || i == 114) bt [7].SetActive (false);
            if (i == 110) bt [44].SetActive (false);
          }
        }
        for (int i = 0; i < 105; i++) {
          if (bt [i].onFirstFramePressed  ()) {
            time = millis ();
            // Desactiva los cuadros de tildes.
            if (i < 105) for (int j = 0; j < 10; j++) {
              if (til [j]) til [j] = false;
            }
          }
          if (bt [i].pressed ()) {
          // Activa los cuadros de tildes.
            for (int j = 0; j < indTilLen; j++) {
              if (i == indTil [j]) {
                if (millis () > time+400) {
                  til [j] = true;
                }
              }
            }
          }
        }
        
      }
    }
    
    void released () {
      if (show) {
        intro = false;
        if (bt [40].on ()) {
          if (shift == 0) {
            shift = 1;
          } else {
            shift = 2;
          }
        }
        if (bt [104].on ()) {
          shift = 0;
        }
        if (bt [41].on ()) {
          sym = true;
          shift = 0;
        }
        if (bt [102].on ()) {
          sym = false;
        }
        for (int i = 0; i < 10; i++)
          if (bt [i].on ()) sal = sal + str (i);
        for (int i = 0; i < 27; i++) {
          if (bt [10+i].on ()) sal = sal + qwe [i];
          if (bt [44+i].on ()) {
            sal = sal + QWE [i];
            if (shift == 1) shift = 0;
          }
          if (bt [73+i].on ()) sal = sal + csym [i];
        }
        if (bt [37].on ()) sal = sal + ' ';
        if (bt [38].on ()) intro = true; // Intro.
        if (bt [39].on ()) { // Borrar
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
        if (bt [42].on ()) sal = sal + ',';
        if (bt [43].on ()) sal = sal + '.';
        if (bt [71].on ()) {
          sal = sal + ';';
          if (shift == 1) shift = 0;
        }
        if (bt [72].on ()) {
          sal = sal + ':';
          if (shift == 1) shift = 0;
        }
        if (bt [100].on ()) sal = sal + csym [27];
        if (bt [101].on ()) sal = sal + csym [28];
        for (int i = 0; i < 10; i++)
          if (bt [105+i].on ()) sal = sal + ctil [i];
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
    
    public boolean Intro () {
      return intro;
    }
    
    public String GetString () {
      return sal;
    }
    
    public void SetString (String stri) {
      sal = stri;
    }
  }
