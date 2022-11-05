import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data.dart';

class UserController extends GetxController{
  var userList =<String>[].obs;
  var userId =<String>[].obs;
  var user = <String,dynamic>{}.obs;


  @override
  void onInit() {
 getUser();
    super.onInit();
  }


  getUser() async {
    final preference = await SharedPreferences.getInstance();
    List<String>? encodedUser = preference.getStringList('users');
    List<String>? idList = preference.getStringList('id');
    // var decodeUser = json.decode(encodedUser);
    if(encodedUser!=null&&idList!=null){
 userList.value = encodedUser;
  userId.value = idList;
    }
  
  
    // ignore: avoid_print
    print("Share -----------------------preference ");
    // ignore: avoid_print
    print(encodedUser.toString());
  }



}