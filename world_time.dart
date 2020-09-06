import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location;// location name for the url
  String time; // the time in the location
  String flag; //the url to assest the flag icon
  String url; //location url for api endpoint
  bool isDaytime;//true or false if daytime or not

  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async{

    try {
      //make the request
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from date
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0,3);
      //String minset=data['utc_offset'].substring(),
     // print(datetime);
      print(data['utc_offset']);
      print(offset);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset),minutes:int.parse( data['utc_offset'].substring(4)) ));
      //print(now);

      //set time property
      isDaytime= now.hour > 6 && now.hour < 15 ? true : false;
      time = DateFormat.jm().format(now);
      //print(time);
    }
    catch(e){
      print(e);
      time='could not get time and date';
    }

  }

}
