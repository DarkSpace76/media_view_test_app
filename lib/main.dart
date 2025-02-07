import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:media_view/data/api_service.dart';
import 'package:media_view/presentation/screens/gallery.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppGallery(
        dataStore: PixabayGetData(),
      ),
    );
  }
}
