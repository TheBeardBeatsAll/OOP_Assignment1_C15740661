class Country
{
  String region;
  int supplies;
  String threat;
  String report;
  
  Country(TableRow row)
  {
    this.region = row.getString(0);
    this.supplies = row.getInt(1);
    this.threat = row.getString(2);
    this.report = row.getString(3);
  }//end constructor
  
  void render(float x, float y, int i)
  {
    fill(#B4F7FF);
    rect((gap_cl * 0.6) + x, (space_cl + (gap_cl * 2.25)) + ((i - y) * (space_cl * 6)), (screen_width * 0.4) - (gap_cl * 1.2),(space_cl * 5.0), space_cl);
    
    textAlign(CENTER);
    fill(0);
    textSize(14);
    text(region, (gap_cl * 0.6) + x, (space_cl + (gap_cl * 2.25)) + ((i - y) * (space_cl * 6)), (screen_width * 0.4) - (gap_cl * 1.2),(space_cl * 5.0));
    textSize(11);
    text("Supplies per Month: " + supplies + "    Threat Level: " + threat + "\n  Report: " + report, (gap_cl * 0.6) + x, (space_cl + (gap_cl * 2.7)) + ((i - y) * (space_cl * 6)), (screen_width * 0.4) - (gap_cl * 1.2),(space_cl * 5.0));
  }//end render
}//end Country