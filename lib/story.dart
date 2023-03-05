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
            //I Don't know how this works, it needs to change. Whenever i delete this, other videos than the first video do not play.
            controller.controller == null ? Text('asd') : Visibility(child: Text('duration ${controller.pos.value}'), visible: false,),
            //Image.network("https://media4.giphy.com/media/hryis7A55UXZNCUTNA/giphy.gif?cid=6c09b9525iv3i8yb7jwv656f7tu7w5ji4y3z0s0l3bacq3er&rid=giphy.gif&ct=g"),
            controller.controller == null ?
            Text("controller.controller!") :
            AspectRatio(
              aspectRatio: controller.controller.value.value.aspectRatio,
              child: VideoPlayer(controller.controller.value),
            ),
          ],)
      ));
  }
}


class VideoPlayerControllergetx extends GetxController {
  late Rx<VideoPlayerController> controller;
  var dur = Duration().obs;
  var pos = Duration().obs;
  RxBool hasFinished = false.obs;

  VideoPlayerControllergetx(String url){
    controller = Rx<VideoPlayerController>(VideoPlayerController.network(url, videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true)));
    initializeVideoPlayer();
  }

  void initializeVideoPlayer() {
    controller.value.addListener(() {
      //pos.value = Duration(milliseconds: _controller!.value.position.inMilliseconds.round());
      pos.value = controller.value.value.position;
      if(pos.value >= dur.value && pos.value.inMilliseconds != 0) {
        hasFinished.value = true;
      }
      update();
    });
    //_controller!.setLooping(true);
    controller.value.initialize().then((_) {
      controller.value.play();
      dur.value = controller.value.value.duration;
      update();
    });
  }


  @override
  void onClose() {
    controller.value.pause();
    controller.value.dispose();
    controller.close();
    dur.close();
    pos.close();
    hasFinished.close();
    super.onClose();
  }
}