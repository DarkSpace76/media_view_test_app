import 'package:get/get.dart';
import 'package:media_view/core/const.dart';
import 'package:media_view/data/api_service_abstract.dart';
import 'package:media_view/domain/model/media.dart';

///Класс управляет медифайлами
class DataController extends GetxController {
  ///Ссылка на API сервис
  late ApiService apiService;

  ///Список харнит набор медиаданных
  var _media = <Media>[].obs;

  ///Индикатор загрузки данных
  var _loading = false.obs;

  ///Гетеры возвращают конечный объект RX переменной
  /// для  читаемости кода
  bool get isLoading => _loading.value;
  List<Media> get media => _media;

  DataController(ApiService ds) {
    apiService = ds;
  }

  ///Осуществляет загрузку данных с сервера Api сервиса
  Future<List<dynamic>?> _fetchDataStore() async {
    List<Media> resultImg = [];
    List<Media> resultVideo = [];
    try {
      var imageData = await apiService.fetchData(imageUrl);

      var videoData = await apiService.fetchData(videoUrl);

      if (imageData != null) {
        resultImg = imageData.map((el) => Media.fromJson(el)).toList();
      }

      if (videoData != null) {
        resultVideo = videoData.map((el) => Media.fromJson(el)).toList();
      }

      return [...resultImg, ...resultVideo];
    } catch (error) {
      print(error);
    }
    return null;
  }

  ///Метод инициализирует загрузку данных
  void loadMore() async {
    _loading.value = true;

    var res = await _fetchDataStore();

    _loading.value = false;

    _media.value = [..._media, ...res ?? []];
  }
}
