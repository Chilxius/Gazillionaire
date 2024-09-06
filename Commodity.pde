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
      default: return "garbage";
    }
  }
}
