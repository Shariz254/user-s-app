import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestAssistant
{
  static Future<dynamic> getRequest(String url) async
  {
    http.Response response = await http.get(Uri.parse(url));

    try
      {
        //confirm if request is successful
        if(response.statusCode == 200)
        {
          String JSONdata = response.body;
          var decodeData = jsonDecode(JSONdata);
          return decodeData;
        } else {
          return "Failed";
        }
      } catch(exp)
      {
        return "Failed";
      }
  }
}