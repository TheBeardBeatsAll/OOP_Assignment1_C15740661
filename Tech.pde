class Tech
{
  int type; // 1 = Armour, 2 = Weapon, 3 = Utility
  String name;
  int amount;
  String description;
  
  Tech(TableRow row)
  {
    this.type = row.getInt(0);
    this.name = row.getString(1);
    this.amount = row.getInt(2);
    this.description = row.getString(3);
  }//end constructor
}//end Tech