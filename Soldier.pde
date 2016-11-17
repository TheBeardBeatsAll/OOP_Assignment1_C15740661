class Soldier
{
  String name;
  String rank;
  String nickname;
  float health;
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
    this.rank = row.getString(1);
    this.health = row.getFloat(2);
    this.kills = row.getInt(3);
    this.mobility = row.getFloat(4);
    this.aim = row.getFloat(5);
    this.tech = row.getFloat(6);
    this.will = row.getFloat(7);
    this.skill1 = row.getString(8);
    this.skill2 = row.getString(9);
    this.skill3 = row.getString(10);
    this.skill4 = row.getString(11);
    this.skill5 = row.getString(12);
    this.bio = row.getString(13);
  }//end constructor
}//end class