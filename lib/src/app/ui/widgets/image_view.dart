import 'package:flutter/cupertino.dart';

class ImageWidget extends StatelessWidget {
  final String? imageUrl;
  const ImageWidget(this.imageUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
      child: imageUrl != null
          ? Container(
          alignment: Alignment.center,
          height: 200,
          child: Expanded(
            child: FadeInImage.assetNetwork(
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset("assets/images/news.png");
              },
              placeholder: "assets/placeholder/loading.jpg",
              image: imageUrl!,
            ),
          ))
          : Image.asset("assets/images/news.png"),
    );
  }
}
