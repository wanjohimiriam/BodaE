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
      "navigate": "/change_password",
    },
    {
      "label": "change_payment",
      "icon": CupertinoIcons.creditcard,
      "navigate": "/changepayment",
    },
    {
      "label": "my_post",
      "icon": CupertinoIcons.bookmark,
      "navigate": "/mypost",
    },
    {
      "label": "language",
      "icon": CupertinoIcons.globe,
      "navigate": "/change_language",
    },
    {
      "label": "contact_us",
      "icon": CupertinoIcons.phone,
      "navigate": "/frontContact",
    },
    {
      "label": "privacy",
      "icon": CupertinoIcons.lock,
      "navigate": "/privacy_and_policy",
    },
    {
      "label": "log_out",
      "icon": Icons.logout,
      "navigate": "",
    },
  ];
