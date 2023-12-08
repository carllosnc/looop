import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/imports/app.dart';
import 'package:vw/vw.dart';

class EmojiSelect extends StatefulWidget {
  const EmojiSelect({
    super.key,
  });

  @override
  State<EmojiSelect> createState() => _EmojiSelectState();
}

class _EmojiSelectState extends State<EmojiSelect> {
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return VWColumn(
      gap: 5,
      children: [
        VWRow(
          padding: const EdgeInsets.all(10),
          horizontalAlignment: MainAxisAlignment.center,
          verticalAlignment: CrossAxisAlignment.center,
          gap: 5,
          children: [
            const Text(
              "Select icon:",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              emojis[isSelected],
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
        Boxy(
          height: 200,
          child: GridView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 60,
              mainAxisExtent: 60,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            children: [
              for (String item in emojis)
                Boxy(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  splashColor: Colors.transparent,
                  border: isSelected == emojis.indexOf(item) ? Border.all(color: Colors.black, width: 2) : null,
                  onTap: () {
                    setState(() {
                      isSelected = emojis.indexOf(item);
                    });
                  },
                  child: Center(
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
