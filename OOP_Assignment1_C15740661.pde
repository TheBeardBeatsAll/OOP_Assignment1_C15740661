void setup()
{
  fullScreen();
  initialize();
  createPDA();
}//end setup

import gifAnimation.*;

Gif loading_screen;

PShape pda, outer, inner, handle;
PImage backg, map;

float x, y;

float border, pda_width, pda_length, screen_inlay;
float handle_length, handle_width, corner;
float screen_width, screen_length, radius;
float menu_border, menu_button ,menu_gap ,menu_width ,menu_padding;
float gap_cl, space_cl;
float gap_cr, craft_length, craft_width;
float gap_m, mission_length, mission_width;
float interval;

int menu_choice, soldier_choice, mission_choice;
  
boolean on = false;
boolean load = false;

Table t;

PImage[] craft = new PImage[3];  
PImage[] areas = new PImage[4];

String[] menu = new String[5];

ArrayList<Mission> missions = new ArrayList<Mission>();
ArrayList<Tech> armour = new ArrayList<Tech>();
ArrayList<Tech> weapon = new ArrayList<Tech>();
ArrayList<Tech> utility = new ArrayList<Tech>();
ArrayList<Country> countries = new ArrayList<Country>();
ArrayList<Craft> aircraft = new ArrayList<Craft>();
ArrayList<Soldier> soldiers = new ArrayList<Soldier>();

void draw()
{
  stroke(0);
  background(backg);
  
  pushMatrix();
  translate(border, border);
  shape(pda);
  translate(pda_width - handle_width, handle_length);
  drawHandle();
  on_off();
  popMatrix();
  
  pushMatrix();
  translate(screen_inlay, screen_inlay);
  screen();
  popMatrix();
  
  mouseOver();
}//end draw

void initialize()
{
  border = width*0.02f;
  pda_width = width - (border*2);
  pda_length = height - (border*2);
  
  corner = pda_length * 0.1f;
  radius = corner * 0.8f;
  
  screen_inlay = border + (corner * 0.9);
  screen_width = pda_width * 0.73f;
  screen_length = pda_length - (corner * 1.8f);
  
  handle_length = pda_length / 3.0f;
  handle_width = pda_length * 0.15f;
  
  menu_choice = 100;
  menu_border = screen_length * 0.18f;
  menu_button = (screen_length * 0.8f) / 6;
  menu_gap = menu_button * 0.25f;
  menu_width = screen_width * 0.18f;
  menu_padding = screen_width * 0.01f;
  
  menu[0] = "Missions";
  menu[1] = "Soldiers";
  menu[2] = "Craft";
  menu[3] = "Tech";
  menu[4] = "Council";
  
  gap_cl = screen_width * 0.04;
  space_cl = (screen_length - (gap_cl * 3.8)) / 43.0;
  
  gap_cr = screen_length * 0.05f;
  craft_length = (screen_length - (gap_cr * 4)) / 3.0;
  craft_width = ((screen_width * 0.8) - (gap_cr * 3)) / 2.0;
  
  gap_m = screen_length * 0.03f;
  mission_length = screen_length * 0.1;
  mission_width = ((screen_width * 0.8) - (gap_m * 3)) / 2.0;
  
  soldier_choice = 100;

  mission_choice = 100;
  
  loadImages();
  loadData();
  
  interval = screen_length / soldiers.size();
}//initialize

void loadImages()
{
  loading_screen = new Gif(this, "XCOM_Shield_Logo.gif");
  
  backg = loadImage("background.jpg");
  backg.resize(width,height);
  
  map = loadImage("map.jpg");
  map.resize((int)((screen_width * 0.8) - (gap_cl * 4))-1, (int)(gap_cl * 2)-1);
  
  for(int i = 0; i < craft.length; i++)
  {
    craft[i] = loadImage("ship" + i + ".jpg");
    craft[i].resize((int)(craft_width - 1), (int)(craft_length - 1));
  }//end for
  
  for(int i = 0; i < areas.length; i++)
  {
    areas[i] = loadImage("area" + i + ".jpg");
    areas[i].resize((int)((mission_width * 1.2) -1), (int)(mission_length * 5) - 1);
  }//end for
}//end loadImages

void loadData()
{
  countries.clear();
  missions.clear();
  armour.clear();
  weapon.clear();
  utility.clear();
  aircraft.clear();
  
  t = loadTable("mission.csv", "csv");
  for(TableRow row : t.rows())
  {
    Mission m = new Mission(row);
    missions.add(m);
  }//end for
  t = loadTable("council.csv", "csv");
  for(TableRow row : t.rows())
  {
    Country c = new Country(row);
    countries.add(c);
  }//end for
  t = loadTable("tech.csv", "csv");
  for(TableRow row : t.rows())
  {
    Tech te = new Tech(row);
    if(te.type == 1)
    {
      armour.add(te);
    }//end if
    else if(te.type == 2)
    {
      weapon.add(te);
    }//end else if
    else if(te.type == 3)
    {
      utility.add(te);
    }//end else if
  }//end for
  t = loadTable("craft.csv", "csv");
  for(TableRow row : t.rows())
  {
    Craft cr = new Craft(row);
    aircraft.add(cr);
  }//end for
  t = loadTable("soldiers.csv", "csv");
  for(TableRow row : t.rows())
  {
    Soldier s = new Soldier(row);
    soldiers.add(s);
  }//end for 
}//end loadData

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
  outer.fill(#106738);
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
  inner.fill(#71C497);
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
      fill(#0E416C);
      rect(0, j*space*7, handle_width, space);
      j++;
    }//end else
    else if( (i - 1) % 7 == 0)
    {
      fill(#7197B7);
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
  
  fill(#106738);
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
        welcome();
        break;
      }//end case
      case 1:       
      {
        missions();
        break;
      }//end case
      case 2:
      {
        soldiers();
        break;
      }//end case
      case 3:
      {
        crafts();
        break;
      }//end case
      case 4:
      {
        tech();
        break;
      }//end case
      case 5:
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

void keyPressed()
{
  if(keyPressed)
  {
    if(key == ' ')
    {
      menu_choice = 0;
    }//end if
  }//end if
}//end keyPressed

void mousePressed()
{
  float x_on = width - ( border + (handle_width / 2) );
  float y_on = border + handle_length - (radius * 0.9f);
  float d = sqrt(pow(mouseX-x_on,2) + pow(mouseY-y_on,2));
  if (d <= ( radius / 2 ))
  {
    if(on)
    {
      on = false;
    }//end if
    else
    {
      load = true;
      on = true;
      menu_choice = 100;
    }//end else
  }//end if
  
  if( mouseX > screen_inlay + menu_padding  + (screen_width * 0.8) && mouseX < screen_inlay + menu_padding + (screen_width * 0.8) + menu_width)
  {
    for(int i = 0; i < 5; i++)
    {
      if( mouseY > screen_inlay + menu_border + (i * (menu_gap + menu_button)) && mouseY < screen_inlay + menu_border + menu_button + (i * (menu_gap + menu_button)))
      {
        menu_choice = i + 1;
        if(menu_choice != 1)
        {
          mission_choice = 100;
        }//end if
        if(menu_choice != 2)
        {
          soldier_choice = 100;
        }//end if
      }//end if
    }//end for
  }//end if
  
  if(menu_choice == 1)
  {
    for(int i = 0; i < missions.size(); i++)
    { 
      x = y = 0;
    
      if(i >= missions.size() / 2)
      {
        y = screen_length - (mission_length + (gap_m * 2));
      }//end if
      
      if(i % 2 == 1)
      {
        x = mission_width + gap_m;
      }//end else
      
      if( mouseX > screen_inlay + gap_m + x && mouseX < screen_inlay + gap_m + x + mission_width)
      {
        if( mouseY > screen_inlay + gap_m + y && mouseY < screen_inlay + gap_m + y + mission_length)
        {
          mission_choice = i;
        }//end if
      }//end if
    }//end for
  }//end if 
  
  if(menu_choice == 2)
  {
    if( mouseX > screen_inlay && mouseX < screen_inlay + (screen_width * 0.25))
    {
      for(int i = 0; i < soldiers.size(); i++)
      {
        if( mouseY > screen_inlay + (i * interval) && mouseY < screen_inlay + interval + (i * interval))
        {
          soldier_choice = i;
          Soldier s = soldiers.get(i);
          pushMatrix();
          translate(screen_inlay + (screen_width * 0.25), screen_inlay);
          s.render();
          popMatrix();
        }//end if
      }//end for
    }//end if
  }//end if
}//end mousePressed

void loading()
{
  if(load)
  {
    fill(0);
    rect(0, 0, screen_width * 0.8f, screen_length);
    loading_screen.play();
    image(loading_screen, (screen_width * 0.8f) / 2 - loading_screen.width / 2, screen_length / 2 - loading_screen.height / 2);
    
    if (frameCount % 60 == 0)
    {
      //if(load)
      //{
        load = false;
        if(menu_choice == 100)
        {
          menu_choice = 0;
        }//end if
        return;
      //}//end if
    }//end if
  }//end if
}//end loading

void menu()
{
  fill(#9CCE64);
  rect(0, 0, screen_width * 0.2f, screen_length);
  
  fill(0);
  textSize(36);
  textAlign(CENTER, CENTER);
  text("XCOM:", (screen_width * 0.2f) / 2, menu_border / 3);
  text("Menu", (screen_width * 0.2f) / 2, (menu_border * 2) / 3);
  
  for(int i = 0; i < 5; i++)
  {
    textSize(24);
    textAlign(CENTER, CENTER);
    
    if(menu_choice == i + 1)
    {
      fill(#020ACB);
    }//end if
    else
    {
      fill(#79ADFF);
    }//end else
    rect(menu_padding, menu_border + ((i * menu_gap) + (i * menu_button)), menu_width, menu_button);

    fill(0);
    text(menu[i], (screen_width * 0.2f) / 2, menu_border + ( menu_button / 2 ) +((i * menu_gap) + (i * menu_button)));
  }//end for
}//end menu

void welcome()
{
  screen_back();
  
}//end welcome

void missions()
{
  screen_back();

  for(int i = 0; i < missions.size(); i++)
  {
    Mission m = missions.get(i);
    
    x = y = 0;
    
    if(i >= missions.size() / 2)
    {
      y = screen_length - (mission_length + (gap_m * 2));
    }//end if
    
    if(i % 2 == 1)
    {
      x = mission_width + gap_m;
    }//end else
    
    if(mission_choice == i)
    {
      fill(#020ACB);
    }//end if
    else
    {
      fill(#79ADFF);
    }//end else
    stroke(0);
    rect(gap_m + x, gap_m + y, mission_width, mission_length);
    
    textSize(24);
    textAlign(CENTER, CENTER);
    fill(0);
    text(m.name, gap_m + x, gap_m + y, mission_width, mission_length);
    
    if(mission_choice == i)
    {
      pushMatrix();
      translate(0, gap_m + mission_length);
      m.render(areas[i]);
      popMatrix();
    }//end if
  }//end for
}//end briefing

void soldiers()
{
  screen_back();
  
  for(int i = 0; i < soldiers.size(); i++)
  {
    Soldier s = soldiers.get(i);
    
    if(soldier_choice == i)
    {
      fill(#020ACB);
    }//end if
    else
    {
      fill(#79ADFF);
    }//end else
    stroke(0);
    rect(0, (i * interval), screen_width * 0.25, interval);
    
    textSize(12);
    textAlign(CENTER, CENTER);
    fill(0);
    text(s.rank + ". " + s.name + " '" + s.nickname + "' " + s.surname, 0, (i * interval), screen_width * 0.25, interval);
  }//end if
}//end soldiers

void crafts()
{
  screen_back();
  
  for(int i = 0; i < aircraft.size(); i++)
  {
    float y = i * (craft_length + gap_cr);
    Craft c = aircraft.get(i);
    c.render(y, craft[i]);
  }//end for
}//end craft

void tech()
{
  screen_back();
  
}//end tech

void council()
{
  screen_back();

  stroke(0);
  noFill();
  rect(gap_cl * 2.0, gap_cl / 3.0, (screen_width * 0.8) - (gap_cl * 4), gap_cl * 2);
  image(map, (gap_cl * 2.0) + 1, (gap_cl / 3.0) + 1);
 
  fill(#B4F7FF);
  stroke(0);
  rect(gap_cl * 3.0, screen_length  - (gap_cl * 1.5), (screen_width * 0.8) - (gap_cl * 6.0), gap_cl * 1.25, space_cl);
  
  textAlign(CENTER);
  fill(0);
  textSize(14);
  text("Monthly Report:", gap_cl * 3.0, screen_length  - (gap_cl * 1.5), (screen_width * 0.8) - (gap_cl * 6.0), gap_cl * 1.25);
  textSize(11);
  text("XCOM has been making great progress, slowly pushing ADVENT and their Alien Overlords back.\nPeople flock to our cause and the Avatar project has been hampered, keep up the good work",
  gap_cl * 3.0, screen_length  - (gap_cl * 1.1), (screen_width * 0.8) - (gap_cl * 6.0), gap_cl * 1.25);
  
  for(int i = 0; i < countries.size(); i++)
  {
    Country c = countries.get(i);
    if(i < countries.size() / 2)
    {
      x = y = 0;
    }//end if
    else
    {
      x = (screen_width * 0.4);
      y = countries.size() / 2;
    }//end else
    c.render(x, y, i);
  }//end for
}//end council

void screen_back()
{
  int line_count = 40;
  float line_across = screen_width * 0.8 / line_count;
  float line_down = screen_length / line_count;
  fill(#1A1A1A);
  rect(0, 0, screen_width * 0.8, screen_length);
  
  for(int i = 1 ; i < line_count; i ++)
  {
    stroke(0);
    line((i * line_across), 0, (i * line_across), screen_length);
    line(0, (i * line_down), screen_width * 0.8, (i * line_down));
  }//end for
}//end screen_back

void mouseOver()
{
  if(menu_choice == 4)
  {
    //for(int i = 0; i < countries.size(); i++)
    //{
    //  Country c = countries.get(i);
    //  if(i < countries.size() / 2)
    //  {
    //    x = 0;
    //    y = 0;
    //  }//end if
    //  else
    //  {
    //    x = (screen_width * 0.4);
    //    y = countries.size() / 2;
    //  }//end else
    //  if(mouseX > ((gap_cl * 1.25) + x + border + (corner * 0.9)) && mouseX < (((screen_width * 0.4) + x + border  + (corner * 0.9)) - (gap_cl * 1.25)))
    //  {
    //    if(mouseY > ((space_cl + border + (corner * 0.9) + (gap_cl * 2.5)) + ((i - y) * (space_cl * 4))) && mouseY < (((space_cl * 4.0) + border + (corner * 0.9) + (gap_cl * 2.5)) + ((i - y) * (space_cl * 4))))
    //    {
    //      rect(mouseX, mouseY, 25, 25);
    //    }//end if
    //  }//end if
    //}//end for
  }//end if
}//end mouseOver