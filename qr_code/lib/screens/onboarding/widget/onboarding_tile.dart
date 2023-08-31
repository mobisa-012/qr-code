// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class OnboardingTile extends StatelessWidget {
  final title, image, description;

  const OnboardingTile({super.key, this.title, this.image, this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.grey
          ),
        ),
        const SizedBox(height: 10,),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16
          ),
        )
      ],
    );
  }
}
