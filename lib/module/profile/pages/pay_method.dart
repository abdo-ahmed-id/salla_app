import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/notifications.dart';

class PayMethodPage extends StatefulWidget {
  const PayMethodPage({Key key}) : super(key: key);

  @override
  _PayMethodPageState createState() => _PayMethodPageState();
}

class _PayMethodPageState extends State<PayMethodPage> {
  String _radioValue; //Initial definition of radio button value
  String choice;

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 'one':
          choice = value;
          break;
        case 'two':
          choice = value;
          break;
        case 'three':
          choice = value;
          break;
        default:
          choice = null;
      }
      debugPrint(choice); //Debug the choice in console
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          'طرق الدفع',
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50.h),
          ListTile(
            title: Text(
              'الدفع عند الاستلام',
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            leading: Radio(
              activeColor: AppTheme.primaryColor,
              value: 'two',
              groupValue: _radioValue,
              onChanged: radioButtonChanges,
            ),
          ),
          InkWell(
            onTap: () {
              Notifications.success('هذه الخدمة سوف تكون متاحة قريبا');
            },
            child: ListTile(
              title: Text(
                'الدفع باستخدام بطاقات الائتمان',
                style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
