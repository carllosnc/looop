import 'package:flutter/material.dart';

extension StringComponent on String {
  Text get featuredText {
    return Text(
      this,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        color: Colors.black.withOpacity(0.8),
      ),
    );
  }

  Text get text {
    return Text(this, style: const TextStyle());
  }

  Text get pageTitle {
    return Text(
      toUpperCase(),
      style: TextStyle(
        fontSize: 14,
        letterSpacing: 1.4,
        fontWeight: FontWeight.bold,
        color: Colors.black.withOpacity(0.8),
      ),
    );
  }

  Text get bigEmoji {
    return Text(
      this,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 100,
      ),
    );
  }
}

extension TextComponent on Text {
  SizedBox size(double width) {
    return SizedBox(
      width: width,
      child: this,
    );
  }

  Text color(Color color) {
    return Text(
      data as String,
      style: style?.copyWith(color: color),
    );
  }

  Text get bold {
    return Text(
      data as String,
      style: style?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Text get italic {
    return Text(
      data as String,
      style: style?.copyWith(fontStyle: FontStyle.italic),
    );
  }

  Text fontSize(double size) {
    return Text(
      data as String,
      style: style?.copyWith(fontSize: size),
    );
  }

  Text height(double height) {
    return Text(
      data as String,
      style: style?.copyWith(height: height),
    );
  }

  Text get textCenter {
    return Text(
      data as String,
      textAlign: TextAlign.center,
    );
  }
}
