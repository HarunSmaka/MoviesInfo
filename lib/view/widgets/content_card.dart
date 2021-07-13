import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
import '../../enum/content_type.dart';
import '../../view/detail_screen.dart';

class MovieCard extends StatelessWidget {
  final item;
  final ContentType contentType;
  const MovieCard({
    required this.item,
    required this.contentType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _item = item;
    var image = _item.poster_path ?? _item.backdrop_path;
    return Container(
      height: 80,
      child: Card(
        child: ListTile(
          onTap: () {
            Get.toNamed(DetailScreen.routeName,
                arguments: [_item, contentType]);
          },
          leading: Container(
            height: 80,
            width: 80,
            child: image != null
                ? Image.network(
                    '${Config.IMG_URL_POSTER}$image',
                    fit: BoxFit.cover,
                  )
                : Image.asset('assets/images/no_image.png'),
          ),
          // Tv Shows have property name while movies have property title
          title: contentType == ContentType.Movie
              ? Text('${_item.title}')
              : Text('${_item.name}'),
          subtitle: Text(
            _item.overview,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
