//This tab contains the data and functions for
//drawing various screens.

//DATA
int [][] starPos = new int[2][750];

//Dem buttons, dem buttons, dem dry buttons
Button backButton;
Button OKButton;
Button newButton, loadButton, saveButton;
Button [] playerCountButton = new Button[6];
Button buyShipButton, dontBuyShipButton;
ShipButton [] shipButton = new ShipButton[12];
Button [] mainButtonLeft = new Button[6];
Button [] mainButtonMiddle = new Button[2];
Button [] mainButtonRight = new Button[6];
PicButton planetButton, leaveButton;
Button [] bankButton = new Button[5];
Button [] loanButton = new Button[5];
Button [] flrrbButton = new Button[3];
Button [] paymentButton = new Button[2];
Button [] insureButton = new Button[2];
Button [] passengerButton = new Button[3];
Button [] visitButton = new Button[9];

String input = ""; //for keyboard input
char qwerty [] = {'Q','W','E','R','T','Y','U','I','O','P','A','S','D','F','G','H','J','K','L','Z','X','C','V','B','N','M','_'};
char numPadBottom [] = {'←','0','✓'};
int keyFlash [] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
int numKeyFlash [] = {0,0,0,0,0,0,0,0,0,0,0,0};
float qwertyX1,qwertyX2,qwertyX3;
int keySize;
String messageText;
Message currentMessage;
float starburstRotation;

PImage messagePic [] = new PImage[20]; //UPDATE AS NEEDED
PImage screenPic [] = new PImage[10]; //UPDATE AS NEEDED

//Sets up buttons and other data for the different screens
void setupScreenData()
{
  for(int i = 0; i < starPos[0].length; i++)
  {
    starPos[0][i] = int(random(screenWidth));
    starPos[1][i] = int(random(screenHeight));
  }
  
  OKButton = new Button( screenWidth/2, screenHeight*.95, adjustInt(400,'x'), adjustInt(75,'y'), 1, "OK" );
  
  newButton  = new Button(screenWidth/2, screenHeight*1/3, adjustFloat(500,'x'), adjustFloat(75,'y'), 0, "New Game");
  loadButton = new Button(screenWidth/2, screenHeight*2/3, adjustFloat(500,'x'), adjustFloat(75,'y'), 3, "Load Game");
  
  for(int i = 0; i < shipButton.length; i++)
    shipButton[i] = new ShipButton( ((i*screenWidth/5)%(screenWidth*.8))+screenWidth/5, ((i/4)+1)*(screenHeight/3.9), i );
  for(int i = 0; i < playerCountButton.length; i++)
    playerCountButton[i] = new Button( screenWidth/2, screenHeight/7*(i+1), adjustFloat(900,'x'), adjustFloat(75,'y'), 1, (i+1)+" Players");
    
  qwertyX1 = screenWidth/2-adjustInt(450,'x');
  qwertyX2 = screenWidth/2-adjustInt(400,'x');
  qwertyX3 = screenWidth/2-adjustInt(350,'x');
  keySize = adjustInt(90,'x');
  
  buyShipButton = new Button( screenWidth/4, screenHeight*.95, adjustFloat(400,'x'), adjustFloat(75,'y'), 0, "I'll Take It!");
  dontBuyShipButton = new Button( screenWidth*3/4, screenHeight*.95, adjustFloat(400,'x'), adjustFloat(75,'y'), 2, "Reconsider...");
  
  messagePic[0] = loadImage("flrrb.png"); messagePic[0].resize( 0, adjustInt(350,'y') ); //Lady Flrrb's tower
  
  screenPic[0] = loadImage("flrrb.png");     screenPic[0].resize(0,adjustInt(650,'y') ); //Lady Flrrb's tower
  screenPic[1] = loadImage("bank.png");      screenPic[1].resize(0,adjustInt(650,'y') ); //Bank buildings (for loan office - poorly named)
  screenPic[2] = loadImage("piggy.png");     screenPic[2].resize(0,adjustInt(650,'y') ); //Piggy Bank
  screenPic[3] = loadImage("crew.png");      screenPic[3].resize(0,adjustInt(650,'y') ); //Alien Lounge
  screenPic[4] = loadImage("tax.png");       screenPic[4].resize(0,adjustInt(650,'y') ); //Tax Crab
  screenPic[5] = loadImage("insurance.png"); screenPic[5].resize(0,adjustInt(650,'y') ); //Burning Ship
  screenPic[6] = loadImage("passengers.png");screenPic[6].resize(0,adjustInt(600,'y') ); //Passeners
  
  mainButtonLeft[0] = new Button( screenWidth*1.1/8, screenHeight*1/7, adjustFloat(screenWidth/3.9,'x'), adjustFloat(screenHeight/10,'y'), 0, "Ship Info");
  mainButtonLeft[1] = new Button( screenWidth*1.1/8, screenHeight*2/7, adjustFloat(screenWidth/3.9,'x'), adjustFloat(screenHeight/10,'y'), 0, "Warehouse");
  mainButtonLeft[2] = new Button( screenWidth*1.1/8, screenHeight*3/7, adjustFloat(screenWidth/3.9,'x'), adjustFloat(screenHeight/10,'y'), 0, "Stocks");
  mainButtonLeft[3] = new Button( screenWidth*1.1/8, screenHeight*4/7, adjustFloat(screenWidth/3.9,'x'), adjustFloat(screenHeight/10,'y'), 0, "Bank");
  mainButtonLeft[4] = new Button( screenWidth*1.1/8, screenHeight*5/7, adjustFloat(screenWidth/3.9,'x'), adjustFloat(screenHeight/10,'y'), 0, "Loan");
  mainButtonLeft[5] = new Button( screenWidth*1.1/8, screenHeight*6/7, adjustFloat(screenWidth/3.9,'x'), adjustFloat(screenHeight/10,'y'), 0, "Lady Flrrb");
  
  planetButton = new PicButton( screenWidth/2-150, screenHeight/3.2, 0 );
  leaveButton = new PicButton( screenWidth/2+150, screenHeight/3.2, 1 );
  
  mainButtonMiddle[0] = new Button( screenWidth/2, screenHeight*4.2/7, adjustFloat(screenWidth/3,'x'), adjustFloat(screenHeight/10,'y'), 4, "Buy Fuel");
  mainButtonMiddle[1] = new Button( screenWidth/2, screenHeight*6/7, adjustFloat(screenWidth/2.5,'x'), adjustFloat(screenHeight/5,'y'), 4, "Market");
  
  mainButtonRight[0] = new Button( screenWidth*6.9/8, screenHeight*1/7, adjustFloat(screenWidth/3.9,'x'), adjustFloat(screenHeight/10,'y'), 3, "Passenger");
  mainButtonRight[1] = new Button( screenWidth*6.9/8, screenHeight*2/7, adjustFloat(screenWidth/3.9,'x'), adjustFloat(screenHeight/10,'y'), 3, "Advertize");
  mainButtonRight[2] = new Button( screenWidth*6.9/8, screenHeight*3/7, adjustFloat(screenWidth/3.9,'x'), adjustFloat(screenHeight/10,'y'), 3, "Insurance");
  mainButtonRight[3] = new Button( screenWidth*6.9/8, screenHeight*4/7, adjustFloat(screenWidth/3.9,'x'), adjustFloat(screenHeight/10,'y'), 3, "Pay Crew");
  mainButtonRight[4] = new Button( screenWidth*6.9/8, screenHeight*5/7, adjustFloat(screenWidth/3.9,'x'), adjustFloat(screenHeight/10,'y'), 3, "Taxes");
  mainButtonRight[5] = new Button( screenWidth*6.9/8, screenHeight*6/7, adjustFloat(screenWidth/3.9,'x'), adjustFloat(screenHeight/10,'y'), 2, "Save/Quit");
  
  bankButton[0] = new Button( screenWidth*1/10, screenHeight*9.5/10, screenWidth/5.1, screenHeight/15, 5, "<< Back" );
  bankButton[1] = new Button( screenWidth*3/10, screenHeight*9.5/10, screenWidth/5.1, screenHeight/15, 1, "Deposit" );
  bankButton[2] = new Button( screenWidth*1/2,  screenHeight*9.5/10, screenWidth/5.1, screenHeight/15, 1, "MAX" );
  bankButton[3] = new Button( screenWidth*7/10, screenHeight*9.5/10, screenWidth/5.1, screenHeight/15, 0, "Withdraw" );
  bankButton[4] = new Button( screenWidth*9/10, screenHeight*9.5/10, screenWidth/5.1, screenHeight/15, 0, "MAX" );
  
  loanButton[0] = new Button( screenWidth*1/10, screenHeight*9.5/10, screenWidth/5.1, screenHeight/15, 5, "<< Back" );
  loanButton[1] = new Button( screenWidth*3/10, screenHeight*9.5/10, screenWidth/5.1, screenHeight/15, 1, "Pay Loan" );
  loanButton[2] = new Button( screenWidth*1/2, screenHeight*9.5/10, screenWidth/5.1, screenHeight/15, 1, "Pay MAX" );
  loanButton[3] = new Button( screenWidth*7/10, screenHeight*9.5/10, screenWidth/5.1, screenHeight/15, 0, "Borrow" );
  loanButton[4] = new Button( screenWidth*9/10, screenHeight*9.5/10, screenWidth/5.1, screenHeight/15, 0, "Borrow MAX" );
  
  flrrbButton[0] = new Button( screenWidth*1/6, screenHeight*9.5/10, screenWidth/3.2, screenHeight/15, 5, "<< Back" );
  flrrbButton[1] = new Button( screenWidth*2/4, screenHeight*9.5/10, screenWidth/3.2, screenHeight/15, 1, "Pay Loan" );
  flrrbButton[2] = new Button( screenWidth*5/6, screenHeight*9.5/10, screenWidth/3.2, screenHeight/15, 1, "Pay Back MAX" );
  
  paymentButton[0] = new Button( screenWidth*1/4, screenHeight*9.5/10, screenWidth/2.2, screenHeight/15, 5, "<< Back" );
  paymentButton[1] = new Button( screenWidth*3/4, screenHeight*9.5/10, screenWidth/2.2, screenHeight/15, 0, "Pay Up" );
  
  insureButton[0] = new Button( screenWidth*1/4, screenHeight*9.5/10, screenWidth/2.2, screenHeight/15, 5, "<< Back" );
  insureButton[1] = new Button( screenWidth*3/4, screenHeight*9.5/10, screenWidth/2.2, screenHeight/15, 0, "Purchase Insurance" );
  
  passengerButton[0] = new Button( screenWidth*1/6, screenHeight*9.5/10, screenWidth/3.2, screenHeight/15, 5, "<< Back" );
  passengerButton[1] = new Button( screenWidth*2/4, screenHeight*9.5/10, screenWidth/3.2, screenHeight/15, 0, "Pick Up Passengers" );
  passengerButton[2] = new Button( screenWidth*5/6, screenHeight*9.5/10, screenWidth/3.2, screenHeight/15, 1, "Set Ticket Price" );
  
  visitButton[7] = new Button( screenWidth*1/6, screenHeight*9.5/10, screenWidth/3.2, screenHeight/15, 5, "<< Back" );
  visitButton[0] = new Button( screenWidth*2/3, screenHeight*9.5/10, screenWidth/1.6, screenHeight/15, 0, "Seek Audience at Imperial Tower" );
  visitButton[1] = new Button( screenWidth*2/3, screenHeight*9.5/10, screenWidth/1.6, screenHeight/15, 0, "Petition the Loan Officers" );
  visitButton[2] = new Button( screenWidth*2/3, screenHeight*9.5/10, screenWidth/1.6, screenHeight/15, 0, "Pay a Visit to your Broker" );
  visitButton[3] = new Button( screenWidth*2/3, screenHeight*9.5/10, screenWidth/1.6, screenHeight/15, 0, "Sane Larry's Discount Fuel" );
  visitButton[4] = new Button( screenWidth*2/3, screenHeight*9.5/10, screenWidth/1.6, screenHeight/15, 0, "Stroll through the Farmers' Market" );
  visitButton[5] = new Button( screenWidth*2/3, screenHeight*9.5/10, screenWidth/1.6, screenHeight/15, 0, "Stop by the Research Labs" );
  visitButton[6] = new Button( screenWidth*2/3, screenHeight*9.5/10, screenWidth/1.6, screenHeight/15, 0, "Doughnuts!" );
  visitButton[8] = new Button( screenWidth*1/2, screenHeight*9.5/10, screenWidth*.98, screenHeight/15, 5, "Return to your Ship" );
  
  //Koo Kee - Request lower tariffs and taxes
  //Stittle - Request better interest rates (loan/bank) or higher credit limit
  //Starlite- Purchase stocks from other planets
  //Ludda   - Wholesale fuel
  //Kezo    - Offered cheaper random goods
  //Rockulus- Random upgrades
  //Cake    - Make crew happy / remove debts
}

//Opening Title Screen
void drawTitleScreen()
{
  push();
  background(0);
  drawStars();
  fill(#EBDC2D);
  textSize(adjustFloat(150,'x')); //100 on 1280
  textAlign(CENTER);
  text("BAZILLIONAIRE",width/2,height/2);
  textSize(20);
  text("[Click to Continue]",width/2,height*0.75);
  pop();
}

//New Game or Load Game
void drawSaveLoadScreen()
{
  push();
  background(0);
  drawStars();
  newButton.drawButton();
  loadButton.drawButton();
  pop();
}

//How Many Players
void drawPlayerCountScreen()
{
  push();
  background(0);
  drawStars();
  for( Button b: playerCountButton )
    b.drawButton();
  pop();
}

//Type Name Screen
void drawNameScreen()
{
  background(0);
  drawStars();
  drawQwerty();
}

//Choose Your Ship
void drawShipSelectScreen()
{
  background(0);
  drawStars();
  textSize(40);
  textAlign(CENTER);
  text(input + ", choose your new ship:",screenWidth/2, screenHeight/12);
  for( int i = 0; i < shipButton.length; i++ )
    if( shipAvailable[i] )
      shipButton[i].drawButton();
}

//For confirming the ship you want
void drawShipConfirmScreen()
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
  text("Cargo Capacity: ", adjustFloat(700,'x'), adjustFloat(200,'y') );  text(ships[currentShip].cargoCapacity + " tons", adjustFloat(1080,'x'), adjustFloat(200,'y') );
  text("Engine Power: ", adjustFloat(700,'x'), adjustFloat(250,'y') );    text(ships[currentShip].engine + " xanpars", adjustFloat(1080,'x'), adjustFloat(250,'y') );
  text("Passenger Rooms: ", adjustFloat(700,'x'), adjustFloat(300,'y') ); text(ships[currentShip].passengerCapacity, adjustFloat(1080,'x'), adjustFloat(300,'y') );
  text("Fuel Capacity: ", adjustFloat(700,'x'), adjustFloat(350,'y') );   text(ships[currentShip].fuelCapacity + " tons", adjustFloat(1080,'x'), adjustFloat(350,'y') );
  text("Required Crew: ", adjustFloat(700,'x'), adjustFloat(400,'y') );   text(ships[currentShip].crew, adjustFloat(1080,'x'), adjustFloat(400,'y') );
  rectMode(CORNER);
  textSize( adjustInt(30,'x') );
  text(ships[currentShip].description, adjustFloat(70,'x'), adjustFloat(480,'y'), 1100,300);

  buyShipButton.drawButton();
  dontBuyShipButton.drawButton();
}

//Handles various messages
void drawMessageScreen()
{
  background(15,80,175);
  fill(200);
  rectMode(CENTER);
  rect( screenWidth/2, screenHeight/4, messageImage(currentMessage).width+4, messageImage(currentMessage).height+4);
  image( messageImage(currentMessage), screenWidth/2, screenHeight/4 );
  textAlign(LEFT);
  rectMode(CORNER);
  textSize(25);
  fill(255);
  text( messageText(currentMessage), adjustFloat(25,'x'), screenHeight/2, screenWidth-adjustFloat(50,'x'), screenHeight );
  OKButton.drawButton();
}

//Draws weekly review screen (at the start of turn rotation)
void drawReviewScreen()
{
  background(0,0,50);
  drawGraph( 50, 50 );
  
  //Display player net worth
  push();
  stroke(255);
  strokeWeight(1);
  line( adjustInt(915,'x'), adjustInt(90,'y'), adjustInt(1160,'x'), adjustInt(90,'y') );
  fill(255);
  textSize(50);
  textAlign(CENTER);
  text("Week " + currentWeek, adjustInt( 1040, 'x' ), adjustInt( 75, 'y' ) );
  textSize(30);
  textAlign(LEFT);
  stroke(255);
  for( int i = 0; i < 6; i++)
  {
    fill(255);
    text( merchant[i].name, adjustInt(950,'x'), adjustInt(150+i*110,'y') );
    text( asCash(merchant[i].netWorth()), adjustInt(950,'x'), adjustInt(150+i*110+40,'y') );
    fill(lineColor[i]);
    circle( adjustInt(900,'x'), adjustInt(150+i*110,'y'), 30 );
  }
  textSize(50);
  fill(255);
  textAlign(CENTER);
  text("GOAL",adjustInt(425,'x'),adjustInt(610,'y'));
  text(asCash(cashGoal),adjustInt(425,'x'),adjustInt(680,'y'));
  pop();
  
  OKButton.drawButton();
}

//Draws the welcome screen for the current planet
void drawPlanetWelcome()
{
  background(0);
  drawStars();
  image(merchant[currentPlayer].currentPlanet.picLarge,screenWidth/3,screenHeight/2);
  fill(255);
  textSize(40);
  textAlign(CENTER);
  text(""+merchant[currentPlayer], screenWidth*3/4, screenHeight/6);
  text("Welcome to "+merchant[currentPlayer].currentPlanet, screenWidth*3/4, screenHeight/4);
  textSize(20);
  text(""+merchant[currentPlayer].currentPlanet.description, screenWidth*3/4, screenHeight/3.5);
}

//Draws the main hub screen
void drawMainScreen()
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
  textSize(45);
  textAlign(CENTER);
  fill(255);
  text( merchant[currentPlayer].name, screenWidth/2, screenHeight*1.5/20 );
  fill(225,225,0);
  textSize(35);
  text( asCash(merchant[currentPlayer].money) + " jeorbs", screenWidth/2, screenHeight*2.5/20 );
  drawFuelGage(0);
}

void drawShipInfoScreen()
{
  //Name and pic
  background(175);
  stroke(150);
  fill(175);
  rectMode(CORNER);
  strokeWeight(3);
  rect(50,50,screenWidth-100,screenHeight-100);
  for( int i = 50; i < screenHeight-50; i+=50 )
    line( 50, i, screenWidth-50, i );
  fill(175);
  rect(425,560,430,150);
  //Bolts
  fill(120);  noStroke();
  circle(25,25,30);               circle(screenWidth-25, 25, 30 );
  circle(25,screenHeight-25,30);  circle(screenWidth-25, screenHeight-25, 30 );
  circle(435,570,10);  circle(845,570,10);
  circle(435,700,10);  circle(845,700,10);
  textAlign(CENTER);
  rectMode(CENTER);
  stroke(255);
  fill(0);
  rect(screenWidth/2,screenHeight/2.6,adjustFloat(600,'x'),adjustFloat(400,'y'));
  image(merchant[currentPlayer].ship.picLarge,screenWidth/2,screenHeight/2.6);
  textSize(35);
  text(merchant[currentPlayer].ship.name, screenWidth/2, adjustFloat(90,'y'));
  
  //Ship data
  textSize(35);
  text( "Ship Size: " + merchant[currentPlayer].ship.size + " tons", screenWidth/2, adjustInt(540,'y') );
  text( "Weekly Crew Wages:", screenWidth/2, adjustInt(605,'y') );
  text( asCash(merchant[currentPlayer].ship.crew*merchant[currentPlayer].ship.crewWages) + " jeorbs", screenWidth/2, adjustInt(645,'y') );
  textSize(30);
  text( "(" + asCash(merchant[currentPlayer].ship.crewWages) + " per person)", screenWidth/2, adjustInt(685,'y') );
  textAlign(LEFT);
  textSize(35);
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

void drawBankScreen()
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
  textSize(35);
  textAlign(CENTER);
  fill(0);
  text( "Secure Cash Vault", adjustInt(1000,'x'), screenHeight/15 );
  textSize(20);
  text( "Account Balance", adjustInt(1000,'x'), screenHeight*0.85/5 );
  text( asCash(merchant[currentPlayer].bankAccount), adjustInt(1000,'x'), screenHeight*1.15/5 );
  text( "Interest Rate", adjustInt(1000,'x'), screenHeight*1.85/5 );
  text( merchant[currentPlayer].bankInterest + "%", adjustInt(1000,'x'), screenHeight*2.15/5 );
  text( "Interest Earned Last Week", adjustInt(1000,'x'), screenHeight*2.85/5 );
  text( asCash(merchant[currentPlayer].bankLastEarned), adjustInt(1000,'x'), screenHeight*3.15/5 );
  text( "Your Cash", adjustInt(1000,'x'), screenHeight*3.85/5 );
  text( asCash(merchant[currentPlayer].money), adjustInt(1000,'x'), screenHeight*4.15/5 );
  
  for( Button b: bankButton )
    b.drawButton();
  pop();
}

void drawLoanScreen()
{
  push();
  //background(250,185,95);
  background(128,0,32);
  
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
  textSize(35);
  textAlign(CENTER);
  fill(0);
  text( "Imperial Trade Union", adjustInt(1000,'x'), screenHeight/15 );
  textSize(20);
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
  
  for( Button b: loanButton )
    b.drawButton();
  pop();
}

void drawFlrrbScreen()
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
  textSize(35);
  textAlign(CENTER);
  fill(0);
  text( "Lady Flrrb's Loan", adjustInt(1000,'x'), screenHeight/15 );
  textSize(20);
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
  
  for( Button b: flrrbButton )
    b.drawButton();
  pop();
}

void drawPlanetSplashScreen()
{
  push();
  background(0);
  imageMode(CENTER);
  image( merchant[currentPlayer].currentPlanet.landscapeBig, screenWidth/2, merchant[currentPlayer].currentPlanet.landscapeBig.height/2 );
  pop();
}

void drawPlanetScreen()
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

void drawPassengerScreen()
{
  push();
  background(100);
  
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
  textSize(35);
  textAlign(CENTER);
  fill(0);
  text( "Passenger Deck", adjustInt(1000,'x'), screenHeight/5.5 );
  textSize(20);
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

/*
passengers on planet:
  MAX: price/100 * advertizement/1000
  MIN: 1000/price
*/

void drawInsuranceScreen()
{
  push();
  background(100);
  
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
  textSize(35);
  textAlign(CENTER);
  fill(0);
  text( "Spaceflight Insurance", adjustInt(1000,'x'), screenHeight/15 );
  textSize(20);
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

void drawCrewScreen()
{
  push();
  background(100);
  
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
  textSize(35);
  textAlign(CENTER);
  fill(0);
  text( "Crew Break Room", adjustInt(1000,'x'), screenHeight/15 );
  textSize(20);
  text( "Number of Employees", adjustInt(1000,'x'), screenHeight*0.85/5 );
  text( merchant[currentPlayer].ship.crew, adjustInt(1000,'x'), screenHeight*1.15/5 );
  text( "Weekly Salary per Person", adjustInt(1000,'x'), screenHeight*1.85/5 );
  text( asCash(merchant[currentPlayer].ship.crewWages), adjustInt(1000,'x'), screenHeight*2.15/5 );
  text( "Total Wages Owed", adjustInt(1000,'x'), screenHeight*2.85/5 );
  text( asCash(merchant[currentPlayer].ship.wagesOwed), adjustInt(1000,'x'), screenHeight*3.15/5 );
  text( "Your Cash", adjustInt(1000,'x'), screenHeight*3.85/5 );
  text( asCash(merchant[currentPlayer].money), adjustInt(1000,'x'), screenHeight*4.15/5 );
  
  for( Button b: paymentButton)
    b.drawButton();
  pop();
}

void drawTaxScreen()
{
  push();
  background(100);
  
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
  textSize(35);
  textAlign(CENTER);
  fill(0);
  text( "Terrence The Tax Crab", adjustInt(1000,'x'), screenHeight/15 );
  textSize(20);
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

//FOR TESTING
void drawTestScreen()
{
  background(0);
  drawStars();
  //for( Planet p: planet )
  //  p.drawSmallPlanet();
  drawGraph( 50, 50 );
}

//Draws stars (does not draw background)
void drawStars()
{
  fill(255,255,200);
  noStroke();
  for( int i = 0; i < starPos[0].length; i++)
    circle( starPos[0][i], starPos[1][i], 2 );
}

//Draws a bar graph showing seats empty/filled
void drawPassengerBar()
{
  int blockSize = int(adjustFloat(1180,'x')/merchant[currentPlayer].ship.passengerCapacity);
  rectMode(CORNER);
  noStroke();
  fill(200);
  rect(adjustInt(50,'x'),adjustInt(30,'y'),blockSize*merchant[currentPlayer].ship.passengerCapacity,adjustInt(40,'y'));
  fill(0,150,0);
  rect(adjustInt(50,'x'),adjustInt(30,'y'),blockSize*merchant[currentPlayer].ship.passengers,adjustInt(40,'y'));
  noFill();
  stroke(150);
  strokeWeight(2);
  rect(adjustInt(50,'x'),adjustInt(30,'y'),blockSize*merchant[currentPlayer].ship.passengerCapacity,adjustInt(40,'y'));
  for( int i = 0; i < merchant[currentPlayer].ship.passengerCapacity; i++ )
    line( adjustInt(50,'x')+i*blockSize, adjustInt(30,'y'), adjustInt(50,'x')+i*blockSize, adjustInt(70,'y') );
}

//Draws fuel tank      0-horizontal
void drawFuelGage( int type )
{
  rectMode(CORNER);
  if( type == 0 )
  {
    noStroke();
    
    //Gray underneath
    fill(160);
    rect( screenWidth/2-adjustInt(230,'x'), adjustInt(540,'y'), adjustInt(460,'x'), 40, 10 );
    
    //Brown above
    fill(90,70,30);
    rect( screenWidth/2-adjustInt(230,'x'), adjustInt(540,'y'), adjustInt(460,'x')*(float(merchant[currentPlayer].ship.fuel)/merchant[currentPlayer].ship.fuelCapacity), 40, 10 ); 
    
    //Grey line on top
    stroke(200);
    strokeWeight(3);
    noFill();
    rect( screenWidth/2-adjustInt(230,'x'), adjustInt(540,'y'), adjustInt(460,'x'), 40, 10 );
  }
}

//Draws the number pad for numeric inputs
void drawNumpad()
{
  rectMode(CENTER);
  textAlign(CENTER);
  strokeWeight(4);
  stroke(255);
  fill(0,100);
  rect( screenWidth/2, screenHeight*1.75/3-keySize, keySize*4, keySize*6, 20);
  fill(255,50);
  rect( screenWidth/2, screenHeight/5.15, keySize*3.5, keySize*.75, 20 );
  fill(255);
  textSize(adjustInt(50,'x'));
  text(asCash(numpadValue),screenWidth/2,screenHeight*1.75/3-keySize*3.3);
  textSize(adjustInt(60,'x'));
  for(int i = 0; i < 9; i++) //numbers
  {
    fill(255,50+numKeyFlash[i]);
    stroke(255);
    rect( screenWidth/2+((i%3-1)*keySize*1.2), screenHeight*1.75/3-(i/3*keySize*1.2), keySize, keySize, 20 );
    fill(255);
    text( i+1, screenWidth/2+((i%3-1)*keySize*1.2), screenHeight*1.835/3-(i/3*keySize*1.2) );
  }
  for( int i = 0; i < 3; i++ )
  {
    fill(255,50+numKeyFlash[i+9]);
    stroke(255);
    rect( screenWidth/2+(i-1)*keySize*1.2, screenHeight*1.75/3+(keySize*1.2), keySize, keySize, 20 );
    fill(255);
    text( numPadBottom[i], screenWidth/2+(i-1)*keySize*1.2, screenHeight*1.835/3+(keySize*1.2) );
  }
}

//Draw Qwerty keyboard for input
void drawQwerty()
{
  rectMode(CENTER);
  textAlign(CENTER);
  fill(255);
  textSize(adjustInt(100,'x'));
  text(input+"_",screenWidth/2,screenHeight/3);
  textSize(adjustInt(60,'x'));
  for(int i = 0; i < 27; i++)
  {
    //noFill();
    strokeWeight(4);
    fill(255,50+keyFlash[i]);
    stroke(255);
    if( i < 10 )
    {
      rect( qwertyX1+(100*i), (screenHeight*1/2)+adjustInt(40,'y'), keySize, keySize, 20);
      fill(255);
      text( qwerty[i], qwertyX1+(100*i), (screenHeight*1/2)+adjustInt(60,'y') );
    }
    else if( i < 19 )
    {
      rect( qwertyX2+(100*(i-10)), (screenHeight*1/2)+adjustInt(140,'y'), keySize, keySize, 20);
      fill(255);
      text( qwerty[i], qwertyX2+(100*(i-10)), (screenHeight*1/2)+adjustInt(160,'y') );
    }
    else
    {
      rect( qwertyX3+(100*(i-19)), (screenHeight*1/2)+adjustInt(240,'y'), keySize, keySize, 20);
      fill(255);
      text( qwerty[i], qwertyX3+(100*(i-19)), (screenHeight*1/2)+adjustInt(260,'y') );
    }
  }
  strokeWeight(4);
  stroke(255);
  fill(255,50+keyFlash[27]);
  circle(screenWidth/10,screenHeight*13/16,keySize*1.5);
  fill(255,50+keyFlash[28]);
  circle(screenWidth-screenWidth/10,screenHeight*13/16,keySize*1.5);
  fill(255);
  text( "DEL", adjustInt(128,'x'), adjustInt(670,'y') );
  text( "OK", adjustInt(1152,'x'), adjustInt(670,'y') );
}

//Convert numbers ( 1000000 ) to number words ( 1,000,000 )
String asCash( int amount )
{
  if( abs(amount) < 1000 )
    return "" + amount;
  
  String amountString = "" + amount;
  String output = "";
  int i = 3;
  
  while( i < amountString.length() )
  {
    output = "," + amountString.substring(amountString.length()-i,amountString.length()-(i-3)) + output;
    i+=3;
  }
  output = amountString.substring(0,amountString.length()-(i-3)) + output;
  
  return output;
}

String messageText( Message m )
{
  switch( m )
  {
    case ZINN: return "    You are invited to the home of Ambrosia Flrrb, wealthy heiress and entrepreneur, on the imperial capital of " + planet[0].name + ". She graciously lends you the " + asCash(merchant[currentPlayer-1].zinnTotal) + " jeorbs needed to purchase your new ship.\n    Lady Flrrb fancies herself a friend of small businesses. After all, she started off small too, working from a roadside stand selling lemonaide NFTs.\n    You must pay " + merchant[currentPlayer-1].zinnInterest + "% interest per week, but that shouldn't be too difficult for a go-getting business- creature such as yourself. And if things go wrong, she could always repurpose your repossessed ship as a playhouse for her Xaxonian Pekingese.";
  }
  
  return "ERROR";
}

PImage messageImage( Message m )
{
  switch( m )
  {
    case ZINN: return messagePic[0];
  }
  
  return null;
}

public enum Message
{
  ZINN,
  NONE
}
