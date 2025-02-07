import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_view/domain/controllers/img_controller.dart';
import 'package:media_view/domain/model/media.dart';
import 'package:media_view/presentation/widgets/image_loader.dart';
import 'package:video_player/video_player.dart';

///Виджет [DataViwer] отображает диалоговое окно
///для просмотра изображения или видео
class DataViwer extends StatefulWidget {
  DataViwer({super.key, required this.media});
  Media media;

  @override
  State<DataViwer> createState() => _DataViwerState();
}

class _DataViwerState extends State<DataViwer> {
  ///Получаем ссылку на [DataController]
  DataController dataController = Get.find();

  ///Констроллер для работы с видео
  VideoPlayerController? _controller;

  @override
  void initState() {
    initVideoController();
    super.initState();
  }

  ///Метод осуществляет инициализацию видеоплеера и запускает воспроизведение видео
  void initVideoController() {
    if (_controller != null && _controller!.value.isPlaying)
      _controller?.pause();

    if (widget.media.isVideo()) {
      _controller = VideoPlayerController.networkUrl(
          Uri.parse(widget.media.medium?.url ?? ''))
        ..initialize().then((_) {
          setState(() {
            _controller?.play();
          });
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  ///Функция осуществляет навигацию вперед/назад в режиме диалогового окна
  Function()? nextMedia(AxisDirection direction) {
    setState(() {
      int idx = dataController.media.indexOf(widget.media);
      switch (direction) {
        case AxisDirection.left:
          idx--;
          widget.media = idx < 0
              ? dataController.media[dataController.media.length - 1]
              : dataController.media[idx];
          break;

        default:
          idx++;
          widget.media = idx > dataController.media.length - 1
              ? dataController.media[0]
              : dataController.media[idx];
          break;
      }
      initVideoController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  profileimage(
                      imageUrl: widget.media.userImageURL,
                      userName: widget.media.user),
                  Spacer(),
                  Builder(builder: (btnContext) {
                    return arrowButton(
                      icon: Icons.info,
                      onPressed: () =>
                          openMenu(btnContext, media: widget.media),
                    );
                  })
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  arrowButton(
                      icon: Icons.arrow_back,
                      onPressed: () => nextMedia(AxisDirection.left)),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: widget.media.isVideo()
                          ? videoPlayer()
                          : imageLoader(widget.media.largeImageURL,
                              fit: BoxFit.cover),
                    ),
                  ),
                  arrowButton(
                      icon: Icons.arrow_forward,
                      onPressed: () => nextMedia(AxisDirection.right)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Виджет отображающий видеоплеер
  Widget videoPlayer() {
    return Center(
      child: _controller!.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            )
          : Container(),
    );
  }
}

///Метод создает контекстное меню для отображения сведений о видеофайле
Future openMenu(
  BuildContext context, {
  required Media media,
}) {
  //Получаем позицию кнопки вызова контекстного меню
  //чтобы отобразить его в нужном месте
  final RenderBox button = context.findRenderObject() as RenderBox;
  final Offset buttonPosition = button.localToGlobal(Offset.zero);

  return showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        buttonPosition.dx,
        buttonPosition.dy,
        buttonPosition.dx,
        buttonPosition.dy,
      ),
      items: media
          .toInfo()
          .entries
          .map((el) => PopupMenuItem(
                child: Text(el.value),
              ))
          .toList());
}

///Виджеть отображает аватар профиля пользователя и его имя
Widget profileimage({String? imageUrl, String? userName}) {
  return Container(
    width: 250,
    height: 50,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(25)),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: SizedBox(width: 50, height: 50, child: imageLoader(imageUrl)),
        ),
        Padding(padding: EdgeInsets.only(right: 15)),
        Text(
          userName ?? '',
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}

///Виджет кнопок навигации вперед/назад
Widget arrowButton({IconData? icon, Function()? onPressed}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Material(
        child: InkWell(
            onTap: onPressed,
            child: SizedBox(
              width: 50,
              height: 50,
              child: Icon(
                icon,
                color: Colors.black,
              ),
            )),
      ),
    ),
  );
}
