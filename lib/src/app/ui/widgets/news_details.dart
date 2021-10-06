import 'package:flutter/material.dart';
import 'package:news_headlines/src/app/repository/news/api/model/news_article.dart';
import 'package:news_headlines/src/app/ui/widgets/image_view.dart';
import 'package:news_headlines/src/app/ui/widgets/text_widget.dart';
import 'package:news_headlines/src/app/ui/widgets/titled_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final news = ModalRoute.of(context)!.settings.arguments as Article;
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title.toString()),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          children: [
            ImageWidget(news.urlToImage),
            TextWidget(news.title, true),
            TextWidget(news.description, false),
            // TextWidget(news.content, false),
            GestureDetector(
              onTap: () {
                _launchURLBrowser(news.url.toString());
              },
              child: const TitledTextWidget(
                  "", true, "Click to read the complete article"),
            ),
            TitledTextWidget("Name :", false, news.source!.name),
            TitledTextWidget("ID :", false, news.source!.id),
            TitledTextWidget("Author :", false, news.author),
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
