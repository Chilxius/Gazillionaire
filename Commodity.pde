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
}

void setupCommodities()
{
  for( int i = 0; i < commodityCount; i++ )
    commodityName[i] = commodityName(i);
}

String commodityName( int t )
{
  int rand = int(random(2));
  switch( t )
  {
    case 0: if(rand==0) return "NFTs"; else return "VPNs";
    case 1: if(rand==0) return "Kobe Beef"; else return "Blue Raspberries";
    case 2: if(rand==0) return "Trading Cards"; else return "Comic Books";
    case 3: if(rand==0) return "Concert Tickets"; else return "PlayStation 5s";
    case 4: if(rand==0) return "Didgeridoos"; else return "Vuvuzelas";
    case 5: if(rand==0) return "Wedding Cakes"; else return "Crèmes Brûlées";
    case 6: if(rand==0) return "Blacklight posters"; else return "Disco Balls";
    case 7: if(rand==0) return "Garden Weasels"; else return "Zambonis";
    case 8: if(rand==0) return "Covid Vaccines"; else return "Apple Cider Vinegar";
    case 9: if(rand==0) return "Trapper Keepers"; else return "Tamagotchis";
    case 10: if(rand==0) return "Doughnuts"; else return "French Toast";
    case 11: if(rand==0) return "Pocket Squares"; else return "Fake Moustaches";
    case 12: if(rand==0) return "Betamax Cassettes"; else return "Strobe Lights";
    case 13: if(rand==0) return "Antiques"; else return "Hula Hoops";
    case 14: if(rand==0) return "Pot holders"; else return "Koozies";
    case 15: if(rand==0) return "Paperweights"; else return "Sand";
    case 16: if(rand==0) return "Kale"; else return "Organic Kale";
    case 17: if(rand==0) return "Sequins"; else return "Stickers";
    default: return "garbage";
  }
}

/*
Seven planets, 18 commodities

NFTs                 VPNs
Kobe beef            Blue Raspberries
Trading cards        Comic Books
Concert tickets      PlayStation 5s
Didgeridoos          Vuvuzelas
Wedding cakes        Crèmes brûlées
Blacklight posters   Disco Balls
Garden weasels       Zambonis
Covid vaccines       Apple Cider Vinegar
Trapper keepers      Tamagotchis
Doughnuts            French Toast
Pocket squares       Fake Moustaches
Betamax cassettes    Strobe Lights
Antiques             Hula Hoops
Pot holders          Koozies
Paperweights         Sand
Kale                 Organic Kale
Sequins              Stickers

Sand
Crème brûlée
Organic Kale
Comic Books
Stickers
Alarm Clocks
Fake Moustaches
Strobe Lights
Vuvuzelas
Tamagotchis
Blue Raspberries

*/
/*
Cantaloupe
Jelly Beans
Moon Ferns
Frog Legs
Whip Cream
Babel Seeds
Diapers
Umbrellas
Toasters
Polyester
Hair Tonic
Lava Lamps
Oxygen
Oggle Sand
Kryptoons
X Fuels
Gems
Exotic
*/
