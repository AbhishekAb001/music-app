import 'package:get/get.dart';

class ProfileController extends GetxController{
  RxMap<String, dynamic> profile = <String, dynamic>{}.obs;

  void setProfile(Map<String, dynamic> profileData){
    profile.value = profileData;
  }

}