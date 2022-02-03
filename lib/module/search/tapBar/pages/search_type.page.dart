import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salla_app/data/models/category.dart';
import 'package:salla_app/helper/app.routes.dart';
import 'package:salla_app/helper/app.widget.dart';

class SearchType extends StatefulWidget {
  @override
  State<SearchType> createState() => _SearchTypeState();
}

class _SearchTypeState extends State<SearchType> {
  TextEditingController _textEditingController = TextEditingController();
  String searchValue = '';
  @override
  Widget build(BuildContext context) {
    return ModelStreamGetBuilder<Category>(
        // query: (q) =>
        //     q.where('description', isGreaterThanOrEqualTo: searchValue),
        builder: (
      context,
      snapshot,
    ) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextForm(
                controller: _textEditingController,
                onChanged: (value) {
                  setState(() {
                    searchValue = value;
                    print(searchValue.length);
                    print(searchValue);
                  });
                },
                hintText: 'Search',
              ),
              SizedBox(
                height: 8.h,
              ),
              searchValue.length >= 1
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            String titleList = snapshot.data[index].title;

                            Category category = snapshot.data[index];
                            if (titleList.contains(searchValue)) {
                              return InkWell(
                                onTap: () {
                                  Modular.to.pushNamed(AppRoutes.category,
                                      arguments: category);
                                },
                                child: Card(
                                    elevation: 4,
                                    // margin: EdgeInsets.all(20),
                                    color: Colors.grey[200],
                                    child: ListTile(
                                      title: Text(category.title),
                                      leading: CircleAvatar(),
                                    )),
                              );
                            }
                            return SizedBox();
                          }),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      );
    });
  }
}
