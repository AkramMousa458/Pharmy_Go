import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/public/models/article_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ThemeColors.kBackgroundColor(context),
        // color: ThemeColors.kSecondBackgroundColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ThemeColors.kLightGreyColor(context).withValues(alpha: 0.3),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // Action when tapping the article
            },
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: NewsImageWidget(imageUrl: article.image),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (article.subTitle != null &&
                              article.subTitle!.isNotEmpty) ...<Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: ThemeColors.kMainColor(context)
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                article.subTitle!,
                                style: TextStyle(
                                  color: ThemeColors.kMainColor(context),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 8.h),
                          ],
                          Text(
                            article.title,
                            style: TextStyle(
                              color: ThemeColors.kSecondColor(context),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NewsImageWidget extends StatelessWidget {
  const NewsImageWidget({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final String? url = imageUrl;
    if (url != null && url.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: url,
        width: 100.w,
        height: 100.h,
        fit: BoxFit.cover,
        placeholder: (BuildContext context, String url) => Container(
          width: 100.w,
          height: 100.h,
          color: ThemeColors.kLightGreyColor(context).withValues(alpha: 0.3),
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
          ),
        ),
        errorWidget: (BuildContext context, String url, Object error) =>
            const NewsPlaceholderImage(),
      );
    } else {
      return const NewsPlaceholderImage();
    }
  }
}

class NewsPlaceholderImage extends StatelessWidget {
  const NewsPlaceholderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            ThemeColors.kMainColor(context).withValues(alpha: 0.2),
            ThemeColors.kSecondColor(context).withValues(alpha: 0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.health_and_safety_outlined,
          color: ThemeColors.kMainColor(context),
          size: 36.sp,
        ),
      ),
    );
  }
}
