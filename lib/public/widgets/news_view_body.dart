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
            itemBuilder: (context, index) {
              final article = news[index];
              return NewsItem(
                // imgUrl: article.image ??  "https://emgf-wordpress-media.s3.eu-west-2.amazonaws.com/wp-content/uploads/2021/08/24133928/empty-180x180.jpg", // Provide a default value if null
                subTitle: article.subTitle ??
                    'No subtitle', // Provide a default value if null
                title: article.title, // Provide a default value if null
              );
            },
          );
        }
      },
    );
  }
}
