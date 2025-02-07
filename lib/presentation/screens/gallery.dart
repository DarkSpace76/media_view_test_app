import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_view/data/api_service_abstract.dart';
import 'package:media_view/domain/controllers/img_controller.dart';
import 'package:media_view/domain/model/media.dart';
import 'package:media_view/presentation/widgets/image_loader.dart';
import 'package:media_view/presentation/widgets/data_viwer.dart';

///Главный экран приложения
class AppGallery extends StatefulWidget {
  const AppGallery({super.key, required this.dataStore});
  final ApiService dataStore;

  @override
  State<AppGallery> createState() => _AppGalleryState();
}

class _AppGalleryState extends State<AppGallery> {
  ///Пременная определяет количество столбцов сетки gridView
  int curColumn = 6;

  /// DataController для работы с медиаданными
  late final DataController dataController;

  @override
  void initState() {
    super.initState();
    dataController = Get.put(DataController(widget.dataStore));
    dataController.loadMore();
  }

  ///Виджет осуществляет отображение миниатюр в сетке GridView
  Widget getPreviewUrl(Media media) {
    String? srcPreview =
        media.isVideo() ? media.small?.thumbnail : media.previewURL;

    if (srcPreview != null) {
      return GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => DataViwer(media: media));
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: imageLoader(srcPreview,
                    isVideo: media.isVideo(), fit: BoxFit.fill),
              ),
              if (media.isVideo())
                Positioned(
                  left: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
            ],
          ));
    }

    return Placeholder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'Media Viewer - test app',
              ),
            ],
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (String value) {
                setState(() {
                  curColumn = int.parse(value);
                });
              },
              itemBuilder: (BuildContext context) {
                return {'1', '2', '3', '4', '5', '6'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text('1 x $choice'),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Obx(() => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: ListView(children: [
              GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: curColumn,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: dataController.media.length,
                  itemBuilder: (context, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: getPreviewUrl(dataController.media[index]))),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: dataController.isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      )
                    : ElevatedButton(
                        onPressed: () => dataController.loadMore(),
                        child: Text('Загрузить еще')),
              )
            ]))));
  }
}
