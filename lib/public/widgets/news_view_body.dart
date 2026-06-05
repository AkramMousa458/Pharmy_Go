import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/news_service.dart';
import 'package:pharmygo/public/models/article_model.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';
import 'package:pharmygo/public/widgets/news_item.dart';

class NewsViewBody extends StatefulWidget {
  const NewsViewBody({super.key});

  @override
  State<NewsViewBody> createState() => _NewsViewBodyState();
}

class _NewsViewBodyState extends State<NewsViewBody> {
  late Future<List<ArticleModel>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = NewsService(Dio()).getTopHeadlines();
  }

  Future<void> _refreshNews() async {
    setState(() {
      _newsFuture = NewsService(Dio()).getTopHeadlines();
    });
    await _newsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleModel>>(
      future: _newsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomLoadingIndicator());
        }

        if (snapshot.hasError) {
          return _FeedMessage(
            icon: Icons.error_outline,
            message: 'Could not load the feed.\nPull down to try again.',
            onRetry: _refreshNews,
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _FeedMessage(
            icon: Icons.newspaper_outlined,
            message: 'No posts in your feed yet.',
            onRetry: _refreshNews,
          );
        }

        final news = snapshot.data!;

        return RefreshIndicator(
          color: ThemeColors.kMainColor(context),
          onRefresh: _refreshNews,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: EdgeInsets.only(bottom: 16.h),
            itemCount: news.length + 1,
            separatorBuilder: (context, index) {
              if (index == 0) return const SizedBox.shrink();
              return Divider(
                height: 8.h,
                thickness: 8.h,
                color: ThemeColors.kLightGreyColor(context).withValues(alpha: 0.25),
              );
            },
            itemBuilder: (context, index) {
              if (index == 0) {
                return _FeedHeader(postCount: news.length);
              }

              return NewsItem(
                article: news[index - 1],
              );
            },
          ),
        );
      },
    );
  }
}

class _FeedHeader extends StatelessWidget {
  const _FeedHeader({required this.postCount});

  final int postCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 12.h),
      decoration: BoxDecoration(
        color: ThemeColors.kBackgroundColor(context),
        border: Border(
          bottom: BorderSide(
            color: ThemeColors.kLightGreyColor(context).withValues(alpha: 0.35),
          ),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor:
                ThemeColors.kMainColor(context).withValues(alpha: 0.12),
            child: Icon(
              Icons.local_hospital_outlined,
              size: 20.sp,
              color: ThemeColors.kMainColor(context),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Health Feed',
                  style: TextStyle(
                    color: ThemeColors.kSecondColor(context),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '$postCount posts for you',
                  style: TextStyle(
                    color: ThemeColors.kGreyColor(context),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.tune_rounded,
            color: ThemeColors.kGreyColor(context),
            size: 22.sp,
          ),
        ],
      ),
    );
  }
}

class _FeedMessage extends StatelessWidget {
  const _FeedMessage({
    required this.icon,
    required this.message,
    required this.onRetry,
  });

  final IconData icon;
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48.sp,
              color: ThemeColors.kGreyColor(context),
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.kGreyColor(context),
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 20.h),
            TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Refresh feed'),
            ),
          ],
        ),
      ),
    );
  }
}
