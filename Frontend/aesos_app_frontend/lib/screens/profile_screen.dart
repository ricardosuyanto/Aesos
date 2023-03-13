import 'dart:convert';

import 'package:aesos_app_frontend/model/Post.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
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
        posts =
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(),
              ),
              SizedBox(height: 120), // spacing antar widget
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // bagian profile picture
                ),
              ),
              SizedBox(height: 80),
              TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: "Posts"),
                  Tab(text: "Saved"),
                ],
              ),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox(
                      height: 500,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: posts.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 3,
                              crossAxisCount:
                                  4, // untuk atur berapa jumlah post di satu row
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "data:image/png;base64,${posts[index].picture}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                          Container(
                            child: Center(
                              child: Text("Test"),
                            ),
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
