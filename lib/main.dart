import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramstory/main.dart';
import 'package:instagramstory/story.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(GetMaterialApp(home: Home()));

class Controller extends GetxController{
  var count = 0.obs;
  increment() => count++;
}

class Home extends StatelessWidget {

  @override
  Widget build(context) {

    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    final Controller c = Get.put(Controller());

    return Scaffold(
      // Use Obx(()=> to update Text() whenever count is changed.
        appBar: AppBar(title: Obx(() => Text("Clicks: ${c.count}"))),

        // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
        body: Center(child: ElevatedButton(
            child: Text("Go to Other"), onPressed: () => Get.to(Story()))),
        floatingActionButton:
        FloatingActionButton(child: Icon(Icons.add), onPressed: c.increment));
  }
}
