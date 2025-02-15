class Commodity
{
  String name;
  
  //image
  
  int amount;
  
  int minValue, maxValue, value; //value is buy price and sell price
  int cost; //value paid for current stock - for determining value of trade
  
  public Commodity( int type )
  {
    name = commodityName(type);
    amount = 0;
    minValue = type*5;
    maxValue = type*40;
    cost = 0;
  }
  
  String commodityName( int t )
  {
    switch( t )
    {
      case 0: return "first";
      case 1: return "second";
      case 2: return "third";
      case 3: return "foruth";
      case 4: return "fifth";
      case 5: return "sixth";
      case 6: return "seventh";
      case 7: return "eight";
      case 8: return "nine";
      case 9: return "tenth";
      case 10: return "eleven";
      case 11: return "12";
      case 12: return "13";
      case 13: return "14";
      case 14: return "15";
      case 15: return "16";
      case 16: return "17";
      case 17: return "18";
      default: return "garbage";
    }
  }
}

/*
Seven planets, 18 commodities

Sequins
NFTs
Covid Vaccines
Pocket Squares
Concert Tickets
Kale
Antiques
Trading Cards
Blacklight Posters
Doughnut
Wedding Cake
Kobe Beef

*/
