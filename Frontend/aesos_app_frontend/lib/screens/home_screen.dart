import 'dart:async';
import 'dart:convert';

import 'package:aesos_app_frontend/model/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/color.dart';
import '../utils/global_variable.dart';
import 'package:http/http.dart' as http;

import '../widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  List<Post> myDataList = [];

  @override
  void initState() {
    super.initState();

    feed();
  }

  Future<void> feed() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final url = Uri.parse('http://localhost:8081/getPostList?user_id=1');
      final headers = {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept": "application/json"
      };
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        myDataList =
            List<Post>.from(data['post'].map((post) => Post.fromJson(post)));
      }
    } catch (e) {
      throw Exception('Failed to load posts');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print(myDataList);

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 32,
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.messenger_outline,
                    color: primaryColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: myDataList.length,
              itemBuilder: (context, index) {
                final myData = myDataList[index];
                return PostCard(
                  title: myData.title,
                  description: myData.description,
                  picture: myData.picture,
                );
              },
            ),
    );
  }
}
