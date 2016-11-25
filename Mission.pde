class Mission
{
  String name;
  String type;
  String rewards;
  String difficulty;
  String location;
  int alien1_amount;
  String alien1_name;
  int alien2_amount;
  String alien2_name;
  int alien3_amount;
  String alien3_name;
  int alien4_amount;
  String alien4_name;
  String description;
  
  Mission(TableRow row)
  {
    this.name = row.getString(0);
    this.type = row.getString(1);
    this.rewards = row.getString(2);
    this.difficulty = row.getString(3);
    this.location = row.getString(4);
    this.alien1_amount = row.getInt(5);
    this.alien1_name = row.getString(6);
    this.alien2_amount = row.getInt(7);
    this.alien2_name = row.getString(8);
    this.alien3_amount = row.getInt(9);
    this.alien3_name = row.getString(10);
    this.alien4_amount = row.getInt(11);
    this.alien4_name = row.getString(12);
    this.description = row.getString(13);
  }//end constructor

  void render(PImage temp)
  {
    stroke(0);
    fill(#B4F7FF);
    rect(mission_width * 0.5, mission_length * 3, mission_width * 1.5, mission_length * 4);
    
    
    fill(0);
    textSize(text_size[5]);
    textAlign(LEFT, TOP);
    text("Name: " + name + "\nType: " + type + "\nRewards: " + rewards + "\nDifficulty: " 
    + difficulty + "\nLocation: " + location
    , mission_width * 1.29, mission_length * 3.1);
    textSize(text_size[3]);
    text("Enemies Present: " + alien1_amount + " " + alien1_name + "'s, " + alien2_amount + " " + alien2_name + "'s, "
    + alien3_amount + " " + alien3_name + "'s, " + alien4_amount + " " + alien4_name + "'s"
    + "\n" + description
    , mission_width * 0.54, mission_length * 5.4, mission_width * 1.46, mission_length * 2.6);
    
    noFill();
    rect(gap_m * 1.5, gap_m, mission_width * 1.2, mission_length * 5);
    image(temp, (gap_m * 1.5) + 1, gap_m + 1);
  }//end render
}//end mission