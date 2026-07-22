import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/features/reports/presentation/views/widgets/reports_view_content.dart';

import '../../../../../core/utils/app_theme.dart';
import '../../managers/get_lab_reports/get_lab_reports_cubit.dart';
import 'no_reports_found.dart';

class ReportsSessionViewBody extends StatelessWidget {
  const ReportsSessionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetLabReportsCubit, GetLabReportsState>(
      listener: (context, state) {
        if (state is GetLabReportsError) {
          log("🔴 Error: ${state.errorMessage}");
        } else if (state is GetLabReportsSuccess) {
          log("🟢 Success: ${state.reports.length}");
        }
      },
      builder: (context, state) {
        if (state is GetLabReportsLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        } else if (state is GetLabReportsSuccess) {
          return ReportsViewContent(reports: state.reports); // 👈 سلمنا الداتا للـ Component
        }
        return const NoReportsFound();
      },
    );
  }
}