class Mission
{
  String name;
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
  int alien4_amount;
  String alien4_name;
  String description;
  
  Mission(TableRow row)
  {
    this.name = row.getString(0);
    this.type = row.getString(1);
    this.rewards = row.getString(2);
    this.difficulty = row.getInt(3);
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

  void render()
  {
    
  }//end render
}//end mission