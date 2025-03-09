import 'package:get/get.dart';

class Contorller extends GetxController{
  RxInt bottomIndex = 2.obs;
  RxBool isPlaying = false.obs;
  Map<dynamic, dynamic> song = <dynamic, dynamic>{}.obs;
  void changeBottomIndex(int index){
    bottomIndex.value = index;
  }

  void togglePlaying(bool isPlay){
    isPlaying.value = isPlay;
  }

  void setSong(Map<dynamic, dynamic> songData){
    song = songData;
  }
}