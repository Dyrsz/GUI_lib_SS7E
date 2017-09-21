
 class PositionGuide {
   
   private int [][] rowCoord, columnCoord;
   private int [][][] matrixCoord;
   private int leftOffset, rightOffset, topOffset, botOffset;
   private int distanceX, distanceY, elementSizeX, elementSizeY;
   private int rowLength = 1;
   private int columnLength = 1;
   private String outputType = "Row"; // Column, Matrix
   private String inputType = "Global"; // Relative, ScreenRelative
   private String defaultMode = "UniformDistribution"; // fixedSize, manual
   
   private int w = width;
   private int h = height;
   
   public PositionGuide (String output, String input) {
     String toutput = output;
     String tinput = input;
     if (toutput.equals ("Row") || toutput.equals ("Column") || toutput.equals ("Matrix")) {
       if (tinput.equals ("Global") || tinput.equals ("Relative") || tinput.equals ("ScreenRelative")) {
         outputType = toutput;
         inputType = tinput;
       } else {
         println ("Bad input on PositionGuide (String outputType, String inputType).");
         println ("Correct input types are: 'Global', 'Relative' or 'ScreenRelative'.");
         println ("Default input set as 'Global'.");
       }
     } else {
       println ("Bad input on PositionGuide (String outputType, String inputType).");
       println ("Correct output types are: 'Row', 'Column' or 'Matrix'.");
       println ("Default output set as 'Row'.");
     }
   }
   
   public PositionGuide (String output, String input, String mode) {
     String toutput = output;
     String tinput = input;
     String tmode = mode;
     if (toutput.equals ("Row") || toutput.equals ("Column") || toutput.equals ("Matrix")) {
       if (tinput.equals ("Global") || tinput.equals ("Relative") || tinput.equals ("ScreenRelative")) {
         if (tmode.equals ("Manual") || tmode.equals ("FixedSize") || tmode.equals ("UniformDistribution")) {
           outputType = toutput;
           inputType = tinput;
           defaultMode = tmode;
         } else {
           println ("Bad input on PositionGuide (String outputType, String inputType, String defaultMode).");
           println ("Correct default modes are: 'Manual', 'FixedSize' or 'UmiformDistribution'.");
           println ("Default mode set as 'UniformDistribution'.");
         }
       } else {
         println ("Bad input on PositionGuide (String outputType, String inputType, String defaultMode).");
         println ("Correct input types are: 'Global', 'Relative' or 'ScreenRelative'.");
         println ("Default input set as 'Global'.");
       }
     } else {
       println ("Bad input on PositionGuide (String outputType, String inputType, String defaultMode).");
       println ("Correct output types are: 'Row', 'Column' or 'Matrix'.");
       println ("Default output set as 'Row'.");
     }
   }
   
   public void Generate () {
     if (outputType.equals ("Row")) {
       if (defaultMode.equals ("UniformDistribution")) {
         if (rowLength == 1) {
           distanceX = 0;
           elementSizeX = w-leftOffset-rightOffset;
         } else {
           distanceX = (w-leftOffset-rightOffset)/((rowLength+1)*(rowLength-1));
           elementSizeX = (w-leftOffset-rightOffset)/(rowLength+1);
         }
         distanceY = 0;
         elementSizeY = h-topOffset-botOffset;
       } else if (defaultMode.equals ("FixedSize")) {
         if (elementSizeX == 0) {
           println ("PositionGuide.defaultMode is 'FixedSize'. You should introduce 'elementSizeX' value first.");
           println ("PositionGuide.elementSizeX provisionally established as '200'.");
           elementSizeX = 200;
         }
         if (rowLength == 1) {
           distanceX = 0;
         } else {
           distanceX = (w-leftOffset-rightOffset-(rowLength*elementSizeX))/(rowLength-1);
         }
         elementSizeY = h-topOffset-botOffset;
         distanceY = 0;
       } // no code if defaultMode is 'Manual'.
       rowCoord = new int [rowLength][4];
       for (int i = 0; i < rowLength; i++) {
         rowCoord [i][0] = leftOffset + (elementSizeX + distanceX) * i;
         rowCoord [i][1] = topOffset;
         rowCoord [i][2] = leftOffset + elementSizeX * (i+1) + distanceX * i;
         rowCoord [i][3] = h - botOffset;
       }
       columnCoord = null;
       matrixCoord = null;
     } else if (outputType.equals ("Column")) {
       if (defaultMode.equals ("UniformDistribution")) {
         if (columnLength == 1) {
           distanceY = 0;
           elementSizeY = h-topOffset-botOffset;
         } else {
           distanceY = (h-topOffset-botOffset)/((columnLength+1)*(columnLength-1));
           elementSizeY = (h-topOffset-botOffset)/(columnLength+1);
         }
         distanceX = 0;
         elementSizeX = w-leftOffset-rightOffset;
       } else if (defaultMode.equals ("FixedSize")) {
         if (elementSizeY == 0) {
           println ("PositionGuide.defaultMode is 'FixedSize'. You should introduce 'elementSizeY' value first.");
           println ("PositionGuide.elementSizeY provisionally established as '100'.");
           elementSizeY = 100;
         }
         if (columnLength == 1) {
           distanceY = 0;
         } else {
           distanceY = (h-topOffset-botOffset-(columnLength*elementSizeY))/(columnLength-1);
         }
         elementSizeX = w-leftOffset-rightOffset;
         distanceX = 0;
       } // no code if defaultMode is 'Manual'.
       columnCoord = new int [columnLength][4];
        for (int i = 0; i < columnLength; i++) {
         columnCoord [i][0] = leftOffset;
         columnCoord [i][1] = topOffset + (elementSizeY + distanceY) * i;
         columnCoord [i][2] = w - botOffset;
         columnCoord [i][3] = topOffset + elementSizeY * (i+1) + distanceY * i;
       }
       rowCoord = null;
       matrixCoord = null;
     } else { // Matrix
       if (defaultMode.equals ("UniformDistribution")) {
         if (rowLength == 1) {
           distanceX = 0;
           elementSizeX = w-leftOffset-rightOffset;
         } else {
           distanceX = (w-leftOffset-rightOffset)/((rowLength+1)*(rowLength-1));
           elementSizeX = (w-leftOffset-rightOffset)/(rowLength+1);
         }
         if (columnLength == 1) {
           distanceY = 0;
           elementSizeY = h-topOffset-botOffset;
         } else {
           distanceY = (h-topOffset-botOffset)/((columnLength+1)*(columnLength-1));
           elementSizeY = (h-topOffset-botOffset)/(columnLength+1);
         }
       } else if (defaultMode.equals ("FixedSize")) {
         if (elementSizeX == 0) {
           println ("PositionGuide.defaultMode is 'FixedSize'. You should introduce 'elementSizeX' value first.");
           println ("PositionGuide.elementSizeX provisionally established as '200'.");
           elementSizeX = 200;
         }
         if (rowLength == 1) {
           distanceX = 0;
         } else {
           distanceX = (w-leftOffset-rightOffset-(rowLength*elementSizeX))/(rowLength-1);
         }
         if (elementSizeY == 0) {
           println ("PositionGuide.defaultMode is 'FixedSize'. You should introduce 'elementSizeY' value first.");
           println ("PositionGuide.elementSizeY provisionally established as '100'.");
           elementSizeY = 100;
         }
         if (columnLength == 1) {
           distanceY = 0;
         } else {
           distanceY = (h-topOffset-botOffset-(columnLength*elementSizeY))/(columnLength-1);
         }
       } // no code if defaultMode is 'Manual'.
       matrixCoord = new int [rowLength][columnLength][4];
       for (int i = 0; i < rowLength; i++)
         for (int j = 0; j < columnLength; j++) {
           matrixCoord [i][j][0] = leftOffset + (elementSizeX + distanceX) * i;
           matrixCoord [i][j][1] = topOffset + (elementSizeY + distanceY) * j;
           matrixCoord [i][j][2] = leftOffset + elementSizeX * (i+1) + distanceX * i;
           matrixCoord [i][j][3] = topOffset + elementSizeY * (j+1) + distanceY * j;
         }
       rowCoord = null;
       columnCoord = null;
     }
   }
   
   public int GetBotOffset () {
     return botOffset;
   }
   
   public int GetColumnLength () {
     return columnLength;
   }
   
   public int [][] GetColumnCoord () {
     if (columnCoord == null) {
       if (outputType.equals ("Row") || outputType.equals ("Matrix")) {
         println ("Bad call on PositionGuide.GetColumnCoord (). Output Type must be 'Column'.");
       } else {
         println ("Bad call on PositionGuide.GetColumnCoord (). Use PositionGuide.Generate () first.");
       }
       return null;
     } else {
       return columnCoord;
     }
   }
   
   public int [] GetColumnCoord (int index) {
     int tindex = index;
     int [] ret = new int [4];
     if (columnCoord == null) {
       if (outputType.equals ("Row") || outputType.equals ("Matrix")) {
         println ("Bad call on PositionGuide.GetColumnCoord (). Output Type must be 'Column'.");
       } else {
         println ("Bad call on PositionGuide.GetColumnCoord (). Use PositionGuide.Generate () first.");
       }
     } else {
       if (0 <= tindex && tindex < columnLength) {
         for (int i = 0; i < 4; i++)
           ret [i] = columnCoord [tindex][i];
       } else {
         println ("Bad index on PositionGuide.GetColumnCoord (index)");
       }
     }
     return ret;
   }
   
   public String GetDefaultMode () {
     return defaultMode;
   }
   
   public int GetDistanceX () {
     return distanceX;
   }
   
   public int GetDistanceY () {
     return distanceY;
   }
   
   public int GetElementSizeX () {
     return elementSizeX;
   }
   
   public int GetElementSizeY () {
     return elementSizeY;
   }
   
   public String GetInputType () {
     return inputType;
   }
   
   public int GetLeftOffset () {
     return leftOffset;
   }
   
   public int [][][] GetMatrixCoord () {
     if (matrixCoord == null) {
       if (outputType.equals ("Column") || outputType.equals ("Row")) {
         println ("Bad call on PositionGuide.GetMatrixCoord (). Output Type must be 'Matrix'.");
       } else {
         println ("Bad call on PositionGuide.GetMatrixCoord (). Use PositionGuide.Generate () first.");
       }
       return null;
     } else {
       return matrixCoord;
     }
   }
   
   public int [] GetMatrixCoord (int ind, int jnd) {
     int in = ind;
     int jn = jnd;
     int [] ret = new int [4];
     if (matrixCoord == null) {
       if (outputType.equals ("Column") || outputType.equals ("Row")) {
         println ("Bad call on PositionGuide.GetMatrixCoord (). Output Type must be 'Matrix'.");
       } else {
         println ("Bad call on PositionGuide.GetMatrixCoord (). Use PositionGuide.Generate () first.");
       }
     } else {
       if (0 <= in && in < rowLength) {
         if (0 <= jn && jn < columnLength) {
           for (int i = 0; i < 4; i++)
             ret [i] = matrixCoord [in][jn][i];
         } else {
           println ("Bad j-ndex on PositionGuide.GetMatrixCoord (i, j)");
         }
       } else {
         println ("Bad i-ndex on PositionGuide.GetMatrixCoord (i, j)");
       }
     }
     return ret;
   }
   
   public String GetOutputType () {
     return outputType;
   }
   
   public float GetRelativeBotOffset () {
     return float (botOffset)/h;
   }
   
   public float GetRelativeDistanceX () {
     if (w != leftOffset + rightOffset) {
       return float (distanceX)/(w-leftOffset-rightOffset);
     } else {
       println ("Off Sets equals to total space. Division by zero.");
       return 1.0;
     }
   }
   
   public float GetRelativeDistanceY () {
     if (h != topOffset + botOffset) {
       return float (distanceY)/(h-topOffset-botOffset);
     } else {
       println ("Off Sets equals to total space. Division by zero.");
       return 1.0;
     }
   }
   
   public float GetRelativeElementSizeX () {
     if (w != leftOffset + rightOffset) {
       return float (elementSizeX)/(w-leftOffset-rightOffset);
     } else {
       println ("Off Sets equals to total space. Division by zero.");
       return 1.0;
     }
   }
   
   public float GetRelativeElementSizeY () {
     if (h != topOffset + botOffset) {
       return float (elementSizeY)/(h-topOffset-botOffset);
     } else {
       println ("Off Sets equals to total space. Division by zero.");
       return 1.0;
     }
   }
   
   public float GetRelativeLeftOffset () {
     return float (leftOffset)/w;
   }
   
   public float [] GetRelativeOffset () {
     float [] ret = {float (leftOffset)/w, float (rightOffset)/w,
     float (topOffset)/h, float (botOffset)/h};
     return ret;
   }
   
   public float GetRelativeRightOffset () {
     return float (rightOffset)/w;
   }
   
   public float GetRelativeTopOffset () {
     return float (topOffset)/h;
   }
   
   public float [] GetRelativeXOffset () {
     float [] ret = {float (leftOffset)/w, float (rightOffset)/w};
     return ret;
   }
   
   public float [] GetRelativeYOffset () {
     float [] ret = {float (topOffset)/h, float (botOffset)/h};
     return ret;
   }
   
   public int GetRightOffset () {
     return rightOffset;
   }
   
   public int GetRowLength () {
     return rowLength;
   }
   
   public int [][] GetRowCoord () {
     if (rowCoord == null) {
       if (outputType.equals ("Column") || outputType.equals ("Matrix")) {
         println ("Bad call on PositionGuide.GetRowCoord (). Output Type must be 'Row'.");
       } else {
         println ("Bad call on PositionGuide.GetRowCoord (). Use PositionGuide.Generate () first.");
       }
       return null;
     } else {
       return rowCoord;
     }
   }
   
   public int [] GetRowCoord (int index) {
     int tindex = index;
     int [] ret = new int [4];
     if (rowCoord == null) {
       if (outputType.equals ("Column") || outputType.equals ("Matrix")) {
         println ("Bad call on PositionGuide.GetRowCoord (). Output Type must be 'Row'.");
       } else {
         println ("Bad call on PositionGuide.GetRowCoord (). Use PositionGuide.Generate () first.");
       }
     } else {
       if (0 <= tindex && tindex < rowLength) {
         for (int i = 0; i < 4; i++)
           ret [i] = rowCoord [tindex][i];
       } else {
         println ("Bad index on PositionGuide.GetRowCoord (index)");
       }
     }
     return ret;
   }
   
   public float GetScreenRelativeDistanceX () {
     return float (distanceX)/w;
   }
   
   public float GetScreenRelativeDistanceY () {
     return float (distanceY)/h;
   }
   
   public float GetScreenRelativeElementSizeX () {
     return float (elementSizeX)/w;
   }
   
   public float GetScreenRelativeElementSizeY () {
     return float (elementSizeY)/h;
   }
   
   public int [] GetOffset () {
     int [] ret = {leftOffset, rightOffset, topOffset, botOffset};
     return ret;
   }
   
   public int GetTopOffset () {
     return topOffset;
   }
   
   public int [] GetXOffset () {
     int [] ret = {leftOffset, rightOffset};
     return ret;
   }
   
   public int [] GetYOffset () {
     int [] ret = {topOffset, botOffset};
     return ret;
   }
   
   public void SetBotOffset (int bot) {
     if (inputType.equals ("Global")) {
       botOffset = bot;
     } else {
       println ("Bad input on PositionGuide.SetBotOffset (int bot).");
       if (inputType.equals ("Relative")) {
         println ("Actual input type is Relative, so you must use a float between 0 and 1.");
       } else {
         println ("Actual input type is ScreenRelative, so you must use a float between 0 and 1.");
       }
     }
   }
   
   public void SetBotOffset (float bot) {
     if (inputType.equals ("Relative") || inputType.equals ("ScreenRelative")) {
       botOffset = int (Math.round (h*bot));
     } else {
       println ("Bad input on PositionGuide.SetBotOffset (float bot).");
       println ("Actual input type is Global, so you must use int as argument.");
     }
   }
   
   public void SetColumnLength (int t) {
     if (outputType.equals("Row")) {
       println ("PositionGuide.outputType is actually 'Row'. If you want");
       println ("to change ColumnLength value, create a new instance of this object");
       println ("or use SetOutputType first. This second option is more risky.");
     } else {
       if (t > 0) {
         columnLength = t;
       } else {
         println ("Bad input on PositionGuide.SetColumnLength (int). Parameter must be > 0.");
       }
     }
   }
   
   public void SetDefaultMode (String mode) {
     String tmode = mode;
     if (tmode.equals ("UniformDistribution") || tmode.equals ("FixedSize") || tmode.equals ("Manual")) {
       defaultMode = tmode;
     } else {
       println ("Bad input on PositionGuide.SetDefaultMode (String)");
       println ("Avaiable modes are 'UniformDistribution', 'FixedSize' or 'Manual'.");
     }
   }
   
   public void SetDistanceX (int x) {
     if (inputType.equals ("Global")) {
       distanceX = x;
     } else {
       println ("Bad input on PositionGuide.SetDistanceX (int x).");
       if (inputType.equals ("Relative")) {
         println ("Actual input type is Relative, so you must use a float between 0 and 1.");
       } else {
         println ("Actual input type is ScreenRelative, so you must use a float between 0 and 1.");
       }
     }
   }
   
   public void SetDistanceX (float tx) {
     float x = tx;
     if (inputType.equals ("Relative")) {
       distanceX = int (Math.round ((w-leftOffset-rightOffset)*x));
     } else if (inputType.equals ("ScreenRelative")) {
       distanceX = int (Math.round (w*x));
     } else {
       println ("Bad input on PositionGuide.SetDistanceX (float x).");
       println ("Actual input type is Global, so you must use int as argument.");
     }
   }
   
   public void SetDistanceY (int y) {
     if (inputType.equals ("Global")) {
       distanceY = y;
     } else {
       println ("Bad input on PositionGuide.SetDistanceY (int y).");
       if (inputType.equals ("Relative")) {
         println ("Actual input type is Relative, so you must use a float between 0 and 1.");
       } else {
         println ("Actual input type is ScreenRelative, so you must use a float between 0 and 1.");
       }
     }
   }
   
   public void SetDistanceY (float ty) {
     float y = ty;
     if (inputType.equals ("Relative")) {
       distanceY = int (Math.round ((w-leftOffset-rightOffset)*y));
     } else if (inputType.equals ("ScreenRelative")) {
       distanceY = int (Math.round (w*y));
     } else {
       println ("Bad input on PositionGuide.SetDistanceY (float y).");
       println ("Actual input type is Global, so you must use int as argument.");
     }
   }
   
   public void SetElementSizeX (int x) {
     if (inputType.equals ("Global")) {
       elementSizeX = x;
     } else {
       println ("Bad input on PositionGuide.SetElementSizeX (int x).");
       if (inputType.equals ("Relative")) {
         println ("Actual input type is Relative, so you must use a float between 0 and 1.");
       } else {
         println ("Actual input type is ScreenRelative, so you must use a float between 0 and 1.");
       }
     }
   }
   
   public void SetElementSizeX (float tx) {
     float x = tx;
     if (inputType.equals ("Relative")) {
       elementSizeX = int (Math.round ((w-leftOffset-rightOffset)*x));
     } else if (inputType.equals ("ScreenRelative")) {
       elementSizeX = int (Math.round (w*x));
     } else {
       println ("Bad input on PositionGuide.SetElementSizeX (float x).");
       println ("Actual input type is Global, so you must use int as argument.");
     }
   }
   
   public void SetElementSizeY (int y) {
     if (inputType.equals ("Global")) {
       elementSizeY = y;
     } else {
       println ("Bad input on PositionGuide.SetElementSizeY (int y).");
       if (inputType.equals ("Relative")) {
         println ("Actual input type is Relative, so you must use a float between 0 and 1.");
       } else {
         println ("Actual input type is ScreenRelative, so you must use a float between 0 and 1.");
       }
     }
   }
   
   public void SetElementSizeY (float ty) {
     float y = ty;
     if (inputType.equals ("Relative")) {
       elementSizeY = int (Math.round ((w-leftOffset-rightOffset)*y));
     } else if (inputType.equals ("ScreenRelative")) {
       elementSizeY = int (Math.round (w*y));
     } else {
       println ("Bad input on PositionGuide.SetElementSizeY (float y).");
       println ("Actual input type is Global, so you must use int as argument.");
     }
   }
   
   public void SetInputType (String tinput) {
     String input = tinput;
     if (input.equals ("Global") || input.equals ("Relative") || input.equals ("ScreenRelative")) {
       inputType = input;
     } else {
       println ("Bad input on PositionGuide.SetInputType (String)");
       println ("Avaiable types are 'Global', 'Relative' or 'ScreenRelative'.");
     }
   }
   
   public void SetLeftOffset (int left) {
     if (inputType.equals ("Global")) {
       leftOffset = left;
     } else {
       println ("Bad input on PositionGuide.SetLeftOffset (int left).");
       if (inputType.equals ("Relative")) {
         println ("Actual input type is Relative, so you must use a float between 0 and 1.");
       } else {
         println ("Actual input type is ScreenRelative, so you must use a float between 0 and 1.");
       }
     }
   }
   
   public void SetLeftOffset (float left) {
     if (inputType.equals ("Relative") || inputType.equals ("ScreenRelative")) {
       leftOffset = int (Math.round (w*left));
     } else {
       println ("Bad input on PositionGuide.SetLeftOffset (float left).");
       println ("Actual input type is Global, so you must use int as argument.");
     }
   }
   
   public void SetOffset (int left, int right, int top, int bot) {
     if (inputType.equals ("Global")) {
       leftOffset = left;
       rightOffset = right;
       topOffset = top;
       botOffset = bot;
     } else {
       println ("Bad input on PositionGuide.SetOffset (int left, int right, int top, int bot).");
       if (inputType.equals ("Relative")) {
         println ("Actual input type is Relative, so you must use a float between 0 and 1.");
       } else {
         println ("Actual input type is ScreenRelative, so you must use a float between 0 and 1.");
       }
     }
   }
   
   public void SetOffset (int [] tp) {
     int [] p = tp;
     if (inputType.equals ("Global")) {
       if (p.length == 4) {
         leftOffset = p [0];
         rightOffset = p [1];
         topOffset = p [2];
         botOffset = p [3];
       } else {
         println ("Bad input on PositionGuide.SetOffset (int [] p).");
         println ("p must have length == 4");
       }
     } else {
       println ("Bad input on PositionGuide.SetOffset (int [] p).");
       if (inputType.equals ("Relative")) {
         println ("Actual input type is Relative, so you must use a float between 0 and 1.");
       } else {
         println ("Actual input type is ScreenRelative, so you must use a float between 0 and 1.");
       }
     }
   }
   
   public void SetOffset (float left, float right, float top, float bot) {
     if (inputType.equals ("Relative") || inputType.equals ("ScreenRelative")) {
       leftOffset = int (Math.round (w*left));
       rightOffset = int (Math.round (w*right));
       topOffset = int (Math.round (h*top));
       botOffset = int (Math.round (h*bot));
     } else {
       println ("Bad input on PositionGuide.SetOffset (float left, float right, float top, float bot).");
       println ("Actual input type is Global, so you must use ints as arguments.");
     }
   }
   
   public void SetOffset (float [] tp) {
     float [] p = tp;
     if (inputType.equals ("Relative") || inputType.equals ("ScreenRelative")) {
       if (p.length == 2) {
         leftOffset = int (Math.round (w*p [0]));
         rightOffset = int (Math.round (w*p [1]));
         topOffset = int (Math.round (h*p [2]));
         botOffset = int (Math.round (h*p [3]));
       } else {
         println ("Bad input on PositionGuide.SetOffset (float [] p).");
         println ("p must have length == 2");
       }
     } else {
       println ("Bad input on PositionGuide.SetOffset (float [] p).");
       println ("Actual input type is Global, so you must use ints as arguments.");
     }
   }
   
   public void SetOutputType (String toutput) {
     String output = toutput;
     if (output.equals ("Row") || output.equals ("Column") || output.equals ("Matrix")) {
       outputType = output;
     } else {
       println ("Bad input on PositionGuide.SetOutputType (String)");
       println ("Avaiable modes are 'Row', 'Column' or 'Matrix'.");
     }
   }
   
   public void SetRightOffset (int right) {
     if (inputType.equals ("Global")) {
       rightOffset = right;
     } else {
       println ("Bad input on PositionGuide.SetRightOffset (int right).");
       if (inputType.equals ("Relative")) {
         println ("Actual input type is Relative, so you must use a float between 0 and 1.");
       } else {
         println ("Actual input type is ScreenRelative, so you must use a float between 0 and 1.");
       }
     }
   }
   
   public void SetRightOffset (float tright) {
     float right = tright;
     if (inputType.equals ("Relative") || inputType.equals ("ScreenRelative")) {
       rightOffset = int (Math.round (w*right));
     } else {
       println ("Bad input on PositionGuide.SetRightOffset (float right).");
       println ("Actual input type is Global, so you must use int as argument.");
     }
   }
   
   public void SetRowLength (int t) {
     if (outputType.equals("Column")) {
       println ("PositionGuide.outputType is actually 'Column'. If you want");
       println ("to change RowLength value, create a new instance of this object");
       println ("or use SetOutputType first. This second option is more risky.");
     } else {
       if (t > 0) {
         rowLength = t;
       } else {
         println ("Bad input on PositionGuide.SetRowLength (int). Parameter must be > 0.");
       }
     }
   }
   
   public void SetTopOffset (int top) {
     if (inputType.equals ("Global")) {
       topOffset = top;
     } else {
       println ("Bad input on PositionGuide.SetTopOffset (int top).");
       if (inputType.equals ("Relative")) {
         println ("Actual input type is Relative, so you must use a float between 0 and 1.");
       } else {
         println ("Actual input type is ScreenRelative, so you must use a float between 0 and 1.");
       }
     }
   }
   
   public void SetTopOffset (float ttop) {
     float top = ttop;
     if (inputType.equals ("Relative") || inputType.equals ("ScreenRelative")) {
       topOffset = int (Math.round (h*top));
     } else {
       println ("Bad input on PositionGuide.SetTopOffset (float top).");
       println ("Actual input type is Global, so you must use int as argument.");
     }
   }
   
   public void SetXOffset (int left, int right) {
     if (inputType.equals ("Global")) {
       leftOffset = left;
       rightOffset = right;
     } else {
       println ("Bad input on PositionGuide.SetXOffset (int left, int right).");
       if (inputType.equals ("Relative")) {
         println ("Actual input type is Relative, so you must use a float between 0 and 1.");
       } else {
         println ("Actual input type is ScreenRelative, so you must use a float between 0 and 1.");
       }
     }
   }
   
   public void SetXOffset (int [] tx) {
     int [] x = tx;
     if (inputType.equals ("Global")) {
       if (x.length == 2) {
         leftOffset = x [0];
         rightOffset = x [1];
       } else {
         println ("Bad input on PositionGuide.SetXOffset (int [] x).");
         println ("x must have length == 2");
       }
     } else {
       println ("Bad input on PositionGuide.SetXOffset (int [] x).");
       if (inputType.equals ("Relative")) {
         println ("Actual input type is Relative, so you must use a float between 0 and 1.");
       } else {
         println ("Actual input type is ScreenRelative, so you must use a float between 0 and 1.");
       }
     }
   }
   
   public void SetXOffset (float left, float right) {
     if (inputType.equals ("Relative") || inputType.equals ("ScreenRelative")) {
       leftOffset = int (Math.round (w*left));
       rightOffset = int (Math.round (w*right));
     } else {
       println ("Bad input on PositionGuide.SetXOffset (float left, float right).");
       println ("Actual input type is Global, so you must use ints as arguments.");
     }
   }
   
   public void SetXOffset (float [] tx) {
     float [] x = tx;
     if (inputType.equals ("Relative") || inputType.equals ("ScreenRelative")) {
       if (x.length == 2) {
         leftOffset = int (Math.round (w*x [0]));
         rightOffset = int (Math.round (w*x [1]));
       } else {
         println ("Bad input on PositionGuide.SetXOffset (float [] x).");
         println ("x must have length == 2");
       }
     } else {
       println ("Bad input on PositionGuide.SetXOffset (float [] x).");
       println ("Actual input type is Global, so you must use ints as arguments.");
     }
   }
   
   public void SetYOffset (int top, int bot) {
     if (inputType.equals ("Global")) {
       topOffset = top;
       botOffset = bot;
     } else {
       println ("Bad input on PositionGuide.SetYOffset (int top, int bot).");
       if (inputType.equals ("Relative")) {
         println ("Actual input type is Relative, so you must use a float between 0 and 1.");
       } else {
         println ("Actual input type is ScreenRelative, so you must use a float between 0 and 1.");
       }
     }
   }
   
   public void SetYOffset (int [] ty) {
     int [] y = ty;
     if (inputType.equals ("Global")) {
       if (y.length == 2) {
         topOffset = y [0];
         botOffset = y [1];
       } else {
         println ("Bad input on PositionGuide.SetYOffset (int [] y).");
         println ("y must have length == 2");
       }
     } else {
       println ("Bad input on PositionGuide.SetYOffset (int [] y).");
       if (inputType.equals ("Relative")) {
         println ("Actual input type is Relative, so you must use a float between 0 and 1.");
       } else {
         println ("Actual input type is ScreenRelative, so you must use a float between 0 and 1.");
       }
     }
   }
   
   public void SetYOffset (float top, float bot) {
     if (inputType.equals ("Relative") || inputType.equals ("ScreenRelative")) {
       topOffset = int (Math.round (h*top));
       botOffset = int (Math.round (h*bot));
     } else {
       println ("Bad input on PositionGuide.SetYOffset (float top, float bot).");
       println ("Actual input type is Global, so you must use ints as arguments.");
     }
   }
   
   public void SetYOffset (float [] ty) {
     float [] y = ty;
     if (inputType.equals ("Relative") || inputType.equals ("ScreenRelative")) {
       if (y.length == 2) {
         topOffset = int (Math.round (h*y [0]));
         botOffset = int (Math.round (h*y [1]));
       } else {
         println ("Bad input on PositionGuide.SetYOffset (float [] y).");
         println ("y must have length == 2");
       }
     } else {
       println ("Bad input on PositionGuide.SetYOffset (float [] y).");
       println ("Actual input type is Global, so you must use ints as arguments.");
     }
   }
   
 }