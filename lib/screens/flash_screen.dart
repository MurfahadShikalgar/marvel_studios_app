import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/helper_functions.dart';
import 'package:marvel_app/widgets/custom_button.dart';
import 'package:video_player/video_player.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  late VideoPlayerController controller;

  @override
  void initState() {
    if(mounted){
      loadVideoPlayer();
    }
    super.initState();
    controller.play().whenComplete(() {
      controller.play();
    });
  }

  loadVideoPlayer(){
     controller = VideoPlayerController.asset('videos/logo1.mp4');
     controller.setLooping(true);
     controller.addListener(() {
        setState(() {});
     });
    controller.initialize().then((value){
        setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    double height = HelperFunction().getHeight(context);
    double width = HelperFunction().getWidth(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
             AspectRatio( 
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
            SizedBox(
              height: height*0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Heroes aren't Born.", style: TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.w400),),
                  const Text("They're Built", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),),
                  const Text("Watch marvels movies, trailer, cast and ratings", style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),),
                  const SizedBox(height: 20,),
                  CustomButton(height: height * 0.09, width: width * 0.9, text: "Let's Go", color: const Color.fromARGB(255, 253, 35, 20)),               
                  const SizedBox(height: 20,),                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
}