class Spaceship
{
  String name;
  String description;
  
  PImage picLarge, picMed, picSmall;
  
  int size;
  int engine;
  
  int passengerCapacity, passengers;
  int passengerPrice = 1000, passengerPriceNext = 1000;
  
  int cargoCapacity;
  
  int fuelCapacity, fuel;
  
  int crew, crewWages, wagesOwed; //wages per person  /  pilot x1, navigator x1, engineer x1, crew x?
  
  public Spaceship( String n, String pic, int e, int p, int c, int f, int cr )
  {
    name = n;
    
    picLarge = loadImage(pic); picLarge.resize( adjustInt(400,'x'), 0 );
    picMed   = loadImage(pic); picMed.resize(   adjustInt(200,'x'), 0 );
    picSmall = loadImage(pic); picSmall.resize( adjustInt(100,'x'), 0 );
    
    size = 400;
    
    engine = e;
    
    passengerCapacity = p;
    passengers = 0;
    
    cargoCapacity = c;
    
    fuelCapacity = f;
    fuel = fuelCapacity;
    
    crew = cr;
    crewWages = 1500;
  }
}

void buildShips()
{                        //  NAME              PIC        ENG, PAS, CAR, FUEL, CREW
  ships[0] = new Spaceship("The Whiz",         "ship_0.png",  7, 8,  100, 20,  4);
  ships[1] = new Spaceship("Rocket Shark",     "ship_1.png",  5, 8,  120, 40,  5);
  ships[2] = new Spaceship("Switchblade",      "ship_2.png",  5, 8,   80, 65,  3);
  ships[3] = new Spaceship("Planet of All",    "ship_3.png",  2, 11, 130, 50,  6);
  ships[4] = new Spaceship("Pincer",           "ship_4.png",  5, 6,  100, 40,  3);
  ships[5] = new Spaceship("Oculoid",          "ship_5.png",  5, 8,  100, 40,  4);
  ships[6] = new Spaceship("Crayola",          "ship_6.png",  7, 7,   80, 30,  4);
  ships[7] = new Spaceship("Nighthawk",        "ship_7.png",  6, 5,  110, 40,  4);
  ships[8] = new Spaceship("Bathtime",         "ship_8.png",  4, 10,  90, 40,  3);
  ships[9] = new Spaceship("The Humanity",     "ship_9.png",  3, 1,  150, 35,  2);
  ships[10]= new Spaceship("Oroberry",         "ship_10.png", 6, 16,  75, 30, 12);
  ships[11]= new Spaceship("Heirloom",         "ship_11.png", 6, 8,  110, 40,  6);
  
  ships[0].description = "While delivering a batch of new experimental rockets, the captain flew too close to a star and the rockets ended up melted to the hull. The captain, filled with the need for speed, swore to retire once he had flown to the very egde of the galaxy. He forgot how fast the ship was now; it took one week. He retired in poverty at the age of 26.";
  ships[1].description = "This vessel is a sharp and fierce predator. Not a potato. There are rumors of planets where root vegetables are hollowed out to make spaceships. Those are lies. This agile fighter is from deep, dark space where only the most dangerous survive. How DARE you think it is a spray-painted potato. Shame on you.";
  ships[2].description = "Clever, overworked engineers toiled for years to develop this ship. Its hull is made of SmartTech metal that can re-shape and re-form to whatever orientation is optimal for any given scenario. It turns out that its current shape is ideal for everything, so it never actually changes anymore.";
  ships[3].description = "You am to be buying of ship? Am good planet and quite yes in consummation of the task. To have much belly, like as frog of feast hunger. Profusion in carseat for old and fireman alike. Twelve spiders, yes. Wear fear of no one's butler, other planet is not happening three times as I am do.";
  ships[4].description = "The first delivery job The Streak ever took was to deliver a set of new experimental rockets.";
  ships[5].description = "The first delivery job The Streak ever took was to deliver a set of new experimental rockets.";
  ships[6].description = "The first delivery job The Streak ever took was to deliver a set of new experimental rockets.";
  ships[7].description = "The Nighthawk once traveled to The Forbidden World, and it brought back some unexpected passengers. Ghostly apparitions could be seen floating in the cargo hold and waiting outside the bathrooms. After extensive exorcisms, only a few ghosts are known to remain, including the one that keeps changing the thermostat.";
  ships[8].description = "The first delivery job The Streak ever took was to deliver a set of new experimental rockets.";
  ships[9].description = "The previous captain tore out most of the passenger seats to make room for cargo. He removed the air conditioning, several fuel tanks, and an espresso machine to make more room. But it wasn't enough - he tore out the cockpit where the pilot and navigator sit. The ship was found floating lost in space ten years later.";
  ships[10].description = "The scent of blueberry pie in the ventilation attracts passengers to this luxury yacht. Its extensive corridors are lined with artwork and koi ponds. Passengers who attempt to walk the circumference of the vessel report that it seems to go on and on without end, and they often have not reached their rooms by the time the trip is over.";
  ships[11].description = "The Heirloom is a Supervessel, certified as fully organic. It was grown on a planet where GMOs have been outlawed for decades, and where natural pests are not controlled with toxic chemicals, but rather in the traditional way: orbital nuclear bombardment.";
}
