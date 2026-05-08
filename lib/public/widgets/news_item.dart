import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.title, required this.subTitle});
  final String? title, subTitle;
  // final String? imgUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   width: double.infinity,
        //   height: 150.h,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       fit: BoxFit.fill,
        //       image: CachedNetworkImageProvider(
        //        imgUrl!,
        //         errorListener: (p0) => const Icon(Icons.error),
        //       ),
        //     ),
        //     borderRadius: BorderRadius.circular(16),
        //   ),
        // ),
        SizedBox(
          height: 6.h,
        ),
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: Text(
            title!,
            style: TextStyle(
                color: ThemeColors.kMainColor(context),
                fontWeight: FontWeight.bold,
                fontSize: 16.sp),
            textAlign: TextAlign.right,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            subTitle!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: ThemeColors.kPriceColor(context), fontSize: 14.sp),
            textAlign: TextAlign.center,
          ),
        ),
        const Divider(),
      ],
    );
  }
}
