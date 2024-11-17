import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';

import '../../../common/style/app_icons.dart';

class ProcedureSteps extends StatefulWidget {
  const ProcedureSteps({super.key});

  @override
  State<ProcedureSteps> createState() => _ProcedureStepsState();
}

class _ProcedureStepsState extends State<ProcedureSteps> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: 15,
      itemBuilder: (context, index) => Card(
        elevation: 0,
        color: context.colors.primaryContainer,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            minHeight: 0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${context.lang.step} ${index + 1}",
                  style: context.textTheme.labelSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  "Agar siz width ni double.infinity qilib, kenglikni butun ekranga moslashtirmoqchi bo'lsangiz va height esa ichidagi matnga qarab o'sishi kerak  foydalanishingiz kerak. Mana buni qanday amalga oshirishingiz mumkinligi:",
                  style: context.textTheme.labelSmall
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
