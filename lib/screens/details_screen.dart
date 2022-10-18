// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/helper_functions.dart';
import 'package:marvel_app/modals/marvel_data_model.dart';
import 'package:marvel_app/providers/marvel_data_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  DetailScreen({super.key, required this.details});
  final MarvelModel details;

  HelperFunction helper = HelperFunction();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        //title: Text(details.title.toString()),
        centerTitle: true,
      ),
       body: SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.only(left: 8, right: 8, bottom: 6),
           child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: helper.getHeight(context) * 0.8,
                width: helper.getWidth(context),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Color.fromARGB(192, 43, 36, 36),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            SizedBox(
                              height: helper.getHeight(context) * 0.35,
                              width: helper.getWidth(context) * 0.6,
                              child: Image.network(details.coverUrl.toString(), fit: BoxFit.fill,),
                            ),
                            Positioned(
                              top: 110,
                              left: 80,
                              child: IconButton(
                                onPressed: () {
                                  //Navigator.of(context).push(MaterialPageRoute(builder: (_) => VideoScreen(videoUrl: details.trailerUrl.toString())));
                                }, 
                                icon: const Icon(Icons.play_circle, color: Colors.white60, size: 65,)
                              )
                            )
                          ]
                        ),
                      ),
                      Text(details.title.toString(), style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white70),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Duration :  ${details.duration.toString()} mins", style: const TextStyle(color: Color.fromARGB(255, 187, 181, 181)),),
                          const SizedBox(width: 10,),
                          Container(color: const Color.fromARGB(255, 151, 149, 149), width: 1,height: 15,),
                          const SizedBox(width: 10,),
                          Flexible(child: Text("Director :  ${details.directedBy.toString()}", style: const TextStyle(color: Color.fromARGB(255, 187, 181, 181)),)),
                        ],
                      ),
                      Text("Release Date :  ${details.releaseDate.toString()}", style: const TextStyle(color: Color.fromARGB(255, 187, 181, 181)),),
                      Text("Box Office :  ${details.boxOffice.toString()}", style: const TextStyle(color: Color.fromARGB(255, 187, 181, 181)),),
                      Text("Saga :  ${details.saga.toString()}", style: const TextStyle(color: Color.fromARGB(255, 187, 181, 181)),),                        
                      Flexible(child: Text(details.overview == null ? "" : details.overview.toString() , style: const TextStyle(color: Color.fromARGB(255, 187, 181, 181)),)),                  
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Container(
                      height: helper.getHeight(context) * 0.08,
                      width: helper.getWidth(context) * 0.8,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        gradient: LinearGradient(
                          colors: [ Color.fromARGB(255, 250, 18, 2), Color.fromARGB(255, 190, 19, 19) ],
                          begin: Alignment.topRight,
                          end: Alignment.centerLeft,
                          )
                      ),
                      child: const Center(child: Text("Add to LikedList", style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),)),
                    ),
                    onTap: (){
                      if(Provider.of<MarvelDataProvider>(context, listen: false).wishList.isEmpty){
                        Provider.of<MarvelDataProvider>(context, listen: false).addToWishList(details);
                        helper.showStatusDialog(context, "Liked?", "Movie added to LikedList.");
                      } else {
                      for(int i=0; i<Provider.of<MarvelDataProvider>(context,listen: false).wishList.length; i++){
                        if(Provider.of<MarvelDataProvider>(context, listen: false).wishList[i].title == details.title){
                          helper.showStatusDialog(context, "Liked?", "These movie is already added to liked list.");
                          break;
                        } else {
                          Provider.of<MarvelDataProvider>(context, listen: false).addToWishList(details);
                          helper.showStatusDialog(context, "Liked?", "Movie added to LikedList.");
                          break;
                        }
                      }
                    }
                  }
                ),
                const Icon(Icons.favorite_border_outlined, color: Colors.pink, size: 30),
              ],
            )
            ],
           ),
         ),
       ),  
    );
  }
}