//Koo Kee - Request lower tariffs and taxes
//Stittle - Request better interest rates (loan/bank) or higher credit limit
//Starlite- Purchase stocks from other planets
//Ludda   - Wholesale fuel
//Kezo    - Offered cheaper random goods
//Rockulus- Random upgrades
//Cake    - Make crew happy / remove debts

String planetNames[] =       {"Koo Kee",                       "Stittle",                      "Starlite",                 "Ludda",              "Kezo",              "Rockulus",                             "Cake"};
String planetDescription[] = {"Capital of the Galactic Empire","Home of the Galactic Treasury","Stock Exchange Playground","Fuel Refinery World","Fertile Farm World","The Cutting Edge of\nTech Development","The Pastry Planet"};
color planetColors[] =       {color(255,240,215),               color(160,240,160),             color(230,200,215),         color(250,115,70),    color(0),            color(155,215,225),                     color(250,200,165)};

class Planet
{
  String name,description;
  int index;
  float xPos, yPos; //for flight screen
  int dist [] = new int[7]; //distance to other planets
  color planetColor;
  
  PImage picLarge, picMed, picSmall, picLandscape, landscapeBig;
  
  Commodity [] goods = new Commodity[commodityCount];
  
  Commodity [] storage = new Commodity[commodityCount];
  
  int passengersAvailable = int(random(5,10));
  
  int sharesForPurchase = 10;
  
  History netHistory;
  
  public Planet( int type )
  {
    //Set commodities and zero them out
    for(int i = 0; i < commodityCount; i++)
    {
      goods[i] = new Commodity(i);
      storage[i] = new Commodity(i);
    }
    name = planetNames[type]; //get name from list
    description = planetDescription[type]; //get description from list
    picLarge = loadImage("planet_"+type+".png"); picLarge.resize(int(adjustFloat(800,'y')),0);
    picMed   = loadImage("planet_"+type+".png"); picMed.resize(adjustInt(275,'x'),0);
    picSmall = loadImage("planet_"+type+".png"); picSmall.resize(adjustInt(150,'x'),0);
    picLandscape = loadImage("p_land_"+type+".png"); picLandscape.resize(0,adjustInt(650,'y'));
    landscapeBig = loadImage("p_land_"+type+".png"); landscapeBig.resize(adjustInt(1280,'x'),0);
    //landscapeBig = loadImage("p_land_"+type+".png"); landscapeBig.resize(0,int(800));
    planetColor = planetGraphColors[type];
    
    index = type;
    
    netHistory = new History(name,planetColor,int(random(1000)));
    netHistory.addValue( int(random(1000) ) );
    netHistory.addValue( int(random(1000) ) );
    netHistory.addValue( int(random(1000) ) );
    netHistory.addValue( int(random(1000) ) );
  }
  
  void drawSmallPlanet()
  {
    image(picSmall, xPos, yPos);
    if( dist(mouseX,mouseY, xPos, yPos) < 75 )
      text( name, xPos, yPos-100 );
  }
  
  public String toString()
  {
    return name;
  }
}

public int planetNumber( Planet p )
{
  switch( p.name )
  {
    case "Koo Kee": return 0;
    case "Stittle": return 1;
    case "Starlite": return 2;
    case "Ludda": return 3;
    case "Kezo": return 4;
    case "Rockulus": return 5;
    case "Cake": return 6;
    
    default: println("ERROR: planet out of range"); return 0;
  }
}

void setupPlanets()
{
  for( int i = 0; i < planet.length; i++ )
    planet[i] = new Planet(i);
    
  planet[0].xPos = adjustFloat(200,'x');
  planet[0].yPos = adjustFloat(520,'y');
  planet[0].dist[0] = 0;
  planet[0].dist[1] = 19;
  planet[0].dist[2] = 8;
  planet[0].dist[3] = 11;
  planet[0].dist[4] = 9;
  planet[0].dist[5] = 8;
  planet[0].dist[6] = 18;
  
  planet[1].xPos = adjustFloat(1050,'x');
  planet[1].yPos = adjustFloat(150,'y');
  planet[1].dist[0] = 19;
  planet[1].dist[1] = 0;
  planet[1].dist[2] = 15;
  planet[1].dist[3] = 8;
  planet[1].dist[4] = 20;
  planet[1].dist[5] = 12;
  planet[1].dist[6] = 11;
    
  planet[2].xPos = adjustFloat(600,'x');
  planet[2].yPos = adjustFloat(650,'y');
  planet[2].dist[0] = 8;
  planet[2].dist[1] = 15;
  planet[2].dist[2] = 0;
  planet[2].dist[3] = 7;
  planet[2].dist[4] = 16;
  planet[2].dist[5] = 19;
  planet[2].dist[6] = 10;
  
  planet[3].xPos = adjustFloat(800,'x');
  planet[3].yPos = adjustFloat(400,'y');
  planet[3].dist[0] = 11;
  planet[3].dist[1] = 8;
  planet[3].dist[2] = 7;
  planet[3].dist[3] = 0;
  planet[3].dist[4] = 14;
  planet[3].dist[5] = 6;
  planet[3].dist[6] = 8;
    
  planet[4].xPos = adjustFloat(100,'x');
  planet[4].yPos = adjustFloat(120,'y');
  planet[4].dist[0] = 9;
  planet[4].dist[1] = 20;
  planet[4].dist[2] = 16;
  planet[4].dist[3] = 14;
  planet[4].dist[4] = 0;
  planet[4].dist[5] = 8;
  planet[4].dist[6] = 23;
  
  planet[5].xPos = adjustFloat(450,'x');
  planet[5].yPos = adjustFloat(300,'y');
  planet[5].dist[0] = 8;
  planet[5].dist[1] = 12;
  planet[5].dist[2] = 10;
  planet[5].dist[3] = 6;
  planet[5].dist[4] = 8;
  planet[5].dist[5] = 0;
  planet[5].dist[6] = 15;
  
  planet[6].xPos = adjustFloat(1100,'x');
  planet[6].yPos = adjustFloat(700,'y');
  planet[6].dist[0] = 18;
  planet[6].dist[1] = 11;
  planet[6].dist[2] = 10;
  planet[6].dist[3] = 8;
  planet[6].dist[4] = 23;
  planet[6].dist[5] = 15;
  planet[6].dist[6] = 0;
}
