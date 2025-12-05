//Button colors based on button's "type"
//First color is the outline, second is top, third is bottom (lightest, light, dark)
color [][] buttonColor = { { color(100,200,100), color(50,200,50),   color(0,150,0) },   //0-green
                           { color(100,100,200), color(50,50,200),   color(0,0,150) },   //1-blue
                           { color(200,100,100), color(200,50,50),   color(150,0,0) },   //2-red
                           { color(255,235,185), color(255,215,100), color(255,185,0) }, //3-orange
                           { color(175,150,255), color(175,75,255),  color(155,0,235) } ,//4-purple
                           { color(250),         color(175),         color(125) } };     //5-grey

//Buttons are rounded and the text is white
//Text is sized based on buttons Y-Size

//Buttons should be passed literal arguments based on my compuer's screen. The constructor will convert.

class Button
{
  float xPos, yPos; //center of button
  float xSize, ySize;
  
  int col;
  String text;
  
  //Sizes are given based on a 1280 x 800 screen, constructor adjusts it to current size
  public Button( float xP, float yP, float xS, float yS, int c, String t )
  {
    xPos = adjustFloat(xP,'x');
    yPos = adjustFloat(yP,'y');
    xSize = adjustFloat(xS,'x');
    ySize = adjustFloat(yS,'y');
    
    col = c;
    text = t;
  }
  
  void drawButton()
  {
    push();
    
    rectMode(CENTER);
    strokeWeight(2);
    stroke(buttonColor[col][0]);
    //Top
    fill(buttonColor[col][1]);
    beginShape();
    vertex(xPos+xSize/2, yPos+1);//right side
    bezierVertex(xPos+xSize/2, yPos-ySize/2, xPos+xSize/2-xSize/20, yPos-ySize/2, xPos+xSize/2-xSize/20, yPos-ySize/2);
    vertex(xPos-xSize/2+xSize/20, yPos-ySize/2);
    bezierVertex(xPos-xSize/2+xSize/20, yPos-ySize/2, xPos-xSize/2, yPos-ySize/2, xPos-xSize/2, yPos+1);
    endShape();
    //Bottom
    fill(buttonColor[col][2]);
    beginShape();
    vertex(xPos+xSize/2, yPos);//right side
    bezierVertex(xPos+xSize/2, yPos+ySize/2, xPos+xSize/2-xSize/20, yPos+ySize/2, xPos+xSize/2-xSize/20, yPos+ySize/2);
    vertex(xPos-xSize/2+xSize/20, yPos+ySize/2);
    bezierVertex(xPos-xSize/2+xSize/20, yPos+ySize/2, xPos-xSize/2, yPos+ySize/2, xPos-xSize/2, yPos);
    endShape();
    
    //Text
    textAlign(CENTER);
    fill(255);
    textSize(ySize*.75);
    text(text,xPos,yPos+ySize*.25);
    
    pop();
  }
  
  boolean mouseOnButton()
  {
    return( mouseX >  xPos-xSize/2
         && mouseX <= xPos+xSize/2
         && mouseY >  yPos-ySize/2
         && mouseY <= yPos+ySize/2 );
  }
}
