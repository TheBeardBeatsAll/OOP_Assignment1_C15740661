class Tech
{
  String type; 
  String name;
  int amount;
  String description;
  
  Tech(TableRow row)
  {
    this.type = row.getString(0);
    this.name = row.getString(1);
    this.amount = row.getInt(2);
    this.description = row.getString(3);
  }//end constructor
  
  void render(float x, float y)
  {
    stroke(0);
    fill(#B4F7FF);
    rect(x,y, tech_width * 1.1, tech_length);
    fill(0);
    textSize(10);
    textAlign(LEFT, TOP);
    text(" Name: " + name + "  Type: " + type + "  Stock: " + amount 
    + "\n Description: " + description
    , x,y, tech_width * 1.1, tech_length);
  }//end render
}//end Tech