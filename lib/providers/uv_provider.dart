import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UVProvider with ChangeNotifier {
  Map<String, dynamic> response_content = {};
  bool error = false;

  String stDuration(String s) {
    if (response_content.isEmpty) {
      return "Not Found";
    } else if (response_content["result"]["safe_exposure_time"][s].toString() ==
        "null") {
      return "∞";
    } else {
      return response_content["result"]["safe_exposure_time"][s].toString();
    }
  }

  List<String> get skintype {
    return ["st1", "st2", "st3", "st4", "st5", "st6"];
  }

  String get maxUVLevel {
    if (response_content.isEmpty) {
      return "Not Found";
    } else {
      return response_content["result"]["uv_max"].toString();
    }
  }

  String stFullForm(String s) {
    switch (s) {
      case "st1":
        return "Skin Type 1";
      case "st2":
        return "Skin Type 2";
      case "st3":
        return "Skin Type 3";
      case "st4":
        return "Skin Type 4";
      case "st5":
        return "Skin Type 5";
      case "st6":
        return "Skin Type 6";
      default:
        return "Not Required";
    }
  }

  String skinTypeDescription(String s) {
    switch (s) {
      case "st1":
        return "Very fair skin, white; red or blond hair; light-colored eyes; freckles likely";
      case "st2":
        return "Fair skin, white; light eyes; light hair";
      case "st3":
        return "Fair skin, cream white; any eye or hair color (very common skin type)";
      case "st4":
        return "Olive skin, typical Mediterranean Caucasian skin; dark brown hair; medium to heavy pigmentation";
      case "st5":
        return "Brown skin, typical Middle Eastern skin; dark hair; rarely sun sensitive";
      case "st6":
        return "Black skin; rarely sun sensitive";
      default:
        return "Not Required";
    }
  }

  Color skintTypeColor(String s) {
    switch (s) {
      case "st1":
        return Color.fromRGBO(241, 209, 177, 1); //rgba(241,209,177,255)
      case "st2":
        return Color.fromRGBO(228, 181, 144, 1); //rgba(228,181,144,255)
      case "st3":
        return Color.fromRGBO(207, 159, 125, 1); //rgba(207,159,125,255)

      case "st4":
        return Color.fromRGBO(182, 120, 81, 1); //rgba(182,120,81,255)

      case "st5":
        return Color.fromRGBO(161, 94, 45, 1); //rgba(161,94,45,255)

      case "st6":
        return Color.fromRGBO(81, 57, 56, 1); //rgba(81,57,56,255)

      default:
        return Color.fromRGBO(241, 209, 177, 1);
    }
  }

  Map<String, dynamic> uvLevel(String uv) {
    String uvLevel;
    Color uvColor;
    double uvNumber = double.parse(uv);
    if (uvNumber >= 0 && uvNumber <= 3) {
      uvLevel = "Low";
      uvColor = Color.fromRGBO(85, 139, 47, 1);
      return {"UV Level": uvLevel, "UV Color": uvColor};
    } else if (uvNumber > 3 && uvNumber <= 6) {
      uvLevel = "Moderate";
      uvColor = Color.fromRGBO(249, 168, 37, 1); //249, 168, 37, 1

      return {"UV Level": uvLevel, "UV Color": uvColor};
    } else if (uvNumber > 6 && uvNumber <= 8) {
      uvLevel = "High";
      uvColor = Color.fromRGBO(239, 108, 0, 1); //239, 108, 0, 1

      return {"UV Level": uvLevel, "UV Color": uvColor};
    } else if (uvNumber > 8 && uvNumber <= 11) {
      uvLevel = "Very High";
      uvColor = Color.fromRGBO(183, 28, 28, 1); //183, 28, 28, 1

      return {"UV Level": uvLevel, "UV Color": uvColor};
    } else {
      uvLevel = "Extreme";
      uvColor = Color.fromRGBO(106, 27, 154, 1); //106, 27, 154, 1

      return {"UV Level": uvLevel, "UV Color": uvColor};
    }
  }

  String get uvindex {
    if (response_content.isEmpty) {
      return "Not Found";
    } else {
      return response_content["result"]["uv"].toString();
    }
  }

  String get UVtime {
    return response_content["result"]["uv_time"].toString();
  }

  String get ozonelevel {
    if (response_content.isEmpty) {
      return "Not Found";
    } else {
      return response_content["result"]["ozone"].toString();
    }
  }

  String get maxUVindexOfDay {
    if (response_content.isEmpty) {
      return "Not found";
    } else {
      return response_content["result"]["uv_max"].toString();
    }
  }

  String sunImage(String s) {
    if (s == 'Low')
      return "assets/images/sleeping.png";
    else if (s == "Moderate")
      return "assets/images/waxing-moon.png";
    else if (s == "High")
      return "assets/images/day.png";
    else if (s == "Extreme")
      return "assets/images/sun.png";
    else
      return "assets/images/hot-temperature.png";
  }

  Future<void> get_uv_index(int lat, int lng) async {
    Map<String, String> querryParams = {
      'lat': lat.toString(),
      'lng': lng.toString()
    };
    final url = Uri.https('api.openuv.io', '/api/v1/uv', querryParams);
    final response = await http.get(url,
        headers: {'x-access-token': '5b11af5b6b8b2880de6c051893aebb3a'});
    response_content = json.decode(response.body) as Map<String, dynamic>;
    if (response_content.containsKey("error")) {
      print(response.body);
      error = true;
      notifyListeners();
    }
    print(response.body);
    notifyListeners();
  }
}
