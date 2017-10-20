 class SelectParameter {
   
   // Parameters:
   private String parameterType = "Int"; // Int, Float, StringList
   private String parameterName;
   private String namePosition = "Top"; // Top, Left
   private int i_value = 0; // Also index if StringList.
   private int i_increment = 1;
   private int i_decrement = 1;
   private float f_value = 0.0;
   private float f_increment = 1.0;
   private float f_decrement = 1.0;
   private int floatLeftDigits = 2;
   private int floatRightDigits = 1;
   private boolean hasTopLimit;
   private float topLimit = 10;
   private boolean hasBotLimit;
   private float botLimit = 0;
   private int stringListSize = 1;
   private String [] stringList = {" "};
   private String string_value = " ";
   private int coord_x1, coord_y1, coord_x2, coord_y2;
   private int lengthX, lengthY;
   private int textSize = 50;
   private color textColor = color (230);
   private int textSeparationX = 20;
   private int textSeparationY = 20;
   private UIButton [] buttons = new UIButton[2];
   private int buttonsLengthX = 200;
   private int buttonsLengthY = 100;
   private int buttonsSeparationX = 20;
   private int buttonsSeparationY = 10;
   private int buttonsTimeInterval = 400;
   private int buttonsAceleration = 0;
   private int buttonsLimit = 1;
   // Auxiliars:
   private int textLengthAux;
   
   public SelectParameter (String name, String type, int x1, int y1) {
     String tname = name;
     String ttype = type;
     int tx1 = x1;
     int ty1 = y1;
     if (!ttype.equals ("Int") && !ttype.equals ("Float") && !ttype.equals ("StringList")) {
       println ("Bad input on SelectParameter(String name, String type, int,int,int,int).");
       println ("Correct parameter types are 'Int', 'Float' or 'StringList'.");
       println ("Default type set as 'Int'.");
     } else {
       parameterName = tname;
       parameterType = ttype;
       coord_x1 = tx1;
       coord_y1 = ty1;
       buttons [0] = new UIButton ();
       buttons [1] = new UIButton ();
       if (ttype.equals ("Int") || ttype.equals ("Float")) {
         buttons [0].SetText ("+");
         buttons [1].SetText ("-");
       } else {
         buttons [0].SetText (">");
         buttons [1].SetText ("<");
       }
       ActualizeElements ();
     }
   }
   
   public SelectParameter (String name, String type, int [] position) {
     String tname = name;
     String ttype = type;
     int [] tposition = position;
     if (!ttype.equals ("Int") && !ttype.equals ("Float") && !ttype.equals ("StringList")) {
       println ("Bad input on SelectParameter(String name, String type, int[] position).");
       println ("Correct parameter types are 'Int', 'Float' or 'StringList'.");
       println ("Default type set as 'Int'.");
     } else {
       if (tposition.length != 2) {
         println ("Bad input on SelectParameter(String name, String type, int[] position).");
         println ("Position length must have to be two. Default position set as [0,0].");
         coord_x1 = 0;
         coord_y1 = 0;
       } else {
         coord_x1 = tposition [0];
         coord_y1 = tposition [1];
       }
       parameterName = tname;
       parameterType = ttype;
       buttons [0] = new UIButton ();
       buttons [1] = new UIButton ();
       if (ttype.equals ("Int") || ttype.equals ("Float")) {
         buttons [0].SetText ("+");
         buttons [1].SetText ("-");
       } else {
         buttons [0].SetText (">");
         buttons [1].SetText ("<");
       }
       ActualizeElements ();
     }
   }
   
   public void ActualizeElements () {
     textSize (textSize);
     textLengthAux = int(textWidth (parameterName) + textWidth (": "));
     if (parameterType.equals ("Int")) {
       textLengthAux += int (textWidth (str (i_value)));
     } else if (parameterType.equals ("Float")) {
         textLengthAux += int (textWidth (nf (f_value, floatLeftDigits, floatRightDigits)));
     } else {
       textLengthAux += int (textWidth (string_value));
     }
     if (namePosition.equals ("Left")) {
       lengthX = textLengthAux + buttonsLengthX + buttonsSeparationX;
       lengthY = 2*buttonsLengthY + buttonsSeparationY;
       coord_x2 = coord_x1 + lengthX;
       coord_y2 = coord_y1 + lengthY;
       buttons [0].SetPosition (coord_x1 + textLengthAux + textSeparationX, coord_y1, 
       coord_x2, coord_y1 + buttonsLengthY);
       buttons [1].SetPosition (coord_x1 + textLengthAux + textSeparationX, coord_y1 + buttonsLengthY + buttonsSeparationY,
       coord_x2, coord_y2);
       if (parameterType.equals ("Int") || parameterType.equals ("Float")) {
         buttons [0].SetText ("+");
         buttons [0].SetTextSize (50);
         buttons [1].SetText ("-");
       } else {
         buttons [0].SetText ("^");
         buttons [0].SetTextSize (70);
         buttons [0].SetTextYPosition (buttons [0].GetTextPosition ()[1]+7);
         buttons [1].SetText ("v");
       }
     } else {
       lengthX = max (textLengthAux, 2*buttonsLengthX + 15);
       lengthY = textSize + buttonsLengthY + buttonsSeparationY;
       coord_x2 = coord_x1 + lengthX;
       coord_y2 = coord_y1 + lengthY;
       buttons [1].SetPosition (coord_x1 + 5, coord_y1 + textSize + textSeparationY,
       coord_x1 + buttonsLengthX + 5, coord_y2);
       buttons [0].SetPosition (coord_x1 + buttonsLengthX + 15, coord_y1 + textSize + textSeparationY,
       coord_x1 + 2*buttonsLengthX + 15, coord_y2);
       if (parameterType.equals ("Int") || parameterType.equals ("Float")) {
         buttons [0].SetText ("+");
         buttons [1].SetText ("-");
       } else {
         buttons [0].SetText (">");
         buttons [1].SetText ("<");
       }
     }  
   }
   
   public void display () {
     fill (textColor);
     textSize (textSize);
     if (namePosition.equals ("Top")) {
       textAlign (CENTER);
       if (parameterType.equals ("Int")) {
         text (parameterName + ": " + str (i_value), coord_x1 + lengthX/2 + 3, coord_y1 + 3 + textSize);
       } else if (parameterType.equals ("Float")) {
         text (parameterName + ": " + nf (f_value, floatLeftDigits, floatRightDigits), coord_x1 + lengthX/2 + 3, coord_y1 + 3 + textSize);
      } else {
         text (parameterName + ": " + string_value, coord_x1 + lengthX/2 + 3, coord_y1 + 3 + textSize);
      }
     } else {
       textAlign (LEFT);
       text (parameterName + ": ", coord_x1 + 3, coord_y1 + (lengthY + textSize)/2 - 3);
       textLengthAux = int (textWidth (parameterName) + textWidth (": "));
       if (parameterType.equals ("Int")) {
         text (str(i_value), coord_x1 + 3 + textLengthAux, coord_y1 + (lengthY + textSize)/2 - 3);
       } else if (parameterType.equals ("Float")) {
         text (nf(f_value, floatLeftDigits, floatRightDigits), coord_x1 + 3 + textLengthAux, coord_y1 + (lengthY + textSize)/2 - 3);
       } else {
         text (string_value, coord_x1 + 3 + textLengthAux, coord_y1 + (lengthY + textSize)/2 - 3);
       }
     }
     buttons [0].display ();
     buttons [1].display ();
     if (parameterType.equals ("StringList")) {
       if (buttons [0].sincePressedMillisMod (buttonsTimeInterval)) {
         i_value += 1;
         if (i_value >= stringListSize) i_value = 0;
         string_value = stringList [i_value];
       } else if (buttons [1].sincePressedMillisMod (buttonsTimeInterval)) {
         i_value -= 1;
         if (i_value < 0) i_value = stringListSize-1;
         string_value = stringList [i_value];
       }
     } else {
       if (buttonsAceleration > 0) {
         if (buttons [0].sincePressedMillisMod (buttonsTimeInterval, buttonsAceleration, buttonsLimit)) {
           if (parameterType.equals ("Int")) {
             i_value += i_increment;
             if (hasTopLimit)
               if (i_value >= int (topLimit))
                 i_value = int (topLimit);
           } else if (parameterType.equals ("Float")) {
             f_value += f_increment;
             if (hasTopLimit)
               if (f_value >= topLimit)
                 f_value = topLimit;
           }
         } else if (buttons [1].sincePressedMillisMod (buttonsTimeInterval, buttonsAceleration, buttonsLimit)) {
           if (parameterType.equals ("Int")) {
             i_value -= i_decrement;
             if (hasBotLimit)
               if (i_value <= int (botLimit))
                 i_value = int (botLimit);
           } else if (parameterType.equals ("Float")) {
             f_value -= f_decrement;
             if (hasBotLimit)
               if (f_value <= botLimit)
                 f_value = botLimit;
           }
         }
       } else {
         if (buttons [0].sincePressedMillisMod (buttonsTimeInterval)) {
           if (parameterType.equals ("Int")) {
             i_value += i_increment;
             if (hasTopLimit)
               if (i_value >= int (topLimit))
                 i_value = int (topLimit);
           } else if (parameterType.equals ("Float")) {
             f_value += f_increment;
             if (hasTopLimit)
               if (f_value >= topLimit)
                 f_value = topLimit;
           }
         } else if (buttons [1].sincePressedMillisMod (buttonsTimeInterval)) {
           if (parameterType.equals ("Int")) {
             i_value -= i_decrement;
             if (hasBotLimit)
               if (i_value <= int (botLimit))
                 i_value = int (botLimit);
           } else if (parameterType.equals ("Float")) {
             f_value -= f_decrement;
             if (hasBotLimit)
               if (f_value <= botLimit)
                 f_value = botLimit;
           }
         }
       }
     }
   }
   
   public boolean changeValue () {
     boolean ret = false;
     if (buttons [0].pressed () || buttons [1].pressed ())
       ret = true;
     return ret;
   }
   
   public float GetBotLimit () {
     return botLimit;
   }
   
   public int GetButtonsAceleration () {
     return buttonsAceleration;
   }
   
   public int GetButtonsLengthX () {
     return buttonsLengthX;
   }
   
   public int GetButtonsLengthY () {
     return buttonsLengthY;
   }
   
   public int GetButtonsLimit () {
     return buttonsLimit;
   }
   
   public int GetButtonsSeparationX () {
     return buttonsSeparationX;
   }
   
   public int GetButtonsSeparationY () {
     return buttonsSeparationY;
   }
   
   public int GetButtonsTimeInterval () {
     return buttonsTimeInterval;
   }
   
   public float GetFloatDecrement () {
     return f_decrement;
   }
   
   public float GetFloatIncrement () {
     return f_increment;
   }
   
   public int GetFloatLeftDigits () {
     return floatLeftDigits;
   }
   
   public int GetFloatRightDigits () {
     return floatRightDigits;
   }
   
   public float GetFloatValue () {
     return f_value;
   }
   
   public int GetIntDecrement () {
     return i_decrement;
   }
   
   public int GetIntIncrement () {
     return i_increment;
   }
   
   public int GetIntValue () {
     return i_value;
   }
   
   public String GetNamePosition () {
     return namePosition;
   }
   
   public String GetParameterName () {
     return parameterName;
   }
   
   public String GetParameterType () {
     return parameterType;
   }
   
   public int [] GetPosition () {
     int [] ret = {coord_x1, coord_y1, coord_x2, coord_y2};
     return ret;
   }
   
   public String [] GetStringList () {
     return stringList;
   }
   
   public int GetLengthX () {
     return lengthX;
   }
   
   public int GetLengthY () {
     return lengthY;
   }
   
   public int GetStringListSize () {
     return stringListSize;
   }
   
   public String GetStringValue () {
     if (parameterType.equals ("StringList")) {
       return stringList [i_value];
     } else {
       println ("Bad call on SelectParameter.GetStringValue ().");
       println ("Parameter type is not 'StringList'.");
       return null;
     }
   }
   
   public color GetTextColor () {
     return textColor;
   }
   
   public int GetTextSeparationX () {
     return textSeparationX;
   }
   
   public int GetTextSeparationY () {
     return textSeparationY;
   }
   
   public int GetTextSize () {
     return textSize;
   }
   
   public float GetTopLimit () {
     return topLimit;
   }
   
   public boolean HasBotLimit () {
     return hasBotLimit;
   }
   
   public boolean HasTopLimit () {
     return hasTopLimit;
   }
   
   public UIButton [] GetUIButtons () {
     return buttons;
   }
   
   public void SetBotLimit (int t) {
     botLimit = float (t);
     hasBotLimit = true;
   }
   
   public void SetBotLimit (float t) {
     botLimit = t;
     hasBotLimit = true;
   }
   
   public void SetButtonsAceleration (int t) {
     buttonsAceleration = t;
   }
   
   public void SetButtonsLengthX (int t) {
     buttonsLengthX = t;
   }
   
   public void SetButtonsLengthY (int t) {
     buttonsLengthY = t;
   }
   
   public void SetButtonsLimit (int t) {
     buttonsLimit = t;
   }
   
   public void SetButtonsSeparationX (int t) {
     buttonsSeparationX = t;
   }
   
   public void SetButtonsSeparationY (int t) {
     buttonsSeparationY = t;
   }
   
   public void SetButtonsTimeInterval (int t) {
     buttonsTimeInterval = t;
   }
   
   public void SetFloatDecrement (float t) {
     f_decrement = t;
     if (parameterType.equals("Int")) i_decrement = int (f_decrement);
   }
   
   public void SetFloatIncrement (float t) {
     f_increment = t;
     if (parameterType.equals("Int")) i_increment = int (f_increment);
   }
   
   public void SetFloatLeftDigits (int t) {
     if (t >= 0) {
       floatLeftDigits = t;
     } else {
       println ("Bad input on SelectParameter.SetFloatLeftDigits ().");
     }
   }
   
   public void SetFloatRightDigits (int t) {
     if (t >= 0) {
       floatRightDigits = t;
     } else {
       println ("Bad input on SelectParameter.SetRightLeftDigits ().");
     }
   }
   
   public void SetFloatValue (float t) {
     f_value = t;
     if (parameterType.equals("Int")) i_value = int (f_value);
   }
   
   public void SetHasBotLimit (boolean b) {
     hasBotLimit = b;
   }
   
   public void SetHasTopLimit (boolean b) {
     hasTopLimit = b;
   }
   
   public void SetIntDecrement (int t) {
     i_decrement = t;
     if (parameterType.equals("Float")) f_decrement = float (i_decrement);
   }
   
   public void SetIntIncrement (int t) {
     i_increment = t;
     if (parameterType.equals("Float")) f_increment = float (i_increment);
   }
   
   public void SetIntValue (int t) {
     i_value = t;
     if (parameterType.equals("Float")) f_value = float (i_value);
     if (parameterType.equals("StringList")) 
       if (0 >= i_value || i_value >= stringListSize) 
         i_value = stringListSize-1;
   }
   
   public void SetNamePosition (String position) {
     String tposition = position;
     if (!tposition.equals("Top") && !tposition.equals("Left")) {
       println ("Bad input on SelectParameter.SetNamePosition (String position).");
       println ("Correct position types are 'Top' or 'Left'.");
     } else {
       namePosition = position;
     }
   }
   
   public void SetParameterName (String name) {
     parameterName = name;
   }
   
   public void SetParameterType (String type) {
     String ttype = type;
     if (!ttype.equals("Int") && !ttype.equals("Float") && !ttype.equals("StringList")) {
       println ("Bad input on SelectParameter.SetParameterType (String type).");
       println ("Correct parameter types are 'Int', 'Float' or 'StringList'.");
     } else {
       parameterType = type;
     }
   }
   
   public void SetPosition (int x1, int y1) {
     coord_x1 = x1;
     coord_y1 = y1;
     coord_x2 = coord_x1 + lengthX;
     coord_y2 = coord_y1 + lengthY;
   }
   
   public void SetPosition (int x1, int y1, int x2, int y2) {
     coord_x1 = x1;
     coord_y1 = y1;
     coord_x2 = x2;
     coord_y2 = y2;
   }
   
   public void SetPosition (int [] position) {
     int [] tposition = position;
     if (tposition.length == 4) {
       coord_x1 = tposition [0];
       coord_y1 = tposition [1];
       coord_x2 = tposition [2];
       coord_y2 = tposition [3];
     } else if (tposition.length == 2) {
       coord_x1 = tposition [0];
       coord_y1 = tposition [1];
       coord_x2 = coord_x1 + lengthX;
       coord_y2 = coord_y1 + lengthY;
     } else {
       println ("Bad input on SelectParameter.SetPosition (int[] position).");
       println ("Position length must have to be two (Fixed) or four (Scalar).");
     }
   }
   
   public void SetStringList (String [] ls) {
     String [] tls = ls;
     if (tls.length >= 1) {
       stringList = tls;
       stringListSize = tls.length;
       string_value = stringList [0];
     } else {
       println ("Bad input on SelectParameter.SetStringList ().");
     }
   }
   
   public void SetTextColor (color tc) {
     textColor = tc;
   }
   
   public void SetTextSeparationX (int ts) {
     textSeparationX = ts;
   }
   
   public void SetTextSeparationY (int ts) {
     textSeparationY = ts;
   }
   
   public void SetTextSize (int ts) {
     textSize = ts;
     buttons [0].SetTextSize (ts);
     buttons [1].SetTextSize (ts);
   }
   
   public void SetTopLimit (int t) {
     topLimit = float (t);
     hasTopLimit = true;
   }
   
   public void SetTopLimit (float t) {
     topLimit = t;
     hasTopLimit = true;
   }
   
 }