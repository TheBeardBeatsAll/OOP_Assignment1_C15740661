void setup()
{
  fullScreen();
  border = width*0.02;
  createPDA();
}//end setup

PShape pda, outer, inner, handle;

float border;
void draw()
{
  background(0);
  
  pushMatrix();
  translate(border, border);
  shape(pda);
  popMatrix();
}//end draw

void createPDA()
{
  float pda_width = width - (border*2);
  float pda_height = height - (border*2);
  float corner1 = pda_height * 0.1;
  float corner2_y = corner1 * 3;
  float handle_corner = corner1 * 0.5;
  float handle_width = corner1 * 1.5;
  float gap = pda_width * 0.05;
  
  pda = createShape(GROUP);
  outer = createShape();
  outer.beginShape();
  outer.fill(0, 0, 125);
  outer.stroke(50);
  outer.vertex(corner1, 0);//starting point
  outer.vertex(pda_width - handle_width, 0);
  outer.vertex(pda_width, corner2_y);//handle corner
  outer.vertex(pda_width - handle_width, corner2_y);
  outer.vertex(pda_width - (handle_width + handle_corner), corner2_y - handle_corner);
  outer.vertex(pda_width - (handle_width + handle_corner + handle_width), corner2_y - handle_corner);
  outer.vertex(pda_width - (handle_width + (handle_corner * 2) + handle_width), corner2_y);
  outer.vertex(pda_width - (handle_width + (handle_corner * 2) + handle_width), pda_height - corner2_y);
  outer.vertex(pda_width - (handle_width + handle_corner + handle_width), pda_height - (corner2_y - handle_corner));
  outer.vertex(pda_width - (handle_width + handle_corner), pda_height - (corner2_y - handle_corner));
  outer.vertex(pda_width - handle_width, pda_height - corner2_y);
  outer.vertex(pda_width, pda_height - corner2_y);
  outer.vertex(pda_width - handle_width, pda_height);
  outer.vertex(corner1, pda_height);
  outer.vertex(0, pda_height - corner1);
  outer.vertex(0, corner1);
  outer.endShape();
  
  pda.addChild(outer);
}//end drawPDA