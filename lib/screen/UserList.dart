import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outshade/controller/user.controller.dart';
import 'package:outshade/data/sharedPreference.dart';
import 'package:outshade/screen/user.screen.dart';

import '../data/data.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  UserController userController = Get.put(UserController());
  TextEditingController age = TextEditingController();
  TextEditingController gender = TextEditingController();
  SharedPrefernceService sharedPrefernceService = SharedPrefernceService();

  // --------------USER CARD------------------------------//
  userCard(user) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: userController.userId.contains(user['id'])
                ? const Color.fromARGB(255, 223, 252, 224)
                : const Color.fromARGB(255, 241, 232, 234)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 247, 247, 247)),
                    child: const Icon(
                      Icons.person,
                      size: 20,
                    )),
                Text(
                  user['name'],
                  style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Obx(
              () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          userController.userId.contains(user['id'])
                              ? const Color.fromARGB(255, 30, 163, 35)
                              : Theme.of(context).primaryColor),
                  onPressed: () {
                    if (userController.userId.contains(user['id'])) {
                      sharedPrefernceService.removeElement(user['id']);
                      Get.showSnackbar(const GetSnackBar(
                        backgroundColor: Color.fromARGB(255, 32, 124, 73),
                        title: null,
                        message: "Log out Successful",
                      ));
                      Future.delayed(const Duration(seconds: 2), (() {
                        Get.closeCurrentSnackbar();
                      }));
                    } else {
                      dailogBox(gender, age, user);
                    }
                    print(userController.userList);
                    print(userController.userId);
                  },
                  child: userController.userId.contains(user['id'])
                      ? const Text(
                          "SING OUT",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      : const Text(
                          "SING IN",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
            )
          ],
        ),
      ),
    );
  }

//--------------------------GENDER AND NAME INPUT DAILOG-----------------------------//
  dailogBox(age, gender, user) {
    return Get.defaultDialog(
        title: "${user['name']} add your details ",
        titlePadding: const EdgeInsets.all(20),
        radius: 12,
        contentPadding: const EdgeInsets.all(20),
        content: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: gender,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    label: Text(
                      "Gender",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 20),
                    ),
                    hintText: "Enter your gender...",
                    suffix: Icon(
                      Icons.close,
                      color: Theme.of(context).primaryColor,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 253, 230, 235)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: age,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    label: Text(
                      "Age",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 20),
                    ),
                    hintText: "Enter your Age...",
                    suffix: Icon(
                      Icons.close,
                      color: Theme.of(context).primaryColor,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 253, 230, 235)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  onPressed: () {
                    setState(() {
                      if (age.text.trim() != null &&
                          age.text.trim() != "" &&
                          gender.text.trim() != null &&
                          gender.text.trim() != "") {
                        sharedPrefernceService.saveUser(
                            user['id'], user['name'], gender.text, age.text);
                        Get.back();
                        Get.showSnackbar(const GetSnackBar(
                          backgroundColor: Color.fromARGB(255, 62, 107, 75),
                          title: null,
                          message: "Sign in successfyl",
                        ));
                        Future.delayed(const Duration(seconds: 3), (() {
                          Get.closeCurrentSnackbar();
                        }));
                      } else {
                        Get.showSnackbar(const GetSnackBar(
                          backgroundColor: Colors.red,
                          title: null,
                          message: "Gender and Age should not be empty",
                        ));
                        Future.delayed(const Duration(seconds: 3), (() {
                          Get.closeCurrentSnackbar();
                        }));
                      }

                      age.text = "";
                      gender.text = "";

                      // Get.to(()=>UserDetails(user: user));
                    });
                  },
                  child: const Text(
                    "SING IN",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(100, 100),
          child: AppBar(
              elevation: 0,
              title: const Text("OUTSHADES",
                  style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold)))),
      body: ListView.builder(
          itemCount: user[0]['users']!.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                sharedPrefernceService.setData(user[0]['users']![index]);
                if (userController.userId
                    .contains(user[0]['users']![index]['id'])) {
                  Get.to(() => UserDetails(user: userController.user));
                } else {
                  dailogBox(gender, age, user[0]['users']![index]);
                }
              },
              child: userCard(user[0]['users']![index]),
            );
          }),
    );
  }
}
