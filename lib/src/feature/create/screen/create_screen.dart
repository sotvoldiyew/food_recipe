import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';
import 'package:food_recipe/src/common/widget/my_text_fild.dart';
import 'package:food_recipe/src/feature/create/bloc/create_bloc.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  late TextEditingController _videoLinkController;
  late TextEditingController _nameController;
  late TextEditingController _videoMinController;
  final List<TextEditingController> _ingredientControllers = [];
  final List<TextEditingController> _stepControllers = [];






  @override
  void initState() {
    super.initState();
    _videoLinkController = TextEditingController();
    _nameController = TextEditingController();
    _videoMinController = TextEditingController();
  }

  @override
  void dispose() {
    _videoLinkController.dispose();
    _nameController.dispose();
    _videoMinController.dispose();
    for (var controller in _ingredientControllers) {
      controller.dispose();
    }
    for (var controller in _stepControllers) {
      controller.dispose();
    }
    super.dispose();
  }


  void _addIngredient() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
    });
  }

  void _addStep() {
    setState(() {
      _stepControllers.add(TextEditingController());
    });
  }



  void _submitRecipe() {
    final List<String> ingredients =
    _ingredientControllers.map((controller) => controller.text.trim()).toList();
    final List<String> steps =
    _stepControllers.map((controller) => controller.text.trim()).toList();

    ingredients.removeWhere((ingredient) => ingredient.isEmpty);
    steps.removeWhere((step) => step.isEmpty);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: context.colors.onPrimary,
        title: const Text("Create Recipe"),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<CreateBloc, CreateState>(
                builder: (context, state) => GestureDetector(
                  onTap: (){
                    context.read<CreateBloc>().add(const ImagePicker$CreateEvent());
                  },
                  child: Container(
                    height: 170,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                    ),
                    child: state.selectedImage != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(state.selectedImage!.path),
                        fit: BoxFit.cover,
                      ),
                    )
                        : Center(
                      child: Text(
                        "Upload Image",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              MyTextFild(controller: _nameController, labelName: context.lang.name),
              const SizedBox(height: 16),
              MyTextFild(controller: _videoLinkController, labelName: context.lang.videoLink),
              const SizedBox(height: 16),
              MyTextFild(controller: _videoMinController, labelName: context.lang.videoMin),
              const SizedBox(height: 16),
              BlocBuilder<CreateBloc, CreateState>(
                builder: (context, state) => GestureDetector(
                  onTap: () async {
                    // ModalBottomSheet ochiladi va tanlangan kategoriya qaytariladi
                    final String? selected = await showModalBottomSheet<String>(
                      context: context,
                      builder: (context) {
                        return ListView(
                          children: state.categories.map((category) {
                            return ListTile(
                              title: Text(category),
                              trailing: state.selectedCategory == category
                                  ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                                  : null,
                              onTap: () => Navigator.pop(context, category),
                            );
                          }).toList(),
                        );
                      },
                    );

                    // Agar kategoriya tanlangan bo‘lsa, BLoC ga yuboriladi
                    if (selected != null) {
                      context.read<CreateBloc>().add(
                        CategorySelecter$CreateEvent(selectedCategory: selected),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.selectedCategory ?? "Select Category",
                          style: TextStyle(
                            color: state.selectedCategory == null ? Colors.grey : Colors.black,
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              _buildDynamicList("Ingredients", _ingredientControllers, _addIngredient),
              const SizedBox(height: 16),
              _buildDynamicList("Steps", _stepControllers, _addStep),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _submitRecipe,
                  child: const Text("Submit Recipe"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicList(
      String title,
      List<TextEditingController> controllers,
      VoidCallback onAdd,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controllers.length + 1,
          itemBuilder: (context, index) {
            if (index == controllers.length) {
              return ElevatedButton(
                onPressed: onAdd,
                child: Text("Add $title"),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                controller: controllers[index],
                decoration: InputDecoration(
                  labelText: "$title ${index + 1}",
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
