import 'package:flutter/material.dart';

class UnorderedList extends StatelessWidget {
  const UnorderedList(this.texts, {super.key});
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (int i = 0; i < texts.length; i++) {
      widgetList.add(UnorderedListItem(texts[i], i + 1));
      widgetList.add(const SizedBox(height: 8.0));
    }
    // for (var text in texts) {}

    return Column(children: widgetList);
  }
}

class UnorderedListItem extends StatelessWidget {
  const UnorderedListItem(this.text, this.index, {super.key});
  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // •
        Text("$index. "),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF6C6C73),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
