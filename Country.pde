class Country
{
  String region;
  String continent;
  int supplies;
  String radio;
  String threat;
  
  Country(TableRow row)
  {
    region = row.getString(0);
    continent = row.getString(2);
    supplies = row.getInt(3);
    radio = row.getString(4);
    threat = row.getString(5);
  }//end constructor
}//end Country