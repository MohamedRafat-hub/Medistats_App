import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/features/reports/presentation/managers/get_lab_reports/get_lab_reports_cubit.dart';
import 'package:medistats/features/reports/presentation/views/widgets/no_reports_found.dart';
import 'package:medistats/features/reports/presentation/views/widgets/reports_view_content.dart';

import '../../../../core/utils/app_theme.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7EDF0),
        body: SafeArea(child: ReportsViewBody()));
  }
}

class ReportsViewBody extends StatelessWidget {
  const ReportsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetLabReportsCubit, GetLabReportsState>(
      builder: (context, state) {
        if (state is GetLabReportsLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        } else if (state is GetLabReportsSuccess) {
          log("🟢 Success: ${state.reports.length} all patient reports");
          return ReportsViewContent(reports: state.reports);
        }
        return const NoReportsFound(readOnly: true);
      },
    );
  }
}
