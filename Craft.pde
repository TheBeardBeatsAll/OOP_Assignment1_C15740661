class Craft
{
  String type;
  String nickname;
  String wp1;
  String wp2;
  String wp3;
  float fuel;
  String armour;
  String description;
  
  Craft(TableRow row)
  {
    this.type = row.getString(0);
    this.nickname = row.getString(1);
    this.wp1 = row.getString(2);
    this.wp2 = row.getString(3);
    this.wp3 = row.getString(4);
    this.fuel = row.getFloat(5);
    this.armour = row.getString(6);
    this.description = row.getString(7);
  }//end constructor
}//end Craft