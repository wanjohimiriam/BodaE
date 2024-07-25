import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> drawerItems = [
    {
      "label": "edit_profile",
      "icon": CupertinoIcons.person,
      "navigate": "/profile",
    },
    {
      "label": "change_password",
      "icon": CupertinoIcons.eye,
      "navigate": "/changePassword",
    },
    {
      "label": "change_payment",
      "icon": CupertinoIcons.creditcard,
      "navigate": "/payment",
    },
    {
      "label": "my_post",
      "icon": CupertinoIcons.bookmark,
      "navigate": "/mypost",
    },
    {
      "label": "language",
      "icon": CupertinoIcons.globe,
      "navigate": "/langpop",
    },
    {
      "label": "contact_us",
      "icon": CupertinoIcons.phone,
      "navigate": "/frontContact",
    },
  
    {
      "label": "log_out",
      "icon": Icons.logout,
      "navigate": "/homelogin",
    },
  ];

  List<Map<String, dynamic>> bottomNavItems = [
    {
      "icon": CupertinoIcons.home,
      "label": "home",
    },
    {
      "icon": CupertinoIcons.mail,
      "label": "messages",
    },
    {
      "icon": CupertinoIcons.shopping_cart,
      "label": "orders",
    },
    {
      "icon": CupertinoIcons.bookmark,
      "label": "saved",
    },
    {
      "icon": Icons.verified_outlined,
      "label": "my_plans",
    },
  ];
