import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/helper_functions/build_show_snack_bar.dart';
import 'package:medistats/core/services/getit_service.dart';
import 'package:medistats/core/utils/app_theme.dart';
import 'package:medistats/features/reports/data/models/lab_report_model.dart';
import 'package:medistats/features/reports/data/repos/lab_report_repo.dart';
import 'package:medistats/features/reports/presentation/managers/delete_report_cubit/delete_report_cubit.dart';
import 'package:medistats/features/reports/presentation/views/widgets/reports_list_tile_bloc_builder.dart';
import 'delete_lab_report_item.dart';
import 'report_tile.dart';

class ReportsList extends StatelessWidget {
  const ReportsList({super.key, required this.reports});

  final List<LabReportModel> reports;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteReportCubit(getIt.get<LabReportRepo>()),
      child: ReportsListTileBlocBuilder(reports: reports),
    );
  }
}

