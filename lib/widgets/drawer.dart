// ignore_for_file: prefer_const_constructors

import 'package:bodae/Constants/colors.dart';
import 'package:bodae/widgets/lists.dart';
import 'package:bodae/widgets/lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({
    super.key,
    // required this.homeController,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  double? _devWidth, _devHeight;
  bool switchValue = true;
  void logout() async {
    try {
      // await firebaseAuth.signOut();
      // Get.offAllNamed("/verify");
    } catch (e) {
      const AlertDialog(
        title: Text(
          "Alert",
        ),
        content: Text(
          "Error logging out!",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _devHeight = MediaQuery.of(context).size.height;
    _devWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Drawer(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: AppColor.blue,
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 32,
                            child: const CircleAvatar(
                              radius: 30,
                              backgroundColor: AppColor.blue,
                              backgroundImage: AssetImage("images/profile.png"),
                            ),
                          ),
                          SizedBox(
                            width: _devWidth! * 0.04,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Miriam Wanjohi",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: Colors.grey.shade300,
                                        fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: _devHeight! * 0.01),
                              Text(
                                "+254758677690",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey.shade300,
                                        fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: _devHeight! * 0.01),
                              Text(
                                "wanjohimm@gmail.com",
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: Colors.grey.shade300,
                                        fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: _devHeight! * 0.04,
                    width: _devHeight! * 0.08,
                    child: FittedBox(
                      child: CupertinoSwitch(
                          value: switchValue,
                          activeColor: AppColor.blue,
                          onChanged: (bool? value) {
                            setState(() {
                              switchValue = value ?? false;
                            });
                          }),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, left: 5),
                        child: Text(
                          "looking_for_delivery",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 18, color: AppColor.blue),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, left: 10),
                        child: Text(
                          "offering_delivery",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 18, color: AppColor.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(
                    drawerItems.length - 1,
                    (index) => GestureDetector(
                      onTap: () {
                        (drawerItems[index]["navigate"]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              drawerItems[index]["icon"],
                              size: 22,
                              color: AppColor.blue,
                            ),
                            SizedBox(width: _devWidth! * 0.04),
                            Text(
                              drawerItems[index]["label"].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: _devHeight! * 0.01),
                  GestureDetector(
                    onTap: logout,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            drawerItems.last["icon"],
                            size: 22,
                            color: AppColor.blue,
                          ),
                          SizedBox(width: _devWidth! * 0.04),
                          Text(
                            drawerItems.last["label"].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
