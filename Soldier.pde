class Soldier
{
  String name;
  String rank;
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
  color c;
  
  Soldier(TableRow row)
  {
    this.name = row.getString(0);
    this.rank = row.getString(1);
    this.nickname = row.getString(2);
    this.health = row.getString(3);
    this.kills = row.getInt(4);
    this.mobility = row.getFloat(5);
    this.aim = row.getFloat(6);
    this.tech = row.getFloat(7);
    this.will = row.getFloat(8);
    this.skill1 = row.getString(9);
    this.skill2 = row.getString(10);
    this.skill3 = row.getString(11);
    this.skill4 = row.getString(12);
    this.skill5 = row.getString(13);
    this.bio = row.getString(14);
  }//end constructor
}//end class