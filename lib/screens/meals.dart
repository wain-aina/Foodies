import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key, 
    this.title, 
    required this.meals,
    required this.onToggleFavorite
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

  void _onSelectMeal(BuildContext context, Meal meal){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealDetailsScreen(
        onToggleFavorite: onToggleFavorite,
        meal: meal,
      )
    ));
  }

  @override
  Widget build(context){
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index)=>
        MealItem(
          meal: meals[index], 
          onSelectMeal: (meal){
            _onSelectMeal(context, meal);
          },)
    );

    if(meals.isEmpty){
      content = Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              Text('Nothing Here', style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground
              ),),
              
              const SizedBox(height: 16,),
              Text(
                "Try another Category", 
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground
                ),)
            ],
          ),
        );
    }

    if(title == null){
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}