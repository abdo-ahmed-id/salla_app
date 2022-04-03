import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/data/models/users.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/app.widget.dart';
import 'package:salla_app/helper/assets.helper.dart';

class ChatPage extends StatelessWidget {
  final UserModel user;

  const ChatPage({this.user});

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: massage(
                      bottomLeft: 0.0, bottomRight: 10.0, color: Colors.grey),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: massage(
                      bottomLeft: 10.0,
                      bottomRight: 0.0,
                      color: AppTheme.primaryColor),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: PrimaryTextField(
                      hintText: 'اترك رسالتك هنا',
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send,
                        color: AppTheme.primaryColor,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget massage({num bottomLeft, num bottomRight, Color color}) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Hello Worlld',
          style: GoogleFonts.cairo(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
