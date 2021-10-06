import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:news_headlines/src/app/repository/news/api/model/news_article.dart';
import 'package:news_headlines/src/app/ui/widgets/image_view.dart';
import 'package:news_headlines/src/app/ui/widgets/text_widget.dart';
import 'package:news_headlines/src/navigation/routes.dart';

class NewsItem extends StatelessWidget {
  final Article newsItem;

  const NewsItem(this.newsItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.newsDetails, arguments: newsItem);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const NewsDetails(),
        //
        //   ),
        // );
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(newsItem.title, true),
            ImageWidget(newsItem.urlToImage),
            TextWidget(newsItem.description, false),
          ],
        ),
      ),
    );
  }
}
