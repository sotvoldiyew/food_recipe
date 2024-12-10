import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/common/router/app_router.dart';
import 'package:food_recipe/src/common/style/app_images.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:food_recipe/src/common/widget/my_text_fild.dart';
import 'package:go_router/go_router.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  int maxLines = 1;

  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _roleController = TextEditingController();
  late TextEditingController _countryController = TextEditingController();
  late TextEditingController _cityController = TextEditingController();
  late TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _cityController = TextEditingController();
    _countryController = TextEditingController();
    _roleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _descriptionController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onPrimary,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: BackButton(onPressed: () {
          context.pop(AppRouter.profile);
        }),
        backgroundColor: context.colors.onPrimary,
        centerTitle: true,
        title: Text(
          context.lang.editProfile,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: ListView(
            children: [
              const SizedBox(height: 15),
              Center(
                child: Stack(
                  children: [
                    BlocBuilder<EditProfileBloc, EditProfileState>(
                      builder: (context, state) => CircleAvatar(
                        radius: 80,
                        backgroundImage: state.selectedImage != null
                            ? FileImage(
                                File(state.selectedImage!.path),
                              )
                            : const AssetImage(AppImages.profileImage)
                                as ImageProvider,
                      ),
                    ),
                    Positioned(
                      right: 4,
                      top: 4,
                      child: SizedBox(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: context.colors.onPrimary,
                          ),
                          child: IconButton(
                            style: const ButtonStyle(
                              padding: WidgetStatePropertyAll(EdgeInsets.zero),
                            ),
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              context
                                  .read<EditProfileBloc>()
                                  .add(const ImagePicker$EditProfileEvent());
                            },
                            icon: const Icon(
                              size: 30,
                              Icons.edit,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              MyTextFild(
                controller: _nameController,
                labelName: context.lang.name,
              ),
              const SizedBox(height: 20),
              MyTextFild(
                controller: _emailController,
                labelName: context.lang.email,
              ),
              const SizedBox(height: 20),
              MyTextFild(
                controller: _countryController,
                labelName: context.lang.country,
              ),
              const SizedBox(height: 20),
              MyTextFild(
                controller: _cityController,
                labelName: context.lang.city,
              ),
              const SizedBox(height: 20),
              MyTextFild(
                controller: _roleController,
                labelName: context.lang.role,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: context.colors.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: null,
                  onChanged: (value) {
                    setState(() {
                      maxLines = '\n'.allMatches(value).length + 1;
                    });
                  },
                  decoration: InputDecoration.collapsed(
                    hintText: context.lang.description, hintStyle: context.textTheme.titleMedium?.copyWith(
                    color: Colors.grey.shade400,
                  ),

                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
