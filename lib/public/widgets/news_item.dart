import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/public/models/article_model.dart';

String formatFeedTimeAgo(DateTime? date) {
  if (date == null) return 'Just now';

  final difference = DateTime.now().difference(date.toLocal());
  if (difference.inMinutes < 1) return 'Just now';
  if (difference.inMinutes < 60) return '${difference.inMinutes}m';
  if (difference.inHours < 24) return '${difference.inHours}h';
  if (difference.inDays < 7) return '${difference.inDays}d';

  return '${date.day}/${date.month}/${date.year}';
}

class NewsItem extends StatefulWidget {
  const NewsItem({super.key, required this.article});

  final ArticleModel article;

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    final article = widget.article;
    final timeLabel = formatFeedTimeAgo(article.publishedAt);
    final metaLabel = article.source != null && article.source!.isNotEmpty
        ? '${article.source} · $timeLabel'
        : timeLabel;

    return Container(
      color: ThemeColors.kBackgroundColor(context),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(12.w, 12.h, 8.w, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22.r,
                    backgroundColor:
                        ThemeColors.kMainColor(context).withValues(alpha: 0.15),
                    child: Text(
                      article.authorInitial,
                      style: TextStyle(
                        color: ThemeColors.kMainColor(context),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.authorName,
                          style: TextStyle(
                            color: ThemeColors.kSecondColor(context),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          metaLabel,
                          style: TextStyle(
                            color: ThemeColors.kGreyColor(context),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz_rounded,
                      color: ThemeColors.kGreyColor(context),
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 12.h),
              child: Text(
                article.title,
                style: TextStyle(
                  color: ThemeColors.kSecondColor(context),
                  fontSize: 15.sp,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (article.image != null && article.image!.isNotEmpty)
              NewsImageWidget(imageUrl: article.image),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: Row(
                children: [
                  _FeedActionButton(
                    icon: _isLiked
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    label: _isLiked ? 'Liked' : 'Like',
                    color: _isLiked
                        ? Colors.redAccent
                        : ThemeColors.kGreyColor(context),
                    onTap: () => setState(() => _isLiked = !_isLiked),
                  ),
                  // _FeedActionButton(
                  //   icon: Icons.chat_bubble_outline_rounded,
                  //   label: 'Comment',
                  //   color: ThemeColors.kGreyColor(context),
                  //   onTap: () {},
                  // ),
                  // _FeedActionButton(
                  //   icon: Icons.share_outlined,
                  //   label: 'Share',
                  //   color: ThemeColors.kGreyColor(context),
                  //   onTap: () {},
                  // ),
                  // const Spacer(),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(
                  //     Icons.bookmark_border_rounded,
                  //     color: ThemeColors.kGreyColor(context),
                  //     size: 22.sp,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeedActionButton extends StatelessWidget {
  const _FeedActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 20.sp, color: color),
      label: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: CachedNetworkImage(
          imageUrl: url,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: ThemeColors.kLightGreyColor(context).withValues(alpha: 0.25),
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (context, url, error) => const NewsPlaceholderImage(),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

class NewsPlaceholderImage extends StatelessWidget {
  const NewsPlaceholderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
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
            size: 48.sp,
          ),
        ),
      ),
    );
  }
}
