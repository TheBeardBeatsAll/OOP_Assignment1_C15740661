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
  
  void render()
  {
    float charts;
    
    charts = chart(mobility);
    charts = chart(aim);
    charts = chart(tech);
    charts = chart(will);
  }//end render
  
  float chart(float x)
  {
    float scale = 0;
    
    return scale;
  }//end chart
}//end class