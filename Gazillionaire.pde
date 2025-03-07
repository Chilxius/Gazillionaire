import java.util.Collections;

//Bazillionaire!

//Objects:
//planet: name, image, comodity list, fuel price
//merchant: cash, bank, loan, zinn, fuel, comodities, rates, passengers
//ship: size, fuel/cap, engine, passenger/cap, cargo/cap, crew
//record: for graphs, etc.

//Menus:
//main(travel)(stocks, money, bank, loan, zinn)(market,supply,werehouse)(passengers,adverts,crew wages,taxes,insurance,planet,file)(gas)

//Windows
//Stocks
//Money (page and update)
//Bank
//Loan
//Zinn
//Supply(buying)
//Marketplace
//Werehouse
//Passengers
//Advertizement
//Wages
//Taxes
//Insurance
//Planet
//File (save/load)
//Gas

// ! Change all button colors when next player's turn starts ! (main menu, adds)
//   Make loan/bank buttons change color when money is owed/saved
//   Update planets' available shares each round
//textLeading() changes space between lines, but rests with textSize(). Create a master method? (which adjusts)
//change takeLoan() to go into debt
//fix where towCost is calculated - can't happen in draw

//Display Data
Screen currentScreen, nextScreen;
TypingMode typingMode;

//Game Data
int cashGoal = 5000000;
//difficulty?
int passengerTax = 15;
int importTariff = 3;
int exportTariff = 2;
int commodityCount = 18; //Number of commodities in the game
int playerCount; //Player count (1-6)   HUMAN players - total merchants is always 6
int currentPlayer; //Current turn (0-5)  WILL NOT CORRESPOND TO PLAYER NUMBER, will correspond to turn order
int currentWeek;
int insuranceMulti = int(random(1000))+1;
int gasMulti = int(random(100))+1;

//Numpad Data
boolean numpadUp = false;
int numpadValue = 0;
boolean numpadDone = false;
NumpadPurpose use = NumpadPurpose.NONE;

//Size Variables
float screenWidth, screenHeight;

//Planet Data
Planet [] planet = new Planet[7];

//Ship Data
Spaceship [] ships = new Spaceship[12];
int currentShip = 11; //Ship being looked at for confirmation
boolean [] shipAvailable = {true,true,true,true,true,true,true,true,true,true,true,true};

//Merchant Data
Merchant [] merchant = new Merchant[6];
int [] turnOrder = {0,1,2,3,4,5};
float [] travelTime = {1,2,3,4,5,6};
String computerName[] = {"Bennett","Alex","Brett","Todd","James","Alan"};

//Red words (used for warnings)
String redWords = "";
float redWordsTimer = 0;

//Graph Data
LineGraph planetStocksGraph;
LineGraph merchantCashGraph;

//Color-changing Button Data
//boolean [] buttonPressed = {false,false,false,false,false}; //Passenger, Adds, Insurance, Crew, Taxes

//Commodity Data
String commodityName[] = new String[commodityCount];

void setup()
{
  fullScreen();
  imageMode(CENTER);
  currentScreen = Screen.TITLE;
  typingMode = TypingMode.NONE;
  screenWidth = width;
  screenHeight = height;
  textFont( createFont("Lucida Sans", 128) );
  setupScreenData();
  setupCommodities();
  setupPlanets();
  buildShips();
}

void draw()
{
  switch(currentScreen)
  {
    case TITLE:
      drawTitleScreen();
    break;
    
    case START_LOAD:
      drawSaveLoadScreen();
    break;
    
    case PLAYER_COUNT:
      drawPlayerCountScreen();
    break;
    
    case NAME:
      drawNameScreen();
    break;
    
    case CHOOSE_SHIP:
      drawShipSelectScreen();
    break;
    
    case SHIP_LOOK:
      drawShipConfirmScreen();
    break;
    
    case MESSAGE:
      drawMessageScreen();
    break;
    
    case WEEK_OVERVIEW:
      drawReviewScreen();
    break;
    
    case PLANET_WELCOME:
      drawPlanetWelcome();
    break;
    
    case MAIN:
      if(turnOrder[currentPlayer] < playerCount) //is a human player
        drawMainScreen();
      else
        runComputerTurn();
    break;
    
    case SHIP:
      drawShipInfoScreen();
    break;
    
    case WAREHOUSE:
      drawWarehouseScreen();
    break;
    
    case STOCK:
      drawStockMarketScreen();
    break;
          
    case BANK:
      drawBankScreen();
    break;
    
    case LOAN:
      drawLoanScreen();
    break;
    
    case ZINN:
      drawFlrrbScreen();
    break;
    
    case FUEL:
      drawGasScreen();
    break;
    
    case MARKET:
      drawMarketScreen();
    break;
    
    case SUPPLY:
      drawSupplyScreen();
    break;
    
    case PLANETSPLASH:
      drawPlanetSplashScreen();
    break;
    
    case PLANET:
      drawPlanetScreen();
    break;
    
    case MAP:
      drawMapScreen();
    break;
    
    case PASSENGERS:
      drawPassengerScreen();
    break;
    
    case ADVERTIZE:
      drawAdvertizingScreen();
    break;
    
    case INSURANCE:
      drawInsuranceScreen();
    break;
    
    case WAGES:
      drawCrewScreen();
    break;
    
    case TAX:
      drawTaxScreen();
    break;
    
    case NONE:
      drawTestScreen();
    break;
  }
  
  if(numpadUp)
  {
    drawNumpad();
    if( numpadDone )
      checkNumpadUses();
  }
  
  showRedWords();
  runAnimations();
  //println(currentScreen);
}

//For animated elements
void runAnimations()
{
  for( int i = 0; i < keyFlash.length; i++ )
    if( keyFlash[i] > 0 )
      keyFlash[i]-=5;
  for( int i = 0; i < numKeyFlash.length; i++ )
    if( numKeyFlash[i] > 0 )
      numKeyFlash[i]-=5;
  redWordsTimer-=2.5;
  //starburstRotation+=0.005;
}

//Computes the computer players' turns
void runComputerTurn()
{
  //should visit market and choose new planet
  //should then go to next player
}

void showRedWords()
{
  if( redWordsTimer < 0 )
    return;
  push();
  textSize(adjustInt(90,'x'));
  textAlign(CENTER);
  fill(200,0,0,redWordsTimer);
  text( redWords, screenWidth/2, screenHeight/2 );
  pop();
}

//Checks for the cases when a numpad entry is sent (checkmark is clicked)
void checkNumpadUses()
{
  switch( use )
  {
    case ZINN:
      merchant[currentPlayer].payZinn(numpadValue);
      break;
      
    case BUY_STOCK:
      merchant[currentPlayer].buyStocks(planetNumber(merchant[currentPlayer].currentPlanet),numpadValue);
      break;
      
    case SELL_STOCK:
      merchant[currentPlayer].sellStocks(planetNumber(merchant[currentPlayer].currentPlanet),numpadValue);
      break;
      
    case LOAN:
      merchant[currentPlayer].payLoan(numpadValue);
      break;
      
    case BORROW:
      merchant[currentPlayer].takeLoan(numpadValue);
      break;
      
    case DEPOSIT:
      merchant[currentPlayer].deposit(numpadValue);
      break;
      
    case WITHDRAW:
      if(!merchant[currentPlayer].withdraw(numpadValue))
        redWords("INSUFFICIENT FUNDS");
      break;

    case GAS:
      merchant[currentPlayer].buyGas(numpadValue);
      break;
      
    case TICKET:
      merchant[currentPlayer].ship.passengerPriceNext = max(min(numpadValue,1000000),100);
      break;
  }
  
  numpadUp=false;
  numpadValue=0;
  numpadDone=false;
}

//Determine turn order based on travel time
void setTurnOrder()
{
  float shortest;
  int quickestIndex;
  for( int j = 0; j < 6; j++ )
  {
    shortest = travelTime[0];
    quickestIndex = 0;
     
    for(int i = 1; i < 6; i++)
      if( shortest > travelTime[i] )
        quickestIndex = i;
    turnOrder[j] = quickestIndex;
    travelTime[quickestIndex] = 10000;
  }
}

//Triggers the red words to flash on screen
void redWords( String words )
{
  redWords = words;
  redWordsTimer = 250;
}

int adjustInt( int value, char axis )
{
  float returnValue = value;
  if( axis == 'x' )
    returnValue = returnValue / 1280 * screenWidth;
  else if( axis == 'y' )
    returnValue = returnValue / 800 * screenHeight;
  return int(returnValue);
}

float adjustFloat( float value, char axis )
{
  if( axis == 'x' )
    value = value / 1280 * screenWidth;
  else if( axis == 'y' )
    value = value / 800 * screenHeight;
  return value;
}

int advertizeCost( int index )
{
  switch( index )
  {
    case 2: return 0;
    case 3: return 1000;
    case 4: return 2000;
    case 5: return 3000;
    case 6: return 4000;
    case 7: return 5000;
    case 8: return 10000;
    
    case 9: return 0;
    case 10: return 1000;
    case 11: return 2000;
    case 12: return 3000;
    case 13: return 4000;
    case 14: return 5000;
    case 15: return 10000;
  }
  
  //Should not reach this
  return -1;
}

public void mousePressed()
{
  println( mouseX + " " + mouseY );

  if( numpadUp )
  {
    int n = checkForNum();
    if( n == -1 )
      return;
    else if( n == 15 )
    {
      numpadDone = true;
      numKeyFlash[11] = 200;
    }
    else if( n == -15 ) //backspace
    {
      numpadValue /= 10;
      numKeyFlash[9] = 200;
    }
    else
    {
      if( n > 0 )
        numKeyFlash[n-1] = 200;
      else
        numKeyFlash[10] = 200;
      if( numpadValue < 1000000 ) //can't go over 9999999
      {
        numpadValue*=10;
        numpadValue+=n;
      }
    }
  }
  else switch(currentScreen)
  {
    case TITLE:
    {
      currentScreen = Screen.START_LOAD;
    }
    return;
    
    case START_LOAD:
    {
      if( newButton.mouseOnButton() )
        currentScreen = Screen.PLAYER_COUNT;
    }
    return;
    
    case PLAYER_COUNT:
    {
      for( int i = 0; i < playerCountButton.length; i++ )
        if( playerCountButton[i].mouseOnButton() )
        {
          playerCount = i+1;
          typingMode = TypingMode.NAME;
          input = "Player 1";
          currentScreen = Screen.NAME;
        }
    }
    return;
    
    case NAME:
    {
    }
    break;
    
    case CHOOSE_SHIP:
    {
      for( int i = 0; i < shipButton.length; i++ )
        if( shipButton[i].mouseOnButton() )
        {
          currentShip = i;
          currentScreen = Screen.SHIP_LOOK;
        }
    }
    return;
    
    case SHIP_LOOK:
    {
      if( buyShipButton.mouseOnButton() )
      {
        merchant[currentPlayer] = new Merchant( input, ships[currentShip] );
        currentPlayer++;
        shipAvailable[currentShip] = false;
        currentScreen = Screen.MESSAGE;
        currentMessage = Message.ZINN;
        if( currentPlayer >= playerCount ) //all players created
        {
          while( currentPlayer < 6 )
          {
            merchant[currentPlayer] = new Merchant( currentPlayer++ );
          }
          
          
          println("about to build graphs");
          buildGraphs();
          println("built graphs");
          nextScreen = Screen.WEEK_OVERVIEW;
        }
        else
        {
          input = "Player " + (currentPlayer+1);
          typingMode = TypingMode.NAME;
          nextScreen = Screen.NAME;
        }
      }
      if( dontBuyShipButton.mouseOnButton() )
        currentScreen = Screen.CHOOSE_SHIP;
    }
    return;
    
    case MESSAGE:
    {
      if( OKButton.mouseOnButton() )
      {
        //got towed
        if( currentMessage == Message.NO_FUEL )
          merchant[currentPlayer].ship.fuel = int(merchant[currentPlayer].ship.fuelCapacity*0.1);
          
        currentScreen = nextScreen;
      }
    }
    return;
    
    case WEEK_OVERVIEW:
    {
      if( OKButton.mouseOnButton() )
      {
        currentScreen = Screen.PLANET_WELCOME;
        setTurnOrder();
        currentPlayer = 0;
      }
    }
    return;
    
    case PLANET_WELCOME:
    {
      currentScreen = Screen.MAIN;
      resetButtonColors( merchant[currentPlayer] );
    }
    return;
    
    case MAIN:
    {
      if     ( mainButtonLeft[0].mouseOnButton() ) currentScreen = Screen.SHIP;
      else if( mainButtonLeft[1].mouseOnButton() ) currentScreen = Screen.WAREHOUSE;
      else if( mainButtonLeft[2].mouseOnButton() ) currentScreen = Screen.STOCK;
      else if( mainButtonLeft[3].mouseOnButton() ) currentScreen = Screen.BANK;
      else if( mainButtonLeft[4].mouseOnButton() ) currentScreen = Screen.LOAN;
      else if( mainButtonLeft[5].mouseOnButton() ) currentScreen = Screen.ZINN;
      
      else if( planetButton.mouseOnButton() )
      {
        if( !merchant[currentPlayer].planetSplashed ) currentScreen = Screen.PLANETSPLASH;
        else
        {
          merchant[currentPlayer].planetSplashed=true;
          currentScreen=Screen.PLANET;
        }
      }
      else if( leaveButton.mouseOnButton() ) currentScreen = Screen.MAP;
      
      else if( mainButtonMiddle[0].mouseOnButton() ) currentScreen = Screen.FUEL;
      else if( mainButtonMiddle[1].mouseOnButton() ) currentScreen = Screen.MARKET;
      
      else if( mainButtonRight[0].mouseOnButton() ) currentScreen = Screen.PASSENGERS;
      else if( mainButtonRight[1].mouseOnButton() ) currentScreen = Screen.ADVERTIZE;
      else if( mainButtonRight[2].mouseOnButton() ) currentScreen = Screen.INSURANCE;
      else if( mainButtonRight[3].mouseOnButton() ) currentScreen = Screen.WAGES;
      else if( mainButtonRight[4].mouseOnButton() ) currentScreen = Screen.TAX;
      else if( mainButtonRight[5].mouseOnButton() ) saveAndQuit();
    }
    return;
    
    case SHIP:
    {
      if( OKButton.mouseOnButton() )
        currentScreen = Screen.MAIN;
    }
    return;
    
    case STOCK:
    {
      if( stockButton[0].mouseOnButton() )
        currentScreen = Screen.MAIN;
        
      else if( stockButton[1].mouseOnButton() )
      {
        numpadUp = true;
        use = NumpadPurpose.BUY_STOCK;
      }
      else if( bankButton[2].mouseOnButton() )
        merchant[currentPlayer].buyStocks();
      else if( loanButton[3].mouseOnButton() )
      {
        numpadUp = true;
        use = NumpadPurpose.SELL_STOCK;
      }
      else if( bankButton[4].mouseOnButton() )
        merchant[currentPlayer].sellStocks();
    }
    return;
    
    case BANK:
    {
      if( bankButton[0].mouseOnButton() )
      {
        currentScreen = Screen.MAIN;
        
        //Change color if money in bank
        if( merchant[currentPlayer].bankAccount == 0 )
          mainButtonLeft[3].col = 0;
        else
          mainButtonLeft[3].col = 1;
      }
        
      else if( bankButton[1].mouseOnButton() )
      {
        numpadUp = true;
        use = NumpadPurpose.DEPOSIT;
      }
      else if( bankButton[2].mouseOnButton() )
        merchant[currentPlayer].deposit(merchant[currentPlayer].money);
      else if( loanButton[3].mouseOnButton() )
      {
        numpadUp = true;
        use = NumpadPurpose.WITHDRAW;
      }
      else if( bankButton[4].mouseOnButton() )
        merchant[currentPlayer].withdraw();
    }
    return;
    
    case LOAN:
    {
      if( loanButton[0].mouseOnButton() )
      {
        currentScreen = Screen.MAIN;
        
        //Change color if in debt
        if( merchant[currentPlayer].loanTotal == 0 )
          mainButtonLeft[4].col = 0;
        else
          mainButtonLeft[4].col = 3;
      }
        
      else if( loanButton[1].mouseOnButton() )
      {
        numpadUp = true;
        use = NumpadPurpose.LOAN;
      }
      else if( loanButton[2].mouseOnButton() )
        merchant[currentPlayer].payLoan(merchant[currentPlayer].money);
      else if( loanButton[3].mouseOnButton() )
      {
        numpadUp = true;
        use = NumpadPurpose.BORROW;
      }
      else if( loanButton[4].mouseOnButton() )
        merchant[currentPlayer].takeLoan();
    }
    return;
    
    case ZINN:
    {
      if( flrrbButton[0].mouseOnButton() )
      {
        currentScreen = Screen.MAIN;
        
        //Change color if in debt
        if( merchant[currentPlayer].zinnTotal == 0 )
          mainButtonLeft[5].col = 0;
        else
          mainButtonLeft[5].col = 3;
      }
      
      else if( flrrbButton[1].mouseOnButton() ) //Pay some
      {
        numpadUp = true;
        use = NumpadPurpose.ZINN;
      }
      else if( flrrbButton[2].mouseOnButton() && merchant[currentPlayer].money > 0 ) //Pay Max
        merchant[currentPlayer].payZinn(merchant[currentPlayer].money);
    }
    return;
    
    case PLANETSPLASH:
    {
      merchant[currentPlayer].planetSplashed = true;
      currentScreen = Screen.PLANET;
    }
    return;
    
    case PLANET:
    {
      if( (!merchant[currentPlayer].planetVisited && visitButton[7].mouseOnButton() )
       || (merchant[currentPlayer].planetVisited && visitButton[8].mouseOnButton() ))
         currentScreen = Screen.MAIN;
    }
    return;
    
    case FEATURE:
    {
      
    }
    return;
    
    case MAP:
    {
      for( int i = 0; i < planet.length; i++ )
        if( dist( mouseX, mouseY, planet[i].xPos, planet[i].yPos ) < 75 )
          merchant[currentPlayer].travelToPlanet(i);
          
      if( mapBackButton.mouseOnButton() )
        currentScreen = Screen.MAIN;
    }
    return;
    
    case FUEL:
    {
      if( gasButton[0].mouseOnButton() )
        currentScreen = Screen.MAIN;
        
      else if( gasButton[1].mouseOnButton() )
      {
        numpadUp = true;
        use = NumpadPurpose.GAS;
      }
        
      else if( gasButton[2].mouseOnButton() )
        if( merchant[currentPlayer].canFillGas() )
          merchant[currentPlayer].fillGas();
        else
          redWords("NOT ENOUGH CASH");
    }
    return;
    
    case MARKET:
    {
      if( marketButton[0].mouseOnButton() )
        currentScreen = Screen.MAIN;
    }
    return;
    
    case PASSENGERS:
    {
      if( passengerButton[0].mouseOnButton() )
        currentScreen = Screen.MAIN;
      if( passengerButton[1].mouseOnButton() ) //Pick up passengers
      {
        merchant[currentPlayer].pickUpPassengers();
        mainButtonRight[0].col = 0;
      }
      if( passengerButton[2].mouseOnButton() ) //Set ticket price
      {
        numpadUp = true;
        use = NumpadPurpose.TICKET;
      }
    }
    return;
    
    case ADVERTIZE:
    {
      if( advertizeButton[0].mouseOnButton() )
        currentScreen = Screen.MAIN;
      if( advertizeButton[1].mouseOnButton() )
      {
        //Not enough money
        if( merchant[currentPlayer].money < merchant[currentPlayer].addsCost() )//advertizeCost(merchant[currentPlayer].passengerAdd)+advertizeCost(merchant[currentPlayer].goodsAdd) )
          redWords("NOT ENOUGH MONEY");
        else
        {
          merchant[currentPlayer].buyAdds();
          //advertizeButton[merchant[currentPlayer].passengerAdd].col = 4;
          //advertizeButton[merchant[currentPlayer].goodsAdd].col = 4;
          //mainButtonRight[1].col = 0;
          //merchant[currentPlayer].addsCost = merchant[currentPlayer].addsCost();
          //merchant[currentPlayer].money -= merchant[currentPlayer].addsCost;
        }
      }
      
      //Check all level choices
      for( int i = 2; i <= 8; i++ )
      {
        if( advertizeButton[i].mouseOnButton() )
        {
          //De-confirm
          mainButtonRight[1].col = 3;
          advertizeButton[merchant[currentPlayer].goodsAdd].col = 3;
          merchant[currentPlayer].refundAddsCost();
          
          //Change choice
          advertizeButton[merchant[currentPlayer].passengerAdd].col = 5;
          merchant[currentPlayer].passengerAdd = i;
          advertizeButton[merchant[currentPlayer].passengerAdd].col = 3;
        }
        if( advertizeButton[i+7].mouseOnButton() )
        {
          //De-confirm
          mainButtonRight[1].col = 3;
          advertizeButton[merchant[currentPlayer].passengerAdd].col = 3;
          merchant[currentPlayer].refundAddsCost();
          
          //Change choice
          advertizeButton[merchant[currentPlayer].goodsAdd].col = 5;
          merchant[currentPlayer].goodsAdd = i+7;
          advertizeButton[merchant[currentPlayer].goodsAdd].col = 3;
        }
      }
    }
    return;
    
    case INSURANCE:
    {
      if( insureButton[0].mouseOnButton() )
        currentScreen = Screen.MAIN;
      if( insureButton[1].mouseOnButton() )
      {
        merchant[currentPlayer].buyInsurance();
        mainButtonRight[2].col = 0;
      }
    }
    return;
    
    case WAGES:
    {
      if( paymentButton[0].mouseOnButton() )
        currentScreen = Screen.MAIN;
      if( paymentButton[1].mouseOnButton() )
      {
        //pay wages
        mainButtonRight[3].col = 0;
      }
    }
    return;
    
    case TAX:
    {
      if( paymentButton[0].mouseOnButton() )
        currentScreen = Screen.MAIN;
      if( paymentButton[1].mouseOnButton() )
      {
        //pay wages
        if( merchant[currentPlayer].payTaxes() )
          mainButtonRight[4].col = 0;
        else
          redWords("NOT ENOUGH CASH");
      }
    }
    return;
  }
  
  //For typing
  if( typingMode != TypingMode.NONE )
  {
    char letter = checkForLetter();
    if( letter == ' ' )
      return;
    else if( letter == '-' && input.length() > 0 )
      input = input.substring(0,input.length()-1);
    else if( letter == '=' && input.length() > 0 )
    {
      if( typingMode == TypingMode.NAME )
      {
        typingMode = TypingMode.NONE;
        currentScreen = Screen.CHOOSE_SHIP;
      }

    }
    else if( letter == '_' )
      input += ' ';
    else
      input += letter;
  }
}

//Check if letter was pressed
char checkForLetter()
{
  for( int i = 0; i < 10; i++ )
    if( dist( mouseX, mouseY, qwertyX1+i*adjustInt(100,'x'), (screenHeight*1/2)+adjustInt(40,'y') ) < adjustInt(50,'x') )
    {
      keyFlash[i]=200;
      return qwerty[i];
    }
  for( int i = 0; i < 9; i++ )
    if( dist( mouseX, mouseY, qwertyX2+i*adjustInt(100,'x'), (screenHeight*1/2)+adjustInt(140,'y') ) < adjustInt(50,'x') )
    {
      keyFlash[i+10]=200;
      return qwerty[i+10];
    }
  for( int i = 0; i < 8; i++ )
    if( dist( mouseX, mouseY, qwertyX3+i*adjustInt(100,'x'), (screenHeight*1/2)+adjustInt(240,'y') ) < adjustInt(50,'x') )
    {
      keyFlash[i+19]=200;
      return qwerty[i+19];
    }
    
  if( dist(mouseX,mouseY, screenWidth/10,screenHeight*13/16) < adjustInt(70,'x') )
  {
    keyFlash[27]=200;
    return '-';   
  }
  if( dist(mouseX,mouseY, screenWidth-screenWidth/10,screenHeight*13/16) < adjustInt(70,'x') )
  {
    keyFlash[28]=200;
    return '=';
  }
      
  return ' ';
}

//returns numbers 0-9, -1 for nothing, -15 for delete, 15 for enter
int checkForNum()
{
  for( int i = 0; i < 9; i++ )
    if( dist( mouseX, mouseY, screenWidth/2+((i%3-1)*keySize*1.2), screenHeight*1.75/3-(i/3*keySize*1.2) ) < adjustInt(50,'x') )
      return i+1;
  if( dist( mouseX, mouseY, screenWidth/2, screenHeight*1.75/3+(keySize*1.2) ) < adjustInt(50,'x') )
    return 0;
  if( dist( mouseX, mouseY, screenWidth/2-keySize*1.2, screenHeight*1.75/3+(keySize*1.2) ) < adjustInt(50,'x') )
    return -15;
  if( dist( mouseX, mouseY, screenWidth/2+keySize*1.2, screenHeight*1.75/3+(keySize*1.2) ) < adjustInt(50,'x') )
    return 15;

  return -1;
}

void saveAndQuit()
{
  
}

public enum Screen
{
  TITLE, START_LOAD, PLAYER_COUNT, NAME, CHOOSE_SHIP, WEEK_OVERVIEW, PLANET_WELCOME, MAIN, 
  MESSAGE,                                SHIP_LOOK,                                 SHIP, WAREHOUSE, STOCK, BANK, LOAN, ZINN,     
  NONE,                                                                              PLANETSPLASH, PLANET, FEATURE, MAP, FUEL, MARKET, SUPPLY,
                                                                                     PASSENGERS, ADVERTIZE, INSURANCE, WAGES, TAX
}

public enum NumpadPurpose
{
  ZINN, BORROW, LOAN, DEPOSIT, WITHDRAW, TICKET, GAS,
  BUY_STOCK, SELL_STOCK,
  NONE
}

public enum TypingMode
{
  NAME,
  NONE
}

//WINDOWS:
  //TITLE -> Start / Load
  //? start -> difficulty ?
  //? difficulty -> player count ?
  //name
  //choose ship
  //zinn loan message
  
  //start cycle
  //Weekly overview
  //planet welcome
  //net worth review
  //MAIN SCREEN
    //ACTION SELECTION
  //Planet screen - facilities
  //STUFF HAPPENS
  //competitor updates
  
//FOR TESTING
void keyPressed()
{
  //merchant[currentPlayer].ship.fuel-=10;
}
