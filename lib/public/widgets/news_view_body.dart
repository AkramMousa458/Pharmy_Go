import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pharmygo/core/utils/news_service.dart';
import 'package:pharmygo/public/models/article_model.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';
import 'package:pharmygo/public/widgets/news_item.dart';

class NewsViewBody extends StatelessWidget {
  const NewsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleModel>>(
      future: NewsService(Dio()).getTopHeadlines(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomLoadingIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No news available'));
        } else {
          List<ArticleModel> news = snapshot.data!;
          return ListView.builder(
            itemCount: news.length,
            itemBuilder: (BuildContext context, int index) {
              final ArticleModel article = news[index];
              return NewsItem(
                article: article,
              );
            },
          );
        }
      },
    );
  }
}
