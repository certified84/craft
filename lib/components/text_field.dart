import 'package:flutter/material.dart';
import '../../../theme/colors.dart' as craft_colors;

class FacilityInput extends StatelessWidget {
  const FacilityInput(
      {super.key,
      this.hintText,
      this.value,
      this.autofocus,
      this.onChanged,
      this.onEditingComplete});
  final String? hintText;
  final String? value;
  final Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final bool? autofocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: craft_colors.Colors.primary,
          width: 2,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        style: const TextStyle(
          fontFamily: "SpaceGrotesk",
        ),
        autofocus: autofocus ?? false,
        cursorColor: craft_colors.Colors.primary,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          icon: Container(
            width: 15,
            height: 15,
            color: craft_colors.Colors.primary,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xFF6C6C73),
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontFamily: "SpaceGrotesk",
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 0.01,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 0.01,
            ),
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              borderSide: BorderSide(width: 0.01)),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
