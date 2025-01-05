import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:komdigi_logbooks_supervisors/core/components/spaces.dart';
import 'package:komdigi_logbooks_supervisors/core/constants/colors.dart';
import 'package:komdigi_logbooks_supervisors/core/core.dart';
import 'package:komdigi_logbooks_supervisors/core/extensions/build_context_ext.dart';
import 'package:komdigi_logbooks_supervisors/helper/permission_helper.dart';
import 'package:komdigi_logbooks_supervisors/presentation/auth/pages/login_page.dart';
import 'package:komdigi_logbooks_supervisors/presentation/register/bloc/register/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final TextEditingController telephoneController;
  late final TextEditingController namaController;
  bool isShowPassword = false;
  bool isShowConfirmPassword = false;
  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    telephoneController = TextEditingController();
    namaController = TextEditingController();
    super.initState();
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(28.0)),
                  child: ColoredBox(
                    color: AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundColor: AppColors.gray4,
                              child: selectedImage != null
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      child: Image.file(
                                        File(selectedImage!.path),
                                        width: 200.0,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: showImageSourceSelection,
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        size: 32.0,
                                        color: AppColors.primary,
                                      ),
                                    ),
                            ),
                          ),
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          const SpaceHeight(16.0),
                          CustomTextField(
                            controller: emailController,
                            label: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            prefixIcon: const Icon(
                              Icons.email,
                              color: AppColors.primary,
                            ),
                          ),
                          const SpaceHeight(8.0),
                          CustomTextField(
                            controller: telephoneController,
                            label: 'Handphone',
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: AppColors.primary,
                            ),
                          ),
                          const SpaceHeight(8.0),
                          CustomTextField(
                            controller: namaController,
                            label: 'Nama',
                            prefixIcon: const Icon(
                              Icons.person,
                              color: AppColors.primary,
                            ),
                          ),
                          const SpaceHeight(8.0),
                          CustomTextField(
                            controller: passwordController,
                            label: 'Password',
                            obscureText: !isShowPassword,
                            prefixIcon: const Icon(
                              Icons.key,
                              color: AppColors.primary,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isShowPassword = !isShowPassword;
                                });
                              },
                              icon: Icon(
                                isShowPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          const SpaceHeight(8.0),
                          CustomTextField(
                            controller: confirmPasswordController,
                            label: ' Konfirmasi Password',
                            obscureText: !isShowConfirmPassword,
                            prefixIcon: const Icon(
                              Icons.key,
                              color: AppColors.primary,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isShowConfirmPassword =
                                      !isShowConfirmPassword;
                                });
                              },
                              icon: Icon(
                                isShowConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          const SpaceHeight(32.0),
                          BlocConsumer<RegisterBloc, RegisterState>(
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
                                      content: Text('Register Success'),
                                      backgroundColor: AppColors.primary,
                                    ),
                                  );
                                  context.pushReplacement(const LoginPage());
                                },
                                error: (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(error),
                                      backgroundColor: AppColors.red,
                                    ),
                                  );
                                },
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () {
                                  return Button.filled(
                                    onPressed: () {
                                      if (passwordController.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text('Password tidak boleh kosong!'),
                                            backgroundColor: AppColors.red,
                                          ),
                                        );
                                      } else if (confirmPasswordController
                                          .text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Konfirmasi password tidak boleh kosong'),
                                            backgroundColor: AppColors.red,
                                          ),
                                        );
                                      } else if (passwordController.text !=
                                          confirmPasswordController.text) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Password tidak sama'),
                                            backgroundColor: AppColors.red,
                                          ),
                                        );
                                      } else {
                                        context.read<RegisterBloc>().add(
                                              RegisterEvent.register(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                                name: namaController.text,
                                                phoneNumber:
                                                    telephoneController.text,
                                                photo: null,
                                              ),
                                            );
                                      }
                                    },
                                    label: 'Sign In',
                                  );
                                },
                                loading: () {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Sudah memiliki akun?',
                              ),
                              TextButton(
                                onPressed: () {
                                  context.pushReplacement(
                                    const LoginPage(),
                                  );
                                },
                                child: const Text('Login'),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
