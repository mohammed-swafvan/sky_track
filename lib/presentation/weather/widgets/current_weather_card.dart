// import 'package:flutter/material.dart';

// class CurrentWeatherCard extends StatelessWidget {
//   const CurrentWeatherCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Image.asset(
//           "assets/weather/${wheatherDataCurrent.currentModel.weather![0].icon}.png",
//           width: 80,
//           height: 80,
//         ),
//         Container(
//           height: 45,
//           width: 1,
//           color: CustomColor.dividerLine,
//         ),
//         RichText(
//           text: TextSpan(
//             children: [
//               TextSpan(
//                 text: "${wheatherDataCurrent.currentModel.temp!.floor()}°",
//                 style: customTextStyle(
//                   color: CustomColor.kBlackColor,
//                   size: 40,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               TextSpan(
//                 text: "${wheatherDataCurrent.currentModel.weather![0].description}",
//                 style: customTextStyle(
//                   color: CustomColor.kGreyColor,
//                   size: 10,
//                   fontWeight: FontWeight.w500,
//                 ),
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
