import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/common/router/app_router.dart';
import 'package:food_recipe/src/common/service/api_service.dart';
import 'package:food_recipe/src/common/service/http_client_service.dart';
import 'package:food_recipe/src/common/style/app_images.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:food_recipe/src/common/widget/my_text_fild.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constants/constants.dart';
import '../../profile/data/profile_model.dart';
import '../../profile/data/profile_repository.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String selectedRole = '';

  final roles = ['USER', 'CHEF'];

  int maxLines = 1;

  late final TextEditingController _nameController;
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _roleController = TextEditingController();
  late TextEditingController _countryController = TextEditingController();
  late TextEditingController _cityController = TextEditingController();
  late TextEditingController _descriptionController = TextEditingController();

  late final ProfileRepository profileRepository;

  Dio createDioInstance(BuildContext context) {
    final token = context.dependencies.shp.getString("token") ?? "";

    log("Token: $token");

    return Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        receiveTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
      ),
    );
  }

  Future<void> updateUserProfile({required BuildContext context}) async {
    final Map<String, Object?> data = {
      "name": _nameController.text.trim(),
      "email": _emailController.text.trim(),
      "role": selectedRole.trim(),
      "country": _countryController.text.trim(),
      "city": _cityController.text.trim(),
      "description": _descriptionController.text.trim(),
      "password": "aaaa1111"
    };

    final apiService = ApiService(dio: createDioInstance(context));

    try {
      log("try");
      final response = await apiService.request(
        Urls.user,
        data: {
          "name": _nameController.text.trim(),
          "email": _emailController.text.trim(),
          "role": selectedRole.trim(),
          "country": _countryController.text.trim(),
          "city": _cityController.text.trim(),
          "description": _descriptionController.text.trim(),
          "password": "aaaa1111"
        },
        method: Method.put,
      );
      print(response);

    } catch (e) {
      debugPrint("Error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update profile")),
      );
    }
  }

  Dio dio = Dio(BaseOptions(
    baseUrl: Constants.baseUrl,
  ));


  Future<void> updateU({required BuildContext context,required Map<String, Object> data,required Dio dio})async{
    Map<String,  Object?> result = await ApiService(dio: dio).request(
      Urls.user,
      data: data,
      method: Method.put
    );
    
    log("result update user : $result");

  }






  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _cityController = TextEditingController();
    _countryController = TextEditingController();
    _roleController = TextEditingController();
    _descriptionController = TextEditingController();
    profileRepository = ProfileRepository(
      dio: dio,
      getHeaders: () async {
        return {
          'Authorization': 'Bearer ${context.dependencies.shp.getString("token") ?? ""}'
        };
      },
    );
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
      body: FutureBuilder<UserProfile?>(
        future: profileRepository.fetchUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No user profile found.'));
          }

          final userProfile = snapshot.data!;
          if (_nameController.text.isEmpty &&
              _emailController.text.isEmpty &&
              _countryController.text.isEmpty &&
              _cityController.text.isEmpty &&
              _descriptionController.text.isEmpty) {
            _emailController.text =
                context.dependencies.shp.getString("email")!;
            _nameController.text = userProfile.data?.userName ?? '';
            _countryController.text = userProfile.data?.country ?? '';
            _cityController.text = userProfile.data?.city ?? '';
            _descriptionController.text = userProfile.data?.description ?? '';
          }
          return Center(
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
                                  padding:
                                      WidgetStatePropertyAll(EdgeInsets.zero),
                                ),
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () {
                                  context
                                      .read<EditProfileBloc>()
                                      .add(ImagePicker$EditProfileEvent(
                                        context: context,
                                      ));
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
                  DropdownButtonFormField<String>(
                    focusColor: Colors.white,
                    value: context.dependencies.shp.getString("role"),
                    items: roles
                        .map((role) => DropdownMenuItem(
                              value: role,
                              child: Text(role),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value!;
                        context.dependencies.shp.setString("role", value);
                        debugPrint(context.dependencies.shp.getString("role"));
                      });
                    },
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
                        maxLines = '\n'.allMatches(value).length + 1;
                      },
                      decoration: InputDecoration.collapsed(
                        hintText: context.lang.description,
                        hintStyle: context.textTheme.titleMedium?.copyWith(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 30,
                    ),
                    child: MaterialButton(
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onPressed: () async{
                        final token = await context.dependencies.shp.getString("token");
                        // final Map<String, Object?> data = {
                        //   "name": _nameController.text.trim(),
                        //   "email": _emailController.text.trim(),
                        //   "role": selectedRole.trim(),
                        //   "country": _countryController.text.trim(),
                        //   "city": _cityController.text.trim(),
                        //   "description": _descriptionController.text.trim(),
                        //   "password": "aaaa1111"
                        // };

                        final Map<String, Object?> data = {
                          "name":"WERTY",
                          "email":"muhammadyusufsotvoldiyev020@gmail.com",
                          "role":"CHEF",
                          "country":"qz",
                          "city":"kz",
                          "description":"nimadur desc",
                          "password":"aaaa1111",
                        };

                        if(token != null){
                          String? result = await ClientService.put(api: Urls.user, token: token, data: data);

                          if(result != null){
                            log("funksiya ishladi");
                          }
                        }

                        // await updateUserProfile(context: context).then((value){
                        //   log("then method");
                        // });
                      },
                      color: context.colors.primary,
                      child: Text(
                        "Save",
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: context.colors.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
