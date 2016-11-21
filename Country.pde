class Country
{
  String region;
  String continent;
  int supplies;
  String radio;
  String threat;
  String report;
  
  Country(TableRow row)
  {
    this.region = row.getString(0);
    this.continent = row.getString(1);
    this.supplies = row.getInt(2);
    this.radio = row.getString(3);
    this.threat = row.getString(4);
    this.report = row.getString(4);
  }//end constructor
  
}//end Country