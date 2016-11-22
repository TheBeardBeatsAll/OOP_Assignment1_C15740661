class Craft
{
  String type;
  String nickname;
  String wp1, wp2, wp3, wp4;
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
    this.wp4 = row.getString(5);
    this.fuel = row.getFloat(6);
    this.armour = row.getString(7);
    this.description = row.getString(8);
  }//end constructor
  
  void render(float y, PImage temp)
  {
    stroke(0);
    fill(#B4F7FF);
    rect(gap_cr, gap_cr + y, craft_width, craft_length);
    
    textAlign(CENTER);
    fill(0);
    textSize(15);
    text(type + " '" + nickname + "'"
    , gap_cr, gap_cr + y, craft_width, craft_length);
    textSize(12);
    text("Systems: " + wp1 + ", " + wp2 + ",\n"
    + wp3 + ", " + wp4 + "\nFuel: " + fuel + "    Armour: " 
    + armour + "\nDescription: " + description 
    , gap_cr, gap_cr + y + (craft_length * 0.15), craft_width, craft_length);
    
    noFill();
    rect((gap_cr * 2) + craft_width, gap_cr + y, craft_width, craft_length);
    image(temp, (gap_cr * 2) + craft_width + 1, gap_cr + y + 1);
  }//end render
}//end Craft