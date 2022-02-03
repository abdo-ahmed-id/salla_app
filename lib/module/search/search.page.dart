import 'package:flutter/material.dart';
import 'package:salla_app/module/search/tapBar/search_main_tabBar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SearchTabBarWidget(),
    );
  }
}
