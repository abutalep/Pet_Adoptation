import 'package:flutter/material.dart';
import 'package:hopepaw/features/adoption/Data/firebase/adoption_servises.dart';
import 'package:hopepaw/features/adoption/UI/screens/widgets/filter_button.dart';
import 'package:hopepaw/features/adoption/UI/screens/widgets/report_card.dart';
import 'package:hopepaw/features/Home/Data/models/animal_report.dart';

class AdoptionScreen extends StatefulWidget {
  const AdoptionScreen({super.key});

  @override
  State<AdoptionScreen> createState() => _AdoptionScreenState();
}

class _AdoptionScreenState extends State<AdoptionScreen> {
  String selectedCategory = "All";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adoption Reports',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF44174E),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterButton(
                        category: "All",
                        selectedCategory: selectedCategory,
                        onSelected: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                      SizedBox(width: 8),
                      FilterButton(
                        category: "Cat",
                        selectedCategory: selectedCategory,
                        onSelected: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                      SizedBox(width: 8),
                      FilterButton(
                        category: "Dog",
                        selectedCategory: selectedCategory,
                        onSelected: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                      SizedBox(width: 8),
                      FilterButton(
                        category: "Bird",
                        selectedCategory: selectedCategory,
                        onSelected: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                      SizedBox(width: 8),
                      FilterButton(
                        category: "Others",
                        selectedCategory: selectedCategory,
                        onSelected: (value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                StreamBuilder<List<AnimalReport>>(
                  stream: AdoptionServices.getAdoptionReportsByCategory(selectedCategory),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data!.isEmpty) {
                      return Center(child: Text('No Reports found.'));
                    }
                    final reports = snapshot.data!;
                    return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: reports.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                      ),
                      itemBuilder: (context, index) => Card(
                        elevation: 2,
                        child: ReportCard(report:reports[index]),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
