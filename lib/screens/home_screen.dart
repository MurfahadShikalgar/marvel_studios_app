import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/helper_functions.dart';
import 'package:marvel_app/providers/marvel_data_provider.dart';
import 'package:marvel_app/screens/details_screen.dart';
import 'package:marvel_app/screens/search_bar_screen.dart';
import 'package:marvel_app/screens/wish_list_screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HelperFunction helper = HelperFunction();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.clear_all),
          onPressed: (){},
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => WishListScreen()));
            }, 
            icon: const Icon(Icons.favorite, color: Colors.pink,)
          ),
          IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SearchBarScreen()));
            }, 
            icon: const Icon(Icons.search)
          ),
        ],
      ),
      body: Consumer<MarvelDataProvider>(
        builder: ((context, provider, child) {
          var data = provider.moviesData;
          return Column(
          children: [
            Expanded(
              child: GridView.count(
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              shrinkWrap: true,
              children: List.generate(data.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailScreen(details: provider.moviesData[index])));
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      child: Card(
                        color: Colors.black,
                        elevation: 4,
                        shadowColor: Colors.red,
                        child: Hero(
                          tag: data[index].id.toString(),
                          child: Image.network(
                            data[index].coverUrl.toString(), 
                            fit: BoxFit.fill, 
                            loadingBuilder: (context, child, loadingProgress) {
                              if(loadingProgress == null)return child;
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              );
                            } ,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },),
            ),
          ),
        ],
      );
    }))
    );
  }
}