void setup()
{
  //set size to fullscreen, initialize all the measurements of that
  //load in all the data and create the two shapes that make up the pda
  fullScreen();
  initialize();
  createPDA();
}//end setup

//library to use gifs
import gifAnimation.*;

//audio library
import ddf.minim.*;

//Class to play a gif
Gif loading_screen;

//Class to play a sound
Minim minim;
AudioPlayer welcome;
AudioPlayer mouse;
AudioPlayer keyb;
AudioPlayer on_s;
AudioPlayer off_s;

PShape pda, outer, inner;
PImage backg, map;

float x, y;

float border, pda_width, pda_length, screen_inlay;
float handle_length, handle_width, corner;
float screen_width, screen_length, radius;
float menu_border, menu_button ,menu_gap ,menu_width ,menu_padding;
float gap_cl, space_cl, timer;
float gap_cr, craft_length, craft_width;
float gap_m, mission_length, mission_width;
float interval, tech_width, tech_length, gap_t;
float soldier_width, soldier_length, gap_s;

int menu_choice, soldier_choice, mission_choice, mission_selected;
int item_choice, count;

String s_select, m_select, o_select;

boolean on;

Table t;

int[] checks = new int[5];
int[] text_size = new int[9];//entries relate to textSize(10, 11, 12, 13, 14, 15, 20, 24, 36)


Boolean[] select_m = new Boolean[4];
Boolean[] select_s = new Boolean[14];

PImage[] craft = new PImage[3];  
PImage[] areas = new PImage[4];
PImage[] item = new PImage[12];

String[] menu = new String[6];
String[] overview = new String[6];

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
  //set background image
  background(backg);
  
  //draw pda, handle and power button
  pushMatrix();
  translate(border, border);
  shape(pda);
  translate(pda_width - handle_width, handle_length);
  drawHandle();
  draw_on_off();
  popMatrix();
  
  //draw the current screen
  pushMatrix();
  translate(screen_inlay, screen_inlay);
  screen();
  popMatrix();
  
  //check if mouseX & mouseY are over certain areas on the tech screen
  mouseOver();
}//end draw

//method intialize all the data: all measurements are taking in relation to width and height
void initialize()
{  
  //set all booleans to false
  for(int i = 0; i < 4; i++)
  {
    select_m[i] = false;
  }//end if
  for(int i = 0; i < 14; i++)
  {
    select_s[i] = false;
  }//end if
  on = false;

  for(int i = 0; i < 5; i++)
  {
    checks[i] = -1;
  }//end if
  count = 0;
  
  border = width * 0.02;
  pda_width = width - (border * 2);
  pda_length = height - (border * 2);
  
  corner = pda_length * 0.1;
  radius = corner * 0.8;
  
  screen_inlay = border + (corner * 0.9);
  screen_width = pda_width * 0.73;
  screen_length = pda_length - (corner * 1.8);
  
  //text sizes scaled
  text_size[0] = (int)(screen_length * 0.018);//entry relate to textSize(10)
  text_size[1] = (int)(screen_length * 0.019);//entry relate to textSize(11)
  text_size[2] = (int)(screen_length * 0.021);//entry relate to textSize(12)
  text_size[3] = (int)(screen_length * 0.0225);//entry relate to textSize(13)
  text_size[4] = (int)(screen_length * 0.024);//entry relate to textSize(14)
  text_size[5] = (int)(screen_length * 0.029);//entry relate to textSize(15)
  text_size[6] = (int)(screen_length * 0.035);//entry relate to textSize(20)
  text_size[7] = (int)(screen_length * 0.045);//entry relate to textSize(24)
  text_size[8] = (int)(screen_length * 0.07);//entry relate to textSize(36)
  
  handle_length = pda_length / 3.0f;
  handle_width = pda_length * 0.15f;
  
  menu_choice = 100;
  menu_border = screen_length * 0.18f;
  menu_button = (screen_length * 0.8f) / 7;
  menu_gap = (menu_button * 0.8) / 5;
  menu_width = screen_width * 0.18f;
  menu_padding = screen_width * 0.01f;
  
  //strings that are set
  menu[0] = "Overview";
  menu[1] = "Missions";
  menu[2] = "Soldiers";
  menu[3] = "Craft";
  menu[4] = "Tech";
  menu[5] = "Council";
  
  overview[3] = "Everything is going smoothly Commander";
  overview[4] = "\nMost of the underpopulated areas around the world belong to us and we are making progress on putting ADVENT under pressure where it hurts them.";
  overview[5] = "\nTheir Avatar Project is still moving forward but we are confident that you have plans to deal with that.\nWe will reclaim this world!";
  overview[0] = "Three of our most advanced aircraft are on standby to deal with any aeriel threats ADVENT send us and can be viewed on the craft screen";
  overview[1] = "The latest items our engineers have developed can be viewed on the Tech screen. Our soldiers will love some of these";
  overview[2] = "Commander, you can see the state of our operations around the world on the Council screen as well as the monthly report from the council";
  
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
  timer = -1;
  
  tech_width = (screen_width * 0.8) / 4;
  gap_t = (screen_width * 0.8) / 24;
  tech_length = (screen_length - (gap_t * 7)) / 4;
  
  soldier_width = screen_width * 0.50;
  soldier_length = screen_length * 0.25;
  gap_s = ((screen_width * 0.55) - soldier_width) / 2;
  
  s_select = ""; 
  m_select = "";
  o_select = "";
  
  //load in csv,wav,png & jpg files
  loadData();
  loadImages();
  loadSounds();
  
  interval = screen_length / soldiers.size();
}//initialize

//method to load in the images
void loadImages()
{
  //load in gif
  loading_screen = new Gif(this, "XCOM_Shield_Logo.gif");
  
  //load in background image
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

//method to load in data
void loadData()
{
  //make sure all arraylists start empty
  countries.clear();
  missions.clear();
  items.clear();
  soldiers.clear();
  aircraft.clear();
  on_mission.clear();
  
  //load in all the data from the csv files
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

//method load in sounds
void loadSounds()
{
  minim = new Minim(this);       
  
  welcome = minim.loadFile("welcome.mp3");
  mouse = minim.loadFile("click.wav");
  keyb = minim.loadFile("button.wav");
  on_s = minim.loadFile("on.wav");
  off_s = minim.loadFile("off.wav");
}//end loadSounds

//method to play the sounds
void playSound(AudioPlayer sound)
{
  if (sound == null)
  {
    return;
  }
  sound.rewind();
  sound.play(); 
}//end playSound

//method to create the inner and outer shape of the pda
void createPDA()
{
  float inside_corner = corner * 0.7f;
  float inside_width = corner * 0.7f;
  float gap_pda = pda_length * 0.015f;
  float theta = 45.0f;
  float gap_theta = gap_pda * sin(radians(theta));
  
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


//method to draw the handle for the pda
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


//method to draw the power button either on or off
void draw_on_off()
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


//method to draw the current screen
void screen()
{
  float gap_sc = screen_width * 0.006f;
  
  fill(#106738);
  rect( - gap_sc, - gap_sc, screen_width + (gap_sc * 2), screen_length + (gap_sc *  2));
  if(on)
  {
    //play the loading gif when the pda is turned on
    loading();
    
    if(menu_choice != 100)
    {
      //draw the menu bar
      pushMatrix();
      translate(screen_width * 0.80f, 0);
      menu();
      popMatrix();
      
      switch(menu_choice)
      {
        case 0:
        {
          overview();
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
  }//end if
  else
  {
    //blank screen when off
    fill(0);
    rect(0, 0, screen_width, screen_length);
  }//end else
}//end screen

//method to process all changes when power button hit
void update_on()
{
  if(on)
  {
    on = false;
    loading_screen.stop();
    playSound(off_s);
  }//end if
  else
  {
    on = true;
    timer = millis();
    loading_screen.play();
    playSound(on_s);
    menu_choice = 100;
    mission_choice = 0;
    soldier_choice = 0;
    mission_selected = 100;
  }//end else
}//end update_on

//method to check key presses
void keyPressed()
{
  if(keyPressed)
  {
    if(key == ' ')
    {
      update_on();
    }//end if
    if(key == ENTER)
    {
      //if on mission screen, select/deselect the mission currently displayed
      if(menu_choice == 1)
      {
        for(int i = 0; i < missions.size(); i++)
        {
          if(mission_choice == i)
          {
            //deselect mission 
            if(select_m[i])
            {
              select_m[i] = false;
              selected = null;
              playSound(keyb);
            }//end if
            else
            {
              //select this mission and set all other missions to deselected
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
              playSound(keyb);
            }//end else
          }//end if
        }//end for
      }//end if
      
      //if on soldier screen, add current soldier onto mission to a total of 5 soldiers
      if(menu_choice == 2)
      {
        for(int i = 0; i < soldiers.size(); i++)
        {
          if(soldier_choice == i)
          {
            if(select_s[i])
            {
              remove(i);
              playSound(keyb);
            }//end if
            else
            {
              if(count < checks.length)
              {
                add(i);
                playSound(keyb);
              }//end if
            }//end else
          }//end if
        }//end for
      }//end if
    }//end if
    
    //navigate up and down the screen menu with w & s
    if(menu_choice > 0 && menu_choice < 6)
    {
      if(key == 'w')
      {
        playSound(keyb);
        menu_choice--;
      }//end if
    }//end if
    
    if(menu_choice < 5 && menu_choice > - 1)
    {
      if(key == 's')
      {
        playSound(keyb);
        menu_choice++;
      }//end if
    }//end if
    
    //navigate up and down the screen menu with q & a
    if(menu_choice == 1)
    {
      if(mission_choice > 0 && mission_choice < missions.size())
      {
        if(key == 'q')
        {
          playSound(keyb);
          mission_choice--;
        }//end if
      }//end if
      
      if(mission_choice < missions.size() - 1 && mission_choice > - 1)
      {
        if(key == 'a')
        {
          playSound(keyb);
          mission_choice++;
        }//end if
      }//end if
    }//end if
    
    //navigate up and down the screen menu with e & d
    if(menu_choice == 2)
    {
      if(soldier_choice > 0 && soldier_choice < soldiers.size())
      {
        if(key == 'e')
        {
          playSound(keyb);
          soldier_choice--;
        }//end if
      }//end if
      
      if(soldier_choice < soldiers.size() - 1 && soldier_choice > - 1)
      {
        if(key == 'd')
        {
          playSound(keyb);
          soldier_choice++;
        }//end if
      }//end if
    }//end if
  }//end if
}//end keyPressed

//method to add soldier to mission
void add(int x)
{
  //store index of soldier in ArrayList soldiers into array checks
  checks[count] = x;
  //add soldier to ArrayList on_mission
  selects = soldiers.get(x);
  on_mission.add(selects);
  count++;
  
  //set all entries of select_s to false except for the entries whose indexes are stored in checks
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

//method to remove the soldier from the mission
void remove(int x)
{
  int temp;
  select_s[x] = false;
  
  //find which entry of checks holds the index of the soldier and set it to -1
  for(int i = 0; i < checks.length; i++)
  {
    if(checks[i] == x)
    {
      on_mission.remove(i);
      checks[i] = -1;
      count--;
      //swap the current entry in checks to the end or until it encounters another -1 entry
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

//method to check if mouseX and mouseY are between a certain set of passed through coordinates
boolean mouseCheck(float x1, float x2, float y1, float y2)
{
  if(mouseX > x1 && mouseX < (x1 + x2))
  {
    if(mouseY > y1 && mouseY < (y1 + y2))
    {
      return true;
    }//end if
    else 
    {
      return false;
    }//end else
  }//end if
  else 
  {
    return false;
  }//end else
}//end mouseCheck

//method to check for a mouse press
void mousePressed()
{
  float x_on = width - ( border + (handle_width / 2) );
  float y_on = border + handle_length - (radius * 0.9f);
  float d = sqrt(pow(mouseX-x_on,2) + pow(mouseY-y_on,2));
  //check for press on power button
  if (d <= ( radius / 2 ))
  {
    update_on();
  }//end if
  
  //check for press on menu button 
  for(int i = 0; i < 6; i++)
  {
    if(mouseCheck(screen_inlay + menu_padding  + (screen_width * 0.8), menu_width, screen_inlay + menu_border + (i * (menu_gap + menu_button)), menu_button))
    {
      menu_choice = i;
      playSound(mouse);
    }//end if
  }//end for
  
  if(menu_choice == 1)
  {
    //check for press on mission menu
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
      
      if(mouseCheck(screen_inlay + gap_m + x, mission_width, screen_inlay + gap_m + y, mission_length))
      {
        mission_choice = i;
        playSound(mouse);
      }//end if
    }//end for
    
    //check for press on mission select
    if(mouseCheck(screen_inlay + (mission_width * 1.4), mission_width * 0.5, screen_inlay + (mission_length * 2.25), mission_length))
    {
      for(int i = 0; i < missions.size(); i++)
      {
        if(mission_choice == i)
        {
          if(select_m[i])
          {
            select_m[i] = false;
            selected = null;
            playSound(mouse);
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
            playSound(mouse);
          }//end else
        }//end if
      }//end for
    }//end if
  }//end if 
  
  if(menu_choice == 2)
  {
    //check for press on soldier menu
    for(int i = 0; i < soldiers.size(); i++)
    {
      if(mouseCheck(screen_inlay, screen_width * 0.25, screen_inlay + (i * interval), interval))
      {
        soldier_choice = i;
        playSound(mouse);
      }//end if
    }//end for

    //check for press on soldier select
    if(mouseCheck(screen_inlay + gap_s + (screen_width * 0.25) + (soldier_width * 0.25), (soldier_width * 0.5), screen_inlay + screen_length - (gap_s * 2.3), gap_s * 1.8))
    {
      for(int i = 0; i < soldiers.size(); i++)
      {
        if(soldier_choice == i)
        {
          if(select_s[i])
          {
            remove(i);
            playSound(mouse);
          }//end if
          else
          {
            if(count < checks.length)
            {
              add(i);
              playSound(mouse);
            }//end if
          }//end else
        }//end if
      }//end for
    }//end if
  }//end if
}//end mousePressed

//method to run loading screen on power on
void loading()
{
  fill(0);
  rect(0, 0, screen_width, screen_length);
  
  
  image(loading_screen, 0, 0, screen_width, screen_length);

  //run loading gif for 3 seconds then swap to overview screen and play welcome sound
  if((millis() - timer) / 1000 > 3)
  {
    if(menu_choice == 100)
    {
      timer = -1;
      playSound(welcome);
      menu_choice = 0;  
    }//end if
  }//end if
}//end loading

//method to draw menu part of screen
void menu()
{
  fill(#9CCE64);
  rect(0, 0, screen_width * 0.2f, screen_length);
  
  fill(0);
  textSize(text_size[8]);
  textAlign(CENTER, CENTER);
  text("XCOM:", (screen_width * 0.2f) / 2, menu_border / 3);
  text("Menu", (screen_width * 0.2f) / 2, (menu_border * 2) / 3);
  
  for(int i = 0; i < 6; i++)
  {
    textSize(text_size[7]);
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

//method to draw overview screen
void overview()
{
  screen_back();
  
  fill(#DE0000);
  stroke(0);
  textSize(text_size[8]);
  textAlign(CENTER, CENTER);
  text("Welcome Commander", screen_width * 0.4, screen_length * 0.05);
  
  stroke(0);
  fill(#B4F7FF);
  rect(gap_m, gap_m * 4, mission_width * 0.8, mission_length * 3.5);
  
  fill(#79ADFF);
  rect(mission_width * 0.3, screen_length * 0.5, mission_width * 1.5, mission_length);
  
  for(int i = 0; i < 3; i++)
  {
    fill(#B4F7FF);
    rect(screen_width * 0.35, (gap_m * 4) + (i * (mission_length + gap_m)), mission_width, mission_length * 0.7);
    fill(0);
    textSize(text_size[0]);
    textAlign(LEFT, TOP);
    text(overview[i], (screen_width * 0.35) + (gap_m * 0.2), (gap_m * 4.2) + (i * (mission_length + gap_m)), mission_width - (gap_m * 0.2), (mission_length * 0.7) - (gap_m * 0.2));
  }//end for

  //display mission if selected
  if(selected != null)
  {
    m_select = "Operation " + selected.name + " locked in";
  }//end if
  else
  {
    m_select = "--No Mission Selected--";
  }//end else
  fill(0);
  textSize(text_size[7]);
  textAlign(CENTER, CENTER);
  text(m_select, mission_width * 1.05, (screen_length * 0.5) + mission_length * 0.5);
  
  //display up to 5 soldiers if selected
  for(int i = 0; i < 5; i++)
  {
    x = y = 0;
    
    if(i < on_mission.size())
    {
      Soldier s = on_mission.get(i);
      s_select = s.rank + " " + s.name + " '" + s.nickname + "' " + s.surname;
    }//end if
    else
    {
      s_select = "--Vacant Slot On Mission--";
    }//end else
    
    if(i > 1)
    {
      y = (mission_length * 0.9) + gap_m;
    }//end if
    if(i % 2 == 1)
    {
      x = mission_width + gap_m;
    }//end if
    if(i == 4)
    {
      x = screen_width * 0.2;
      y = 2 * ((mission_length * 0.9) + gap_m);
    }//end if
    
    fill(#79ADFF);
    rect(gap_m + x, (screen_length * 0.65) + y, mission_width, mission_length * 0.9);
    
    fill(0);
    textSize(text_size[5]);
    textAlign(CENTER, CENTER);
    text(s_select, (mission_width * 0.5)+ gap_m + x, (mission_length * 0.45) + (screen_length * 0.65) + y);
  }//end for
  
  textSize(text_size[2]);
  textAlign(LEFT, TOP);
  text(overview[3] + overview[4] + overview[5], gap_m * 1.2, gap_m * 4.2, (mission_width * 0.8) - (gap_m * 0.2), (mission_length * 3.5)  - (gap_m * 0.2));
}//end overview

//method to draw mission screen
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
    
    //display whether mission is selected or not
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
      textSize(text_size[7]);
      textAlign(CENTER, CENTER);
      text(m_select, mission_width * 1.65, mission_length * 2.75);
      
      //show mission info
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
    
    //draw mission menu
    stroke(0);
    rect(gap_m + x, gap_m + y, mission_width, mission_length);
    
    textSize(text_size[7]);
    textAlign(CENTER, CENTER);
    fill(0);
    text(m.name, gap_m + x, gap_m + y, mission_width, mission_length);
  }//end for
}//end briefing

//mission to draw soldiers screen
void soldiers()
{
  screen_back();
  
  fill(#79ADFF);
  stroke(0);
  rect((soldier_width * 0.7) + screen_width * 0.25, gap_s, soldier_width * 0.35, gap_s * 2);
  
  //display amount of soldiers on mission
  fill(0);
  textSize(text_size[6]);
  textAlign(CENTER, CENTER);
  text(count + "/5 on mission", (soldier_width * 0.875) + screen_width * 0.25, gap_s * 2);
  
  
  for(int i = 0; i < soldiers.size(); i++)
  {
    Soldier s = soldiers.get(i);
    
    if(soldier_choice == i)
    {
      pushMatrix();
      translate((screen_width * 0.25), 0);
      
      //show whether current soldier is on mission or not
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
      textSize(text_size[6]);
      textAlign(CENTER, CENTER);
      text(s_select, gap_s + (soldier_width * 0.5), screen_length - (gap_s * 1.4));
      
      //show current soldiers info
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
    
    //display soldier menu
    textSize(text_size[2]);
    textAlign(CENTER, CENTER);
    fill(0);
    text(s.rank + ". " + s.name + " '" + s.nickname + "' " + s.surname, 0, (i * interval), screen_width * 0.25, interval);
  }//end for
}//end soldiers

//method to draw crafts screen
void crafts()
{
  screen_back();
  
  for(int i = 0; i < aircraft.size(); i++)
  {
    float y = i * (craft_length + gap_cr);
    Craft c = aircraft.get(i);
    //display craft info + image
    c.render(y, craft[i]);
  }//end for
}//end craft

//method to draw tech screen
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
      
      //display info icon
      stroke(0);
      fill(#B4F7FF);
      rect((gap_t * 2) + x + tech_width, (gap_t * 2) + y, (gap_t * 0.6), gap_t);
      fill(#FCF503);
      ellipse((gap_t * 2.3) + x + tech_width, (gap_t * 2.3) + y, (gap_t * 0.3), (gap_t * 0.3));
      rect((gap_t * 2.15) + x + tech_width, (gap_t * 2.55) + y, (gap_t * 0.3), (gap_t * 0.35));
      
      //display item image
      image(item[item_choice], (gap_t * 2) + x, (gap_t * 2) + y);
      item_choice++;
    }//end if
  }//end for
}//end tech

//method to draw council screen
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
  textSize(text_size[4]);
  text("Monthly Report:", gap_cl * 3.0, screen_length  - (gap_cl * 1.5), (screen_width * 0.8) - (gap_cl * 6.0), gap_cl * 1.25);
  textSize(text_size[1]);
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
    //show country info
    c.render(x, y, i);
  }//end for
}//end council

//method to draw the background grid on each screen
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

//method to check if mouse is over tech info icon
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
        item_choice++;
        if(mouseCheck(screen_inlay + (gap_t * 2) + tech_width + x, gap_t * 0.6, screen_inlay + (gap_t * 2) + y, gap_t))
        {
          //display item info
          t.render(mouseX,mouseY);
        }//end if
      }//end for
    }//end for
  }//end if
}//end mouseOver