import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramstory/main.dart';
import 'package:instagramstory/story.dart';
import 'package:video_player/video_player.dart';

class Story extends StatelessWidget {
  // You can ask Get to find a Controller that is being used by another page and redirect you to it.
  final Controller c = Get.find();

  @override
  Widget build(context){
    final VideoPlayerControllergetx controller = Get.put(VideoPlayerControllergetx("https://images.all-free-download.com/footage_preview/mp4/tiny_wild_bird_searching_for_food_in_nature_6892037.mp4"));
    // Access the updated count variable
    return Obx(() {
      return GestureDetector(
        child: Scaffold(
            body: Center(
                child: Column(children: [
                  Text("${c.count}"),
                  controller.controller == null ? Text('asd') : Text('duration ${controller.controller!.value.duration}'),
                  //Image.network("https://media4.giphy.com/media/hryis7A55UXZNCUTNA/giphy.gif?cid=6c09b9525iv3i8yb7jwv656f7tu7w5ji4y3z0s0l3bacq3er&rid=giphy.gif&ct=g"),
                  controller.controller == null ?
                  Text("controller.controller!") :
                      Column(children: [
                        AspectRatio(
                          aspectRatio: controller.controller!.value.aspectRatio,
                          child: VideoPlayer(controller.controller!),
                          ),
                        ],
                      ),
                  TextButton(
                      onPressed: () {
                        controller.initializeVideoPlayer();
                        },
                      child: Text("button")),
                ],)
            )
        ),
        onTapDown: (TapDownDetails details) {
          controller.controller!.pause();
          double width = MediaQuery.of(context).size.width ;
          double height = MediaQuery.of(context).size.height;
          double dx = details.globalPosition.dx;
          if(dx < width / 2) {
            for(int i = 0; i < 50; i++)
              print('left');
          }
          else {
            for(int i = 0; i < 50; i++)
              print('right');
          }
          print('x: ${details.globalPosition}');
        },
        onTapUp: (TapUpDetails details) {
          controller.controller!.play();
          for(int i = 0; i < 50; i++)
            print('play');
        },
      );
    });
  }
}


class VideoPlayerControllergetx extends GetxController {
  VideoPlayerController? _controller;

  VideoPlayerControllergetx(String url){
    _controller = VideoPlayerController.network(url);
  }

  void initializeVideoPlayer() {
    print(_controller == null);
    _controller!.addListener(() => update());
    _controller!.setLooping(true);
    _controller!.initialize().then((_) {
      _controller!.play();
      update();
    });
    print(_controller == null);
    update();
  }

  VideoPlayerController? get controller => _controller;

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }
}