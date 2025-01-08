import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komdigi_logbooks_supervisors/core/core.dart';
import 'package:komdigi_logbooks_supervisors/presentation/project/bloc/get_project/get_project_bloc.dart';

class ProjectPages extends StatefulWidget {
  const ProjectPages({super.key});

  @override
  State<ProjectPages> createState() => _ProjectPagesState();
}

class _ProjectPagesState extends State<ProjectPages> {
  @override
  void initState() {
    context.read<GetProjectBloc>().add(const GetProjectEvent.getProject());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Project'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<GetProjectBloc, GetProjectState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    success: (data) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final projects = data[index];
                          return Container(
                            decoration: BoxDecoration(
                              border: const Border(
                                bottom: BorderSide(
                                  color: AppColors.gray2,
                                  width: 1.0,
                                ),
                                top: BorderSide(
                                  color: AppColors.gray2,
                                  width: 1.0,
                                ),
                                left: BorderSide(
                                  color: AppColors.gray2,
                                  width: 1.0,
                                ),
                                right: BorderSide(
                                  color: AppColors.gray2,
                                  width: 1.0,
                                ),
                              ),
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  projects.name ?? "Tidak ada nama",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Divider(
                                  color: AppColors.gray2,
                                ),
                                const SpaceHeight(16.0),
                                const Text(
                                  'Fitur yang dibutuhlan',
                                  style: TextStyle(color: AppColors.gray1),
                                ),
                                const SpaceHeight(8.0),
                                Text(
                                  projects.features ?? "Tidak ada nama project",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SpaceHeight(32.0),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
