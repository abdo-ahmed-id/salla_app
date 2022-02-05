import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/app.widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomListTile(
            text: 'المعلومات الشخصية',
            onTap: () {
              Modular.to.pushNamed(AppRoutes.personal);
            },
            icon: Icons.person,
          ),
          CustomListTile(
            text: 'عنوانك',
            onTap: () {},
            icon: Icons.location_on,
          ),
          CustomListTile(
            text: 'طرق الدفع',
            onTap: () {},
            icon: Icons.card_travel,
          ),
        ],
      ),
    ));
  }
}
