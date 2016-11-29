class Tech
{
  String type; 
  String name;
  int amount;
  String description;
  
  //load in data from row in file
  Tech(TableRow row)
  {
    this.type = row.getString(0);
    this.name = row.getString(1);
    this.amount = row.getInt(2);
    this.description = row.getString(3);
  }//end constructor
  
  //Class method to draw data
  void render(float x, float y)
  {
    stroke(0);
    fill(#B4F7FF);
    rect(x, y, tech_width * 1.1, tech_length * 1.35);
    fill(0);
    textSize(text_size[4]);
    textAlign(CENTER, CENTER);
    text(name, 
    x + (tech_width * 0.55), y + (tech_length * 0.1));
    textSize(text_size[0]);
    text("Type: " + type + "  Stock: " + amount, 
    x + (tech_width * 0.55), y + (tech_length * 0.29));
    textAlign(LEFT, TOP);
    text("Description: " + description, 
    x + (tech_width * 0.03), y + (tech_length * 0.4), tech_width * 1.05, tech_length);
  }//end render
}//end Tech