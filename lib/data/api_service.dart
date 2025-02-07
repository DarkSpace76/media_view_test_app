import 'package:dio/dio.dart';
import 'package:media_view/data/api_service_abstract.dart';

class PixabayGetData extends ApiService {
  late Dio dio;

  PixabayGetData() {
    dio = Dio();
  }

  ///Метод загрузки медиаданных
  @override
  Future<List<Map<String, dynamic>>?> fetchData(String url) async {
    try {
      Response response = await dio.get(url);
      if (response.data != null) {
        await Future.delayed(Duration(seconds: 1));
        return (response.data['hits'] as List)
            .map((el) => el as Map<String, dynamic>)
            .toList();
      }
    } catch (error) {
      print(error);
    }
    return null;
  }
}
