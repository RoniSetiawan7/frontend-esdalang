import 'package:esdalang_app/widgets/appbar.dart';
import 'package:esdalang_app/widgets/background.dart';
import 'package:esdalang_app/widgets/grid.dart';
import 'package:flutter/material.dart';

class MenuKurikulum extends StatelessWidget {
  const MenuKurikulum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context: context, title: 'Menu Kurikulum'),
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
                imageUrl: 'assets/icons/kurikulum.png',
                onTap: () =>
                    Navigator.pushNamed(context, '/listKurikulumKelas7'),
              ),
              MyGrid(
                text: 'Kelas Delapan',
                imageUrl: 'assets/icons/kurikulum.png',
                onTap: () =>
                    Navigator.pushNamed(context, '/listKurikulumKelas8'),
              ),
              MyGrid(
                text: 'Kelas Sembilan',
                imageUrl: 'assets/icons/kurikulum.png',
                onTap: () =>
                    Navigator.pushNamed(context, '/listKurikulumKelas9'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
