//NAMED "Page" TO NOT CONFLICT WITH "Screen"
//State class to handle different screens
//Hypothetical new system to replace switch in draw() and mousePressed()

//Improvement: Add Buttons to each concrete Screen as an array, draw all screen's buttons with a loop
//  Have buttons exist outside Screens to avoid constant creation/garbage collection?

//*******************************************
// State Manager for Page objects
//*******************************************
class ScreenManager
{
  Page currentScreen;
  
  public ScreenManager()
  {
    currentScreen = new TitleScreen();
  }
  
  public void setScreen( Page newScreen )
  {
    currentScreen = newScreen; 
  }
  
  public void display()
  {
    currentScreen.display();
  }
  
  public void checkMouseEvents( int x, int y )
  {
    currentScreen.checkMouseEvents(x,y);
  }
}

//*******************************************
// Abstract Page class for determining State
//*******************************************
abstract class Page //will be "Screen" eventually
{
  Button backButton;
  Button OKButton;
  
  Button [] buttons;
  
  abstract void display();
  abstract void checkMouseEvents(int x, int y);
}

//*******************************************
// Title Splash Screen
//*******************************************
class TitleScreen extends Page
{
  //Space background with title in the center
  void display()
  {
    push();
    background(0);
    drawStars();
    fill(#EBDC2D);
    textSize(adjustFloat(150,'x')); //100 on 1280
    textAlign(CENTER);
    text("BAZILLIONAIRE",width/2,height/2);
    textSize(adjustInt(20,'x'));
    text("[Click to Continue]",width/2,height*0.75);
    pop();
  }
  
  void checkMouseEvents(int x, int y)
  {
    manager.setScreen( new StartLoadScreen() );
  }
}

//*******************************************
// Screen for Staring new game or Loading
//*******************************************
class StartLoadScreen extends Page
{
  void display()
  {
    push();
    background(0);
    drawStars();
    newButton.drawButton();
    loadButton.drawButton();
    pop();
  }
  
  void checkMouseEvents(int x, int y)
  {
    if( newButton.mouseOnButton() )
      manager.setScreen( new PlayerCountScreen() );
    //TODO: Handle loading game
  }
}

//*******************************************
// Screen for selecting Player Count
//*******************************************
class PlayerCountScreen extends Page
{
  void display()
  {
    push();
    background(0);
    drawStars();
    for( Button b: playerCountButton )
      b.drawButton();
    pop();
  }
  
  void checkMouseEvents(int x, int y)
  {
    for( int i = 0; i < playerCountButton.length; i++ )
      if( playerCountButton[i].mouseOnButton() )
      {
        playerCount = i+1;
        typingMode = TypingMode.NAME;
        input = "Player 1";
        currentScreen = Screen.NAME;
        manager.setScreen( new EnterNameScreen() );
      }
  }
}

//*******************************************
// Screen for Typing the Player's Name
//*******************************************
class EnterNameScreen extends Page
{
  void display()
  {
    background(0);
    drawStars();
    drawQwerty();
  }
  
  void checkMouseEvents(int x, int y)
  {
    //currently handled by keyboard input - should change to be handled here
  }
}

//*******************************************
// Screen for Typing the Player's Name
//*******************************************
class ShipSelectScreen extends Page
{
  void display()
  {
    background(0);
    drawStars();
    textSize(adjustInt(40,'x'));
    textAlign(CENTER);
    text(input + ", choose your new ship:",screenWidth/2, screenHeight/12);
    for( int i = 0; i < shipButton.length; i++ )
      if( shipAvailable[i] )
        shipButton[i].drawButton();
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for Confirming Choice of Ship
//*******************************************
class ShipConfirmScreen extends Page
{
  void display()
  {
    background(0);
    drawStars();
    rectMode(CENTER);
    stroke(255);
    fill(0);
    rect(screenWidth/3.5,screenHeight/3,adjustFloat(600,'x'),adjustFloat(400,'y'));
    image(ships[currentShip].picLarge,screenWidth/3.5,screenHeight/3);
    fill(255);
    textSize( adjustInt(75,'x') );
    textAlign(CENTER);
    text(ships[currentShip].name,adjustFloat(975,'x'),adjustFloat(110,'y'));
    textSize( adjustInt(40,'x') );
    textAlign(LEFT);
    text("Cargo Capacity: ",  adjustFloat(700,'x'), adjustFloat(200,'y') ); text(ships[currentShip].cargoCapacity + " tons", adjustFloat(1080,'x'), adjustFloat(200,'y') );
    text("Engine Power: ",    adjustFloat(700,'x'), adjustFloat(250,'y') ); text(ships[currentShip].engine + " xanpars",     adjustFloat(1080,'x'), adjustFloat(250,'y') );
    text("Passenger Rooms: ", adjustFloat(700,'x'), adjustFloat(300,'y') ); text(ships[currentShip].passengerCapacity,       adjustFloat(1080,'x'), adjustFloat(300,'y') );
    text("Fuel Capacity: ",   adjustFloat(700,'x'), adjustFloat(350,'y') ); text(ships[currentShip].fuelCapacity + " tons",  adjustFloat(1080,'x'), adjustFloat(350,'y') );
    text("Required Crew: ",   adjustFloat(700,'x'), adjustFloat(400,'y') ); text(ships[currentShip].crew,                    adjustFloat(1080,'x'), adjustFloat(400,'y') );
    rectMode(CORNER);
    textSize( adjustInt(30,'x') );
    text(ships[currentShip].description, adjustFloat(70,'x'), adjustFloat(480,'y'), adjustFloat(1100,'x'),adjustFloat(300,'x'));
  
    buyShipButton.drawButton();
    dontBuyShipButton.drawButton();
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for any of the random Messages
//*******************************************
class MessageScreen extends Page
{
  void display()
  {
    background(15,80,175);
    fill(200);
    rectMode(CENTER);
    rect( screenWidth/2, screenHeight/4, messageImage(currentMessage).width+4, messageImage(currentMessage).height+4);
    image( messageImage(currentMessage), screenWidth/2, screenHeight/4 );
    textAlign(LEFT);
    rectMode(CORNER);
    textSize(adjustInt(25,'x'));
    fill(255);
    text( messageText(currentMessage), adjustFloat(25,'x'), screenHeight/2, screenWidth-adjustFloat(50,'x'), screenHeight );
    OKButton.drawButton();
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for any of the random Messages
//*******************************************
class WeekReviewScreen extends Page
{
  void display()
  {
    background(0,0,50);
    merchantCashGraph.drawGraph();
    
    OKButton.drawButton();
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for Planet Splash image
//*******************************************
class PlanetWelcomeScreen extends Page
{
  void display()
  {
    background(0);
    drawStars();
    image(merchant[currentPlayer].currentPlanet.picLarge,screenWidth/3,screenHeight/2);
    fill(255);
    textSize(adjustInt(40,'x'));
    textAlign(CENTER);
    text(""+merchant[currentPlayer], screenWidth*3/4, screenHeight/6);
    text("Welcome to "+merchant[currentPlayer].currentPlanet, screenWidth*3/4, screenHeight/4);
    textSize(adjustInt(20,'x'));
    text(""+merchant[currentPlayer].currentPlanet.description, screenWidth*3/4, screenHeight/3.5);
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for Main Planet Action Hub
//*******************************************
class MainScreen extends Page
{
  void display()
  {
    background(0);
    drawStars();
    for( int i = 0; i < mainButtonLeft.length; i++ )
    {
      mainButtonLeft[i].drawButton();
      mainButtonRight[i].drawButton();
    }
    for( int i = 0; i < mainButtonMiddle.length; i++ )
      mainButtonMiddle[i].drawButton();
    planetButton.drawButton();
    leaveButton.drawButton();
    textSize(adjustInt(45,'x'));
    textAlign(CENTER);
    fill(255);
    text( merchant[currentPlayer].name, screenWidth/2, screenHeight*1.5/20 );
    fill(225,225,0);
    textSize(adjustInt(35,'x'));
    text( asCash(merchant[currentPlayer].money) + " jeorbs", screenWidth/2, screenHeight*2.5/20 );
    drawFuelGage(0);
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for Ship Information
//*******************************************
class ShipInfoScreen extends Page
{
  void display()
  {
    //Name and pic
    background(175);
    stroke(150);
    fill(175);
    rectMode(CORNER);
    strokeWeight(3);
    rect(adjustInt(50,'x'),adjustInt(50,'y'),screenWidth-adjustInt(100,'x'),screenHeight-adjustInt(100,'y'));
    for( int i = adjustInt(50,'y'); i < screenHeight-adjustInt(50,'y'); i+=adjustInt(50,'y') )
      line( adjustInt(50,'x'), i, screenWidth-adjustInt(50,'x'), i );
    fill(175);
    rect(adjustInt(425,'x'),adjustInt(560,'y'),adjustInt(430,'x'),adjustInt(150,'y'));
    //Bolts
    fill(120);  noStroke();
    circle(25,25,30);               circle(screenWidth-25, 25, 30 );
    circle(25,screenHeight-25,30);  circle(screenWidth-25, screenHeight-25, 30 );
    circle(adjustInt(435,'x'),adjustInt(570,'y'),10);  circle(adjustInt(845,'x'),adjustInt(570,'y'),10);
    circle(adjustInt(435,'x'),adjustInt(700,'y'),10);  circle(adjustInt(845,'x'),adjustInt(700,'y'),10);
    textAlign(CENTER);
    rectMode(CENTER);
    stroke(255);
    fill(0);
    rect(screenWidth/2,screenHeight/2.6,adjustFloat(600,'x'),adjustFloat(400,'y'));
    image(merchant[currentPlayer].ship.picLarge,screenWidth/2,screenHeight/2.6);
    textSize(adjustInt(35,'x'));
    text(merchant[currentPlayer].ship.name, screenWidth/2, adjustFloat(90,'y'));
    
    //Ship data
    textSize(adjustInt(35,'x'));
    text( "Ship Size: " + merchant[currentPlayer].ship.size + " tons", screenWidth/2, adjustInt(540,'y') );
    text( "Weekly Crew Wages:", screenWidth/2, adjustInt(605,'y') );
    text( asCash(merchant[currentPlayer].ship.crew*merchant[currentPlayer].ship.crewWages) + " jeorbs", screenWidth/2, adjustInt(645,'y') );
    textSize(adjustInt(30,'x'));
    text( "(" + asCash(merchant[currentPlayer].ship.crewWages) + " per person)", screenWidth/2, adjustInt(685,'y') );
    textAlign(LEFT);
    textSize(adjustInt(35,'x'));
    text( "Engine: " + merchant[currentPlayer].ship.engine + " xanpars", adjustInt(50,'x'), adjustInt(540,'y') );
    text( "Cargo: " + merchant[currentPlayer].ship.cargoCapacity + " tons", adjustInt(50,'x'), adjustInt(590,'y') );
    text( "Fuel Tank: " + merchant[currentPlayer].ship.fuelCapacity + " tons", adjustInt(50,'x'), adjustInt(640,'y') );
    text( "Passenger Rooms: " + merchant[currentPlayer].ship.passengerCapacity, adjustInt(50,'x'), adjustInt(690,'y') );
    
    int crewTotal = merchant[currentPlayer].ship.crew;
    textAlign(RIGHT);
    text( "Pilot:", adjustInt(1140,'x'), adjustInt(550,'y') );
    crewTotal--;
    if( crewTotal > 0 )
      text( "Navigator:", adjustInt(1140,'x'), adjustInt(600,'y') );
    crewTotal--;
    if( crewTotal > 0 )
      text( "Engineer:", adjustInt(1140,'x'), adjustInt(650,'y') );
    crewTotal--;
    if( crewTotal > 0 )
      text( "Staff:", adjustInt(1140,'x'), adjustInt(700,'y') );
      
    crewTotal = merchant[currentPlayer].ship.crew;
    textAlign(LEFT);
    text( "1", adjustInt(1150,'x'), adjustInt(550,'y') );
    crewTotal--;
    if( crewTotal > 0 )
      text( "1", adjustInt(1150,'x'), adjustInt(600,'y') );
    crewTotal--;
    if( crewTotal > 0 )
      text( "1", adjustInt(1150,'x'), adjustInt(650,'y') );
    crewTotal--;
    if( crewTotal > 0 )
      text( crewTotal, adjustInt(1150,'x'), adjustInt(700,'y') );
      
    OKButton.drawButton();
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for Warehouse
//*******************************************
class WarehouseScreen extends Page
{
  void display()
  {
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for Planetary Stock Market
//*******************************************
class StockMarketScreen extends Page
{
  void display()
  {
    push();
    background(50,50,0);
    
    //Draw graph
    planetStocksGraph.drawGraph();
  
    //Info
    noStroke();
    rectMode(CENTER);
    fill(0,140,100);
    rect( adjustInt(1000,'x'), screenHeight*1/5, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*2/5, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*3/5, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*4/5, screenWidth/3, adjustInt(100,'y'), 20 );
    fill(150,240,150);
    rect( adjustInt(1000,'x'), screenHeight*1.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*2.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*3.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*4.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    textSize(adjustInt(35,'x'));
    textAlign(CENTER);
    fill(200);
    text( merchant[currentPlayer].currentPlanet.name + " Trading Floor", adjustInt(1000,'x'), screenHeight/15 );
    fill(0);
    textSize(adjustInt(20,'x'));
    text( "Shares Available / Current Value", adjustInt(1000,'x'), screenHeight*0.85/5 );
    text( merchant[currentPlayer].currentPlanet.sharesForPurchase + " / " + asCash(merchant[currentPlayer].currentPlanet.netHistory.netHistory.get(0)), adjustInt(1000,'x'), screenHeight*1.15/5 );
    text( "Your Shares in " + merchant[currentPlayer].currentPlanet.name +" / Purchase Price", adjustInt(1000,'x'), screenHeight*1.85/5 );
    text( merchant[currentPlayer].shares[planetNumber(merchant[currentPlayer].currentPlanet)] + " / " +asCash(int(merchant[currentPlayer].shareValues[planetNumber(merchant[currentPlayer].currentPlanet)])), adjustInt(1000,'x'), screenHeight*2.15/5 );
    text( "Transaction", adjustInt(1000,'x'), screenHeight*2.85/5 );
    text( asCash(merchant[currentPlayer].shareTransaction), adjustInt(1000,'x'), screenHeight*3.15/5 );
    text( "Your Cash", adjustInt(1000,'x'), screenHeight*3.85/5 );
    text( asCash(merchant[currentPlayer].money), adjustInt(1000,'x'), screenHeight*4.15/5 );
    
    //for( Button b: stockButton )
    //  b.drawButton();
  
    pop();
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for Bank
//*******************************************
class BankScreen extends Page
{
  void display()
  {
    push();
    background(18,143,171);
    
    //Image
    fill(200);
    rectMode(CORNER);
    imageMode(CORNER);
    rect( adjustInt(48,'x'), adjustInt(48,'y'), screenPic[2].width+4, screenPic[2].height+4);
    image( screenPic[2], adjustInt(50,'x'), adjustInt(50,'y') );
    
    //Info
    noStroke();
    rectMode(CENTER);
    fill(0,140,100);
    rect( adjustInt(1000,'x'), screenHeight*1/5, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*2/5, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*3/5, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*4/5, screenWidth/3, adjustInt(100,'y'), 20 );
    fill(150,240,150);
    rect( adjustInt(1000,'x'), screenHeight*1.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*2.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*3.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*4.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    textSize(adjustInt(35,'x'));
    textAlign(CENTER);
    fill(0);
    text( "Secure Cash Vault", adjustInt(1000,'x'), screenHeight/15 );
    textSize(adjustInt(20,'x'));
    text( "Account Balance", adjustInt(1000,'x'), screenHeight*0.85/5 );
    text( asCash(merchant[currentPlayer].bankAccount), adjustInt(1000,'x'), screenHeight*1.15/5 );
    text( "Interest Rate", adjustInt(1000,'x'), screenHeight*1.85/5 );
    text( merchant[currentPlayer].bankInterest + "%", adjustInt(1000,'x'), screenHeight*2.15/5 );
    text( "Interest Earned Last Week", adjustInt(1000,'x'), screenHeight*2.85/5 );
    text( asCash(merchant[currentPlayer].bankLastEarned), adjustInt(1000,'x'), screenHeight*3.15/5 );
    text( "Your Cash", adjustInt(1000,'x'), screenHeight*3.85/5 );
    text( asCash(merchant[currentPlayer].money), adjustInt(1000,'x'), screenHeight*4.15/5 );
    
    //for( Button b: bankButton )
    //  b.drawButton();
    pop();
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for Loan Office
//*******************************************
class LoanScreen extends Page
{
  void display()
  {
    push();
    //background(250,185,95);
    //background(128,0,32);
    background(66,0,33);
    
    //Image
    fill(200);
    rectMode(CORNER);
    imageMode(CORNER);
    rect( adjustInt(48,'x'), adjustInt(48,'y'), screenPic[1].width+4, screenPic[1].height+4);
    image( screenPic[1], adjustInt(50,'x'), adjustInt(50,'y') );
      
    //Info
    noStroke();
    rectMode(CENTER);
    fill(0,145,185);
    rect( adjustInt(1000,'x'), screenHeight*1/6, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*2/6, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*3/6, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*4/6, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*5/6, screenWidth/3, adjustInt(100,'y'), 20 );
    fill(175,210,220);
    rect( adjustInt(1000,'x'), screenHeight*1.1/6, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*2.1/6, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*3.1/6, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*4.1/6, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*5.1/6, screenWidth/3.1, adjustInt(50,'y'), 20 );
    textSize(adjustInt(35,'x'));
    textAlign(CENTER);
    fill(0);
    text( "Imperial Trade Union", adjustInt(1000,'x'), screenHeight/15 );
    textSize(adjustInt(20,'x'));
    text( "Loan Amount", adjustInt(1000,'x'), screenHeight*0.85/6 );
    text( asCash(merchant[currentPlayer].loanTotal), adjustInt(1000,'x'), screenHeight*1.15/6 );
    text( "Credit Limit", adjustInt(1000,'x'), screenHeight*1.85/6 );
    text( asCash(merchant[currentPlayer].loanMax), adjustInt(1000,'x'), screenHeight*2.15/6 );
    text( "Interest Rate", adjustInt(1000,'x'), screenHeight*2.85/6 );
    text( merchant[currentPlayer].loanInterest + "%", adjustInt(1000,'x'), screenHeight*3.15/6 );
    text( "Interest Paid Last Week", adjustInt(1000,'x'), screenHeight*3.85/6 );
    text( asCash(merchant[currentPlayer].loanLastPaid), adjustInt(1000,'x'), screenHeight*4.15/6 );
    text( "Your Cash", adjustInt(1000,'x'), screenHeight*4.85/6 );
    text( asCash(merchant[currentPlayer].money), adjustInt(1000,'x'), screenHeight*5.15/6 );
    
    //for( Button b: loanButton )
    //  b.drawButton();
    pop();
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for Paying Lady Flrrb
//*******************************************
class FlrrbScreen extends Page
{
  void display()
  {
    push();
    background(18,143,171);
    
    //Image
    fill(200);
    rectMode(CORNER);
    imageMode(CORNER);
    rect( adjustInt(48,'x'), adjustInt(48,'y'), screenPic[0].width+4, screenPic[0].height+4);
    image( screenPic[0], adjustInt(50,'x'), adjustInt(50,'y') );
    
    //Info
    noStroke();
    rectMode(CENTER);
    fill(250,160,100);
    rect( adjustInt(1000,'x'), screenHeight*1/6, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*2/6, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*3/6, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*4/6, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*5/6, screenWidth/3, adjustInt(100,'y'), 20 );
    fill(255,230,200);
    rect( adjustInt(1000,'x'), screenHeight*1.1/6, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*2.1/6, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*3.1/6, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*4.1/6, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*5.1/6, screenWidth/3.1, adjustInt(50,'y'), 20 );
    textSize(adjustInt(35,'x'));
    textAlign(CENTER);
    fill(0);
    text( "Lady Flrrb's Loan", adjustInt(1000,'x'), screenHeight/15 );
    textSize(adjustInt(20,'x'));
    text( "Loan Amount", adjustInt(1000,'x'), screenHeight*0.85/6 );
    text( asCash(merchant[currentPlayer].zinnTotal), adjustInt(1000,'x'), screenHeight*1.15/6 );
    text( "Credit Limit", adjustInt(1000,'x'), screenHeight*1.85/6 );
    text( asCash(merchant[currentPlayer].zinnMax), adjustInt(1000,'x'), screenHeight*2.15/6 );
    text( "Interest Rate", adjustInt(1000,'x'), screenHeight*2.85/6 );
    text( merchant[currentPlayer].zinnInterest + "%", adjustInt(1000,'x'), screenHeight*3.15/6 );
    text( "Interest Paid Last Week", adjustInt(1000,'x'), screenHeight*3.85/6 );
    text( asCash(merchant[currentPlayer].zinnLastPaid), adjustInt(1000,'x'), screenHeight*4.15/6 );
    text( "Your Cash", adjustInt(1000,'x'), screenHeight*4.85/6 );
    text( asCash(merchant[currentPlayer].money), adjustInt(1000,'x'), screenHeight*5.15/6 );
    
    //for( Button b: flrrbButton )
    //  b.drawButton();
    pop();
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for Buying Fuel
//*******************************************
class FuelScreen extends Page
{
  void display()
  {
    push();
    background(#8E3671);
    
    //Image
    fill(200);
    rectMode(CORNER);
    imageMode(CORNER);
    rect( adjustInt(48,'x'), adjustInt(48,'y'), screenPic[0].width+4, screenPic[0].height+4);
    image( screenPic[8], adjustInt(50,'x'), adjustInt(50,'y') );
    
    //Info
    noStroke();
    rectMode(CENTER);
    fill(#2B51A2);
    rect( adjustInt(1000,'x'), screenHeight*1/5, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*2/5, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*3/5, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*4/5, screenWidth/3, adjustInt(100,'y'), 20 );
    fill(#6DE5CC);
    rect( adjustInt(1000,'x'), screenHeight*1.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*2.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*3.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*4.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    textSize(adjustInt(35,'x'));
    textAlign(CENTER);
    fill(0);
    text( "Niez Kleen Gas Station", adjustInt(1000,'x'), screenHeight/15 );
    textSize(adjustInt(20,'x'));
    text( "Your Cash", adjustInt(1000,'x'), screenHeight*0.85/5 );
    text( asCash(merchant[currentPlayer].money), adjustInt(1000,'x'), screenHeight*1.15/5 );
    text( "Fuel Price Range (per ton)", adjustInt(1000,'x'), screenHeight*1.85/5 );
    text( asCash(merchant[currentPlayer].gasBase) + " - " + asCash(merchant[currentPlayer].gasBase*1000), adjustInt(1000,'x'), screenHeight*2.15/5 );
    text( "Fuel Cost (per ton)", adjustInt(1000,'x'), screenHeight*2.85/5 );
    text( asCash(merchant[currentPlayer].gasCost()), adjustInt(1000,'x'), screenHeight*3.15/5 );
    text( "Tank", adjustInt(1000,'x'), screenHeight*3.85/5 );
    text( merchant[currentPlayer].gasFraction(), adjustInt(1000,'x'), screenHeight*4.15/5 );
    
    //for( Button b: gasButton )
    //  b.drawButton();
      
    pop();
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for the main Market
//*******************************************
class MarketScreen extends Page
{
  void display()
  {
    push();
    background(#549B62);
    
    //Interactive Market Items
    interactiveMarket();
    
    //Info
    noStroke();
    rectMode(CENTER);
    fill(#625595);
    rect( adjustInt(1135,'x'), screenHeight*1/5, adjustFloat( 250,'x'), adjustInt(100,'y'), 20 );
    rect( adjustInt(1135,'x'), screenHeight*2/5, adjustFloat( 250,'x'), adjustInt(100,'y'), 20 );
    fill(#ac85c4);
    rect( adjustInt(1135,'x'), screenHeight*1.1/5, adjustFloat( 240,'x'), adjustInt(50,'y'), 20 );
    rect( adjustInt(1135,'x'), screenHeight*2.1/5, adjustFloat( 240,'x'), adjustInt(50,'y'), 20 );
    //Text
    textSize(adjustInt(35,'x'));
    textAlign(CENTER);
    fill(0);
    text( "Marketplace", adjustInt(1135,'x'), screenHeight/15 );
    textSize(adjustInt(20,'x'));
    text( "Your Cash", adjustInt(1135,'x'), screenHeight*0.85/5 );
    text( asCash(merchant[currentPlayer].money), adjustInt(1135,'x'), screenHeight*1.15/5 );
    text( "Profit", adjustInt(1135,'x'), screenHeight*1.85/5 );
    text( asCash(merchant[currentPlayer].marketProfit), adjustInt(1135,'x'), screenHeight*2.15/5 );
    
    //for( Button b: marketButton )
    //  b.drawButton();
    pop();
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for checking Goods Supplies
//*******************************************
class SupplyScreen extends Page
{
  void display()
  {

  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for first vising Planet
//*******************************************
class PlanetSplashScreen extends Page
{
  void display()
  {
    push();
    background(0);
    imageMode(CENTER);
    image( merchant[currentPlayer].currentPlanet.landscapeBig, screenWidth/2, merchant[currentPlayer].currentPlanet.landscapeBig.height/2 );
    pop();
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for vising Planet
//*******************************************
class PlanetScreen extends Page
{
  void display()
  {
    push();
    background(100);
    
    //Landscape Image
    fill(200);
    rectMode(CENTER);
    imageMode(CENTER);
    rect( screenWidth/2, screenHeight/2.2, merchant[currentPlayer].currentPlanet.picLandscape.width+4, merchant[currentPlayer].currentPlanet.picLandscape.height+4);
    image( merchant[currentPlayer].currentPlanet.picLandscape, screenWidth/2, screenHeight/2.2 );
    
    visitButton[merchant[currentPlayer].currentPlanet.index].drawButton();
    if( merchant[currentPlayer].planetVisited )
      visitButton[8].drawButton();
    else
      visitButton[7].drawButton();
    
    pop();
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for Space Map
//*******************************************
class MapScreen extends Page
{
  void display()
  {
    background(0);
    drawStars();
    for( Planet p: planet )
      p.drawSmallPlanet();
      
    mapBackButton.drawButton();
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for Picking up Passengers
//*******************************************
class PassengerScreen extends Page
{
  void display()
  {
    push();
    background(160,130,80);
    
    //Image
    fill(200);
    rectMode(CORNER);
    imageMode(CORNER);
    rect( adjustInt(48,'x'), adjustInt(98,'y'), screenPic[6].width+4, screenPic[6].height+4);
    image( screenPic[6], adjustInt(50,'x'), adjustInt(100,'y') );
    
    //Info
    noStroke();
    rectMode(CENTER);
    fill(250,160,100);
    rect( adjustInt(1000,'x'), screenHeight*1.8/6, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*2.8/6, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*3.8/6, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*4.8/6, screenWidth/3, adjustInt(100,'y'), 20 );
    fill(255,230,200);
    rect( adjustInt(1000,'x'), screenHeight*1.9/6, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*2.9/6, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*3.9/6, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*4.9/6, screenWidth/3.1, adjustInt(50,'y'), 20 );
    textSize(adjustInt(35,'x'));
    textAlign(CENTER);
    fill(0);
    text( "Passenger Deck", adjustInt(1000,'x'), screenHeight/5.5 );
    textSize(adjustInt(20,'x'));
    text( "Profit This Week", adjustInt(1000,'x'), screenHeight*1.625/6 );
    text( asCash(merchant[currentPlayer].ship.passengers*merchant[currentPlayer].ship.passengerPrice), adjustInt(1000,'x'), screenHeight*1.95/6 );
    text( "Ticket Price", adjustInt(1000,'x'), screenHeight*2.625/6 );
    text( asCash(merchant[currentPlayer].ship.passengerPrice), adjustInt(1000,'x'), screenHeight*2.95/6 );
    text( "Ticket Price Next Week", adjustInt(1000,'x'), screenHeight*3.625/6 );
    text( asCash(merchant[currentPlayer].ship.passengerPriceNext), adjustInt(1000,'x'), screenHeight*3.95/6 );
    text( "Passengers Waiting", adjustInt(1000,'x'), screenHeight*4.625/6 );
    text( merchant[currentPlayer].currentPlanet.passengersAvailable, adjustInt(1000,'x'), screenHeight*4.95/6 );
    
    drawPassengerBar();
    
    for(Button b: passengerButton)
      b.drawButton();
    pop();
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for Buying Advertizing
//*******************************************
class AdvertizingScreen extends Page
{
  void display()
  {
    push();
    background(255,150,175);
    
    //Image
    fill(200);
    rectMode(CORNER);
    imageMode(CORNER);
    rect( adjustInt(48,'x'), adjustInt(48,'y'), screenPic[5].width+4, screenPic[5].height+4);
    image( screenPic[7], adjustInt(50,'x'), adjustInt(50,'y') );
    
    //Info
    noStroke();
    rectMode(CENTER);
    fill(#625595);
    rect( adjustInt(845,'x'),  screenHeight*1.8/10, adjustFloat( 250,'x'), adjustInt(80,'y'), 20 );
    rect( adjustInt(1135,'x'), screenHeight*1.8/10, adjustFloat( 250,'x'), adjustInt(90,'y'), 20 );
    fill(#ac85c4);
    rect( adjustInt(845,'x'), screenHeight*2/10, adjustFloat( 240,'x'), adjustInt(40,'y'), 20 );
    rect( adjustInt(1135,'x'), screenHeight*2/10, adjustFloat( 240,'x'), adjustInt(40,'y'), 20 );
    //Text
    textSize(adjustInt(35,'x'));
    textAlign(CENTER);
    fill(0);
    text( "Advertizing", adjustInt(990,'x'), screenHeight/13 );
    //text( "Commodities", adjustInt(1135,'x'), screenHeight/13 );
    textSize(adjustInt(20,'x'));
    text( "Passenger", adjustInt(845,'x'), screenHeight*1.6/10 );
    text( asCash(advertizeCost(merchant[currentPlayer].passengerAdd)), adjustInt(845,'x'), screenHeight*2.08/10 );
    text( "Commodities", adjustInt(1135,'x'), screenHeight*1.6/10 );
    text( asCash(advertizeCost(merchant[currentPlayer].goodsAdd)), adjustInt(1135,'x'), screenHeight*2.08/10 );
    
    //for(Button b: advertizeButton)
    //  b.drawButton();
    pop();
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for Buying Insurance
//*******************************************
class InsuranceScreen extends Page
{
  void display()
  {
    push();
    background(50);
    
    //Image
    fill(200);
    rectMode(CORNER);
    imageMode(CORNER);
    rect( adjustInt(48,'x'), adjustInt(48,'y'), screenPic[5].width+4, screenPic[5].height+4);
    image( screenPic[5], adjustInt(50,'x'), adjustInt(50,'y') );
    
    //Info
    noStroke();
    rectMode(CENTER);
    fill(250,145,40);
    rect( adjustInt(1000,'x'), screenHeight*1/5, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*2/5, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*3/5, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*4/5, screenWidth/3, adjustInt(100,'y'), 20 );
    fill(250,200,145);
    rect( adjustInt(1000,'x'), screenHeight*1.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*2.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*3.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*4.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    textSize(adjustInt(35,'x'));
    textAlign(CENTER);
    fill(0);
    text( "Spaceflight Insurance", adjustInt(1000,'x'), screenHeight/15 );
    textSize(adjustInt(20,'x'));
    text( "Your Cash", adjustInt(1000,'x'), screenHeight*0.85/5 );
    text( asCash(merchant[currentPlayer].money), adjustInt(1000,'x'), screenHeight*1.15/5 );
    text( "Price Range", adjustInt(1000,'x'), screenHeight*1.85/5 );
    text( asCash(merchant[currentPlayer].insuranceBase) + " - " + asCash(merchant[currentPlayer].insuranceBase*1000), adjustInt(1000,'x'), screenHeight*2.15/5 );
    text( "Insurance Cost", adjustInt(1000,'x'), screenHeight*2.85/5 );
    text( asCash(merchant[currentPlayer].insuranceCost()), adjustInt(1000,'x'), screenHeight*3.15/5 );
    text( "Covered Next Week", adjustInt(1000,'x'), screenHeight*3.85/5 );
    if( merchant[currentPlayer].insured )
      text( "Yes", adjustInt(1000,'x'), screenHeight*4.15/5 );
    else
      text( "No", adjustInt(1000,'x'), screenHeight*4.15/5 );
  
    for(Button b: insureButton)
      b.drawButton();
      
    pop();
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for Paying your Crew's Wages
//*******************************************
class WagesScreen extends Page
{
  void display()
  {
    push();
    background(50,180,180);
    
    //Image
    fill(200);
    rectMode(CORNER);
    imageMode(CORNER);
    rect( adjustInt(48,'x'), adjustInt(48,'y'), screenPic[3].width+4, screenPic[3].height+4);
    image( screenPic[3], adjustInt(50,'x'), adjustInt(50,'y') );
    
    //Info
    noStroke();
    rectMode(CENTER);
    fill(250,75,65);
    rect( adjustInt(1000,'x'), screenHeight*1/5, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*2/5, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*3/5, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*4/5, screenWidth/3, adjustInt(100,'y'), 20 );
    fill(250,145,130);
    rect( adjustInt(1000,'x'), screenHeight*1.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*2.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*3.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*4.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    textSize(adjustInt(35,'x'));
    textAlign(CENTER);
    fill(0);
    text( "Crew Break Room", adjustInt(1000,'x'), screenHeight/15 );
    textSize(adjustInt(20,'x'));
    text( "Number of Employees", adjustInt(1000,'x'), screenHeight*0.85/5 );
    text( merchant[currentPlayer].ship.crew, adjustInt(1000,'x'), screenHeight*1.15/5 );
    text( "Weekly Salary per Person", adjustInt(1000,'x'), screenHeight*1.85/5 );
    text( asCash(merchant[currentPlayer].ship.crewWages), adjustInt(1000,'x'), screenHeight*2.15/5 );
    text( "Total Wages Owed", adjustInt(1000,'x'), screenHeight*2.85/5 );
    text( asCash(merchant[currentPlayer].ship.wagesOwed), adjustInt(1000,'x'), screenHeight*3.15/5 );
    text( "Your Cash", adjustInt(1000,'x'), screenHeight*3.85/5 );
    text( asCash(merchant[currentPlayer].money), adjustInt(1000,'x'), screenHeight*4.15/5 );
    
    //for( Button b: paymentButton)
    //  b.drawButton();
    pop();
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}

//*******************************************
// Screen for Paying your Taxes
//*******************************************
class TaxScreen extends Page
{
  void display()
  {
    push();
    background(200);
    
    //Image
    fill(200);
    rectMode(CORNER);
    imageMode(CORNER);
    rect( adjustInt(48,'x'), adjustInt(48,'y'), screenPic[4].width+4, screenPic[4].height+4);
    image( screenPic[4], adjustInt(50,'x'), adjustInt(50,'y') );
    
    //Info
    noStroke();
    rectMode(CENTER);
    fill(240,190,80);
    rect( adjustInt(1000,'x'), screenHeight*1/5, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*2/5, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*3/5, screenWidth/3, adjustInt(100,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*4/5, screenWidth/3, adjustInt(100,'y'), 20 );
    fill(220,215,210);
    rect( adjustInt(1000,'x'), screenHeight*1.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*2.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*3.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    rect( adjustInt(1000,'x'), screenHeight*4.1/5, screenWidth/3.1, adjustInt(50,'y'), 20 );
    textSize(adjustInt(35,'x'));
    textAlign(CENTER);
    fill(0);
    text( "Terrence The Tax Crab", adjustInt(1000,'x'), screenHeight/15 );
    textSize(adjustInt(20,'x'));
    text( "Passenger Taxes (" + passengerTax + "%)", adjustInt(1000,'x'), screenHeight*0.85/5 );
    text( asCash(merchant[currentPlayer].passTax), adjustInt(1000,'x'), screenHeight*1.15/5 );
    text( "Commodity Taxes (Import " + importTariff + "%, Export "+exportTariff+"%)", adjustInt(1000,'x'), screenHeight*1.85/5 );
    text( asCash(merchant[currentPlayer].stuffTax), adjustInt(1000,'x'), screenHeight*2.15/5 );
    text( "Total Taxes Accrued", adjustInt(1000,'x'), screenHeight*2.85/5 );
    text( asCash(merchant[currentPlayer].totalTax()), adjustInt(1000,'x'), screenHeight*3.15/5 );
    text( "Your Cash", adjustInt(1000,'x'), screenHeight*3.85/5 );
    text( asCash(merchant[currentPlayer].money), adjustInt(1000,'x'), screenHeight*4.15/5 );
    
    for( Button b: paymentButton)
      b.drawButton();
    pop();
  }
  
  void checkMouseEvents(int x, int y)
  {
  }
}
