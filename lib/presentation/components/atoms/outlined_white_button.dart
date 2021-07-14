import 'package:flutter/material.dart';

class OutlinedWhiteButton extends StatelessWidget {
  const OutlinedWhiteButton({
    Key? key,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          side: const BorderSide(color: Colors.white),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
