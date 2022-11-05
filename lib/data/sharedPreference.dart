import 'dart:convert';

import 'package:get/get.dart';
import 'package:outshade/controller/user.controller.dart';
import 'package:outshade/screen/user.screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefernceService {

  static bool isUserPresent = false;
  UserController userController = Get.put(UserController());


//------------------------Check User---------------------------//
  setData(user) async {
  
    if (userController.userList.isNotEmpty &&
        userController.userId.isNotEmpty) {
      for (var i = 0; i < userController.userList.length; i++) {
        var userMap = json.decode(userController.userList[i]);
        if (userMap['id'] == user['id'] && userController.userId.contains(user['id'])) {
          isUserPresent = true;
          Get.to(()=>UserDetails(user: userMap));
          break;
        } else {
          isUserPresent = false;
        }
      }
    } else {
    isUserPresent = false;
    }
  }

//----------------Save User--------------------------------------//
  saveUser(id,name,gender,age) async {
    final preferences = await SharedPreferences.getInstance();
    var user = {"id": id, "name": name, "gender": gender, "age": age};
    String encodeUser = json.encode(user);
    userController.userList.add(encodeUser);
    userController.userId.add(user['id']);
    preferences.setStringList('id', userController.userId);
    preferences.setStringList("users", userController.userList);
    
  }


//-------------------Remove User-----------------------------//
  removeElement(id) async {
    final preference = await SharedPreferences.getInstance();
    for (var i = 0; i < userController.userList.length; i++) {
      var userMap = json.decode(userController.userList[i]);
      if (userController.userId.contains(id) && userMap['id'] == id) {
        userController.userId.remove(id);
        userController.userList.removeAt(i);
        preference.setStringList("id", userController.userId);
        preference.setStringList("users", userController.userList);
      }
    }
  }
}
