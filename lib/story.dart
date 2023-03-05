import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramstory/main.dart';
import 'package:instagramstory/story.dart';
import 'package:video_player/video_player.dart';

class Story extends StatelessWidget {

  final Controller c = Get.find();
  final VideoPlayerControllergetx controller = Get.put(VideoPlayerControllergetx("https://images.all-free-download.com/footage_preview/mp4/tiny_wild_bird_searching_for_food_in_nature_6892037.mp4"));
  @override
  Widget build(context){
    //https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4
    //https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_2mb.mp4
    //https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_5mb.mp4
    //https://images.all-free-download.com/footage_preview/mp4/tiny_wild_bird_searching_for_food_in_nature_6892037.mp4
    //http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4
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
                  LinearProgressIndicator(
                    backgroundColor: Colors.orangeAccent,
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    minHeight: 25,
                    value: controller.pos.value.inMilliseconds == 0 ? 0.0 : controller.pos.value.inMilliseconds / controller.controller!.value.duration.inMilliseconds,
                  ),
                  TextButton(
                      onPressed: () {
                        print(controller.pos.value.inMilliseconds);
                        print(controller.controller!.value.duration.inMilliseconds);
                        print(controller.pos.value.inMilliseconds / controller.controller!.value.duration.inMilliseconds);
                        },
                      child: Text("button")),
                ],)
            )
        ),
        onHorizontalDragStart: (DragStartDetails details) {
          controller.controller!.pause();
          double width = MediaQuery.of(context).size.width ;
          double height = MediaQuery.of(context).size.height;
          double dx = details.globalPosition.dx;
          print('x: ${details.globalPosition}');
        },
        onHorizontalDragEnd: (DragEndDetails details) {
        controller.controller!.play();
        double width = MediaQuery.of(context).size.width ;
        double height = MediaQuery.of(context).size.height;
        double dx = details.velocity.pixelsPerSecond.dx;
        if(dx < width / 2) {
          for(int i = 0; i < 50; i++)
            print(dx);
        }
        else {
          for(int i = 0; i < 50; i++)
            print(dx);
        }
        print('x: ${dx}');
      },
      );
    });
  }
}


class VideoPlayerControllergetx extends GetxController {
  VideoPlayerController? _controller;
  var dur = Duration().obs;
  var pos = Duration().obs;

  VideoPlayerControllergetx(String url){
    _controller = VideoPlayerController.network(url);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    initializeVideoPlayer();
    super.onInit();
  }

  void initializeVideoPlayer() {
    _controller!.addListener(() {
      //pos.value = Duration(milliseconds: _controller!.value.position.inMilliseconds.round());
      pos.value = _controller!.value.position;
      update();
    });
    _controller!.setLooping(true);
    _controller!.initialize().then((_) {
      _controller!.play();
      dur.value = _controller!.value.duration;
      update();
    });
  }

  VideoPlayerController? get controller => _controller;

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }
}