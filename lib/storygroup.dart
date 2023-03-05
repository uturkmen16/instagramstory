import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramstory/main.dart';
import 'package:instagramstory/story.dart';
import 'package:video_player/video_player.dart';

class StoryGroup extends StatelessWidget {

  final StoryGroupController storyGroupController = Get.put(StoryGroupController());

  void addStory(String url) {
    //stories.add(Story(url));
  }
  @override
  Widget build(BuildContext context) {
    print('BuildBAS');
    /*
    print(storyGroupController.activeStoryIndex.value);
    var controller = stories[storyGroupController.activeStoryIndex.value];
    controller.controller!.play();
    for(int i = 0; i < 50; i++){
      print('Build');
      print(storyGroupController.activeStoryIndex.value);
    }
     */return Obx(() {
      return GestureDetector(
        child: Scaffold(
            body:Column(
              children: [
                storyGroupController.currentStory.value,
                TextButton(onPressed: () {
                  storyGroupController.nextStory();
                }, child: Text("asd"))
              ],
            ),
        ),
        onHorizontalDragStart: (DragStartDetails details) {
          storyGroupController.controller.controller!.pause();
          double width = MediaQuery.of(context).size.width ;
          double height = MediaQuery.of(context).size.height;
          double dx = details.globalPosition.dx;
          print('x: ${details.globalPosition}');
        },
        onHorizontalDragEnd: (DragEndDetails details) {
          storyGroupController.controller.controller!.play();
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
        },
      );
    });
    return Obx(() => storyGroupController.currentStory.value);
  }
}

class StoryGroupController extends GetxController{
  RxInt activeStoryIndex = 0.obs;
  late VideoPlayerControllergetx controller;
  late List<String> stories;
  late Rx<Story> currentStory;
  StoryGroupController() {
    stories = [
      //Story("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"),
      "https://images.all-free-download.com/footage_preview/mp4/wild_butterfly_in_nature_6891914.mp4",
      "https://images.all-free-download.com/footage_preview/mp4/tiny_wild_bird_searching_for_food_in_nature_6892037.mp4",
      "https://images.all-free-download.com/footage_preview/mp4/bright_full_moon_on_cloudy_dark_sky_6892040.mp4",
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"
      "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_5mb.mp4",

    ];
    currentStory = Rx<Story>(Story(stories[activeStoryIndex.value]));
    controller = currentStory.value.controller;
  }
  @override
  void onInit() {
    currentStory.value.controller.hasFinished.listen((hasFinished) {
      print("listened");
      if(hasFinished) {
        //video finished
        nextStory();
      }
    });
    super.onInit();
  }

  void nextStory() {
    activeStoryIndex.value += 1;
    currentStory.value.controller.onClose();
    currentStory.value.controller = VideoPlayerControllergetx(stories[activeStoryIndex.value]);
    controller = currentStory.value.controller;
    currentStory.value.controller.hasFinished.listen((hasFinished) {
      print("listened");
      if(hasFinished) {
        //video finished
        nextStory();
      }
    });
    update();
  }
  void setActiveStoryIndex(int index) {
    activeStoryIndex.value = index;
    update(); // trigger a rebuild of the widget tree
  }
}
