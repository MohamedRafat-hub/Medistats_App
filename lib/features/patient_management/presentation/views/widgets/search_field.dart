import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/features/patient_management/presentation/managers/add_patient_cubit/add_patient_cubit.dart';
import 'package:medistats/features/patient_management/presentation/managers/get_all_patients_cubit/get_all_patients_cubit.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFD9DEE1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.black54),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: (value) {
                context.read<GetAllPatientsCubit>().searchPatients(value);
              },
              decoration: const InputDecoration(
                hintText: 'Search patients...',
                hintStyle: TextStyle(color: Colors.black54, fontSize: 16),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}