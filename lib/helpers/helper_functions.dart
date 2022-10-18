import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/providers/marvel_data_provider.dart';
import 'package:provider/provider.dart';

class HelperFunction {

  double getHeight(BuildContext context ) {
    double height = MediaQuery.of(context).size.height;
    return height;
  }

  double getWidth(BuildContext context ) {
    double width = MediaQuery.of(context).size.width;
    return width;
  }

  void showDeleteDialog(BuildContext context, String title, String desc, var index)
 {
   showCupertinoDialog(
     context: context,
     builder: (context) {
       return CupertinoAlertDialog(
         title: Text(title),
         content: Text(desc),
         actions: [
           CupertinoDialogAction(
               onPressed: (){
                Provider.of<MarvelDataProvider>(context, listen: false).removeFromWishList(index);
                Navigator.of(context).pop();
               },
               child: const Text("Yes", style: TextStyle(color: Colors.red),)
           ),
           CupertinoDialogAction(
             child: const Text("No", style: TextStyle(color: Colors.red),),
             onPressed: (){
               Navigator.of(context).pop();
             }
             ,
           )
         ],
       );
     },
   );
 }

 void showStatusDialog(BuildContext context, String title, String desc){
  showCupertinoDialog(
     context: context,
     builder: (context) {
       return CupertinoAlertDialog(
         title: Text(title),
         content: Text(desc),
         actions: [
           CupertinoDialogAction(
             child: const Text("Ok", style: TextStyle(color: Colors.red),),
             onPressed: (){
               Navigator.of(context).pop();
             }
             ,
           )
         ],
       );
     },
   );
 }

}