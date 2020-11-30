import 'dart:collection';
import 'package:flutter/services.dart';

class LocationData {
  List<String> states = new List<String>();
  HashMap<String, List<String>> districtMap = new HashMap();

  Future<List<String>> getStateList() async{
    String data = await rootBundle.loadString("assets/states_and_district.csv");
    String stateName, distName;
    List<String> lines = data.split("\n");
    for(String line in lines){
      if(line.isNotEmpty){
        distName = line.split(",")[0].trim();
        stateName = line.split(",")[1].trim();
        if(!states.contains(stateName)){
          states.add(stateName);
        }

        if(!districtMap.containsKey(stateName)){
          districtMap[stateName] = new List<String>();
        }
        districtMap[stateName].add(distName);
      }
    }
    return states;
  }

  List<String> getDistrict(String state){
    if(state == null) return new List<String>();
    return districtMap[state];
  }
}
