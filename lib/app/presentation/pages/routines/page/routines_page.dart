import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_routines/app/data/models/routine/routine.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';
import 'package:smart_routines/app/presentation/pages/routines/routines.dart';
import 'package:smart_routines/app/presentation/pages/routines/widgets/routine_details_widget.dart';
import 'package:smart_routines/app/presentation/pages/routines/widgets/routine_widget.dart';
import 'package:smart_routines/core/injection/injection.dart';

@RoutePage()
class RoutinesPage extends StatelessWidget {
  const RoutinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<RoutinesCubit>()..load(),
      child: const _RoutinesView(),
    );
  }
}

class _RoutinesView extends StatelessWidget {
  const _RoutinesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: BlocBuilder<RoutinesCubit, RoutinesState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: _RoutineList.new,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final smartModels = context.read<RoutinesCubit>().state.maybeWhen(
                loaded: (r, s) => s,
                orElse: () => <SmartModel>[],
              );
          final newRoutine = await RoutineDetailsWidget(
            smartModels: smartModels,
          ).show(context);

          if (newRoutine != null && context.mounted) {
            await context.read<RoutinesCubit>().addOrUpdateRoutine(newRoutine);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _RoutineList extends StatelessWidget {
  const _RoutineList(this.routines, this.smartModels);
  final List<Routine> routines;
  final List<SmartModel> smartModels;

  Future<void> showRoutineDetails(BuildContext context, Routine routine) async {
    final updatedRoutine = await RoutineDetailsWidget(
      routine: routine,
      smartModels: smartModels,
      onDeleted: () => context.read<RoutinesCubit>().deleteRoutine(routine),
    ).show(context);

    if (updatedRoutine != null && context.mounted) {
      await context.read<RoutinesCubit>().addOrUpdateRoutine(updatedRoutine);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: routines.length,
      itemBuilder: (context, index) {
        final routine = routines[index];
        return RoutineWidget(
          routine: routine,
          onTap: () async => showRoutineDetails(context, routine),
          toggleState: () => context
              .read<RoutinesCubit>()
              .addOrUpdateRoutine(routine.toggleActive()),
        );
      },
    );
  }
}
