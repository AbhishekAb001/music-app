import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxMap<dynamic, dynamic> profile = <dynamic, dynamic>{}.obs;

  void setProfile(Map<dynamic, dynamic> profileData) {
    profile.value = profileData;
  }
}
