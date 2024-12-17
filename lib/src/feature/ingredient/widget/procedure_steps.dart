import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';

import '../data/steps_model.dart';

class ProcedureSteps extends StatefulWidget {
  const ProcedureSteps({super.key, required this.list});
  final List<Datumm> list;

  @override
  State<ProcedureSteps> createState() => _ProcedureStepsState();
}

class _ProcedureStepsState extends State<ProcedureSteps> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.list.length,
      itemBuilder: (context, index){
        final model = widget.list[index];
        return Card(
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
                    model.text.toString(),
                    style: context.textTheme.labelSmall
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
