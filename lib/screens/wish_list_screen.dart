// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/helper_functions.dart';
import 'package:marvel_app/modals/marvel_data_model.dart';
import 'package:marvel_app/providers/marvel_data_provider.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatelessWidget {
  WishListScreen({super.key});
  HelperFunction helper = HelperFunction();
  @override
  Widget build(BuildContext context) {
    List <MarvelModel> wishList = Provider.of<MarvelDataProvider>(context, listen: false).wishList;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Wishlist"),
        backgroundColor: Colors.black,
      ),
      body: Provider.of<MarvelDataProvider>(context).wishList.isNotEmpty ? ListView.builder(
        itemCount: Provider.of<MarvelDataProvider>(context).wishList.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Container(
              height: helper.getHeight(context) * 0.155,
              width: helper.getWidth(context),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Color.fromARGB(192, 43, 36, 36),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10,),
                  Container(
                    height: helper.getHeight(context)*0.14,
                    width: helper.getWidth(context)*0.3,
                    color: Color.fromARGB(192, 43, 36, 36),
                    child: Image.network(wishList[index].coverUrl.toString(), fit: BoxFit.fill,),
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: helper.getHeight(context)*0.14,
                        width: helper.getWidth(context)*0.45,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Director :  ${wishList[index].directedBy.toString()}", style: const TextStyle(color:  Color.fromARGB(255, 151, 149, 149), fontSize: 12, fontWeight: FontWeight.w300),),
                            Text("Saga :  ${wishList[index].saga.toString()}", style: const TextStyle(color:  Color.fromARGB(255, 151, 149, 149), fontSize: 12, fontWeight: FontWeight.w300),),
                            Text("IMDB :  ${wishList[index].imdbId.toString()}", style: const TextStyle(color:  Color.fromARGB(255, 151, 149, 149), fontSize: 12, fontWeight: FontWeight.w300),),
                          ],
                        ),
                      ),
                      ],
                  ),
                  
                  IconButton(
                    onPressed: (){
                      helper.showDeleteDialog(context, "Delete?", "Do you want to delete item from cart?", index);
                    }, 
                    icon: const Icon(Icons.delete_forever, size: 45, color: Colors.pink,)
                  )
                ],
              ),
            ),
          );
        })
        ) : const Center(child: Text(""),),
    );
  }
}