import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:komdigi_logbooks_supervisors/core/core.dart';
import 'package:komdigi_logbooks_supervisors/core/extensions/build_context_ext.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_supervisors/data/models/auth_response_model.dart';
import 'package:komdigi_logbooks_supervisors/helper/permission_helper.dart';
import 'package:komdigi_logbooks_supervisors/presentation/main_page.dart';
import 'package:komdigi_logbooks_supervisors/presentation/profile/bloc/update_profile_bloc/update_profile_bloc.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  late final TextEditingController namaController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController phoneController;
  bool showPassword = false;
  User? user;
  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;

  Future<void> initializeUserData() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      setState(() {
        user = authData?.user;
        if (user != null) {
          namaController.text = user!.name ?? '';
          emailController.text = user!.email ?? '';
          phoneController.text = user!.phone ?? '';
        }
      });
    } catch (e) {
      print('Error fetching auth data: $e');
      setState(() {
        user = null;
      });
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final hasPermission = await PermissionHelper.requestPermissions(context);
    if (!hasPermission) return;
    try {
      final image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          selectedImage = image;
        });
      } else {
        print('Pengguna membatalkan pemilihan gambar.');
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal membuka kamera/galeri: $e')),
      );
    }
  }

  void showImageSourceSelection() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Kamera'),
                onTap: () {
                  context.pop();
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeri'),
                onTap: () {
                  context.pop();
                  pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    namaController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    initializeUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ubah Profile',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 8,
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: selectedImage != null
                        ? FileImage(File(selectedImage!.path))
                        : (user != null && user!.photo != null
                            ? NetworkImage(user!.photo!) as ImageProvider
                            : Assets.images.avatar.provider()),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: showImageSourceSelection,
                      child: const CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColors.primary,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                controller: namaController,
                label: 'Nama',
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                controller: emailController,
                label: 'Email',
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                controller: passwordController,
                label: 'Password',
                obscureText: !showPassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                  controller: phoneController, label: 'Nomor Telepon'),
              const SizedBox(
                height: 32,
              ),
              BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    success: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile berhasil diupdate!'),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                      context.pushReplacement(const MainPage());
                    },
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: AppColors.red,
                        ),
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Button.filled(
                        onPressed: () {
                          context.read<UpdateProfileBloc>().add(
                                UpdateProfileEvent.updateProfile(
                                  id: user!.id,
                                  name: namaController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  photo: selectedImage,
                                ),
                              );
                        },
                        label: 'Simpan',
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
