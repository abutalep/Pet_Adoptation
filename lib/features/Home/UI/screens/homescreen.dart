import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hopepaw/features/providers/user_provider.dart';
import 'package:hopepaw/features/Home/Data/firebase/home_firebase.dart';
import 'package:hopepaw/features/Home/UI/screens/widgets/filter_button.dart';
import 'package:hopepaw/features/Home/UI/screens/widgets/profile_card.dart';
import 'package:hopepaw/features/Home/UI/screens/widgets/report_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "All";
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final displayName =
        userProvider.userData?['displayName'] ??
        FirebaseAuth.instance.currentUser?.displayName ??
        "User";
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfileCard(name: displayName),
              SizedBox(height: 8),
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
              StreamBuilder(
                stream: HomeFirebase.getPostsByCategory(selectedCategory),
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
                      child: AspectRatio(
                        aspectRatio: 0.75,
                        child: ReportCard(report: reports[index]),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
