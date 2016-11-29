class Soldier
{
  String name, surname, rank;
  String nickname;
  String health;
  int kills;
  float mobility;
  float aim;
  float tech;
  float will;
  String skill1;
  String skill2;
  String skill3;
  String skill4;
  String skill5;
  String bio;
  
  //load in data from row in file
  Soldier(TableRow row)
  {
    this.name = row.getString(0);
    this.surname = row.getString(1);
    this.rank = row.getString(2);
    this.nickname = row.getString(3);
    this.health = row.getString(4);
    this.kills = row.getInt(5);
    this.mobility = row.getFloat(6);
    this.aim = row.getFloat(7);
    this.tech = row.getFloat(8);
    this.will = row.getFloat(9);
    this.skill1 = row.getString(10);
    this.skill2 = row.getString(11);
    this.skill3 = row.getString(12);
    this.skill4 = row.getString(13);
    this.skill5 = row.getString(14);
    this.bio = row.getString(15);
  }//end constructor
  
  //Class method to draw data
  void render()
  {
    float inlay = soldier_width * 0.02;
    float chart_width; 
    float chart_length = inlay * 1.5;
      
    stroke(0);
    fill(#B4F7FF);
    rect(gap_s, gap_s, soldier_width * 0.6, soldier_length * 2.2);
    rect(gap_s, (gap_s * 2) + (soldier_length * 2.2), soldier_width, soldier_length);
    
    fill(0);
    textSize(text_size[2]);
    textAlign(LEFT, TOP);
    text("Name: " + name + " '" + nickname + "' " + surname 
    + "\nRank: " + rank + "\nHealth: " + health + "\nKills:" + kills
    + "\nMobility:\n\nAim:\n\nTech:\n\nWill:\n\nSkills:\n" + skill1
    + ", " + skill2 + ",\n" + skill3 + ", " +
    skill4 + ", " + skill5
    , gap_s + inlay, gap_s + inlay);
    text("Bio:\n" + bio, gap_s + inlay, (gap_s * 2) + (soldier_length * 2.2) + inlay, 
     soldier_width - (inlay * 2), soldier_length - inlay);
    
    chart_width = chart(mobility, inlay);
    fill(#E5FA05);
    rect(gap_s + inlay, gap_s + (inlay * 11), chart_width, chart_length);
    chart_width = chart(aim, inlay);
    fill(#1405FA);
    rect(gap_s + inlay, gap_s + (inlay * 15), chart_width, chart_length);
    chart_width = chart(tech, inlay);
    fill(#05FA1F);
    rect(gap_s + inlay, gap_s + (inlay * 19), chart_width, chart_length);
    chart_width = chart(will, inlay);
    fill(#FA0505);
    rect(gap_s + inlay, gap_s + (inlay * 23), chart_width, chart_length);
    
    fill(140);
    rect(soldier_width * 0.75, gap_s * 4, soldier_width * 0.25,  soldier_width * 0.3);
    fill(0);
    textSize(text_size[6]);
    textAlign(CENTER, CENTER);
    text("No\nImage\nAvailable", soldier_width * 0.875, (gap_s * 4) + (soldier_width * 0.15));
  }//end render
  
  //Class method to return scale on soldier stats to draw bar chart
  float chart(float x, float y)
  {
    float scale;
    
    scale = (x * ((soldier_width * 0.6) - (y * 2))) / 100;
    
    return scale;
  }//end chart
}//end class