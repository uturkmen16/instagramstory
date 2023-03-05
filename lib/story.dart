import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramstory/main.dart';
import 'package:video_player/video_player.dart';

class Story extends StatelessWidget {

  final Controller c = Get.find();
  late VideoPlayerControllergetx controller;

  Story(String url) {
    controller = Get.put(VideoPlayerControllergetx(url));
  }
  @override
  Widget build(context){
    //https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4
    //https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_2mb.mp4
    //https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_5mb.mp4
    //https://images.all-free-download.com/footage_preview/mp4/tiny_wild_bird_searching_for_food_in_nature_6892037.mp4
    //http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4
    // Access the updated count variable
    //throw UnimplementedError();
    return Obx(() => Center(
          child: Column(children: [
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
              value: controller.pos.value.inMilliseconds == 0 ? 0.0 : controller.pos.value.inMilliseconds / controller.dur.value.inMilliseconds,
            ),
          ],)
      ));
  }
}


class VideoPlayerControllergetx extends GetxController {
  VideoPlayerController? _controller;
  var dur = Duration().obs;
  var pos = Duration().obs;
  RxBool hasFinished = false.obs;

  VideoPlayerControllergetx(String url){
    _controller = VideoPlayerController.network(url, videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
    initializeVideoPlayer();
  }

  void initializeVideoPlayer() {
    _controller!.addListener(() {
      //pos.value = Duration(milliseconds: _controller!.value.position.inMilliseconds.round());
      pos.value = _controller!.value.position;
      if(pos.value >= dur.value && pos.value.inMilliseconds != 0) {
        hasFinished.value = true;
      }
      update();
    });
    //_controller!.setLooping(true);
    _controller!.initialize().then((_) {
      _controller!.play();
      dur.value = _controller!.value.duration;
      update();
    });
  }

  VideoPlayerController? get controller => _controller;

  @override
  void onClose() {
    _controller!.pause();
    _controller!.dispose();
    dur.close();
    pos.close();
    hasFinished.close();
    super.onClose();
  }
}