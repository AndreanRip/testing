import 'package:flutter/material.dart';
import 'package:latihan_responsi_mobile/model/foodModel.dart';
import 'package:latihan_responsi_mobile/services/foodServices.dart';

class HomePage extends StatelessWidget {
  final foodServices foodService = foodServices();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: foodService.getAllFood(), // Memanggil API untuk mendapatkan data makanan
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Menampilkan CircularProgressIndicator jika sedang memuat data
          return const SafeArea(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // Menampilkan pesan error jika terjadi kesalahan
          return const SafeArea(
            child: Center(
              child: Text("Terjadi kesalahan saat memuat data."),
            ),
          );
        } else if (snapshot.hasData) {
          // Data berhasil didapatkan, proses JSON menjadi FoodModel
          FoodModel foodModel = FoodModel.fromJson(snapshot.data!);

          // Menampilkan data makanan dalam bentuk ListView atau widget lain
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text('Food Menu'),
              ),
              body: ListView.builder(
                itemCount: foodModel.meals.length,
                itemBuilder: (context, index) {
                  Meal meal = foodModel.meals[index];

                  return ListTile(
                    leading: meal.strMealThumb != null
                        ? Image.network(meal.strMealThumb!)
                        : null,
                    title: Text(meal.strMeal),
                    subtitle: Text(meal.strCategory),
                    onTap: () {
                      // Aksi ketika item dipilih (bisa diarahkan ke detail meal)
                    },
                  );
                },
              ),
            ),
          );
        } else {
          // Jika data tidak tersedia
          return const SafeArea(
            child: Center(
              child: Text("Data tidak tersedia"),
            ),
          );
        }
      },
    );
  }
}
