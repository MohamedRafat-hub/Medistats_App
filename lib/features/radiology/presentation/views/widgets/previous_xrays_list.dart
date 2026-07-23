import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/helper_functions/build_show_snack_bar.dart';
import 'package:medistats/core/services/getit_service.dart';
import 'package:medistats/features/radiology/data/repos/radiology_repo.dart';
import 'package:medistats/features/radiology/presentation/managers/delete_radio_cubit/delete_radio_cubit.dart';

import '../../../data/models/radiology_model.dart';
import 'previous_xray_tile.dart';

class PreviousXraysList extends StatelessWidget {
  const PreviousXraysList({
    super.key,
    required this.previousXrays,
    this.isScrollable = true,
  });

  final bool isScrollable;
  final List<RadiologyModel> previousXrays;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteRadioCubit(getIt.get<RadiologyRepo>()),
      child: PreviousXraysListBlocBuilder(
        isScrollable: isScrollable,
        previousXrays: previousXrays,
      ),
    );
  }
}

class PreviousXraysListBlocBuilder extends StatelessWidget {
  const PreviousXraysListBlocBuilder({
    super.key,
    required this.isScrollable,
    required this.previousXrays,
  });

  final bool isScrollable;
  final List<RadiologyModel> previousXrays;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteRadioCubit, DeleteRadioState>(
      listener: (context, state) {
        if (state is DeleteRadioSuccess) {
          showSnackBar(context, message: 'Radio record deleted successfully');
        } else if (state is DeleteRadioFailure) {
          showSnackBar(context, message: state.errorMessage);
        }
      },
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          physics: isScrollable
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          itemCount: previousXrays.length,
          itemBuilder: (context, index) {
            final xrayItem = previousXrays[index];

            return PreviousXrayTile(
              radiologyModel: xrayItem,
              onDelete: () => _confirmDeletion(context, xrayItem),
            );
          },
        );
      },
    );
  }

  void _confirmDeletion(BuildContext context, RadiologyModel xrayItem) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Delete Radio Record'),
          content: Text(
            'Are you sure you want to delete this record? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                log("Radio id is : ${xrayItem.id}");
                Navigator.of(dialogContext).pop(); // Close dialog first
                context.read<DeleteRadioCubit>().deleteRadio(
                  radiologyId: xrayItem.id,
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
