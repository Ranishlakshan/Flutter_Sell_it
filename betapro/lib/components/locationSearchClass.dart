class LocationSearchclass{

  String searchdistrict;
  String searchTown;
  String searchtype;

  LocationSearchclass(String dis,String tow,String typ){
    searchdistrict=dis;
    searchTown=tow;
    searchtype=typ;
  }

  void setSearchdistrict(val){
    this.searchdistrict=val;
  }

  void setSearchtown(val){
    this.searchTown=val;
  }

  void setSearchType(val){
    this.searchtype=val;
  }

  String getSearchdistrictName(){
    return searchdistrict;
  }
  String getSearchTownname(){
    return searchTown;
  }

  String getSearchType(){
    return searchtype;
  }

}