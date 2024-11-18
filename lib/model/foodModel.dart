import 'dart:convert';

// FoodModel untuk representasi data makanan
class FoodModel {
  final List<Meal> meals;

  FoodModel({required this.meals});

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      meals: List<Meal>.from(json['meals'].map((meal) => Meal.fromJson(meal))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meals': meals.map((meal) => meal.toJson()).toList(),
    };
  }
}

// Meal untuk setiap hidangan
class Meal {
  final String idMeal;
  final String strMeal;
  final String? strDrinkAlternate;
  final String strCategory;
  final String strArea;
  final String strInstructions;
  final String? strMealThumb;
  final String? strTags;
  final String? strYoutube;
  final List<Ingredient> ingredients;

  Meal({
    required this.idMeal,
    required this.strMeal,
    this.strDrinkAlternate,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strDrinkAlternate: json['strDrinkAlternate'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strInstructions: json['strInstructions'],
      strMealThumb: json['strMealThumb'],
      strTags: json['strTags'],
      strYoutube: json['strYoutube'],
      ingredients: List<Ingredient>.from(json.keys.where((key) => key.startsWith('strIngredient')).map((key) {
        return Ingredient(
          name: json[key] ?? '',
          measure: json['strMeasure${key.replaceAll('strIngredient', '')}'] ?? '',
        );
      })),
    );
  }

  Map<String, dynamic> toJson() {
    final ingredientsJson = Map.fromIterable(
      ingredients,
      key: (ingredient) => 'strIngredient${ingredient.index}',
      value: (ingredient) => ingredient.name,
    );

    final measuresJson = Map.fromIterable(
      ingredients,
      key: (ingredient) => 'strMeasure${ingredient.index}',
      value: (ingredient) => ingredient.measure,
    );

    return {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strDrinkAlternate': strDrinkAlternate,
      'strCategory': strCategory,
      'strArea': strArea,
      'strInstructions': strInstructions,
      'strMealThumb': strMealThumb,
      'strTags': strTags,
      'strYoutube': strYoutube,
      ...ingredientsJson,
      ...measuresJson,
    };
  }
}

// Ingredient untuk bahan-bahan masakan
class Ingredient {
  final String name;
  final String measure;

  Ingredient({
    required this.name,
    required this.measure,
  });
}

void main() {
  // Contoh parsing dari JSON
  String jsonResponse = '''{
    "meals": [
      {
        "idMeal": "52768",
        "strMeal": "Apple Frangipan Tart",
        "strDrinkAlternate": null,
        "strCategory": "Dessert",
        "strArea": "British",
        "strInstructions": "Preheat the oven to 200C\\/180C Fan\\/Gas 6.\\r\\nPut the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs. Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter. Tip into the tart tin and, using the back of a spoon, press over the base and sides of the tin to give an even layer. Chill in the fridge while you make the filling.\\r\\nCream together the butter and sugar until light and fluffy. You can do this in a food processor if you have one. Process for 2-3 minutes. Mix in the eggs, then add the ground almonds and almond extract and blend until well combined.\\r\\nPeel the apples, and cut thin slices of apple. Do this at the last minute to prevent the apple going brown. Arrange the slices over the biscuit base. Spread the frangipane filling evenly on top. Level the surface and sprinkle with the flaked almonds.\\r\\nBake for 20-25 minutes until golden-brown and set.\\r\\nRemove from the oven and leave to cool for 15 minutes. Remove the sides of the tin. An easy way to do this is to stand the tin on a can of beans and push down gently on the edges of the tin.\\r\\nTransfer the tart, with the tin base attached, to a serving plate. Serve warm with cream, cr\u00e8me fraiche or ice cream.",
        "strMealThumb": "https:\/\/www.themealdb.com\/images\/media\/meals\/wxywrq1468235067.jpg",
        "strTags": "Tart,Baking,Fruity",
        "strYoutube": "https:\/\/www.youtube.com\/watch?v=rp8Slv4INLk",
        "strIngredient1": "digestive biscuits",
        "strIngredient2": "butter",
        "strIngredient3": "Bramley apples",
        "strIngredient4": "butter, softened",
        "strIngredient5": "caster sugar",
        "strIngredient6": "free-range eggs, beaten",
        "strIngredient7": "ground almonds",
        "strIngredient8": "almond extract",
        "strIngredient9": "flaked almonds",
        "strMeasure1": "175g\/6oz",
        "strMeasure2": "75g\/3oz",
        "strMeasure3": "200g\/7oz",
        "strMeasure4": "75g\/3oz",
        "strMeasure5": "75g\/3oz",
        "strMeasure6": "2",
        "strMeasure7": "75g\/3oz",
        "strMeasure8": "1 tsp",
        "strMeasure9": "50g\/1\u00beoz"
      }
    ]
  }''';

  // Parse JSON
  Map<String, dynamic> jsonMap = jsonDecode(jsonResponse);
  FoodModel foodModel = FoodModel.fromJson(jsonMap);

  // Cetak hasil
  print('Meal: ${foodModel.meals[0].strMeal}');
  print('Ingredients: ${foodModel.meals[0].ingredients[0].name}');
}
