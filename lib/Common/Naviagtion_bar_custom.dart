// import 'package:flutter/material.dart';
// import 'package:foodei_life/theme/colors.dart';
//
// class NavigationButton extends StatelessWidget {
//   const NavigationButton({
//     super.key, required this.selectedIndex,
//   });
//   final int selectedIndex;
//
//
//   @override
//   Widget build(BuildContext context) {
//     void _selectPage(int index){
//
//     }
//
//     return BottomNavigationBar(
//       currentIndex: selectedIndex,
//       onTap: onTap,
//       elevation: 0,
//       type: BottomNavigationBarType.fixed, // Use fixed type to keep the buttons visible
//       showSelectedLabels: false, // You can configure label visibility as needed
//       showUnselectedLabels: false,
//       items: <BottomNavigationBarItem>[
//         const BottomNavigationBarItem(
//           icon: Icon(Icons.category),
//           label: '', // Empty label to hide text
//         ),
//         BottomNavigationBarItem(
//           icon: Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: materialColor[400],
//             ),
//             padding: const EdgeInsets.all(10),
//             child: Icon(
//               Icons.add,
//               size: 30,
//               color: materialColor[50],
//             ),
//           ),
//           label: '',
//         ),
//         const BottomNavigationBarItem(
//           icon: Icon(Icons.filter_list_alt),
//           label: '',
//         ),
//       ],
//
//     );
//   }
// }
//
