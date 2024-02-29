import 'package:flutter/material.dart';
import '/imports/app.dart';

class EmojiSelect extends StatefulWidget {
  final String? Function(String?)? validator;
  final Function(String?) onChanged;
  final TextStyle? style;
  final String? initialValue;

  const EmojiSelect({
    super.key,
    this.validator,
    this.style,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<EmojiSelect> createState() => _EmojiSelectState();
}

class _EmojiSelectState extends State<EmojiSelect> {
  int isSelected = 0;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.initialValue != null) {
      controller.text = widget.initialValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      validator: widget.validator,
      controller: controller,
      style: widget.style,
      decoration: const InputDecoration(
        labelText: "Icon",
        floatingLabelAlignment: FloatingLabelAlignment.start,
        suffixIcon: Icon(Icons.emoji_emotions_outlined),
      ),
      onTap: () {
        showModalBottomSheet(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          context: context,
          builder: (context) {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
              ),
              itemCount: emojis.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = index;
                    });

                    controller.text = emojis[index];
                    widget.onChanged(emojis[index]);
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: isSelected == index ? Colors.black : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        emojis[index],
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
