import 'dart:convert';

import 'package:http/http.dart';
import 'package:marvel_app/modals/marvel_data_model.dart';

class ApiService {

  static Future<List<MarvelModel>> getMarvelData() async {
    String link = "https://mcuapi.herokuapp.com/api/v1/movies";
    Uri url = Uri.parse(link);
    var response = await get(url);
    var decodedData = jsonDecode(response.body);
    return MarvelDataModel.fromJson(decodedData).data!;
  }

  

}