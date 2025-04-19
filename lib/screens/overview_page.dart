import 'package:flutter/material.dart';
import '../widgets/OverviewWidgets/header_section.dart';
import '../widgets/OverviewWidgets/health_overview_card.dart';
import '../widgets/OverviewWidgets/category_section.dart';
import '../widgets/OverviewWidgets/report_section.dart';
import '../widgets/OverviewWidgets/more_details_button.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderSection(),
              SizedBox(height: 16),
              Text(
                "Overview",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              HealthOverviewCard(),
              SizedBox(height: 16),
              CategorySection(),
              SizedBox(height: 24),
              ReportSection(),
              SizedBox(height: 10),
              MoreDetailsButton(),
            ],
          ),
        ),
      ),
    );
  }
}
