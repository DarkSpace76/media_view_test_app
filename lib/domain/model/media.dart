///Модель данных [Media], объеденяет в себе как свойства для картинок и видео
///объеденяя это все в объект [Media]
class Media {
  int? id;
  String? pageURL;
  String? type;
  String? tags;
  String? previewURL;
  int? previewWidth;
  int? previewHeight;
  String? webformatURL;
  int? webformatWidth;
  int? webformatHeight;
  String? largeImageURL;
  int? imageWidth;
  int? imageHeight;
  int? imageSize;
  int? views;
  int? downloads;
  int? collections;
  int? likes;
  int? comments;
  int? userId;
  String? user;
  String? userImageURL;
  int? duration;
  VideoQuality? large;
  VideoQuality? medium;
  VideoQuality? small;
  VideoQuality? tiny;

  Media({
    this.id,
    this.pageURL,
    this.type,
    this.tags,
    this.previewURL = '',
    this.previewWidth = 0,
    this.previewHeight = 0,
    this.webformatURL = '',
    this.webformatWidth = 0,
    this.webformatHeight = 0,
    this.largeImageURL = '',
    this.imageWidth = 0,
    this.imageHeight = 0,
    this.imageSize = 0,
    this.views,
    this.downloads,
    this.collections = 0,
    this.likes,
    this.comments,
    this.userId,
    this.user,
    this.userImageURL,
    this.duration = 0,
    this.large,
    this.medium,
    this.small,
    this.tiny,
  });

  ///Метод возвращает [true] если объект [Media] является видео
  bool isVideo() => type == 'film';

  ///Метод позволяет создать объект [media]
  ///на основе ответа Api сервиса
  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'],
      pageURL: json['pageURL'],
      type: json['type'],
      tags: json['tags'],
      previewURL: json['previewURL'] ?? '',
      previewWidth: json['previewWidth'] ?? 0,
      previewHeight: json['previewHeight'] ?? 0,
      webformatURL: json['webformatURL'] ?? '',
      webformatWidth: json['webformatWidth'] ?? 0,
      webformatHeight: json['webformatHeight'] ?? 0,
      largeImageURL: json['largeImageURL'] ?? '',
      imageWidth: json['imageWidth'] ?? 0,
      imageHeight: json['imageHeight'] ?? 0,
      imageSize: json['imageSize'] ?? 0,
      views: json['views'],
      downloads: json['downloads'],
      collections: json['collections'] ?? 0,
      likes: json['likes'],
      comments: json['comments'],
      userId: json['user_id'],
      user: json['user'],
      userImageURL: json['userImageURL'],
      duration: json['duration'] ?? 0,
      large: json['videos'] != null
          ? VideoQuality.fromJson(json['videos']['large'])
          : null,
      medium: json['videos'] != null
          ? VideoQuality.fromJson(json['videos']['medium'])
          : null,
      small: json['videos'] != null
          ? VideoQuality.fromJson(json['videos']['small'])
          : null,
      tiny: json['videos'] != null
          ? VideoQuality.fromJson(json['videos']['tiny'])
          : null,
    );
  }

  Map<String, dynamic> toInfo() => <String, dynamic>{
        'id': 'id изображения: $id',
        'pageURL': 'Домашняя страница: $pageURL',
        'type': 'Тип: $type',
        'tags': 'Тэги: $tags',
        'previewURL': 'Ссылка preview: $previewURL',
        'previewHeight': 'Высота preview: $previewHeight',
        'previewWidth': 'Ширина preview: $previewWidth',
        'webformatURL': 'URL web формат: $webformatURL',
        'webformatWidth': 'Ширина web: $webformatWidth',
        'webformatHeight': 'Высота web: $webformatHeight',
        'largeImageURL': 'Ссылка на оригинал: $largeImageURL',
        'imageWidth': 'Ширина: $imageWidth',
        'imageHeight': 'Высота: $imageHeight',
        'imageSize': 'Размер: $imageSize',
        'views': 'Количество просмотров: $views',
        'downloads': 'Количество загрузок: $downloads',
        'user_id': 'id пользователя: $userId',
        'user': 'Пользователь: $user',
      };
}

///Объект  [VideoQuality] хранит данные о видеофайле
class VideoQuality {
  String? url;
  int? width;
  int? height;
  int? size;
  String? thumbnail;

  VideoQuality({
    this.url,
    this.width,
    this.height,
    this.size,
    this.thumbnail,
  });

  factory VideoQuality.fromJson(Map<String, dynamic> json) {
    return VideoQuality(
      url: json['url'],
      width: json['width'],
      height: json['height'],
      size: json['size'],
      thumbnail: json['thumbnail'],
    );
  }
}
