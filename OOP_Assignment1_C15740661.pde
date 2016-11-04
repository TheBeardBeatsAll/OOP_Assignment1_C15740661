void setup()
{
  fullScreen();
  border = width*0.02f;
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
  float corner1 = pda_height * 0.1f;
  float corner2_y = corner1 * 3.0f;
  float handle_corner = corner1 * 0.5f;
  float handle_width = corner1 * 1.5f;
  float gap = pda_width * 0.01f;
  float theta = 45.0f;
  float gap_theta = gap * sin(radians(theta));
  
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
  outer.vertex(pda_width - (handle_width + handle_corner + handle_width), (pda_height + handle_corner) - corner2_y);
  outer.vertex(pda_width - (handle_width + handle_corner), (pda_height + handle_corner) - corner2_y);
  outer.vertex(pda_width - handle_width, pda_height - corner2_y);
  outer.vertex(pda_width, pda_height - corner2_y);
  outer.vertex(pda_width - handle_width, pda_height);
  outer.vertex(corner1, pda_height);
  outer.vertex(0, pda_height - corner1);
  outer.vertex(0, corner1);
  outer.endShape();
  
  pda = createShape(GROUP);
  inner = createShape();
  inner.beginShape();
  inner.fill(0, 125, 125);
  inner.stroke(50);
  inner.vertex(corner1 + gap_theta, gap_theta);//starting point
  inner.vertex(pda_width - (gap_theta + handle_width), gap_theta);
  inner.vertex(pda_width - gap_theta, corner2_y - gap_theta);//handle corner
  inner.vertex((pda_width + gap_theta) - handle_width, corner2_y - gap);
  inner.vertex((pda_width + gap_theta) - (handle_width + handle_corner), corner2_y - (handle_corner + gap));
  inner.vertex(pda_width - (handle_width + handle_corner + handle_width + gap_theta), corner2_y - (handle_corner + gap));
  inner.vertex(pda_width - (handle_width + (handle_corner * 2) + handle_width + gap_theta), corner2_y - gap_theta);
  inner.vertex(pda_width - (handle_width + (handle_corner * 2) + handle_width + gap_theta), (pda_height + gap_theta) - corner2_y);
  inner.vertex(pda_width - (handle_width + handle_corner + handle_width + gap_theta), (pda_height + handle_corner + gap_theta) - corner2_y);
  inner.vertex((pda_width + gap_theta) - (handle_width + handle_corner), (pda_height + handle_corner + gap_theta) - corner2_y);
  inner.vertex((pda_width + gap_theta) - handle_width, (pda_height + gap_theta) - corner2_y);
  inner.vertex(pda_width - gap_theta, (pda_height + gap_theta) - corner2_y);
  inner.vertex(pda_width - (handle_width + gap_theta), pda_height - gap_theta);
  inner.vertex(corner1 + gap_theta, pda_height - gap_theta);
  inner.vertex(gap_theta, pda_height - (corner1 +gap_theta));
  inner.vertex(gap_theta, corner1 + gap_theta);
  outer.endShape();
  
  pda.addChild(outer);
  pda.addChild(inner);
}//end drawPDA