class Merchant
{
  String name;
  
  Spaceship ship;
  Planet currentPlanet;
  boolean planetSplashed = false; //have we shown the splash screen yet
  boolean planetVisited = false; //has player used planet's unique option
  
  Commodity [] goods = new Commodity[commodityCount];
  
  int money;
  
  int insuranceBase = 15; //increases by 10 for every ship upgrade
  boolean insured = false;
  
  int gasBase = 2;
  
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
      goods[i] = new Commodity(i);
    money = 25000;
    bankAccount = 0;
    loanTotal = 500;
    zinnTotal = 100000;
    netHistory = new History(netWorth());
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
      goods[j] = new Commodity(j);
    money = 25000;
    bankAccount = 0;
    loanTotal = 0;
    zinnTotal = 100000;
    netHistory = new History(netWorth());
    currentPlanet = planet[int(random(7))];
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
  
  String gasFraction()
  {
    return ship.fuel + "/" + ship.fuelCapacity;
  }
  
  int addsCost()
  {
    return advertizeCost(passengerAdd)+advertizeCost(goodsAdd);
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
  }
  
  void buyInsurance()
  {
    if( !insured &&  money >= insuranceCost() )
    {
      money-=insuranceCost();
      insured = true;
    }
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
  boolean takeLoan( int amount )
  {
    if( loanTotal + amount > loanMax )
      return false;
      
    money += amount;
    loanTotal += amount;
    
    return true;
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
