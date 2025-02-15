//For planet and ship "buttons"

class PicButton extends Button
{ 
  public PicButton( float x, float y, int type )
  {
    super(x, y, adjustFloat(300,'x'), adjustFloat(300,'y'), type, "");
  }
  
  void drawButton()
  {
    fill(200);
    textSize(adjustInt(20,'x'));
    textAlign(CENTER);
    if( col == 0 )
    {
      image( merchant[currentPlayer].currentPlanet.picMed, xPos, yPos );
      text("Visit "+merchant[currentPlayer].currentPlanet, xPos, yPos+adjustInt(150,'x') );
    }
    else
    {
      image( merchant[currentPlayer].ship.picMed, xPos, yPos );
      text("Blast Off", xPos, yPos+adjustInt(150,'x') );
    }
  }
  
  boolean mouseOnButton()
  {
    if( dist( mouseX, mouseY, xPos, yPos ) < adjustFloat(137.5,'x') )
      return true;
    return false;
  }
}
