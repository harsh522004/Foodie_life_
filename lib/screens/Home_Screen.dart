//
// import 'package:flutter/material.dart';
// import 'package:foodei_life/Common/custom_Card.dart';
// import 'package:foodei_life/Common/serch_bar.dart';
// import 'package:foodei_life/constant/images.dart';
// import 'package:foodei_life/theme/colors.dart';
// import 'package:getwidget/getwidget.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the TabController with 3 tabs
//     _tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose(); // Dispose of the TabController when done
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Circular Avatar
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const GFAvatar(
//                     backgroundImage: AssetImage(hProfilePic),
//                     radius: 40,
//                   ),
//                   IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.notes_sharp,
//                       color: materialColor[500],
//                       size: 40,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//
//               // Text title
//               Container(
//                 padding: const EdgeInsets.only(left: 5),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Hey! Harsh',
//                       style: GoogleFonts.getFont(
//                         'Open Sans',
//                         fontSize: 40,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     Text(
//                       'What\'s in your Mind Today?',
//                       style: GoogleFonts.getFont(
//                         'Open Sans',
//                         fontSize: 25,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Sized Box
//               const SizedBox(
//                 height: 15,
//               ),
//
//               // Search Bar
//               HSearchBar(
//                 backgroundColor: materialColor[100]!,
//                 hintText: 'Search',
//               ),
//
//               // Cards
//               Expanded(
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       CustomCard(title: "Harsh Butani", color: materialColor[200]!),
//                       CustomCard(title: "Harsh Butani", color: materialColor[200]!),
//                       CustomCard(title: "Harsh Butani", color: materialColor[200]!),
//                       CustomCard(title: "Harsh Butani", color: materialColor[200]!),
//                       CustomCard(title: "Harsh Butani", color: materialColor[200]!),
//                       // Add more CardItems as needed
//                     ],
//                   ),
//                 ),
//               ),
//
//               Expanded(
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       CustomCard(title: "Harsh Butani", color: materialColor[200]!),
//                       CustomCard(title: "Harsh Butani", color: materialColor[200]!),
//                       CustomCard(title: "Harsh Butani", color: materialColor[200]!),
//                       CustomCard(title: "Harsh Butani", color: materialColor[200]!),
//                       CustomCard(title: "Harsh Butani", color: materialColor[200]!),
//                       // Add more CardItems as needed
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//
//       // Add BottomNavigationBar
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _tabController.index, // Set the current tab index
//         onTap: (index) {
//           _tabController.animateTo(index); // Switch to the selected tab
//         },
//         items:  [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home,color: materialColor[500],),
//             label: '',
//
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search,color: materialColor[500],size: 40,),
//             label: '',
//
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person,color: materialColor[500],),
//             label: '',
//
//           ),
//         ],
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:foodei_life/Common/custom_Card.dart';
import 'package:foodei_life/Common/serch_bar.dart';
import 'package:foodei_life/constant/images.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circular Avatar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const GFAvatar(
                    backgroundImage: AssetImage(hProfilePic),
                    radius: 40,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notes_sharp,
                      color: materialColor[500],
                      size: 40,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),

              // Text title
              Container(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hey! Harsh',
                      style: GoogleFonts.getFont(
                        'Open Sans',
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'What\'s in your Mind Today?',
                      style: GoogleFonts.getFont(
                        'Open Sans',
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // Sized Box
              const SizedBox(
                height: 15,
              ),

              // Search Bar
              HSearchBar(
                backgroundColor: materialColor[100]!,
                hintText: 'Search',
              ),

              // Cards
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomCard(title: "Harsh Butani", color: materialColor[200]!),
                      CustomCard(title: "Harsh Butani", color: materialColor[200]!),
                      CustomCard(title: "Harsh Butani", color: materialColor[200]!),
                      CustomCard(title: "Harsh Butani", color: materialColor[200]!),
                      CustomCard(title: "Harsh Butani", color: materialColor[200]!),
                      // Add more CardItems as needed
                    ],
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomCard(title: "Harsh Butani", color: materialColor[200]!),
                      CustomCard(title: "Harsh Butani", color: materialColor[200]!),
                      CustomCard(title: "Harsh Butani", color: materialColor[200]!),
                      CustomCard(title: "Harsh Butani", color: materialColor[200]!),
                      CustomCard(title: "Harsh Butani", color: materialColor[200]!),
                      // Add more CardItems as needed
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Custom Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey, // Add your desired border color here
              width: 1.0, // Add your desired border width here
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Add shadow color
              spreadRadius: 2, // Add spread radius
              blurRadius: 5, // Add blur radius
              offset: Offset(0, 3), // Add shadow offset
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Add background color of the center icon
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.home,
                  color: materialColor[500], // Add icon color
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: materialColor[100]!, // Add background color of the search icon
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.white, // Add icon color
                  size: 50, // Increase icon size
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Add background color of the third icon
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person,
                  color: materialColor[500], // Add icon color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
