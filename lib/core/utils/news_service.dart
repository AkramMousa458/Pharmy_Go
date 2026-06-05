import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pharmygo/public/models/article_model.dart';

final String apiKey = '5b66ca3a0c254feea2b17201b0478e0a';

class NewsService {
  final Dio dio;
  NewsService(
    this.dio,
  );

  Future<List<ArticleModel>> getTopHeadlines() async {
    try {
      Response res = await dio.get(
          "https://newsapi.org/v2/everything?q=health&language=ar&sortBy=publishedAt&apiKey=$apiKey");
      // log('res:${res.data}');
      Map<String, dynamic> jsonData = res.data;
      List<dynamic> articles = jsonData['articles'];
      List<ArticleModel> articlesList = [];
      for (var article in articles) {
        ArticleModel articleModel = ArticleModel.fromJson(article);
        articlesList.add(articleModel);
      }
      return articlesList;
    } catch (e) {
      return [];
    }
  }
}
