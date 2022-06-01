import 'dart:io';

import 'package:flutter/material.dart';
import 'package:final_project/responsive.dart';
import 'package:final_project/searching/webview.dart';
import 'package:image_picker/image_picker.dart';

class myHomePage extends StatefulWidget {
  const myHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<myHomePage> createState() => _myHomePageState();
}

class _myHomePageState extends State<myHomePage> {
  late Responsive _size;

  late File pickedImage;

  var tempStor;

  bool loading = true;

  /*  fetchimagecamera() async {
    var image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    if (result != null) {
      print('result Is : $result');
    }
    pickedImage = File(image.path);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const ProductPage(),
    //     ));
  } */

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _size = Responsive(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: _size.height(),
        padding: EdgeInsets.only(
          top: _size.height() * 0.06,
          left: _size.width() * 0.038,
          right: _size.width() * 0.038,
        ),
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  'Hello Dear',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            SizedBox(
              height: _size.height() * 0.02,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: _size.height() * 0.35,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.blueAccent,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(80),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(5, 10),
                      blurRadius: 20,
                      color: Colors.blue,
                    ),
                  ]),
              child: Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: _size.width() * 0.06,
                    top: _size.height() * 0.03,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Take a Picture and \nTranslate it or Information\nAbout it and price',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              width: _size.width() * 0.6,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.blueAccent,
                                      blurRadius: 10,
                                      offset: Offset(4, 8),
                                    )
                                  ]),
                              child: Icon(
                                Icons.play_circle_fill,
                                size: _size.height() * 0.10,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: _size.height() * 0.15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: _size.height() * 0.004,
                        vertical: _size.height() * 0.008),
                    child: ElevatedButton(
                      onPressed: () async {
                        tempStor = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (tempStor == null) return;
                        setState(() {
                          loading = false;
                          pickedImage = File(tempStor.path);
                        });
                        !loading
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => webView(
                                    pickedImage: pickedImage,
                                  ),
                                ),
                              )
                            : null;
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(80),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.blue,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: _size.height() * 0.02,
                          vertical: _size.height() * 0.048,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.search_rounded,
                              size: _size.height() * 0.09,
                              color: Colors.white,
                            ),
                            const Text(
                              'Search For Product',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.clip,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: _size.width() * 0.045),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0.00001),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.white38,
                      ),
                    ),
                    child: Padding(
                      // padding: EdgeInsets.all(_size.height() * 0.012),
                      padding: EdgeInsets.fromLTRB(
                        _size.height() * 0.043,
                        _size.height() * 0.057,
                        _size.height() * 0.043,
                        _size.height() * 0.057,
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.translate,
                            size: _size.height() * 0.09,
                            color: Colors.white,
                          ),
                          const Text(
                            'Translate',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
