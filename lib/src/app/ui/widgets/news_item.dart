import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:news_headlines/src/app/repository/news/api/model/news_article.dart';
import 'package:news_headlines/src/navigation/routes.dart';

class NewsItem extends StatelessWidget {
  final Article? newsItem;

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
            Container(
              margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
              child: newsItem!.title != null
                  ? Text(
                      newsItem!.title as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    )
                  : const Text(
                      "title not available",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
              child: newsItem!.urlToImage != null
                  ? Container(
                      height: 200,
                      alignment: Alignment.center,
                      child: FadeInImage.assetNetwork(
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/images/news.png");
                        },
                        placeholder: "assets/placeholder/loading.jpg",
                        image: newsItem!.urlToImage.toString(),
                      ),
                    )
                  : Image.asset("assets/images/news.png"),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
              child: newsItem!.description != null
                  ? Text(newsItem!.description as String)
                  : const Text(
                      "Description not available",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
