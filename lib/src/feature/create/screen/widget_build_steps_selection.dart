


import 'package:flutter/material.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';

class BuildDynamicSteps extends StatefulWidget {
  const BuildDynamicSteps({super.key, required this.title, required this.controllers, required this.onAdd});
  final String title;
  final List<TextEditingController> controllers;
  final VoidCallback onAdd;

  @override
  State<BuildDynamicSteps> createState() => _BuildDynamicStepsState();
}

class _BuildDynamicStepsState extends State<BuildDynamicSteps> {
  String? newTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.controllers.length + 1,
          itemBuilder: (context, index) {
            if (index == widget.controllers.length) {
              return MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                height: 50,
                minWidth: 10,
                color: context.colors.primary,
                onPressed: widget.onAdd,
                child: Text(
                  "Add ${widget.title}",
                  style: context.textTheme.labelMedium?.copyWith(color: context.colors.onPrimary),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                controller: widget.controllers[index],
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: context.colors.primary,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1.5,
                    ),
                  ),
                  filled: true,
                  fillColor: context.colors.primaryContainer,
                  labelText: "${widget.title} ${index + 1}",
                  labelStyle: context.textTheme.titleMedium?.copyWith(color: Colors.grey.shade400),
                  border: const OutlineInputBorder(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
