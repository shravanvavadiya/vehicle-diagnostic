import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/modules/chat_view/services/services.dart';
import 'package:flutter_template/utils/app_string.dart';
import 'package:flutter_template/utils/utils.dart';
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
  RxBool isEditAnsValue = false.obs;
  RxBool isAllAnswerAdd = false.obs;
  RxInt fillAnswer = 1.obs;
  RxInt isEditSelectedIndex = 0.obs;
  RxInt isEditTimeIndex = (-1).obs;
  RxInt passVehicleId = 0.obs;
  List<String> splitQuestionList = <String>[];
  List demoList = [];

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
          print("data ${data.apiresponse!.data!.length}");
          demoList.assignAll(data.apiresponse!.data!.toList());
          log("demoList ${demoList.toString()}");
          RxString question = data.apiresponse!.data!.toString().obs;
          // splitQuestionList = question.value.replaceAll("[", "").replaceAll("]", "").split(",").obs;
          splitQuestionList.assignAll(data.apiresponse!.data!);
          for (int i = 0; i < splitQuestionList.length; i++) {
            questionAndAnswerList.add(QuestionAndAnswerModel(index: i, question: splitQuestionList[i].replaceAll("'", ""), answer: ""));
          }
        } else {}
      },
    );
  }

  Future<void> submitUserAns({required String answer, required String question}) async {
    handleLoading(true);
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
          isEditAnsValue.value == true
              ? {
                  questionAndAnswerList[isEditTimeIndex.value].answer = answerController.value.text,
                  isEditAnsValue.value = false,
                  isEditTimeIndex.value = -1,
                  answerController.value.clear(),
                  if (questionAndAnswerList.length > fillAnswer.value) {} else {isAllAnswerAdd.value = true},
                }
              : {
                  questionAndAnswerList[fillAnswer.value - 1].answer = answerController.value.text,
                  answerController.value.text = "",
                  if (questionAndAnswerList.length > fillAnswer.value)
                    {fillAnswer.value++}
                  else
                    {
                      isAllAnswerAdd.value = true,
                    },
                };
          handleLoading(false);
        }
      },
    );

    handleLoading(false);
  }

  Future<void> downloadUserReport({required int vehicle}) async {
    // handleLoading(true);
    await processApi(
      () => ChatServices.downloadReport(vehicle: passVehicleId.value),
      error: (error, stack) {
        Get.back();
        // handleLoading(false);
      },
      result: (data) {
        // handleLoading(false);
        Get.off(PdfViewScreen(
          pdfData: data,
        ));
      },
    );
    // handleLoading(false);
  }

  FocusNode myFocusNode = FocusNode();

  Future<void> editQuestionAnswerFunction({required int currentIndex}) async {
    Utils.keyboardInApp(context, myFocusNode);
    answerController.value.text = questionAndAnswerList[currentIndex].answer ?? "";
    isEditAnsValue.value = true;
    isEditTimeIndex.value = currentIndex;
    isCheckText.value = true;
    if (questionAndAnswerList.length > fillAnswer.value) {
      isAllAnswerAdd.value = false;
    } else {}
  }

  @override
  void onInit() {
    getAllChatQuestion();
    // TODO: implement onInit
    super.onInit();
  }
}
