//THE LINE GRAPH MAY LOOK WRONG ON DIFFERENT SCREEN RESOLUTIONS

color lineColor [] = { color(200,0,0), color(250,140,0), color(250,250,0), color(0,250,0), color(0,0,250), color(200,0,250) };

class History
{
  ArrayList<Integer> netHistory = new ArrayList<Integer>();
  
  public History( int firstValue )
  {
    netHistory.add( firstValue );
    netHistory.add( 0 );
  }
  
  void addValue( int value )
  {
    netHistory.add( 0, value );
    while( netHistory.size() > 20 )
      netHistory.remove( netHistory.size()-1 );
  }
  
  int highest()
  {
    return Collections.max(netHistory);
  }
  
  int lowest()
  {
    return Collections.min(netHistory);
  }
}

void drawGraph( float x, float y )
{
  int maxScore = 0;
  int minScore = merchant[0].netHistory.lowest();
  int graphWidth = 755, graphHeight = 505;

  for( int i = 1; i < merchant.length; i++ )
  {
    if(maxScore < merchant[i].netHistory.highest() )
      maxScore = merchant[i].netHistory.highest();
    if(minScore > merchant[i].netHistory.lowest() )
      minScore = merchant[i].netHistory.lowest();
  }
  
  //Get difference between highest and lowest value
  int gap = int(dist(maxScore,0,minScore,0));//abs(maxScore-minScore);
    
  //Choose and Draw Metadata Numbers
  int tierSize = setTierSize(gap);
  
  //Determine ceiling and floor of graph
  int ceiling = maxScore;
  while( ceiling%tierSize != 0 )
    ceiling++;
  int floor = minScore-tierSize;
  while( floor%tierSize != 0 )
    floor++;
    
  //Re-determine gap and tier size
  gap = int(dist(ceiling,0,floor,0));
  tierSize = setTierSize( gap );
    
  push();
  //Draw Graph
  fill(255);
  strokeWeight(5);
  stroke(175);
  rect(x,y-5,graphWidth,graphHeight);
  stroke(#85BB65);
  line( x+100, y+10, x+100, y+490 );
  strokeWeight(1);
  line( x+100, y+8,   x+740, y+8 );
  line( x+100, y+130, x+740, y+130 );
  line( x+100, y+250, x+740, y+250 );
  line( x+100, y+370, x+740, y+370 );
  line( x+100, y+492, x+740, y+492 );
  
  //MetaData
  textAlign(RIGHT);
  fill(#85BB65);
  textSize(20);
  text( graphNum(ceiling), x+85, y+20 );
  text( graphNum(ceiling-tierSize), x+85, y+138 );
  text( graphNum(ceiling-tierSize*2), x+85, y+256 );
  text( graphNum(ceiling-tierSize*3), x+85, y+374 );
  text( graphNum(ceiling-tierSize*4), x+85, y+490 );
  
  //Draw lines
  int numLines = merchant[0].netHistory.netHistory.size();
  strokeWeight(2);
  for( int j = 0; j < 6; j++ )
  {
    stroke( lineColor[j] );
    for( int i = 0; i < merchant[i].netHistory.netHistory.size()-1; i++ )
      line( graphXPos(0,i,numLines,x), y+10+graphYPos(ceiling,tierSize,merchant[j].netHistory.netHistory.get(i)), graphXPos(1,i,numLines,x), y+10+graphYPos(ceiling,tierSize,merchant[j].netHistory.netHistory.get(i+1)) );
  }
  pop();
}

int setTierSize( int g )
{
  if(      g <= 10000  )  return 2500;
  else if( g <= 20000  )  return 5000;
  else if( g <= 40000  )  return 10000;
  else if( g <= 80000  )  return 20000;
  else if( g <= 200000 )  return 50000;
  else if( g <= 400000 )  return 100000;
  else if( g <= 800000 )  return 200000;
  else if( g <= 1000000 ) return 250000;
  else if( g <= 2000000 ) return 500000;
  else if( g <= 3000000 ) return 750000;
  else if( g <  4000000 ) return 1000000;
  else                    return 1500000;
}

//            side of line, index, number of lines, graph's X
int graphXPos( int side, int i, int num, float x )
{
  float segmentLength = 20.0 / (num-1) * 31.5;
  return int( x+733-(segmentLength*(i+side)) );
}

int graphYPos( int top, int tier, int value ) //convert values to Y-pos on grid
{
  float returnValue = dist(top,0,value,0);
  float pixMulti = 480.0 / (tier*4);
  returnValue *= pixMulti;
  return int(returnValue);
}

String graphNum( int value ) //convert to 500k or 3M
{
  if( abs(value) >= 1000000 )
    return value/1000000.0 + "M";
  if( abs(value) > 1000 )
    return value/1000 + "K";
  return ""+value;
}
