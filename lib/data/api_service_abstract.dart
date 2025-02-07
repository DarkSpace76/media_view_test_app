///Абстрактный класс ApiService для загрузки данных
abstract class ApiService {
  Future<List<Map<String, dynamic>>?> fetchData(String url);
}
