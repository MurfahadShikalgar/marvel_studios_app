import 'package:flutter/material.dart';
import 'package:marvel_app/modals/marvel_data_model.dart';
import 'package:marvel_app/providers/marvel_data_provider.dart';
import 'package:marvel_app/screens/details_screen.dart';
import 'package:provider/provider.dart';

class SearchBarScreen extends StatefulWidget {
  const SearchBarScreen({super.key});

  @override
  State<SearchBarScreen> createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends State<SearchBarScreen> {
  TextEditingController controller = TextEditingController();
  List <MarvelModel> movies = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                final suggestions = Provider.of<MarvelDataProvider>(context, listen: false).moviesData.where((element){
                  final movieTitle = element.title.toString().toLowerCase();
                  final input = value.toLowerCase();
                  return movieTitle.contains(input);
                }).toList();
                setState(() {
                  movies = suggestions;
                });
              },
              decoration: const InputDecoration( 
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.white)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.blue)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.white)
                ),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.search, color: Colors.white,),
               )
              ),
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index){
                  return ListTile(
                    leading: Image.network(movies[index].coverUrl.toString(),
                      fit: BoxFit.fill,
                      width: 50,
                      height: 60,
                    ),
                    title: Text(movies[index].title.toString(), style: const TextStyle(color: Colors.white),),
                    onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (_)=> DetailScreen(details: movies[index]))),
                  );
                }
              )
            )
          ],
        ),
      ),
    );
  }
}