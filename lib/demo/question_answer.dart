import 'package:flutter/material.dart';

class QuestionAndAnsScreenDemo extends StatefulWidget {
  @override
  _QuestionAndAnsScreenDemoState createState() => _QuestionAndAnsScreenDemoState();
}

class _QuestionAndAnsScreenDemoState extends State<QuestionAndAnsScreenDemo> {
  PageController _pageController = PageController();
  int _currentStep = 0;
  final int totalPages = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Question and Answer Demo')),
      body: Column(
        children: [
          // Stepper indicator with Containers instead of CircleAvatars
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(totalPages, (index) {
                return Container(
                  width: 50,
                  height: 10,
                  decoration: BoxDecoration(
                    color: _currentStep >= index ? Colors.blue : Colors.grey,
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentStep = page;
                });
              },
              children: List.generate(totalPages, (index) {
                return _buildStepPage('Step ${index + 1}', Colors.primaries[index % Colors.primaries.length]);
              }),
            ),
          ),
          // Navigation buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _currentStep > 0
                      ? () {
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      : null,
                  child: Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: _currentStep < totalPages - 1
                      ? () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      : null,
                  child: Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // A function to build individual step pages
  Widget _buildStepPage(String stepText, Color color) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          stepText,
          style: TextStyle(fontSize: 32, color: Colors.white),
        ),
      ),
    );
  }
}
