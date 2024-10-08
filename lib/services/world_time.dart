import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;
  WorldTime({this.location, this.flag, this.url});

  //   // //simulate network reequest for a username to get bio
  //   // String bio = await Future.delayed(Duration(seconds: 3), () {
  //   //   return 'igzooo';
  //   // });
  //   // print('$username - $bio');

  //   Response response =
  //       await get('https://jsonplaceholder.typicode.com/todos/1');
  //   Map data = jsonDecode(response.body);
  //   print(data);
  //   print(data['title']);
  // }

  Future<void> getTime() async {
    try {
      //make the request
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body.toString());

      //get properties of data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // print(datetime);
      // print(offset);

      //create date time object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = (now.hour > 6 && now.hour < 18) ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print(e);
      time = 'Error getting time';
      isDayTime = false;
    }
  }
}
