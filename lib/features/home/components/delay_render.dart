import 'package:flutter/material.dart';

class DelayRender extends StatefulWidget {
  final Widget child;
  final Widget? loading;
  final int delay;

  const DelayRender({
    super.key,
    required this.child,
    this.delay = 200,
    this.loading,
  });

  @override
  State<DelayRender> createState() => _DelayRenderState();
}

class _DelayRenderState extends State<DelayRender> {
  bool canRender = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.delay), () {
      setState(() {
        canRender = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return canRender //
        ? widget.child
        : widget.loading ?? const SizedBox();
  }
}
