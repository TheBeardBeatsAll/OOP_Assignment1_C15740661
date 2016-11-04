void setup()
{

  size(1300, 700);
  createPDA();
}//end setup

PShape pda, outer, inner, handle;

float bord = width/2;

void draw()
{
  background(0);
  
  pushMatrix();
  translate(30, 30);
  shape(pda);
  popMatrix();
}//end draw

void createPDA()
{
  pda = createShape(GROUP);
  
  outer = createShape();
  outer.beginShape();
  outer.fill(0, 0, 255);
  outer.stroke(79, 112, 113);
  outer.vertex(0, 0);
  outer.vertex(200, 0);
  outer.vertex(200, 200);
  outer.vertex(0, 200);
  outer.endShape(CLOSE);
  
  pda.addChild(outer);
}//end drawPDA