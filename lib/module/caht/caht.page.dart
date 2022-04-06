import 'package:firestore_model/firestore_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salla_app/data/models/massage.dart';
import 'package:salla_app/data/models/users.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/assets.helper.dart';
import 'package:salla_app/helper/constants.dart';
import 'package:salla_app/module/caht/chat.widget.dart';

import '../app/bloc/app.bloc.dart';

class ChatPage extends StatelessWidget {
  // final UserModel user;
  UserModel currentUser = Modular.get<AppBloc>().state.user;

  String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              AssetsHelper.backgroundImage,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              ModelStreamGetBuilder<Massage>(
                  query: (q) => q.orderBy('createdAt', descending: false),
                  parentModel: currentUser,
                  onSuccess: (massages) {
                    return Expanded(
                      flex: 12,
                      child: ListView.separated(
                        itemCount: massages.length,
                        itemBuilder: (context, index) {
                          Massage massage = massages[index];

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: massage.senderId == currentUser.docId
                                ? SeMassageWidget(
                                    text: massage.text,
                                  )
                                : ReMassageWidget(
                                    text: massage.text,
                                  ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 10);
                        },
                      ),
                    );
                  }),
              // Spacer(),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: PrimaryTextField(
                        onChanged: (value) {
                          text = value;
                        },
                        hintText: 'اترك رسالتك هنا',
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () async {
                          Massage massage =
                              currentUser.subCollection<Massage>();
                          massage.text = text;
                          massage.senderId = currentUser.docId;
                          await massage.create();
                          UserModel reUser =
                              await FirestoreModel.use<UserModel>()
                                  .find(Constants.adminId);
                          Massage massage2 = reUser.subCollection<Massage>();
                          massage2.text = text;
                          massage2.senderId = currentUser.docId;
                          massage2.receiverId = reUser.docId;
                          await massage2.create();
                        },
                        icon: Icon(
                          Icons.send,
                          color: AppTheme.primaryColor,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
