import 'package:flutter/material.dart';
import 'package:marvel_app/providers/marvel_data_provider.dart';
import 'package:marvel_app/screens/flash_screen.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(const MarvelApp());
}

class MarvelApp extends StatelessWidget {
  const MarvelApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MarvelDataProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FlashScreen(),
      ),
    ); 
  }
}