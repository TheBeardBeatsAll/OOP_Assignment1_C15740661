class Tech
{
  String type; 
  String name;
  int amount;
  String description;
  String type_n;
  
  Tech(TableRow row)
  {
    this.type = row.getString(0);
    this.name = row.getString(1);
    this.amount = row.getInt(2);
    this.description = row.getString(3);
  }//end constructor
  
  void render(float x, float y)
  {
    fill(0);
    rect(x,y, 20, 20);
  }//end render
}//end Tech