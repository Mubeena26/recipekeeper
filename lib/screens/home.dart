// ignore_for_file: unused_local_variable, unused_field, sort_child_properties_last, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_project/db/db_functions.dart';
import 'package:recipe_project/model/data_model.dart';

import 'package:recipe_project/screens/add_recipe.dart';
import 'package:recipe_project/screens/breakfast.dart';
import 'package:recipe_project/screens/desert.dart';
import 'package:recipe_project/screens/main_course.dart';
// import 'package:recipe_project/screens/favourites.dart';

import 'package:recipe_project/screens/recipe_detail.dart';
import 'package:recipe_project/screens/show_more.dart';
// import 'package:recipe_project/screens/search.dart';

import 'package:recipe_project/screens/snacks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late TextEditingController _searchController;
  final List<String> _categories = [
    'Breakfast',
    'Main course',
    'Dessert',
    'Snacks'
  ];
  final LinearGradient _gradient = const LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 136, 255, 1),
      Colors.lightGreen,
      Color.fromARGB(255, 207, 228, 18)
    ],
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<List<RecipeModel>> getFavoriteRecipes() async {
    final favoriteBox = await Hive.openBox<RecipeModel>('favorites');
    final favoriteRecipes = favoriteBox.values.toList();
    return favoriteRecipes;
  }

  Future<void> fetchFavoriteRecipes() async {
    final favoriteRecipes = await getFavoriteRecipes();
    // Do something with the fetched favorite recipes if needed
  }

  // Other code...
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _categories.length,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        color: Color.fromARGB(255, 103, 233, 42),
                        height: 280,
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/WhatsApp Image 2024-03-05 at 19.24.29_3cf7eb7d.jpg',
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            left: 75,
                            bottom: 160,
                            right: 16,
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(padding: EdgeInsets.all(1.0)),
                                  SizedBox(width: 80.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Image.asset(
                                            'assets/PinClipart 2.png'),
                                      ),
                                      SizedBox(height: 0.0),
                                      Padding(
                                        padding: EdgeInsets.all(1.0),
                                        child: ShaderMask(
                                          shaderCallback: (Rect bounds) {
                                            return _gradient
                                                .createShader(bounds);
                                          },
                                          child: Text(
                                            'Freshly\ndropped',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  foreground: Paint()
                                                    ..style =
                                                        PaintingStyle.stroke
                                                    ..strokeWidth = 2
                                                    ..color = Colors.green,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            top: 110,
                            right: 16,
                            child: Container(
                              height: 35,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: TextField(
                                      // controller: _searchController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10.0),
                                        hintText: 'Search Dishes/Ingredients',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.all(1.0),
                                    onPressed: () {
                                      showSearch(
                                        context: context,
                                        delegate: StudentSearchDelegate(
                                            recipeListNotifier.value),
                                      );
                                    },
                                    icon: Icon(Icons.search),
                                    color: Colors.black54,
                                    iconSize: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      color: Color.fromARGB(255, 14, 10, 10),
                      height: 260,
                    ),
                  ),
                ],
              ),
              TabBar(
                indicatorColor: Colors.green,
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black,
                tabs: _categories.map((category) {
                  if (category == 'Breakfast') {
                    return Tab(
                      text: category,
                      icon: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          'assets/fried-egg-food-breakfast-bread-toast-transparent-png-2333981 1.png',
                          width: 40,
                          height: 35,
                        ),
                      ),
                    );
                  } else if (category == 'Main course') {
                    return Tab(
                      text: category,
                      icon: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          'assets/kisspng-vindaloo-butter-chicken-tandoori-chicken-korma-pak-butter-chicken-5b56bdb90a6fc1 1.png',
                          width: 40,
                          height: 35,
                        ),
                      ),
                    );
                  } else if (category == 'Dessert') {
                    return Tab(
                      text: category,
                      icon: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          'assets/ice-cream-cones-chocolate-ice-cream-sundae-ice-cream-73a9a5527f7dba7b8554edfad76a8677 1.png',
                          width: 40,
                          height: 35,
                        ),
                      ),
                    );
                  } else if (category == 'Snacks') {
                    return Tab(
                      text: category,
                      icon: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          'assets/—Pngtree—potato chip oil fried snack_6190931 1.png',
                          width: 40,
                          height: 35,
                        ),
                      ),
                    );
                  } else {
                    return Tab(text: category);
                  }
                }).toList(),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Breakfast(),
                    Maincourse(),
                    Desert(),
                    Snacks(),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0), // Adjust margin as needed
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green, // Border color
                    width: 2.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(10.0), // Border radius
                ),
                child: SizedBox(
                  width: 100.0,
                  height: 40.0, // Increase the height to accommodate the text
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowMore(),
                        ),
                      );
                    },
                    child: Text(
                      'Show More',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddScreen()),
            ).then((_) {});
          },
          backgroundColor: Color.fromARGB(255, 13, 97, 16),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: ListTile(
          title: Text(title),
          subtitle: Text('Subtitle'),
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/placeholder_image.jpg'),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height / 1.2);
    var firstStart = Offset(size.width / 5, size.height / 2);
    var firstEnd = Offset(size.width / 2, size.height - 50.0);
    path.quadraticBezierTo(
      firstStart.dx,
      firstStart.dy,
      firstEnd.dx,
      firstEnd.dy,
    );

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    var secondEnd = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(
      secondStart.dx,
      secondStart.dy,
      secondEnd.dx,
      secondEnd.dy,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class StudentSearchDelegate extends SearchDelegate<List<RecipeModel>> {
  final List<RecipeModel> recipes;

  StudentSearchDelegate(this.recipes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, []);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context, query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context, query);
  }

  Widget _buildSearchResults(BuildContext context, String query) {
    final List<RecipeModel> searchResults = recipeListNotifier.value
        .where(
            (recipe) => recipe.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (query.isEmpty) {
      // If the search query is empty, return an empty container
      return Container();
    }

    return ListView.separated(
      itemBuilder: (context, index) {
        final data = searchResults[index];
        return ListTile(
          title: Text(data.name),
          subtitle: Text(data.description),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetail(
                  recipe: data,
                ),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: searchResults.length,
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:recipe_project/db/db_functions.dart';
// import 'package:recipe_project/model/data_model.dart';

// import 'package:recipe_project/screens/add.dart';
// import 'package:recipe_project/screens/breakfast.dart';
// import 'package:recipe_project/screens/desert.dart';
// import 'package:recipe_project/screens/favourites.dart';
// import 'package:recipe_project/screens/maincourse.dart';
// import 'package:recipe_project/screens/recipedetail.dart';
// import 'package:recipe_project/screens/search.dart';
// import 'package:recipe_project/screens/snacks.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//   late TextEditingController _searchController;
//   final List<String> _categories = [
//     'Breakfast',
//     'Main course',
//     'Dessert',
//     'Snacks'
//   ];
//   final LinearGradient _gradient = const LinearGradient(
//     colors: <Color>[
//       Color.fromARGB(255, 136, 255, 1),
//       Colors.lightGreen,
//       Color.fromARGB(255, 207, 228, 18)
//     ],
//   );

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   Future<List<RecipeModel>> getFavoriteRecipes() async {
//     final favoriteBox = await Hive.openBox<RecipeModel>('favorites');
//     final favoriteRecipes = favoriteBox.values.toList();
//     return favoriteRecipes;
//   }

//   Future<void> fetchFavoriteRecipes() async {
//     final favoriteRecipes = await getFavoriteRecipes();
//     // Do something with the fetched favorite recipes if needed
//   }

//   // Other code...
//   @override
//   void initState() {
//     super.initState();
//     _searchController = TextEditingController();

//     getRecipes();
//   }

//  @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: SafeArea(
//       child: Column(
//         children: [
//           Stack(
//             children: [
//               Opacity(
//                 opacity: 0.5,
//                 child: ClipPath(
//                   clipper: WaveClipper(),
//                   child: Container(
//                     color: Color.fromARGB(255, 103, 233, 42),
//                     height: 280,
//                   ),
//                 ),
//               ),
//               ClipPath(
//                 clipper: WaveClipper(),
//                 child: Container(
//                   child: Stack(
//                     children: [
//                       Image.asset(
//                         'assets/WhatsApp Image 2024-03-05 at 19.24.29_3cf7eb7d.jpg',
//                         fit: BoxFit.cover,
//                       ),
//                       Positioned(
//                         left: 75,
//                         bottom: 160,
//                         right: 16,
//                         child: Container(
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Padding(padding: EdgeInsets.all(1.0)),
//                               SizedBox(width: 80.0),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.all(10.0),
//                                     child: Image.asset('assets/PinClipart 2.png'),
//                                   ),
//                                   SizedBox(height: 0.0),
//                                   Padding(
//                                     padding: EdgeInsets.all(1.0),
//                                     child: ShaderMask(
//                                       shaderCallback: (Rect bounds) {
//                                         return _gradient.createShader(bounds);
//                                       },
//                                       child: Text(
//                                         'Freshly\ndropped',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .titleMedium!
//                                             .copyWith(
//                                               fontWeight: FontWeight.w500,
//                                               fontSize: 14,
//                                               foreground: Paint()
//                                                 ..style = PaintingStyle.stroke
//                                                 ..strokeWidth = 2
//                                                 ..color = Colors.green,
//                                             ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         left: 16,
//                         top: 110,
//                         right: 16,
//                         child: Container(
//                           height: 35,
//                           width: 300,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(8),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 2,
//                                 blurRadius: 5,
//                                 offset: Offset(0, 3),
//                               ),
//                             ],
//                           ),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: TextField(
//                                   // controller: _searchController,
//                                   decoration: InputDecoration(
//                                     contentPadding: EdgeInsets.all(10.0),
//                                     hintText: 'Search Dishes/Ingredients',
//                                     border: InputBorder.none,
//                                   ),
//                                 ),
//                               ),
//                               IconButton(
//                                 padding: EdgeInsets.all(1.0),
//                                 onPressed: () {
//                                   showSearch(
//                                     context: context,
//                                     delegate: StudentSearchDelegate(recipeListNotifier.value),
//                                   );
//                                 },
//                                 icon: Icon(Icons.search),
//                                 color: Colors.black54,
//                                 iconSize: 30,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   color: Color.fromARGB(255, 14, 10, 10),
//                   height: 260,
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: Container(
//               margin: EdgeInsets.all(10.0), // Adjust margin as needed
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.green, // Border color
//                   width: 2.0, // Border width
//                 ),
//                 borderRadius: BorderRadius.circular(10.0), // Border radius
//               ),
//               child: GridView.builder(
                
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                  crossAxisCount: 2, 
//                       crossAxisSpacing:10.0, 
//                       mainAxisSpacing: 30.0, 
//                   childAspectRatio: 1.5,
//                 ),
//                 itemCount: _categories.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final category = _categories[index];
//                   String imagePath = '';
//                   switch (category) {
//                     case 'Breakfast':
                    
//                       imagePath = 'assets/fried-egg-food-breakfast-bread-toast-transparent-png-2333981 1.png';
//                       break;
//                     case 'Main course':
//                       imagePath = 'assets/kisspng-vindaloo-butter-chicken-tandoori-chicken-korma-pak-butter-chicken-5b56bdb90a6fc1 1.png';
//                       break;
//                     case 'Dessert':
//                       imagePath = 'assets/ice-cream-cones-chocolate-ice-cream-sundae-ice-cream-73a9a5527f7dba7b8554edfad76a8677 1.png';
//                       break;
//                     case 'Snacks':
//                       imagePath = 'assets/—Pngtree—potato chip oil fried snack_6190931 1.png';
//                       break;
//                   }
//                   return _buildCategoryItem(category, imagePath);
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//     floatingActionButton: FloatingActionButton(
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => AddScreen()),
//         ).then((_) {});
//       },
//       backgroundColor: Color.fromARGB(255, 13, 97, 16),
//       child: Icon(
//         Icons.add,
//         color: Colors.white,
//       ),
//     ),
//   );
// }


// Widget _buildCategoryItem(String category, String imagePath) {
//   return InkWell(
//     onTap: () {
//       // Handle the tap event, e.g., navigate to corresponding screen
//       switch (category) {
//         case 'Breakfast':
//         Navigator.push(context, MaterialPageRoute(  builder: (context) => Breakfast()
//                 ));
//           // Navigate to Breakfast screen
//           break;
//         case 'Main course':
//          Navigator.push(context, MaterialPageRoute(  builder: (context) => Maincourse()
//                 ));
//           // Navigate to Main course screen
//           break;
//         case 'Dessert':
//          Navigator.push(context, MaterialPageRoute(  builder: (context) => Desert()
//                 ));
//           // Navigate to Dessert screen
//           break;
//         case 'Snacks':
//          Navigator.push(context, MaterialPageRoute(  builder: (context) => Snacks()
//                 ));
//           // Navigate to Snacks screen
//           break;
//         default:
//           // Handle other cases if needed
//       }
//     },
//     child: Card(
//       elevation: 5,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             imagePath,
//             width: 100,
//             height: 80,
//           ),
//           SizedBox(height: 8),
//           Text(
//             category,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 14),
//           ),
//         ],
//       ),
//     ),
//   );
// }

//   Widget _buildCard(String title) {
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Card(
//         elevation: 5,
//         child: ListTile(
//           title: Text(title),
//           subtitle: Text('Subtitle'),
//           leading: CircleAvatar(
//             backgroundImage: AssetImage('assets/placeholder_image.jpg'),
//           ),
//           onTap: () {},
//         ),
//       ),
//     );
//   }
// }

// class WaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = new Path();
//     path.lineTo(0, size.height / 1.2);
//     var firstStart = Offset(size.width / 5, size.height / 2);
//     var firstEnd = Offset(size.width / 2, size.height - 50.0);
//     path.quadraticBezierTo(
//       firstStart.dx,
//       firstStart.dy,
//       firstEnd.dx,
//       firstEnd.dy,
//     );

//     var secondStart =
//         Offset(size.width - (size.width / 3.24), size.height - 105);
//     var secondEnd = Offset(size.width, size.height - 20);
//     path.quadraticBezierTo(
//       secondStart.dx,
//       secondStart.dy,
//       secondEnd.dx,
//       secondEnd.dy,
//     );

//     path.lineTo(size.width, 0);
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

// class StudentSearchDelegate extends SearchDelegate<List<RecipeModel>> {
//   final List<RecipeModel> recipes;

//   StudentSearchDelegate(this.recipes);

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, []);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return _buildSearchResults(context, query);
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return _buildSearchResults(context, query);
//   }

//   Widget _buildSearchResults(BuildContext context, String query) {
//     final List<RecipeModel> searchResults = recipeListNotifier.value
//         .where(
//             (recipe) => recipe.name.toLowerCase().contains(query.toLowerCase()))
//         .toList();

//     if (query.isEmpty) {
//       // If the search query is empty, return an empty container
//       return Container();
//     }

//     return ListView.separated(
//       itemBuilder: (context, index) {
//         final data = searchResults[index];
//         return ListTile(
//           title: Text(data.name),
//           subtitle: Text(data.description),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => RecipeDetail(recipe: data,),
//               ),
//             );
//           },
         
//         );
//       },
//       separatorBuilder: (context, index) {
//         return Divider();
//       },
//       itemCount: searchResults.length,
//     );
//   }
// }
