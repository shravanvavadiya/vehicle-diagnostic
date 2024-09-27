import 'package:flutter/material.dart';
import 'package:flutter_template/demo/question_ans_controller.dart';
import 'package:get/get.dart';

class QuestionAndAnsScreenDemo extends StatefulWidget {
  QuestionAndAnsScreenDemo();

  @override
  _QuestionAndAnsScreenDemoState createState() => _QuestionAndAnsScreenDemoState();
}

class _QuestionAndAnsScreenDemoState extends State<QuestionAndAnsScreenDemo> {
  @override
  Widget build(BuildContext context) {
    return GetX<QuestionAndAnsController>(
      init: QuestionAndAnsController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(title: Text('Question and Answer Demo')),
        body: Column(
          children: [
            // Progress bar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: LinearProgressIndicator(
                value: controller.progress.value,
                backgroundColor: Colors.grey[300],
                color: Colors.blue,
              ),
            ),
            controller.isResponseData.value == true
                ? Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      onPageChanged: (int page) {
                        controller.currentStep.value = page;
                        controller.updateProgress();
                      },
                      itemCount: controller.vehicleModel.value.apiresponse!.data!.length,
                      itemBuilder: (context, index) {
                        return _buildStepPage(
                            controller.vehicleModel.value.apiresponse!.data![index].question!,
                            controller.vehicleModel.value.apiresponse!.data![index].answers!,
                            controller.vehicleModel.value.apiresponse!.data![index].key!,
                            index,
                            controller);
                      },
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: controller.currentStep > 0
                        ? () {
                            controller.pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        : null,
                    child: Text('Previous'),
                  ),
                  ElevatedButton(
                    onPressed: controller.currentStep.value < controller.vehicleModel.value.apiresponse!.data!.length - 1 &&
                            controller.selectedAnswers.containsKey(controller.currentStep.value)
                        ? () {
                            controller.pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        : controller.currentStep.value == controller.vehicleModel.value.apiresponse!.data!.length - 1 &&
                                controller.selectedAnswers.containsKey(controller.currentStep)
                            ? () {
                                _showSelectedAnswers(controller); // Show the selected answers on the last page
                              }
                            : null,
                    child:
                        controller.currentStep.value == controller.vehicleModel.value.apiresponse!.data!.length - 1 ? Text('Finish') : Text('Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepPage(String question, List<dynamic> answers, String questionKey, int index, QuestionAndAnsController controller) {
    String? selectedAnswer = controller.selectedAnswers[index]; // Get the selected answer for this page

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Column(
            children: List.generate(answers.length, (i) {
              return CheckboxListTile(
                title: Text(answers[i]),
                value: selectedAnswer == answers[i],
                onChanged: (bool? value) {
                  if (value == true) {
                    controller.selectedAnswers[index] = answers[i]; // Store answer by index
                    controller.selectedResponse[questionKey] = answers[i]; // Store answer by key
                  } else {
                    controller.selectedAnswers.remove(index);
                    controller.selectedResponse.remove(questionKey); // Remove the answer if unchecked
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showSelectedAnswers(QuestionAndAnsController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Selected Answers'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: controller.selectedResponse.entries.map((entry) {
              return ListTile(
                title: Text("${entry.key}: ${entry.value}"),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
