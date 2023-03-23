import 'package:flutter/material.dart';

import '../screens/add_post_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  HomeScreen(),
  Text('search'),
  AddPostScreen(),
  Text('notif'),
  ProfileScreen()
];
