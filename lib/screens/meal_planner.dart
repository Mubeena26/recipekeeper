import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:recipe_project/db/db_functions.dart';
import 'package:recipe_project/model/data_model.dart';
import 'package:recipe_project/screens/add_meal.dart';

class AddMealplanner extends StatefulWidget {
  const AddMealplanner({Key? key}) : super(key: key);

  @override
  _AddMealplannerState createState() => _AddMealplannerState();
}

class _AddMealplannerState extends State<AddMealplanner> {
  DateTime _selectedDate = DateTime.now();
  List<Meal> _meals = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchMeals(_selectedDate);
    getMealsForDate(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    _fetchMeals(_selectedDate);
    getMealsForDate(_selectedDate);
    return Scaffold(
        body: SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(_selectedDate),
                  style: headingStyle,
                ),
                Text(
                  'Today',
                  style: subheadingStyle,
                ),
              ],
            ),
            SizedBox(
              width: 80,
            ),
            ElevatedButton(
              onPressed: () async {
                final selectedDate = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddMeal(selectedDate: _selectedDate)),
                );
                if (selectedDate != null) {
                  _selectedDate = selectedDate;
                  _fetchMeals(_selectedDate);
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: Colors.green,
              ),
              child: Text(
                "+Add Meal",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, left: 20),
          child: DatePicker(
            DateTime.now(),
            height: 100,
            width: 80,
            initialSelectedDate: DateTime.now(),
            selectionColor: Colors.green,
            selectedTextColor: Colors.white,
            dateTextStyle: GoogleFonts.lato(
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            onDateChange: (date) {
              setState(() {
                _selectedDate = date;
                _fetchMeals(date);
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _meals.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_meals[index].meal),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Recipe: ${_meals[index].recipe}"),
                    Text("Size: ${_meals[index].size}"),
                    Text("Notes: ${_meals[index].notes}"),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    deleteMeal(_meals[index]);
                    _fetchMeals(_selectedDate);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Meal deleted successfully'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: Icon(Icons.delete),
                ),
              );
            },
          ),
        ),
      ]),
    ));
  }

  TextStyle get headingStyle {
    return GoogleFonts.lato(
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black38,
      ),
    );
  }

  TextStyle get subheadingStyle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  void _fetchMeals(DateTime date) async {
    List<Meal> meals = await getMealsForDate(date);
    setState(() {
      _meals = meals;
    });
  }
}
