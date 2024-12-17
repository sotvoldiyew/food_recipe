  import 'dart:developer';

import 'package:flutter/material.dart';
  import 'package:food_recipe/src/common/utils/context_extension.dart';

  class BuildDynamicList extends StatefulWidget {
    const BuildDynamicList(
        {super.key, required this.title, required this.controllers, required this.onAdd, required this.titles, required this.selectIngredient});

    final String title;
    final List<TextEditingController> controllers;
    final List<String> titles;
    final VoidCallback onAdd;
    final Future<void> Function() selectIngredient;

    @override
    State<BuildDynamicList> createState() => _BuildDynamicListState();
  }

  class _BuildDynamicListState extends State<BuildDynamicList> {
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
            itemCount: widget.controllers.length +1,
            itemBuilder: (context, index) {
              if (index == widget.controllers.length) {
                return MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  height: 50,
                  minWidth: 10,
                  color: context.colors.primary,
                  // onPressed:(){
                  //   log("\n\nwidget title list is Empty? ${widget.titles.isEmpty}\n\n");
                  //     if (widget.controllers.last.text.isNotEmpty
                  //         && widget.titles.last.isNotEmpty || widget.titles.isEmpty) {
                  //       widget.onAdd();
                  //     }
                  // },
                  // onPressed: widget.controllers.isEmpty ||
                  //     widget.controllers.last.text.isNotEmpty &&
                  //         (widget.titles.isEmpty || widget.titles.last.isNotEmpty)
                  //     ? widget.onAdd
                  //     : null,
                  onPressed: widget.onAdd,
                  child: Text(
                    "Add ${widget.title}",
                    style: context.textTheme.labelMedium?.copyWith(color: context.colors.onPrimary),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        // controller: widget.controllers[index],
                        controller:  widget.controllers.length != index ? widget.controllers[index] : TextEditingController(),
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
                    ),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: () async => await widget.selectIngredient(),
                        child: Text(
                          widget.titles.length != index ? widget.titles[index] : "Select Gradients",
                          style: const TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      );
    }
  }
