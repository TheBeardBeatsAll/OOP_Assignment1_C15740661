void setup()
{
  fullScreen();
  loading_screen = new Gif(this, "XCOM_Shield_Logo.gif");
  initialize();
  createPDA();
}//end setup

import gifAnimation.*;

Gif loading_screen;

PShape pda, outer, inner, handle;

float border, pda_width, pda_length;
float handle_length, handle_width, corner;
float screen_width, screen_length, radius;

int menu_choice;
  
boolean on = false;

void draw()
{
  background(15);
  
  pushMatrix();
  translate(border, border);
  shape(pda);
  translate(pda_width - handle_width, handle_length);
  drawHandle();
  on_off();
  popMatrix();
  
  pushMatrix();
  translate(border + (corner * 0.9), border + (corner * 0.9));
  screen();
  popMatrix();
}//end draw

void initialize()
{
  border = width*0.02f;
  pda_width = width - (border*2);
  pda_length = height - (border*2);
  
  corner = pda_length * 0.1f;
  radius = corner * 0.8f;
  
  screen_width = pda_width * 0.73f;
  screen_length = pda_length - (corner * 1.8f);
  
  handle_length = pda_length / 3.0f;
  handle_width = pda_length * 0.15f;
  
  menu_choice = 100;
  stroke(0);
}//initialize

void createPDA()
{
  float inside_corner = corner * 0.7f;
  float inside_width = corner * 0.7f;
  float gap = pda_length * 0.015f;
  float theta = 45.0f;
  float gap_theta = gap * sin(radians(theta));
  
  pda = createShape(GROUP);
  outer = createShape();
  outer.beginShape();
  outer.fill(0, 0, 125);
  outer.stroke(0);
  outer.vertex(corner, 0);
  outer.vertex(pda_width - corner, 0);
  outer.vertex(pda_width, corner);
  outer.vertex(pda_width, handle_length);
  outer.vertex(pda_width - handle_width, handle_length);
  outer.vertex(pda_width - (handle_width + inside_corner), handle_length - inside_corner);
  outer.vertex(pda_width - (handle_width + inside_corner + inside_width), handle_length - inside_corner);
  outer.vertex(pda_width - (handle_width + (inside_corner * 2) + inside_width), handle_length);
  outer.vertex(pda_width - (handle_width + (inside_corner * 2) + inside_width), pda_length - handle_length);
  outer.vertex(pda_width - (handle_width + inside_corner + inside_width), (pda_length + inside_corner) - handle_length);
  outer.vertex(pda_width - (handle_width + inside_corner), (pda_length + inside_corner) - handle_length);
  outer.vertex(pda_width - handle_width, pda_length - handle_length);
  outer.vertex(pda_width, pda_length - handle_length);
  outer.vertex(pda_width,  pda_length - corner);
  outer.vertex(pda_width - corner, pda_length);
  outer.vertex(corner, pda_length);
  outer.vertex(0, pda_length - corner);
  outer.vertex(0, corner);
  outer.endShape(CLOSE);
  
  pda = createShape(GROUP);
  inner = createShape();
  inner.beginShape();
  inner.fill(0, 125, 125);
  inner.stroke(0);
  inner.vertex(corner + gap_theta, gap_theta);
  inner.vertex(pda_width - (gap_theta + corner), gap_theta);
  inner.vertex(pda_width - gap_theta, corner + gap_theta);
  inner.vertex(pda_width - gap_theta, handle_length - gap_theta);
  inner.vertex((pda_width + gap_theta) - handle_width, handle_length - gap_theta);
  inner.vertex((pda_width + gap_theta) - (handle_width + inside_corner), handle_length - (inside_corner + gap_theta));
  inner.vertex(pda_width - (handle_width + inside_corner + inside_width + gap_theta), handle_length - (inside_corner + gap_theta));
  inner.vertex(pda_width - (handle_width + (inside_corner * 2) + inside_width + gap_theta), handle_length - gap_theta);
  inner.vertex(pda_width - (handle_width + (inside_corner * 2) + inside_width + gap_theta), (pda_length + gap_theta) - handle_length);
  inner.vertex(pda_width - (handle_width + inside_corner + inside_width + gap_theta), (pda_length + inside_corner + gap_theta) - handle_length);
  inner.vertex((pda_width + gap_theta) - (handle_width + inside_corner), (pda_length + inside_corner + gap_theta) - handle_length);
  inner.vertex((pda_width + gap_theta) - handle_width, (pda_length + gap_theta) - handle_length);
  inner.vertex(pda_width - gap_theta, (pda_length + gap_theta) - handle_length);
  inner.vertex(pda_width - gap_theta,  pda_length - (corner + gap_theta));
  inner.vertex(pda_width - (corner + gap_theta), pda_length - gap_theta);
  inner.vertex(corner + gap_theta, pda_length - gap_theta);
  inner.vertex(gap_theta, pda_length - (corner +gap_theta));
  inner.vertex(gap_theta, corner + gap_theta);
  inner.endShape(CLOSE);
  
  pda.addChild(outer);
  pda.addChild(inner);
}//end drawPDA

void drawHandle()
{
  int i = 0;
  int j = 0;
  int k = 1;
  float space = handle_length / 29.0;
  while(i < 29)
  {
    if( i % 7 == 0 )
    {
      fill(125, 0, 125);
      rect(0, j*space*7, handle_width, space);
      j++;
    }//end else
    else if( (i - 1) % 7 == 0)
    {
      fill(125, 125, 0);
      rect(0, k*space, handle_width, space * 6);
      k = k + 7;
    }//end else
    i++;
  }//end while
}//end drawHandle

void on_off()
{  
  if(on)
  {
    fill(#FF1F23);
    ellipse(handle_width / 2, - radius * 0.9f, radius, radius);
  }//end if
  else
  {
    fill(#810103);
    ellipse(handle_width / 2, - radius * 0.9f, radius, radius);
  }//end else
  arc(handle_width / 2, - radius * 0.9f, radius/2, radius/2, - THIRD_PI, PI + THIRD_PI, OPEN);
  line(handle_width / 2, - radius * 0.9f,  handle_width / 2, -radius * 1.2f);
}//end on_off

void screen()
{
  float gap = screen_width * 0.006f;
 
  fill(#898080);
  rect( - gap, - gap, screen_width + (gap * 2), screen_length + (gap *  2));
  if(on)
  {
    loading();
    
    pushMatrix();
    translate(screen_width * 0.80f, 0);
    menu();
    popMatrix();
    
    switch(menu_choice)
    {
      case 0:
      {
        briefing();
        break;
      }//end case
      case 1:
      {
        soldiers();
        break;
      }//end case
      case 2:
      {
        crafts();
        break;
      }//end case
      case 3:
      {
        tech();
        break;
      }//end case
      case 4:
      {
        council();
        break;
      }//end case
    }//end switch
  }//end if
  else
  {
    fill(0);
    rect(0, 0, screen_width, screen_length);
  }//end else
}//end screen

void mousePressed()
{
  float on_x = pda_width - (handle_width / 2);
  float on_y = handle_length - (radius * 0.9f);
  float d = sqrt(pow(mouseX-on_x,2) + pow(mouseY-on_y,2));
  if (d < radius)
  {
    if(on)
    {
      on = false;
    }//end if
    else
    {
      on = true;
    }//end else
  }//end if
}//end on_off

void loading()
{
  float timeDelta = 0;
  float timeAccumulator = 0;

  int last = 0;
  int now = millis();
  
  timeDelta = (now - last) / 1000.0f;  
  last = now;  
  timeAccumulator += timeDelta;
  
  fill(0);
  rect(0, 0, screen_width * 0.8f, screen_length);
  loading_screen.loop();
  image(loading_screen, (screen_width * 0.8f) / 2 - loading_screen.width / 2, screen_length / 2 - loading_screen.height / 2);
  if (timeAccumulator >= 4)
  {
      menu_choice = 0;
      return;
  }
}//end loading

void menu()
{
  float menu_border = screen_length * 0.18f;
  float menu_button = (screen_length * 0.8f) / 6;
  float menu_gap = menu_button * 0.25f;
  float menu_width = screen_width * 0.18f;
  float menu_padding = screen_width * 0.01f;
  
  fill(#6F3A5F);
  rect(0, 0, screen_width * 0.2f, screen_length);
  
  fill(0);
  textSize(36);
  textAlign(CENTER, CENTER);
  text("XCOM:", (screen_width * 0.2f) / 2, menu_border / 3);
  text("Menu", (screen_width * 0.2f) / 2, (menu_border * 2) / 3);
  
  for(int i = 0; i < 5; i++)
  {
    fill(#60EFF5);
    rect(menu_padding, menu_border +((i * menu_gap) + (i * menu_button)), menu_width, menu_button);
    
    fill(0);
    textSize(24);
    textAlign(CENTER, CENTER);
    if(i == 0)
    {
      text("Briefing", (screen_width * 0.2f) / 2, menu_border + ( menu_button / 2 ) +((i * menu_gap) + (i * menu_button)));
    }//end if
    else if(i == 1)
    {
      text("Soldiers", (screen_width * 0.2f) / 2, menu_border + ( menu_button / 2 ) +((i * menu_gap) + (i * menu_button)));
    }//end else if
    else if(i == 2)
    {
      text("Craft", (screen_width * 0.2f) / 2, menu_border + ( menu_button / 2 ) +((i * menu_gap) + (i * menu_button)));
    }//end else if
    else if(i == 3)
    {
      text("Tech", (screen_width * 0.2f) / 2, menu_border + ( menu_button / 2 ) +((i * menu_gap) + (i * menu_button)));
    }//end else if
    else if(i == 4)
    {
      text("Council", (screen_width * 0.2f) / 2, menu_border + ( menu_button / 2 ) +((i * menu_gap) + (i * menu_button)));
    }//end else if
  }//end for
}//end menu

void briefing()
{
  fill(#BA3CC1);
  rect(0, 0, screen_width * 0.8f, screen_length);
}//end briefing

void soldiers()
{
  fill(#138346);
  rect(0, 0, screen_width * 0.8f, screen_length);
}//end soldiers

void crafts()
{
  fill(#836B13);
  rect(0, 0, screen_width * 0.8f, screen_length);
}//end craft

void tech()
{
  fill(#8E2818);
  rect(0, 0, screen_width * 0.8f, screen_length);
}//end tech

void council()
{
  fill(#67DFFF);
  rect(0, 0, screen_width * 0.8f, screen_length);
}//end council