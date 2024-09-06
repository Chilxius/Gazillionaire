//For ship select screen

class ShipButton extends Button
{
  PImage pic;
  
  public ShipButton( float x, float y, int type )
  {
    super(x, y, adjustFloat(240,'x'), adjustFloat(190,'y'), type, "");
    pic = loadImage("ship_"+type+".png");
    if( pic.width > pic.height )
      pic.resize(int(xSize*.8),0);
    else
      pic.resize(0,int(ySize*.8));
    println( "Ship Button "+type+": "+xPos + "  \t" + yPos );
  }
  
  void drawButton()
  {
    push();
    rectMode(CENTER);
    stroke(255);
    fill(0);
    rect(xPos,yPos,xSize,ySize);
    image(pic,xPos,yPos);
    pop();
  }
}
