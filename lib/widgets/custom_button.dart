import 'package:flutter/material.dart';
import 'package:marvel_app/providers/marvel_data_provider.dart';
import 'package:marvel_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  
  const CustomButton({super.key, required this.height, required this.width, required this.text, required this.color});
  final double height;
  final double width;
  final String text;
  final Color color;
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: height,
        width: width,
        // ignore: sort_child_properties_last
        child: Center(child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),)),
        decoration:  BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: color,
        ),
      ),
      onTap: () async {
        Provider.of<MarvelDataProvider>(context, listen: false).getMoviesData();
        Navigator.of(context).pushReplacement(MaterialPageRoute( builder: (_) => HomeScreen()));
      },
    );
  }
}