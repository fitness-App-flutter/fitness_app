import 'package:fitness_app/core/utils/step_counter_logic.dart';
import 'package:flutter/material.dart';
import '../widgets/OverviewWidgets/header_section.dart';
import '../widgets/OverviewWidgets/health_overview_card.dart';
import '../widgets/OverviewWidgets/category_section.dart';
import '../widgets/OverviewWidgets/report_section.dart';
import '../widgets/OverviewWidgets/more_details_button.dart';
import 'package:provider/provider.dart';


class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stepsCount = context.watch<StepCounterLogic>().stepsToday;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderSection(),
              const SizedBox(height: 16),
              const Text(
                "Overview",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const HealthOverviewCard(),
              const SizedBox(height: 16),
              const CategorySection(),
              const SizedBox(height: 24),
              ReportSection(stepsCount: stepsCount),
              const SizedBox(height: 10),
              const MoreDetailsButton(),
            ],
          ),
        ),
      ),
    );
  }
}
