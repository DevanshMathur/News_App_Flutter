import 'package:flutter/material.dart';
import 'package:news_headlines/src/app/repository/news/api/model/news_article.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatelessWidget {
  final Article? news;

  const NewsDetails(this.news, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news!.title.toString()),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          children: [
            news!.urlToImage != null
                ? Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/placeholder/loading.jpg",
                      image: news!.urlToImage.toString(),
                    ),
                  )
                : Image.asset("assets/images/news.png"),
            Container(
              margin: const EdgeInsets.all(3),
              padding: const EdgeInsets.all(3),
              child: Center(
                child: news!.title != null
                    ? Text(
                        news!.title as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 20,
                        ),
                      )
                    : const Text(
                        "title not available",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
              ),
            ),
            Container(
              child: news!.description != null
                  ? Container(
                      margin: const EdgeInsets.all(3),
                      padding: const EdgeInsets.all(3),
                      child: Text(news!.description as String),
                    )
                  : Container(),
            ),
            Container(
              child: news!.content != null
                  ? Container(
                      margin: const EdgeInsets.all(3),
                      padding: const EdgeInsets.all(3),
                      child: Text(news!.content as String),
                    )
                  : Container(),
            ),
            Container(
              child: news!.url != null
                  ? Container(
                      margin: const EdgeInsets.all(3),
                      padding: const EdgeInsets.all(3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Source",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _launchURLBrowser(news!.url.toString());
                            },
                            child: Text(
                              news!.url as String,
                              style: const TextStyle(
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ),
            Container(
              child: news!.source!.name != null
                  ? Container(
                      margin: const EdgeInsets.all(3),
                      padding: const EdgeInsets.all(3),
                      child: Row(
                        children: [
                          const Text(
                            "Name :- ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(news!.source!.name as String),
                        ],
                      ),
                    )
                  : Container(),
            ),
            Container(
              child: news!.source!.id != null
                  ? Container(
                      margin: const EdgeInsets.all(3),
                      padding: const EdgeInsets.all(3),
                      child: Row(
                        children: [
                          const Text(
                            "ID :- ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(news!.source!.id as String),
                        ],
                      ),
                    )
                  : Container(),
            ),
            Container(
              child: news!.author != null
                  ? Container(
                      margin: const EdgeInsets.all(3),
                      padding: const EdgeInsets.all(3),
                      child: Row(
                        children: [
                          const Text(
                            "Author :- ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(news!.author as String),
                        ],
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  _launchURLBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
