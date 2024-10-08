import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/modules/chat_view/services/services.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/widget/app_snackbar.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../utils/common_api_caller.dart';
import '../../../utils/loading_mixin.dart';
import '../../add_vehicle_information/services/vehicle_information_service.dart';
import '../model/chat_question_model.dart';
import '../model/question_and_answer_model.dart';
import '../model/user_ans_check_model.dart';
import '../presentation/pdf_view_screen.dart';

class ChatController extends GetxController with LoadingMixin, LoadingApiMixin {
  RxString screenHeading = "Car-Fixer".obs;
  RxBool isResponse = false.obs;
  RxList<QuestionAndAnswerModel> questionAndAnswerList = <QuestionAndAnswerModel>[].obs;
  Rx<TextEditingController> answerController = TextEditingController().obs;
  Rx<GetChatQuestionModel> chatQuestionList = GetChatQuestionModel().obs;
  Rx<UserAnswerCheckModel> userAnswerCheckList = UserAnswerCheckModel().obs;
  RxBool isCheckText = false.obs;
  RxInt fillAnswer = 1.obs;
  RxInt passVehicleId = 0.obs;

  ChatController({required int vehicleId}) {
    passVehicleId.value = vehicleId;
    log(passVehicleId.value.toString());
  }

  Future<void> getAllChatQuestion() async {
    await processApi(
      () => ChatServices.chatGptQuestionServices(),
      error: (error, stack) => handleLoading(false),
      result: (data) {
        if (data.apiresponse!.data?.isEmpty != true) {
          chatQuestionList.value = data;
          isResponse.value = true;
          RxString question = data.apiresponse!.data!.toString().obs;
          log("split ans ${question.value.replaceAll("[", "").replaceAll("]", "").split(",")}");
          List<String> splitQuestionList = question.value.replaceAll("[", "").replaceAll("]", "").split(",").obs;

          for (int i = 0; i < splitQuestionList.length; i++) {
            log(splitQuestionList[i].replaceAll("'", ""));
            questionAndAnswerList.add(QuestionAndAnswerModel(index: i, question: splitQuestionList[i].replaceAll("'", ""), answer: ""));
          }
        } else {}
      },
    );
  }

  Future<void> submitUserAns({required String answer, required String question}) async {
    final body = {
      "qaChatgptRequests": [
        {
          "answer": answer,
          "question": question
          // "answer": "Yes, the engine makes strange noises, especially during ignition or while accelerating.",
          // "question": "Does the engine make strange noises, specially during ignition or while accelerating?"
        }
      ],
      "vehicleId": passVehicleId.value
    };
    await processApi(
      () => ChatServices.userSubmitAnswer(bodyData: body),
      error: (error, stack) {
        handleLoading(false);

        AppSnackBar.showErrorSnackBar(message: error.toString().split(":")[2], title: "error");
        log("error $error");
      },
      result: (data) {
        if (data.apiresponse!.data!.qaChatGptResponses!.isNotEmpty) {
          userAnswerCheckList.value = data;
          log("response after ans check ${data.apiresponse!.data!.qaChatGptResponses.toString()}");
          questionAndAnswerList[fillAnswer.value - 1].answer = answerController.value.text;
          answerController.value.text = "";
          log("questionAndAnswerList.length ${questionAndAnswerList.length}  fillAnswer.value ${fillAnswer.value}");
          if (questionAndAnswerList.length > fillAnswer.value) fillAnswer.value++;
        }
      },
    );
  }

  Future<void> downloadUserReport({required int userId}) async {
    handleLoading(true);
    await processApi(
      () => ChatServices.downloadReport(userId: userId),
      error: (error, stack) {
        handleLoading(false);
      },
      result: (data) {
        Get.to(PdfViewScreen(
          pdfData: data,
        ));
      },
    );
    handleLoading(false);
  }

  @override
  void onInit() {
    getAllChatQuestion();
    // TODO: implement onInit
    super.onInit();
  }
}
