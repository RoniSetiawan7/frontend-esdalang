import 'package:esdalang_app/widgets/appbar.dart';
import 'package:esdalang_app/widgets/background.dart';
import 'package:esdalang_app/widgets/grid.dart';
import 'package:flutter/material.dart';

class MenuMateri extends StatelessWidget {
  const MenuMateri({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context: context, title: 'Menu Materi'),
      body: SafeArea(
        child: MyBackground(
          padding: const EdgeInsets.all(16),
          child: GridView.extent(
            maxCrossAxisExtent: 400,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2,
            children: [
              MyGrid(
                text: 'Kelas Tujuh',
                imageUrl: 'assets/icons/materi.png',
                onTap: () => Navigator.pushNamed(context, '/listMateriKelas7'),
              ),
              MyGrid(
                text: 'Kelas Delapan',
                imageUrl: 'assets/icons/materi.png',
                onTap: () => Navigator.pushNamed(context, '/listMateriKelas8'),
              ),
              MyGrid(
                text: 'Kelas Sembilan',
                imageUrl: 'assets/icons/materi.png',
                onTap: () => Navigator.pushNamed(context, '/listMateriKelas9'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
