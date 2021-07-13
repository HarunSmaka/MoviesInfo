import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/config.dart';
import '../enum/content_type.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail';

  DetailScreen({Key? key}) : super(key: key);

  final _item = Get.arguments[0];
  final ContentType contentType = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // Some objects don't have backdrop_path or/and poster_path property
    var image = '';
    if (_item.backdrop_path != null) {
      image = _item.backdrop_path;
    } else if (_item.poster_path != null) {
      image = _item.poster_path;
    }
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            image.isNotEmpty
                ? Container(
                    height: screenSize.height * 0.3,
                    child: Image.network(
                      '${Config.IMG_URL_POSTER}$image',
                      fit: BoxFit.cover,
                    ),
                  )
                : const SizedBox(height: 25),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                contentType == ContentType.Movie ? _item.title : _item.name,
                style: TextStyle(fontSize: 22),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                _item.overview,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
