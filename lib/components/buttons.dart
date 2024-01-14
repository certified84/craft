import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vector_graphics/vector_graphics.dart';
import '../../theme/colors.dart' as craft_colors;

Widget defaultButton({
  required double width,
  required String text,
  Color? backgroundColor,
  Color? textColor,
  void Function()? onPressed,
}) {
  return SizedBox(
    // margin: const EdgeInsets.only(top: 24),
    width: width,
    height: 50,
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor ?? craft_colors.Colors.onBackground,
        side: const BorderSide(width: 0.01),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? craft_colors.Colors.onPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          fontFamily: "SpaceGrotesk",
        ),
      ),
    ),
  );
}

Widget defaultOutlinedButton({
  required double width,
  required String text,
  Color? borderColor,
  Color? textColor,
  void Function()? onPressed,
}) {
  return SizedBox(
    // margin: const EdgeInsets.only(top: 24),
    width: width,
    height: 50,
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: borderColor ?? craft_colors.Colors.onBackground,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? craft_colors.Colors.onPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    ),
  );
}

Widget googleButton({
  required double width,
  required bool signin,
  void Function()? onPressed,
}) {
  return SizedBox(
    width: width,
    height: 50,
    child: OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          craft_colors.Colors.white,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SvgPicture(
            AssetBytesLoader('assets/svgs/google_icon.svg.vec'),
            semanticsLabel: 'Google Icon',
          ),
          const SizedBox(width: 8),
          Text(
            signin ? "Sign in with Google" : "Sign up with Google",
            style: const TextStyle(
              color: craft_colors.Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget appleButton({
  required double width,
  required bool signin,
  void Function()? onPressed,
}) {
  return SizedBox(
    width: width,
    height: 50,
    child: OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          craft_colors.Colors.white,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SvgPicture(
            AssetBytesLoader('assets/svgs/apple_icon.svg.vec'),
            semanticsLabel: 'Google Icon',
          ),
          const SizedBox(width: 8),
          Text(
            signin ? "Sign in with Apple" : "Sign up with Apple",
            style: const TextStyle(
              color: craft_colors.Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}
