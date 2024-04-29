import 'package:flutter/material.dart';
import 'package:recipe_project/screens/breakfast.dart';
import 'package:recipe_project/screens/desert.dart';
import 'package:recipe_project/screens/main_course.dart';

import 'package:recipe_project/screens/snacks.dart';

class ShowMore extends StatelessWidget {
  const ShowMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Show More'),
          bottom: TabBar(
            indicatorColor: Colors.green,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                text: 'Breakfast',
                icon: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/fried-egg-food-breakfast-bread-toast-transparent-png-2333981 1.png',
                    width: 40,
                    height: 35,
                  ),
                ),
              ),
              Tab(
                text: 'Main course',
                icon: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/kisspng-vindaloo-butter-chicken-tandoori-chicken-korma-pak-butter-chicken-5b56bdb90a6fc1 1.png',
                    width: 40,
                    height: 35,
                  ),
                ),
              ),
              Tab(
                text: 'Dessert',
                icon: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/ice-cream-cones-chocolate-ice-cream-sundae-ice-cream-73a9a5527f7dba7b8554edfad76a8677 1.png',
                    width: 40,
                    height: 35,
                  ),
                ),
              ),
              Tab(
                text: 'Snacks',
                icon: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/—Pngtree—potato chip oil fried snack_6190931 1.png',
                    width: 40,
                    height: 35,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Breakfast(),
            Maincourse(),
            Desert(),
            Snacks(),
          ],
        ),
      ),
    );
  }
}
