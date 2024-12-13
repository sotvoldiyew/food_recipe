import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/common/constants/constants.dart';
import 'package:food_recipe/src/common/service/new_dio_service.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';
import 'package:food_recipe/src/common/widget/my_text_fild.dart';
import 'package:food_recipe/src/feature/create/bloc/create_bloc.dart';
import 'package:food_recipe/src/feature/create/data/ingradient_model.dart';
import 'package:food_recipe/src/feature/create/data/post_recipe_model.dart';
import 'package:food_recipe/src/feature/create/screen/widget_build_ingredient_selection.dart';
import 'package:food_recipe/src/feature/create/screen/widget_build_steps_selection.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  TextEditingController stepsCtrl = TextEditingController();
  TextEditingController ingCtrl = TextEditingController();
  TextEditingController ctrl = TextEditingController();
  late TextEditingController _videoLinkController;
  late TextEditingController _nameController;
  late TextEditingController _videoMinController;
  final List<TextEditingController> _ingredientControllers = [];
  final List<TextEditingController> _stepControllers = [];
  final List<String> selectedIngredients = [];

  List<IngredientList> ingredients = [];
  List<StepsList> stepsItems = [];


  String? selected;
  int? categoryId;

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
      _ingredientControllers.add(ingCtrl);
      ingredients.add(IngredientList(ingredientQuantity: ingCtrl.text, ingredientId: _ingredientControllers.length+1));
    });
  }

  void _addStep() {
    setState(() {
      _stepControllers.add((stepsCtrl));
      stepsItems.add(StepsList(text: stepsCtrl.text, stepNumber: _stepControllers.length+1));
    });
  }

  void _submitRecipe(
      {required File file,
      required List<IngredientList> ingredient,
      required List<StepsList> stepsItems,
      required String title,
      required String desc,
      required String cookingTime,
      required int categoryId,
      required String videoUrl}) async {
    log("submit func");
    final List<String> ingredients = _ingredientControllers.map((controller) => controller.text.trim()).toList();
    final List<String> steps = _stepControllers.map((controller) => controller.text.trim()).toList();
    ingredients.removeWhere((ingredient) => ingredient.isEmpty);
    steps.removeWhere((step) => step.isEmpty);

    PostRecipeModel model = PostRecipeModel(
      title: title,
      description: desc,
      cookingTime: cookingTime,
      categoryId: categoryId,
      videoUrl: videoUrl,
      ingredientList: ingredient,
      stepsList: stepsItems,
    );

    log("model desc: ${model.description}");
    log("model step List: ${model.ingredientList}");
    log("model ingredient list: ${model.stepsList}");
    log("video url ${model.videoUrl}");
    await createNewRecipe(data: model.toJson(), file: file);
  }

  Future<void> createNewRecipe({required Map<String, Object?> data, required File file}) async {
    log("\n\ncreateNewRecipe post func\n\n\n");
    // String? result = await NetworkService.post(api: Urls.addOneRecipe, context: context, data: data);

    String? result = await NetworkService.sendMultipartRequest(api: Urls.addOneRecipe, context: context, jsonData: data, file: file);
    log("create page result $result");
    if (result != null) {
      log("Successfully post data in create new Recipe");
    } else {
      log("something went wring at post new recipe");
    }
  }

  void selectIngredient() async {
    String? result = await NetworkService.get(Urls.getAllIngredients, {}, context);
    String? newTitle;
    if (result != null) {
      log("\n\ningradients != null  result: $result \n\n");
      final model = ingradientModelFromJson(result);
      showDialog(
        context: context,
        builder: (context) {
          String? selectedTitle = ""; // Temporary variable for dialog
          return StatefulBuilder(
            builder: (context, setDialogState) {
              return AlertDialog(
                title: Text(selectedTitle ?? 'Select one Ingredient'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(model.data!.length, (index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            // Update the title inside the dialog
                            setDialogState(() {
                              selectedTitle = model.data![index].name;
                            });
                          },
                          title: Text("${model.data![index].name}"),
                        ),
                      );
                    }),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        newTitle = selectedTitle;
                        selectedIngredients.add(newTitle!);
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Select'),
                  ),
                ],
              );
            },
          );
        },
      );
      setState(() {});
    } else {
      log("\n\n\ningradients == null\n\n\n");
    }
    setState(() {});
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
                  onTap: () {
                    context
                        .read<CreateBloc>()
                        .add(const ImagePicker$CreateEvent());
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
                   selected = await showModalBottomSheet<String>(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...List.generate(state.categories.length, (index){
                              final item = state.categories[index];
                              categoryId = index+1;
                                return ListTile(
                                  title: Text(item),
                                  trailing: state.selectedCategory == item ? Icon(Icons.check, color: Theme.of(context).primaryColor) : null,
                                  onTap: () => Navigator.pop(context, item),
                                );
                            })
                            // state.categories.map((category) {
                            //   return ListTile(
                            //     title: Text(category),
                            //     trailing: state.selectedCategory == category ? Icon(Icons.check, color: Theme.of(context).primaryColor) : null,
                            //     onTap: () => Navigator.pop(context, category),
                            //   );
                            // }).toList()
                          ],
                        );
                      },
                    );

                    if (selected != null) {
                      context.read<CreateBloc>().add(
                            CategorySelecter$CreateEvent(selectedCategory: selected!),
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
              BuildDynamicList(
                title: "Ingredients",
                controllers: _ingredientControllers,
                onAdd: _addIngredient,
                titles: selectedIngredients,
                selectIngredient: () async {
                  selectIngredient();
                  log("list item count => ${selectedIngredients.length}");
                },
              ),
              const SizedBox(height: 16),
              BuildDynamicSteps(
                title: "Steps",
                controllers: _stepControllers,
                onAdd: _addStep,
              ),
              const SizedBox(height: 24),
              BlocBuilder<CreateBloc, CreateState>(
                builder: (context, state) {
                  return Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        File file = File(state.selectedImage!.path);


                        _submitRecipe(
                          file: file,
                          ingredient: ingredients,
                          stepsItems: stepsItems,
                          title: _nameController.text,
                          desc: "desc",
                          cookingTime: _videoMinController.text,
                          categoryId: categoryId!,
                          videoUrl: _videoLinkController.text,
                        );
                        log("Show all data ");
                        log("${_ingredientControllers}");
                        log("${_stepControllers}");
                        log("${selectedIngredients}");
                      },
                      child: const Text("Submit Recipe"),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
