class Merchant
{
  String name;
  
  Spaceship ship;
  Planet currentPlanet;
  boolean planetSplashed = false; //have we shown the splash screen yet
  boolean planetVisited = false; //has player used planet's unique option
  
  Commodity [] goods = new Commodity[commodityCount];
  //int [] goodsBuyPrice = new int[commodityCount];
  Commodity [] storage = new Commodity[commodityCount];
  //int [] storedGoodsPrice = new int[commodityCount];
  
  int money;
  
  int insuranceBase = 15; //increases by 10 for every ship upgrade
  boolean insured = false;
  
  int gasBase = 2;
  
  int [] shares = {2,0,0,0,0,0,0};
  float [] shareValues = {50,0,0,0,0,0,0};
  int shareTransaction = 0;
  
  int bankAccount;
  int bankInterest = 1;
  int bankLastEarned = 0;
  
  int loanTotal;
  int loanMax = 100000;
  int loanInterest = 5;
  int loanLastPaid = 0;
  
  int zinnTotal;
  int zinnMax = 200000;
  int zinnInterest = 4;
  int zinnLastPaid = 0;
  
  int marketProfit;
  
  int passTax; //tax on passengers
  int stuffTax; //tax on commodities (import and export)
  
  //int addsCost;
  int passengerAdd = 2; //2-8
  int goodsAdd = 9;     //9-15
  boolean paidForAdds;
  
  ArrayList<Integer> netWorthHistory = new ArrayList<Integer>();
  
  History netHistory;
  
  public Merchant( String n, Spaceship s )
  {
    name = n;
    ship = s;
    for(int i = 0; i < commodityCount; i++)
    {
      goods[i] = new Commodity(i);
      storage[i] = new Commodity(i);
    }
    money = 25000;
    bankAccount = 0;
    loanTotal = 500;
    zinnTotal = 100000;
    netHistory = new History(name,lineColor[currentPlayer],netWorth());
    currentPlanet = planet[int(random(7))];
  }
  
  //For computer merchants
  public Merchant( int i )
  {
    name = computerName[i];
    
    //Find a ship that's available
    int shipIndex = int(random(12));
    while( !shipAvailable[shipIndex] )
      shipIndex = int(random(12));
    ship = ships[shipIndex];
    shipAvailable[shipIndex]=false;
    
    for(int j = 0; j < commodityCount; j++)
    {
      goods[j] = new Commodity(j);
      storage[i] = new Commodity(j);
    }
    money = 25000;
    bankAccount = 0;
    loanTotal = 0;
    zinnTotal = 100000;
    netHistory = new History(name,lineColor[i],netWorth());
    currentPlanet = planet[int(random(7))];
  }
  
  void payMoney( int amount )
  {
    money -= amount;
    if( money < 0 )
    {
      takeLoan( abs(money) );
    }
  }
  
  void travelToPlanet( int planetIndex )
  {
    println( "Travel Dist: " + currentPlanet.dist[planetIndex] );
    
    //Can't travel to same world
    if( currentPlanet == planet[planetIndex] )
    {
      println("TRIED TO TRAVEL TO SAME PLANET");
      return;
    }
    
    //Check for enough gas
    ship.fuel -= currentPlanet.dist[planetIndex];
    if( ship.fuel < 0 )
    {
      currentScreen = Screen.MESSAGE;
      currentMessage = Message.NO_FUEL;
      payMoney( towCost() );
    }
    else
      currentScreen = Screen.PLANET_WELCOME;
    
    //Change Planet
    currentPlanet = planet[planetIndex];

  }
  
  int netWorth()
  {
    return (bankAccount+money+stockValue()) - (loanTotal+zinnTotal);
  }
  
  int stockValue()
  {
    return 0;
  }
  
  int insuranceCost()
  {
    return insuranceMulti*insuranceBase;
    //15-15000
    //26-26000
    //32-32000
    //43-43000
  }
  
  int gasCost()
  {
    return gasMulti*gasBase;
  }
  
  boolean canFillGas()
  {
    return( money > (gasCost()*(ship.fuelCapacity-ship.fuel)) );
  }
  
  void fillGas()
  {
    money -= gasCost()*(ship.fuelCapacity-ship.fuel);
    ship.fuel = ship.fuelCapacity;
  }
  
  void buyGas( int amount )
  {
    //Cap at missing amount
    amount = min( amount, ship.fuelCapacity-ship.fuel );
    
    //Make sure they can afford it
    int cost = amount * gasCost();
    if( cost > money ) { redWords("NOT ENOUGH CASH"); return; }
    
    //Take money, give fuel
    money -= cost;
    ship.fuel += amount;
  }
  
  String gasFraction()
  {
    return ship.fuel + "/" + ship.fuelCapacity;
  }
  
  //Bring fuel back to 10%, costs 2x normal fuel rate
  int towCost()
  {
    return ( abs(merchant[currentPlayer].ship.fuel)+int(merchant[currentPlayer].ship.fuelCapacity*0.1) ) * merchant[currentPlayer].gasCost() * 2;
  }
  
  int addsCost()
  {
    return advertizeCost(passengerAdd)+advertizeCost(goodsAdd);
  }
  
  void buyStocks()
  {
    buyStocks( planetNumber(currentPlanet), -1 );
  }
  
  //-1 to buy all
  void buyStocks( int p, int num )
  {
    if( num == -1 || num > planet[p].sharesForPurchase)
      num = planet[p].sharesForPurchase;

    if( planet[p].netHistory.netHistory.get(0)*num > money )
      redWords("NOT ENOUGH CASH");
    else
    {
      money -= planet[p].netHistory.netHistory.get(0)*num;
      shareTransaction -= planet[p].netHistory.netHistory.get(0)*num;
      planet[p].sharesForPurchase -= num;
      recalculatePurchaseValue( p, num );
    }
  }
  
  void sellStocks()
  {
    sellStocks( planetNumber(currentPlanet), -1 );
  }
  
  //-1 to sell all
  void sellStocks( int p, int num )
  {
    if( num == -1 || num > merchant[currentPlayer].shares[p] )
      num = merchant[currentPlayer].shares[p];
      
    money += shareValues[p]*num;
    shareTransaction += shareValues[p]*num;
    shares[p]-=num;
    if( shares[p] == 0 )
      shareValues[p]=0;
    planet[p].sharesForPurchase += num;
  }
  
  void recalculatePurchaseValue( int p, int n )
  {
    int totalStock = shares[p] + n;
    float newValue = ( (shareValues[p]*shares[p]) + (planet[p].netHistory.netHistory.get(0)*n) )/totalStock;
    
    shareValues[p] = newValue;
    shares[p] = totalStock;
  }
  
  void buyAdds()
  {
      advertizeButton[passengerAdd].col = 4;
      advertizeButton[goodsAdd].col = 4;
      mainButtonRight[1].col = 0;
      //addsCost = addsCost();
      money -= addsCost();
      paidForAdds = true;
  }
  
  void refundAddsCost()
  {
    if(!paidForAdds) return;
    
    money += addsCost();
    //addsCost = 0;
    paidForAdds = false;
    //passengerAdd = 2;
    //goodsAdd = 9;
  }
  
  void pickUpPassengers()
  {
    int numPassengers = min(ship.passengerCapacity-ship.passengers,currentPlanet.passengersAvailable);
    ship.passengers += numPassengers;
    currentPlanet.passengersAvailable-=ship.passengers;
    money += numPassengers*ship.passengerPrice;
    
    //Passenger Tax
    passTax += (numPassengers*ship.passengerPrice*passengerTax)/100;
    mainButtonRight[4].col = 3;
  }
  
  void buyInsurance()
  {
    if( !insured &&  money >= insuranceCost() )
    {
      money-=insuranceCost();
      insured = true;
    }
  }
  
  boolean payTaxes()
  {
    if( money >= totalTax() )
    {
      money-=totalTax();
      passTax = stuffTax = 0;
      return true;
    }
    
    return false;
  }
  
  void deposit( int amount )
  {
    amount = min( amount, money );
    bankAccount += amount;
    money -= amount;
  }
  
  void withdraw()
  {
    money+=bankAccount;
    bankAccount = 0;
  }
  
  boolean withdraw( int amount )
  {
    if( amount > bankAccount )
      return false;
      
    money += amount;
    bankAccount -= amount;
    
    return true;
  }
  
  void payLoan( int amount )
  {
    amount = min( amount, money );
    loanTotal -= amount;
    money -= amount;
    if( loanTotal < 0 )
    {
      money += abs(loanTotal);
      loanTotal = 0;
    }
  }
  
  void takeLoan()
  {
    int amountTaken = loanMax-loanTotal;
    money += amountTaken;
    loanTotal = loanMax;
  }
  
  //Returns false if player tries to take out too much money
  void takeLoan( int amount )
  {
    if( loanTotal + amount > loanMax )
      redWords("OVER BORROW LIMIT");
      
    money += amount;
    loanTotal += amount;
  }
  
  void payZinn( int amount )
  {
    amount = min( amount, money );
    zinnTotal -= amount;
    money -= amount;
    if( zinnTotal < 0 )
    {
      money += abs(zinnTotal);
      zinnTotal = 0;
    }
  }
  
  int totalTax()
  {
    return passTax + stuffTax;
  }
  
  public String toString()
  {
    return name;
  }
}

//cash, bank, loan, zinn, fuel, comodities, rates, passengers
