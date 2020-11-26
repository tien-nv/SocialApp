// Widget buildMedia(List<String> listMedia) {
//     int number = listMedia.length;
//     switch (number) {
//       case 1:
//         return Row(children: [
//           buildOneImage(listMedia[0]),
//         ]);
//         break;
//       case 2:
//         return Row(
//           children: [
//             Expanded(
//               flex: 1,
//               child: buildOneImage(listMedia[0]),
//             ),
//             Expanded(
//               flex: 1,
//               child: buildOneImage(listMedia[1]),
//             ),
//           ],
//         );
//         break;
//       case 3:
//         return Row(
//           children: [
//             Expanded(
//               flex: 1,
//               child: buildOneImage(listMedia[0]),
//             ),
//             Expanded(
//               flex: 1,
//               child: GridView.count(
//                 scrollDirection: Axis.horizontal,
//                 crossAxisCount: 2,
//                 children: [
//                   buildOneImage(listMedia[1]),
//                   buildOneImage(listMedia[2]),
//                 ],
//               ),
//             ),
//           ],
//         );
//         break;
//       default: // > 3
//         return Row(
//           children: [
//             Expanded(
//               flex: 1,
//               child: buildOneImage(listMedia[0]),
//             ),
//             Expanded(
//               flex: 1,
//               child: GridView.count(
//                 scrollDirection: Axis.horizontal,
//                 crossAxisCount: 2,
//                 children: [
//                   buildOneImage(listMedia[1]),
//                   Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       buildOneImage(listMedia[2]),
//                       Container(
//                         color: Colors.grey.withOpacity(0.8),
//                         child: Center(
//                           child: Text(
//                             '+',
//                             style: TextStyle(
//                               fontSize: 60,
//                               color: Colors.white.withOpacity(0.5),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//         break;
//     }
//   }
