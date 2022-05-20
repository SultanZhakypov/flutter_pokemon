import 'package:flutter/material.dart';

import 'package:pokemon/resources/app_colors.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField({
    Key? key,
    required this.inSearch,
  }) : super(key: key);

  final TextEditingController inSearch;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inSearch,
      style: const TextStyle(
        color: AppColors.color97BFB4,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        hintText: 'Search here ...',
        fillColor: AppColors.color43403F,
        filled: true,
        hintStyle: const TextStyle(
          color: AppColors.color97BFB4,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }
}
