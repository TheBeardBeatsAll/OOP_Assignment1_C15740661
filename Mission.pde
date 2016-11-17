class Mission
{

  String type;
  String rewards;
  int difficulty;
  String location;
  int alien1_amount;
  String alien1_name;
  int alien2_amount;
  String alien2_name;
  int alien3_amount;
  String alien3_name;
  String description;
  
  Mission(TableRow row)
  {
    this.type = row.getString(0);
    this.rewards = row.getString(1);
    this.difficulty = row.getInt(2);
    this.location = row.getString(3);
    this.alien1_amount = row.getInt(4);
    this.alien1_name = row.getString(5);
    this.alien2_amount = row.getInt(6);
    this.alien2_name = row.getString(7);
    this.alien3_amount = row.getInt(8);
    this.alien3_name = row.getString(9);
    this.description = row.getString(10);
  }//end constructor

}//end mission