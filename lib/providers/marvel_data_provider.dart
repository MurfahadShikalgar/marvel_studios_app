// ignore_for_file: non_constant_identifier_names, prefer_final_fields, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:marvel_app/modals/marvel_data_model.dart';
import 'package:marvel_app/services/api_services.dart';

class MarvelDataProvider with ChangeNotifier{

   List <MarvelModel>_moviesList = [];
   List <MarvelModel> get moviesData => _moviesList;

   List <MarvelModel> wishList = [];

  void getMoviesData() async {
    _moviesList = await ApiService.getMarvelData();
    notifyListeners();
  }
  
  void addToWishList(var details){
    wishList.add(details);
    notifyListeners();
  }

  void removeFromWishList(var index){
    wishList.removeAt(index);
    notifyListeners();
  }

}