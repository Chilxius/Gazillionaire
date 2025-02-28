//THE LINE GRAPH MAY LOOK WRONG ON DIFFERENT SCREEN RESOLUTIONS

color planetGraphColors[] = {color(150,130,90),#1aa773,#7777AA,#eb5d2d,#f0c060,#469dbe,#f8aea3};
color lineColor [] = { color(200,0,0), color(250,140,0), color(250,250,0), color(0,250,0), color(0,0,250), color(200,0,250) };

void buildGraphs()
{
  History merchantHistories[] = new History[6];
  History planetHistories[] = new History[7];
  for( int i = 0; i < 6; i++ )
    merchantHistories[i] = merchant[i].netHistory;
  for( int i = 0; i < 7; i++ )
    planetHistories[i] = planet[i].netHistory;
  planetStocksGraph = new LineGraph(adjustInt(50,'x'),adjustInt(50,'y'),875,adjustInt(650,'y'),"Planet Stock Exchange","Value","Week",planetHistories);
  merchantCashGraph = new LineGraph(adjustInt(50,'x'),adjustInt(100,'y'),adjustFloat(1180,'x'),adjustInt(600,'y'),"Company History","Net Worth","Week",merchantHistories);
}

class History
{
  ArrayList<Integer> netHistory = new ArrayList<Integer>();
  String name;
  color lineColor;
  int xAxisLowest = 0; //Bottom axis starts at 0 and counts up
  
  public History( String n, color c, int firstValue )
  {
    name = n;
    lineColor = c;
    
    netHistory.add( firstValue );
    netHistory.add( 0 );
  }
  
  void addValue( int value )
  {
    netHistory.add( 0, value );
    while( netHistory.size() > 10 )
    {
      netHistory.remove( netHistory.size()-1 );
      xAxisLowest++;
    }
  }
  
  int highest()
  {
    return Collections.max(netHistory);
  }
  
  int lowest()
  {
    return Collections.min(netHistory);
  }
  
  String name()
  {
    return name;
  }
}

class LineGraph
{
  float xPos, yPos;
  float xSize, ySize;
  String title, yLabel, xLabel;
  History [] histories;
  
  int highestValue, lowestValue;
  int lineIncrement;
  float dotSpace;
  
  public LineGraph( float x, float y, float w, float h, String t, String yL, String xL, History[] hist )
  {
    xPos = x;
    yPos = y;
    xSize = w;
    ySize = h;
    title = t;
    xLabel = xL;
    yLabel = yL;
    histories = hist;
    updateLimits();
  }
  
  void drawGraph( )
  {
    push();
    textAlign(CENTER);
    strokeCap(SQUARE);
    rectMode(CORNER);
    
    //Graph Title
    textSize(xSize/20);
    fill(200);
    text(title,xPos+xSize/2,yPos-ySize/30);
    
    //Background Panel
    strokeWeight(ySize/100);
    stroke(150);
    fill(200);
    rect(xPos,yPos,xSize,ySize);
    
    //Axis Labels
    textSize(xSize/30);
    fill(0,200,0);
    text(xLabel, xPos+xSize/2, yPos+ySize*.95);
    float midpoint = yPos+ySize/2;
    float spacing = xSize/30;
    for( float i = 0, y = -yLabel.length()/2*spacing; y <= yLabel.length()/2*spacing; i++, y += spacing )
      text( yLabel.charAt(int(i)), xPos+xSize/30, midpoint+y );
    
    //Graph lines
    stroke(0,200,0);
    strokeWeight(1);
    spacing = (ySize-(ySize/20+ySize*0.10))/12;
    for(int i = 0; i < 12; i++)
      line( xPos+xSize/8.15, yPos+ySize/20+spacing*i, xPos+xSize-xSize/6, yPos+ySize/20+spacing*i );
      
    //Graph Numbers
    textSize(xSize/50);
    textAlign(RIGHT);
    //Get startNum to be top of graph
    int startNum = highestValue;
    while( !(startNum % lineIncrement == 0) ) startNum++;
    //Draw numbers
    for( int i = 0; i < 12; i++ )
      text( shortenedNum(startNum-lineIncrement*(i)), xPos+xSize/8.50, yPos+ySize/20+(spacing*i+ySize/100) );
    
    //Entity Names
    textSize(xSize/35);
    textAlign(RIGHT);
    spacing = ySize/(histories.length+1);
    for( int i = 0; i < histories.length; i++ )
    {
      fill( histories[i].lineColor );
      text( histories[i].name, xPos+xSize*0.99, yPos+spacing*(i+1) );
    }
    
    //Entities' Lines (and week numbers)
    float lineStart = xPos+xSize-xSize/6;
    float yStart = yPos+ySize/20;
    spacing = (ySize-(ySize/20+ySize*0.10))/12;
    strokeWeight(ySize/200);
    //strokeCap(PROJECT);
    strokeCap(ROUND);
    strokeJoin(MITER);
    //Drawn twice so lines go above and below other lines
    //for( History h: histories )
    //{
    //  stroke( h.lineColor );
    //  noFill();
    //  beginShape();
    //  for( int i = 1; i < min(10,h.netHistory.size()); i+=1 )
    //  {
    //    float previousPoint = yStart + (float(startNum)-h.netHistory.get(i))/lineIncrement*spacing;
    //    float pointOnGraph = yStart + (float(startNum)-h.netHistory.get(i-1))/lineIncrement*spacing;
    //    line( lineStart-i*dotSpace, previousPoint, lineStart-(i-1)*dotSpace, pointOnGraph );
    //  }
    //  endShape();
    //}
    for( History h: histories )
    {
      stroke( h.lineColor );
      for( int i = 1; i < min(10,h.netHistory.size()); i+=2 )
      {
        float previousPoint = yStart + (float(startNum)-h.netHistory.get(i))/lineIncrement*spacing;
        float pointOnGraph = yStart + (float(startNum)-h.netHistory.get(i-1))/lineIncrement*spacing;
        line( lineStart-i*dotSpace, previousPoint, lineStart-(i-1)*dotSpace, pointOnGraph );
      }
    }
    for( int j = histories.length-1; j >=0; j-- )
    {
      stroke( histories[j].lineColor );
      for( int i = 2; i < min(10,histories[j].netHistory.size()); i+=2 )
      {
        float previousPoint = yStart + (float(startNum)-histories[j].netHistory.get(i))/lineIncrement*spacing;
        float pointOnGraph = yStart + (float(startNum)-histories[j].netHistory.get(i-1))/lineIncrement*spacing;
        line( lineStart-i*dotSpace, previousPoint, lineStart-(i-1)*dotSpace, pointOnGraph );
      }
    }
    textSize(xSize/50);
    fill(0,200,0);
    textAlign(CENTER);
    for( int i = 0, n = histories[0].xAxisLowest; i < min(10,histories[0].netHistory.size()); i++, n++ )
    {
      text( n, xPos+xSize/8+i*dotSpace ,yPos+ySize*.875 );
    }
    
    //Side line
    strokeWeight(ySize/100);
    stroke(0,200,0);
    strokeCap(SQUARE);
    line( xPos+xSize/8, yPos+ySize/20, xPos+xSize/8, yPos+ySize/20+spacing*11 );
    
    pop();
  }

  void updateLimits()
  {
    highestValue = lowestValue = histories[0].netHistory.get(0);
    //Re-calculate highest/lowest
    for( int i = 0; i < histories.length; i++ )
      for( int j = 0; j < histories[i].netHistory.size(); j++ )
        if( histories[i].netHistory.get(j) > highestValue )
          highestValue = histories[i].netHistory.get(j);
        else if( histories[i].netHistory.get(j) < lowestValue )
          lowestValue = histories[i].netHistory.get(j);
    
    //Horizontal space between points of lines
    dotSpace = dist( xPos+xSize/8.15, 0, xPos+xSize-xSize/6, 0 );
    dotSpace /= (histories[0].netHistory.size()-1);
    
    //Vertical space between graph lines (multiple of ten)
    for( int i = 0; i <= highestValue-lowestValue; i+=100 ) lineIncrement = i;
    lineIncrement/=10;
    while( lineIncrement % 100 != 0 ) lineIncrement+=10;
    lineIncrement = max( 100, lineIncrement );
    println( highestValue + " to " + lowestValue + ": " + lineIncrement );
  }
  
  String shortenedNum( int number )
  {
    String returnValue = "";
    
    //Store negative sign
    if( number < 0 ) returnValue += "-";
    
    //Make value positive
    number = abs(number);
    
    //Less than 1000
    if( abs(number) < 1000 ) return returnValue+number;
    
    //Less than 10k
    if( abs(number) < 10000 ) return returnValue+number/1000+","+str(number).substring(1);
    
    //10k or More
    return returnValue + float(int(float(number)/100))/10 + "K";
  }
}
  
//  class History
//  {
//    ArrayList<Integer> netHistory = new ArrayList<Integer>();
    
//    public History( int firstValue )
//    {
//      netHistory.add( firstValue );
//      netHistory.add( 0 );
//    }
    
//    void addValue( int value )
//    {
//      netHistory.add( 0, value );
//      while( netHistory.size() > 20 )
//        netHistory.remove( netHistory.size()-1 );
//    }
    
//    int highest()
//    {
//      return Collections.max(netHistory);
//    }
    
//    int lowest()
//    {
//      return Collections.min(netHistory);
//    }
//  }

//void drawGraph( float x, float y )
//{
//  int maxScore = 0;
//  int minScore = merchant[0].netHistory.lowest();
//  int graphWidth = 755, graphHeight = 505;

//  for( int i = 1; i < merchant.length; i++ )
//  {
//    if(maxScore < merchant[i].netHistory.highest() )
//      maxScore = merchant[i].netHistory.highest();
//    if(minScore > merchant[i].netHistory.lowest() )
//      minScore = merchant[i].netHistory.lowest();
//  }
  
//  //Get difference between highest and lowest value
//  int gap = int(dist(maxScore,0,minScore,0));//abs(maxScore-minScore);
    
//  //Choose and Draw Metadata Numbers
//  int tierSize = setTierSize(gap);
  
//  //Determine ceiling and floor of graph
//  int ceiling = maxScore;
//  while( ceiling%tierSize != 0 )
//    ceiling++;
//  int floor = minScore-tierSize;
//  while( floor%tierSize != 0 )
//    floor++;
    
//  //Re-determine gap and tier size
//  gap = int(dist(ceiling,0,floor,0));
//  tierSize = setTierSize( gap );
    
//  push();
//  //Draw Graph
//  fill(255);
//  strokeWeight(5);
//  stroke(175);
//  rect(x,y-5,graphWidth,graphHeight);
//  stroke(#85BB65);
//  line( x+100, y+10, x+100, y+490 );
//  strokeWeight(1);
//  line( x+100, y+8,   x+740, y+8 );
//  line( x+100, y+130, x+740, y+130 );
//  line( x+100, y+250, x+740, y+250 );
//  line( x+100, y+370, x+740, y+370 );
//  line( x+100, y+492, x+740, y+492 );
  
//  //MetaData
//  textAlign(RIGHT);
//  fill(#85BB65);
//  textSize(20);
//  text( graphNum(ceiling), x+85, y+20 );
//  text( graphNum(ceiling-tierSize), x+85, y+138 );
//  text( graphNum(ceiling-tierSize*2), x+85, y+256 );
//  text( graphNum(ceiling-tierSize*3), x+85, y+374 );
//  text( graphNum(ceiling-tierSize*4), x+85, y+490 );
  
//  //Draw lines
//  int numLines = merchant[0].netHistory.netHistory.size();
//  strokeWeight(2);
//  for( int j = 0; j < 6; j++ )
//  {
//    stroke( lineColor[j] );
//    for( int i = 0; i < merchant[i].netHistory.netHistory.size()-1; i++ )
//      line( graphXPos(0,i,numLines,x), y+10+graphYPos(ceiling,tierSize,merchant[j].netHistory.netHistory.get(i)), graphXPos(1,i,numLines,x), y+10+graphYPos(ceiling,tierSize,merchant[j].netHistory.netHistory.get(i+1)) );
//  }
//  pop();
//}

//int setTierSize( int g )
//{
//  if(      g <= 10000  )  return 2500;
//  else if( g <= 20000  )  return 5000;
//  else if( g <= 40000  )  return 10000;
//  else if( g <= 80000  )  return 20000;
//  else if( g <= 200000 )  return 50000;
//  else if( g <= 400000 )  return 100000;
//  else if( g <= 800000 )  return 200000;
//  else if( g <= 1000000 ) return 250000;
//  else if( g <= 2000000 ) return 500000;
//  else if( g <= 3000000 ) return 750000;
//  else if( g <  4000000 ) return 1000000;
//  else                    return 1500000;
//}

////            side of line, index, number of lines, graph's X
//int graphXPos( int side, int i, int num, float x )
//{
//  float segmentLength = 20.0 / (num-1) * 31.5;
//  return int( x+733-(segmentLength*(i+side)) );
//}

//int graphYPos( int top, int tier, int value ) //convert values to Y-pos on grid
//{
//  float returnValue = dist(top,0,value,0);
//  float pixMulti = 480.0 / (tier*4);
//  returnValue *= pixMulti;
//  return int(returnValue);
//}

//String graphNum( int value ) //convert to 500k or 3M
//{
//  if( abs(value) >= 1000000 )
//    return value/1000000.0 + "M";
//  if( abs(value) > 1000 )
//    return value/1000 + "K";
//  return ""+value;
//}
