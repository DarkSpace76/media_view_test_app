import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

///Виджет используется для отображения изображений в приложении
Widget imageLoader(String? source, {bool isVideo = false, BoxFit? fit}) {
  return CachedNetworkImage(
    fit: fit,
    imageUrl: source ?? '',
    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}
