import 'dart:convert';
import 'dart:io';

import 'package:aesos_app_frontend/utils/color.dart';
import 'package:aesos_app_frontend/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../model/user.dart';
import '../resources/post.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  File? _file;
  String? _base64Image;

  Future<void> uploadPost() async {
    print(_file);
    final picker = ImagePicker();
    final storage = FlutterSecureStorage();
    //after get data image
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    final bytes = await pickedFile!.readAsBytes();
    //get user in object
    User user = User.deserialize(await storage.read(key: 'user'));
    //base64 in _base64Image
    setState(() {
      _base64Image = base64.encode(bytes);
    });
    var res = await PostMethod().makePost(
        user_id: user.id,
        title: "testing",
        description: "masuk",
        picture: _base64Image.toString());

    if (res!.statusCode == 200) {
      print("got it");
    } else {
      print("eror ");
    }
  }

  Future _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a Post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  File file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();

                  uploadPost();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final base64Image = 'data:image/png;base64,$_base64Image';

    return _base64Image == null
        ? Center(
            child: IconButton(
              icon: const Icon(Icons.upload),
              onPressed: () => _selectImage(context),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {},
              ),
              title: const Text('Post to'),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
            body: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1679240017168-5d2adb0529a7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80'),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Write a caption..",
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: AspectRatio(
                      aspectRatio: 487 / 451,
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                        image: _base64Image == null
                            ? NetworkImage(
                                'https://images.unsplash.com/photo-1679240017168-5d2adb0529a7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80')
                            : NetworkImage(base64Image),
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter,
                      ))),
                    ),
                  ),
                  const Divider(),
                ],
              )
            ]),
          );
  }
}
