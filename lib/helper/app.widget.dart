import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salla_app/helper/app.theme.dart';
import 'package:salla_app/helper/assets.helper.dart';
import 'package:salla_app/module/app/bloc/app.bloc.dart';
import 'package:salla_app/module/app/bloc/app.state.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String imageUrl;
  CustomCircleAvatar({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        placeholder: (context, url) => Center(
            child: Image.asset(
          AssetsHelper.engineImage,
          fit: BoxFit.fill,
        )),
        errorWidget: (context, url, error) {
          print('cached error:$error');
          return Image.asset(
            AssetsHelper.bataryImage,
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }
}

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;

  CustomCachedImage({Key key, this.imageUrl, this.width, this.height, this.fit})
      : super(key: key);
  final AppState state = Modular.get<AppBloc>().state;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholderFadeInDuration: Duration(seconds: 2),
      imageUrl: imageUrl,
      placeholder: (context, url) =>
          Center(child: Image.asset(AssetsHelper.bataryImage)),
      errorWidget: (context, url, error) {
        print('cached error:$error');
        return Icon(
          Icons.error,
          color: Colors.red,
          size: 30,
        );
      },
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key key,
    this.text,
    this.onTap,
    this.icon,
  }) : super(key: key);
  final String text;
  final Function onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24.sp,
      ),
      title: Text(
        text,
        style: GoogleFonts.cairo(color: Colors.black, fontSize: 17.sp),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_sharp,
        color: AppTheme.primaryColor,
        size: 24.sp,
      ),
      onTap: onTap,
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Function onPressed;

  CustomButton(
      {this.text, this.backgroundColor, this.textColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 50,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.cairo(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor ?? Colors.black),
        ),
        style: OutlinedButton.styleFrom(
            backgroundColor: backgroundColor ?? Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Function onPressed;
  final int width;
  final int height;

  const GradientButton(
      {this.text,
      this.backgroundColor,
      this.textColor,
      this.onPressed,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [AppTheme.primaryColor, Colors.orange[400]],
        ),
      ),
      width: width ?? 240,
      height: height ?? 50,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.cairo(
              fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
        ),
        style: OutlinedButton.styleFrom(
            // backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final Function onPressed;
  final String name;

  const SocialButton({this.onPressed, this.name});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Image.asset(name),
      style:
          OutlinedButton.styleFrom(backgroundColor: AppTheme.backgroundColor),
    );
  }
}

class CustomTextForm extends StatelessWidget {
  final String hintText;
  final String labelText;
  final String initialValue;
  final bool obscureText;
  final TextInputType keyboardType;
  final Function onChanged;
  final Function validator;
  final bool readOnly;
  final Function onTap;
  final TextEditingController controller;
  final Color color;
  final int maxLength;

  const CustomTextForm(
      {this.initialValue,
      this.maxLength,
      this.hintText,
      this.obscureText = false,
      this.readOnly = false,
      this.keyboardType,
      this.onChanged,
      this.validator,
      this.controller,
      this.onTap,
      this.labelText,
      this.color});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      readOnly: readOnly,
      onTap: onTap,
      initialValue: initialValue,
      controller: controller,
      style: GoogleFonts.cairo(
          fontSize: 20,
          color: color ?? Theme.of(context).accentColor,
          height: 1),
      onChanged: onChanged,
      decoration: InputDecoration(
        focusColor: Theme.of(context).accentColor,
        // fillColor: AppTheme.secondaryColor,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: color ?? Theme.of(context).accentColor,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;
  final double size;

  const CustomTextButton({this.text, this.onPressed, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            color: color ?? Colors.white,
            fontSize: size,
          ),
        ));
  }
}

class CustomLikeButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const CustomLikeButton({Key key, this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            color: AppTheme.secondaryColor,
            icon: Icon(icon),
            onPressed: () {},
          ),
          Text(
            text,
            style: GoogleFonts.cairo(
                color: AppTheme.secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class PrimaryTextField extends StatelessWidget {
  final String hintText;
  final String initialValue;
  final bool obscureText;
  final bool readOnly;
  final TextInputType keyboardType;
  final Function onChanged;
  final Function onTap;
  final TextEditingController controller;
  final int maxLength;
  final int maxLines;

  const PrimaryTextField(
      {this.hintText,
      this.maxLength,
      this.maxLines,
      this.obscureText = false,
      this.keyboardType,
      this.onChanged,
      this.initialValue,
      this.controller,
      this.onTap,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      maxLength: maxLength,
      readOnly: readOnly,
      onTap: onTap,
      controller: controller,
      initialValue: initialValue,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      style: TextStyle(
        height: 1,
        fontSize: 18,
        color: Theme.of(context).accentColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).accentColor,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}

/*class DateInput extends StatefulWidget {
  final String hintText;
  final String initValue;
  final ValueChanged<String> onChange;

  const DateInput({Key key, this.hintText, this.initValue, this.onChange})
      : super(key: key);

  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryTextField(
      readOnly: true,
      controller: _controller,
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now().subtract(Duration(days: 365 * 6)),
          firstDate: DateTime.parse('1950-10-08'),
          lastDate: DateTime.now().subtract(Duration(days: 365 * 6)),
        ).then((date) {
          String value = DateFormat.yMMMd().format(date);
          _controller.text = value;
          widget.onChange(value);
        });
      },
      hintText: widget.hintText,
      keyboardType: TextInputType.number,
    );
  }
}*/
