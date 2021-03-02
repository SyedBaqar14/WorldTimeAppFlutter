import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for the UI
  String time; // the time in the location
  String flag; // url to an asset flag icon
  String url; // location url for the api endpoint
  bool isDayTime; // true or false if day time or not

  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async {

    try {
      // make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      // print(data);

      // get properties from data
      String datatime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      // print(datatime);
      // print(offset);

      DateTime now = DateTime.parse(datatime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDayTime = now.hour > 5 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch(e) {
      print('cought error: $e');
      time = 'could not get time data';
    }
  }

}