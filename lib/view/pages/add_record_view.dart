import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/meal.dart';
import '../../theme.dart';
import '../widgets/meal_card.dart';

class AddRecord extends StatefulWidget{
  @override
  _RecordState createState() => _RecordState();

}


class _RecordState extends State<AddRecord>{

  List<String> months = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro"
  ];

  List<Meal> meals = [
    Meal.incomplete("Pequeno Almoço"),
    Meal.incomplete("Lanche da Manhã"),
    Meal.incomplete("Almoço"),
    Meal.incomplete("Lanche"),
    Meal.incomplete("Jantar"),
    Meal.incomplete("Ceia")
  ];

  @override
  Widget build(BuildContext context) {
    String title = DateTime.now().day.toString() + " de " + months[DateTime.now().month-1];
    return Scaffold(
      appBar: AppBar(
        elevation:0.0,
        centerTitle: true,
        title: Text(title, style: const TextStyle(color: Colors.white,
        fontFamily: 'Mulish',
          fontSize: 20.0,
        )),
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          expandedHeaderPadding: EdgeInsets.all(0),
          elevation: 0,
          dividerColor: mainColor,
          children: meals
          .map((meal) => ExpansionPanelRadio(
              canTapOnHeader: true,
              value: meal.meal,
              headerBuilder: (context, isExpanded) =>
              ListTile(
                title: Text(meal.meal,
                style: const TextStyle(fontSize: 18, color: textGrayColor),),
              ),
              body: MealCard(meal: meal)))
          .toList(),
        ),
      )
    );
  }

}