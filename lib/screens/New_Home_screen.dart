import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Provider/Serch_bar_provider.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:foodei_life/widgets/Custome_Category_card.dart';
import 'package:foodei_life/widgets/New_Category_Grid.dart';
import 'package:foodei_life/widgets/Side_Drawer.dart';
import 'package:foodei_life/widgets/new_home_above_content.dart';
import 'package:foodei_life/widgets/new_home_appBar.dart';
import 'package:velocity_x/velocity_x.dart';

class NewHomeScreen extends ConsumerStatefulWidget {
  const NewHomeScreen({super.key});

  @override
  _NewHomeScreenState createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends ConsumerState<NewHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKeyNew = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  bool _initialDataLoaded = false;

  // when screen building
  @override
  void initState() {
    super.initState();

    // Load initial data for displayedCategories
    Future.delayed(Duration.zero, () {
      _loadInitialData();
    });
  }

  // load data
  void _loadInitialData() {
    ref.read(searchProvider.notifier).updateFilteredCategories('');
    setState(() {
      _initialDataLoaded = true;
    });
  }

  // build method
  @override
  Widget build(BuildContext context) {
    // if data not avaliable then loading
    if (!_initialDataLoaded) {
      return const CircularProgressIndicator(); // Or any loading indicator
    }

    // scaffold
    return Scaffold(
      key: _scaffoldKeyNew,
      backgroundColor: hscreenBg,
      drawer: const SideDrawer(),
      appBar: NewHomeAppbar(
        appBar: AppBar(),
        onSideMenuTap: () {
          _scaffoldKeyNew.currentState?.openDrawer();
        },
      ),
      body: Column(
        children: [
          // upper part
          NewHomeAboveContent(
            searchController: _searchController,
          ),
          20.heightBox,

          // category grid
          SizedBox(child: NewCategoryGrid())
              .h(55)
              .w(context.screenWidth)
              .pOnly(right: 10),

          // 9665227365 sainath
        ],
      ),
    );
  }
}
