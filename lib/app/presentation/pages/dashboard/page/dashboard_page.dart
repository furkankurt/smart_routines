import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_routines/app/data/models/smart_model/smart_model.dart';
import 'package:smart_routines/app/presentation/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:smart_routines/app/presentation/pages/dashboard/widgets/smart_model_details_widget.dart';
import 'package:smart_routines/app/presentation/pages/dashboard/widgets/smart_model_widget.dart';
import 'package:smart_routines/core/injection/injection.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<DashboardCubit>()..load(),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (smartModels) => _buildModelList(context, smartModels),
            );
          },
        ),
      ),
    );
  }

  Widget _buildModelList(BuildContext context, List<SmartModel> smartModels) {
    final devices = smartModels.where((e) => e.type == ModelType.device);
    final services = smartModels.where((e) => e.type == ModelType.service);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Devices',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        _SmartModelList(devices.toList()),
        const SizedBox(height: 8),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Services',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        _SmartModelList(services.toList()),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _SmartModelList extends StatelessWidget {
  const _SmartModelList(this.smartModels);
  final List<SmartModel> smartModels;

  Future<void> showModelDetails(BuildContext context, SmartModel model) async {
    final updatedModel = await SmartModelDetails(model: model).show(context);
    if (updatedModel != null && context.mounted) {
      await context.read<DashboardCubit>().addOrUpdateModel(updatedModel);
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
      shrinkWrap: true,
      primary: false,
      itemCount: smartModels.length,
      itemBuilder: (context, index) {
        final model = smartModels[index];
        return SmartModelWidget(
          smartModel: model,
          onTap: () async => showModelDetails(context, model),
          onPropertyChange: (propertyName, value) {
            final updatedModel = model.updatePropertyValue(propertyName, value);
            context.read<DashboardCubit>().addOrUpdateModel(updatedModel);
          },
        );
      },
    );
  }
}
