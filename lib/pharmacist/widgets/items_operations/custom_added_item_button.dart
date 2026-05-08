// import 'package:flutter/material.dart';
// import 'package:pharmygo/core/utils/colors.dart';
// import 'package:pharmygo/core/utils/dimensions.dart';

// class AddedButton extends StatelessWidget {
//   const AddedButton({
//     super.key,
//     required this.image,
//     required this.text,
//   });

//   final String image;
//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
//       height: Dimensions.screenHeight(context) / 8,
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         color:  ThemeColors.kSecondBackgroundColor(context),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.fromLTRB(80, 35, 0, 40),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               color: Colors.white,
//               image: DecorationImage(
//                 fit: BoxFit.contain,
//                 image: AssetImage(image),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//             child: SizedBox(
//               height: 40,
//               width: Dimensions.screenWidth(context) / 2.4,
//               child: Text(
//                 text,
//                 style: const TextStyle(
//                   fontSize: 15,
//                   color:  ThemeColors.kSecondColor(context),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           const Text(
//             'Added',
//             style: TextStyle(
//               color:  ThemeColors.kSecondColor(context),
//               fontSize: 15,
//               fontWeight: FontWeight.bold,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
