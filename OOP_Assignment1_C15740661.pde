void setup()
{
  //fullScreen();
  size( 1000, 600);
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
float interval, tech_width, tech_length, gap_t;
float soldier_width, soldier_length, gap_s;

int menu_choice, soldier_choice, mission_choice, mission_selected;
int item_choice, count;

String s_select, m_select, o_select;

boolean on, load;

Table t;

int[] checks = new int[5];

Boolean[] select_m = new Boolean[4];
Boolean[] select_s = new Boolean[14];

PImage[] craft = new PImage[3];  
PImage[] areas = new PImage[4];
PImage[] item = new PImage[12];

String[] menu = new String[6];

Mission selected = null;
Soldier selects = null;

ArrayList<Mission> missions = new ArrayList<Mission>();
ArrayList<Tech> items = new ArrayList<Tech>();
ArrayList<Country> countries = new ArrayList<Country>();
ArrayList<Craft> aircraft = new ArrayList<Craft>();
ArrayList<Soldier> soldiers = new ArrayList<Soldier>();
ArrayList<Soldier> on_mission = new ArrayList<Soldier>();

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
  for(int i = 0; i < 4; i++)
  {
    select_m[i] = false;
  }//end if
  for(int i = 0; i < 14; i++)
  {
    select_s[i] = false;
  }//end if
  on = load = false;

  for(int i = 0; i < 5; i++)
  {
    checks[i] = -1;
  }//end if
  count = 0;
  
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
  menu_button = (screen_length * 0.8f) / 7;
  menu_gap = (menu_button * 0.8) / 5;
  menu_width = screen_width * 0.18f;
  menu_padding = screen_width * 0.01f;
  
  menu[0] = "Overview";
  menu[1] = "Missions";
  menu[2] = "Soldiers";
  menu[3] = "Craft";
  menu[4] = "Tech";
  menu[5] = "Council";
  
  gap_cl = screen_width * 0.04;
  space_cl = (screen_length - (gap_cl * 3.8)) / 43.0;
  
  gap_cr = screen_length * 0.05f;
  craft_length = (screen_length - (gap_cr * 4)) / 3.0;
  craft_width = ((screen_width * 0.8) - (gap_cr * 3)) / 2.0;
  
  gap_m = screen_length * 0.03f;
  mission_length = screen_length * 0.1;
  mission_width = ((screen_width * 0.8) - (gap_m * 3)) / 2.0;
  
  soldier_choice = 0;
  mission_choice = 0;
  mission_selected = 100;
  
  tech_width = (screen_width * 0.8) / 4;
  gap_t = (screen_width * 0.8) / 24;
  tech_length = (screen_length - (gap_t * 7)) / 4;
  
  soldier_width = screen_width * 0.50;
  soldier_length = screen_length * 0.25;
  gap_s = ((screen_width * 0.55) - soldier_width) / 2;
  
  loadData();
  loadImages();
  
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
  
  for(int i = 0; i < item.length; i++)
  {
    item[i] = loadImage("item" + i + ".png");
    item[i].resize((int)((tech_width)), (int)(tech_length));
  }//end for
}//end loadImages

void loadData()
{
  countries.clear();
  missions.clear();
  items.clear();
  soldiers.clear();
  aircraft.clear();
  on_mission.clear();
  
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
    items.add(te);
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
      fill(#26263B);
      rect(0, j*space*7, handle_width, space);
      j++;
    }//end else
    else if( (i - 1) % 7 == 0)
    {
      fill(#595962);
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
      if(on)
      {
        on = false;
      }//end if
      else
      {
        load = true;
        on = true;
        menu_choice = 100;
        mission_choice = 0;
        soldier_choice = 0;
        mission_selected = 100;
      }//end else
    }//end if
    if(key == ENTER)
    {
      if(menu_choice == 1)
      {
        for(int i = 0; i < missions.size(); i++)
        {
          if(mission_choice == i)
          {
            if(select_m[i])
            {
              select_m[i] = false;
              selected = null;
            }//end if
            else
            {
              for(int j = 0; j < missions.size(); j++)
              {
                if(i == j)
                {
                  select_m[j] = true;
                }//end if
                else
                {
                  select_m[j] = false;
                }//end else
              }//end for
              selected = missions.get(i);
            }//end else
          }//end if
        }//end for
      }//end if
      
      if(menu_choice == 2)
      {
        for(int i = 0; i < soldiers.size(); i++)
        {
          if(soldier_choice == i)
          {
            if(select_s[i])
            {
              remove(i);
            }//end if
            else
            {
              if(count < checks.length)
              {
                add(i);
              }//end if
            }//end else
          }//end if
        }//end for
      }//end if
    }//end if
    
    if(menu_choice > 0 && menu_choice < 6)
    {
      if(key == 'w')
      {
        menu_choice--;
      }//end if
    }//end if
    
    if(menu_choice < 5 && menu_choice > - 1)
    {
      if(key == 's')
      {
        menu_choice++;
      }//end if
    }//end if
    
    if(menu_choice == 1)
    {
      if(mission_choice > 0 && mission_choice < missions.size())
      {
        if(key == 'q')
        {
          mission_choice--;
        }//end if
      }//end if
      
      if(mission_choice < missions.size() - 1 && mission_choice > - 1)
      {
        if(key == 'a')
        {
          mission_choice++;
        }//end if
      }//end if
    }//end if
    if(menu_choice == 2)
    {
      if(soldier_choice > 0 && soldier_choice < soldiers.size())
      {
        if(key == 'e')
        {
          soldier_choice--;
        }//end if
      }//end if
      
      if(soldier_choice < soldiers.size() - 1 && soldier_choice > - 1)
      {
        if(key == 'd')
        {
          soldier_choice++;
        }//end if
      }//end if
    }//end if
  }//end if
}//end keyPressed

void add(int x)
{
  checks[count] = x;
  selects = soldiers.get(x);
  on_mission.add(selects);
  count++;
  
  for(int j = 0; j < select_s.length; j++)
  {
    for( int i = 0; i < count; i++)
    {
      if(j == checks[i])
      {
        select_s[j] = true;
        break;
      }//end if
      else
      {
        select_s[j] = false;
      }//end else
    }//end for
  }//end for
}//end add

void remove(int x)
{
  int temp;
  select_s[x] = false;
  
  for(int i = 0; i < checks.length; i++)
  {
    if(checks[i] == x)
    {
      on_mission.remove(i);
      checks[i] = -1;
      count--;
      for(int j = i; j < checks.length - 1; j++)
      {
        if(checks[j + 1] == -1)
        {
          return;
        }//end if
        temp = checks[j];
        checks[j] = checks[j + 1];
        checks[j + 1] = temp;
      }//end for
    }//end if
  }//end for
}//end remove

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
      mission_choice = 0;
      soldier_choice = 0;
      mission_selected = 100;
    }//end else
  }//end if
  
  if( mouseX > screen_inlay + menu_padding  + (screen_width * 0.8) && mouseX < screen_inlay + menu_padding + (screen_width * 0.8) + menu_width)
  {
    for(int i = 0; i < 6; i++)
    {
      if( mouseY > screen_inlay + menu_border + (i * (menu_gap + menu_button)) && mouseY < screen_inlay + menu_border + menu_button + (i * (menu_gap + menu_button)))
      {
        menu_choice = i;
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
    
  if( mouseX > screen_inlay + mission_width * 1.4 && mouseX < screen_inlay + mission_width * 1.9)
    {
      if( mouseY > screen_inlay + mission_length * 2.25 && mouseY < screen_inlay + mission_length * 3.25)
      {
        for(int i = 0; i < missions.size(); i++)
        {
          if(mission_choice == i)
          {
            if(select_m[i])
            {
              select_m[i] = false;
              selected = null;
            }//end if
            else
            {
              for(int j = 0; j < missions.size(); j++)
              {
                if(i == j)
                {
                  select_m[j] = true;
                }//end if
                else
                {
                  select_m[j] = false;
                }//end else
              }//end for
              selected = missions.get(i);
            }//end else
          }//end if
        }//end for
      }//end if
    }//end if
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
        }//end if
      }//end for
    }//end if

    if( mouseX > screen_inlay + (screen_width * 0.25) + gap_s + (soldier_width * 0.25) && mouseX <  screen_inlay + (screen_width * 0.25) + gap_s + (soldier_width * 0.75))
    {
      if( mouseY >   screen_inlay + screen_length - (gap_s * 2.3) && mouseY <  screen_inlay + screen_length - (gap_s * 0.5))
      {
        for(int i = 0; i < soldiers.size(); i++)
        {
          if(soldier_choice == i)
          {
            if(select_s[i])
            {
              remove(i);
            }//end if
            else
            {
              if(count < checks.length)
              {
                add(i);
              }//end if
            }//end else
          }//end if
        }//end for
      }//end if
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
  
  for(int i = 0; i < 6; i++)
  {
    textSize(24);
    textAlign(CENTER, CENTER);
    
    if(menu_choice == i)
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
  
  stroke(0);
  fill(255);
  rect(0,0, mission_width, mission_length);
  
  if(on_mission != null)
  {
    for(int i = 0; i < on_mission.size(); i++)
    {
       Soldier s = on_mission.get(i);
       fill(0);
       textSize(24);
       textAlign(CENTER, CENTER);
       text(s.name, mission_width * 0.8, mission_length * 0.5 + (i * (mission_length * 0.5)));
    }//end for
  }//end if
  if(selected != null)
  {
   fill(0);
   textSize(24);
   textAlign(CENTER, CENTER);
   text(selected.name, mission_width * 0.5, mission_length * 0.5);
  }//end if
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
      if(select_m[i])
      {
        fill(#FF1F23);
        m_select = "Selected";
        
      }//end if
      else
      {
        fill(#79ADFF);
        m_select = "Select";
      }//end else
      stroke(0);
      rect(mission_width * 1.4, mission_length * 2.25, mission_width * 0.5, mission_length);
      
      fill(0);
      textSize(24);
      textAlign(CENTER, CENTER);
      text(m_select, mission_width * 1.65, mission_length * 2.75);
      
      pushMatrix();
      translate(0, gap_m + mission_length);
      m.render(areas[i]);
      popMatrix();
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
      pushMatrix();
      translate((screen_width * 0.25), 0);
      if(select_s[i])
      {
        fill(#FF1F23);
        s_select = "On Mission";
      }//end if
      else
      {
        fill(#79ADFF);
        s_select = "Assign to Mission";
      }//end else
      stroke(0);
      rect(gap_s + (soldier_width * 0.25), screen_length - (gap_s * 2.3), soldier_width * 0.5, gap_s * 1.8);
      
      fill(0);
      textSize(20);
      textAlign(CENTER, CENTER);
      text(s_select, gap_s + (soldier_width * 0.5), screen_length - (gap_s * 1.4));
      
      s.render();
      popMatrix();
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
  }//end for
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
  
  item_choice = 0;
  
  for(int i = 0; i < items.size() / 4; i++)
  {
    for(int j = 0; j < items.size() / 3; j++)
    {
      x = i * (tech_width + gap_t);
      y = j * (tech_length + gap_t);
      
      stroke(0);
      fill(#B4F7FF);
      rect((gap_t * 2) + x + tech_width, (gap_t * 2) + y, (gap_t * 0.6), gap_t);
      fill(#FCF503);
      ellipse((gap_t * 2.3) + x + tech_width, (gap_t * 2.3) + y, (gap_t * 0.3), (gap_t * 0.3));
      rect((gap_t * 2.15) + x + tech_width, (gap_t * 2.55) + y, (gap_t * 0.3), (gap_t * 0.35));
      
      image(item[item_choice], (gap_t * 2) + x, (gap_t * 2) + y);
      item_choice++;
    }//end if
  }//end for
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
    item_choice = 0;
    for(int i = 0; i < items.size() / 4; i++)
    {
      for(int j = 0; j < items.size() / 3; j++)
      {
        x = i * (tech_width + gap_t);
        y = j * (tech_length + gap_t);
        
        Tech t = items.get(item_choice);
        if(mouseX > screen_inlay + (gap_t * 2) + tech_width + x && mouseX < screen_inlay + (gap_t * 2.6) + x + tech_width)
        {
          if(mouseY > screen_inlay + (gap_t * 2) + y && mouseY < screen_inlay + (gap_t * 3) + y)
          {
            t.render(mouseX,mouseY);
          }//end if
        }//end if
        item_choice++;
      }//end for
    }//end for
  }//end if
}//end mouseOver