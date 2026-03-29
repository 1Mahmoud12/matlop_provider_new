// import 'package:flutter/material.dart';
// import 'package:tashiraa/core/themes/color_constraint.dart';
// import 'package:tashiraa/core/themes/styles.dart';
// import 'package:tashiraa/features/chat/presentation/widgets/item_image.dart';

// class ListOfImages extends StatelessWidget {
//   const ListOfImages({
//     super.key,
//     required this.imageList,
//   });

//   final List<String> imageList;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(3),
//       margin: const EdgeInsets.only(top: 5),
//       decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(10)),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               ItemImage(image: imageList[0],),
//               const SizedBox(
//                 width: 3,
//               ),
//               ItemImage(image: imageList[1]),
//             ],
//           ),
//           const SizedBox(
//             height: 3,
//           ),
//           Row(
//             children: [
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   ItemImage(image: imageList[2]),
//                   Container(
//                     width: 80,
//                     height: 90,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.35),
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: Center(
//                       child: Text(
//                         '4+',
//                         style: Styles.style14500.copyWith(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 width: 3,
//               ),
//               ItemImage(image: imageList[3]),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
