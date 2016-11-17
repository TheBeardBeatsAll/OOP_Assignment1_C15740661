class Country
{
  String region;
  String continent;
  int supplies;
  boolean radio;
  int threat;
  
  Country(TableRow row)
  {
    this.region = row.getString(0);
    this.continent = row.getString(1);
    this.supplies = row.getInt(2);
    if(row.getInt(3)==1)
    {
      this.radio = true;
    }//end else
    else
    {
      this.radio = false;
    }//end else
    this.threat = row.getInt(4);
  }//end constructor
}//end Country