class FormStepData {
  final String question;
  final String subtitle;
  final List<Map<String, dynamic>> optionsList;

  FormStepData({
    required this.question,
    required this.subtitle,
    required this.optionsList,
  });
}

/*class SingleStepInfoModel {
  final String option;
  final bool isSelected;

  SingleStepInfoModel({
    required this.option,
    required this.isSelected,
  });
}*/

final List<FormStepData> formStepsList = [
  FormStepData(
    question: "What is the main symptom or issue you're experiencing?",
    subtitle: "Add your vehicle information for better search.",
    optionsList: [
      {
        "option": "What is the main symptom or issue you're experiencing?",
        "isSelected": false
      },
      {
        "option": "The car makes strange noises (e.g., knocking, squealing)",
        "isSelected": false
      },
      {
        "option": "The car vibrates or shakes while driving",
        "isSelected": false
      },
      {
        "option": "A warning light is on (e.g., check engine, ABS)",
        "isSelected": false
      },
      {
        "option": "The car struggles to accelerate or loses power",
        "isSelected": false
      },
      {"option": "Other", "isSelected": false}
    ],
  ),
  FormStepData(
    question: "When did you first notice the issue?",
    subtitle: "Add your vehicle information for better search.",
    optionsList: [
      {"option": "Today", "isSelected": false},
      {"option": "A few days ago", "isSelected": false},
      {"option": "A few weeks ago", "isSelected": false},
      {"option": "Over a month ago", "isSelected": false},
    ],
  ),
  FormStepData(
    question: " How often does the issue occur?",
    subtitle: "Add your vehicle information for better search.",
    optionsList: [
      {"option": "Every time I use the car", "isSelected": false},
      {"option": "Only sometimes", "isSelected": false},
      {"option": "It only happened once", "isSelected": false},
      {"option": "Not sure", "isSelected": false},
    ],
  ),
  FormStepData(
    question: "When does the problem typically happen?",
    subtitle: "When does the problem typically happen?",
    optionsList: [
      {
        "option": "When starting the car",
        "isSelected": false
      },
      {
        "option": "While driving (e.g., accelerating or turning)",
        "isSelected": false
      },
      {
        "option": "When slowing down or braking",
        "isSelected": false
      },
      {
        "option": "Randomly",
        "isSelected": false
      },
      {
        "option": "Not sure",
        "isSelected": false
      },

    ],
  ),
  FormStepData(
    question: "What is the main symptom or issue you're experiencing? 11111",
    subtitle: "Add your vehicle information for better search.",
    optionsList: [
      {
        "option": "What is the main symptom or issue you're experiencing?",
        "isSelected": false
      },
      {
        "option": "The car makes strange noises (e.g., knocking, squealing)",
        "isSelected": false
      },
      {
        "option": "The car vibrates or shakes while driving",
        "isSelected": false
      },
      {
        "option": "A warning light is on (e.g., check engine, ABS)",
        "isSelected": false
      },
      {
        "option": "The car struggles to accelerate or loses power",
        "isSelected": false
      },
      {"option": "Other", "isSelected": false}
    ],
  ),
  FormStepData(
    question: "When did you first notice the issue?1111",
    subtitle: "Add your vehicle information for better search.",
    optionsList: [
      {"option": "Today", "isSelected": false},
      {"option": "A few days ago", "isSelected": false},
      {"option": "A few weeks ago", "isSelected": false},
      {"option": "Over a month ago", "isSelected": false},
    ],
  ),
  FormStepData(
    question: " How often does the issue occur? 11111",
    subtitle: "Add your vehicle information for better search.",
    optionsList: [
      {"option": "Every time I use the car", "isSelected": false},
      {"option": "Only sometimes", "isSelected": false},
      {"option": "It only happened once", "isSelected": false},
      {"option": "Not sure", "isSelected": false},
    ],
  ),
  FormStepData(
    question: "When does the problem typically happen?1111",
    subtitle: "When does the problem typically happen?",
    optionsList: [
      {
        "option": "When starting the car",
        "isSelected": false
      },
      {
        "option": "While driving (e.g., accelerating or turning)",
        "isSelected": false
      },
      {
        "option": "When slowing down or braking",
        "isSelected": false
      },
      {
        "option": "Randomly",
        "isSelected": false
      },
      {
        "option": "Not sure",
        "isSelected": false
      },

    ],
  ), FormStepData(
    question: "What is the main symptom or issue you're experiencing? 2222",
    subtitle: "Add your vehicle information for better search.",
    optionsList: [
      {
        "option": "What is the main symptom or issue you're experiencing?",
        "isSelected": false
      },
      {
        "option": "The car makes strange noises (e.g., knocking, squealing)",
        "isSelected": false
      },
      {
        "option": "The car vibrates or shakes while driving",
        "isSelected": false
      },
      {
        "option": "A warning light is on (e.g., check engine, ABS)",
        "isSelected": false
      },
      {
        "option": "The car struggles to accelerate or loses power",
        "isSelected": false
      },
      {"option": "Other", "isSelected": false}
    ],
  ),
  FormStepData(
    question: "When did you first notice the issue?2222",
    subtitle: "Add your vehicle information for better search.",
    optionsList: [
      {"option": "Today", "isSelected": false},
      {"option": "A few days ago", "isSelected": false},
      {"option": "A few weeks ago", "isSelected": false},
      {"option": "Over a month ago", "isSelected": false},
    ],
  ),
  FormStepData(
    question: " How often does the issue occur?22222",
    subtitle: "Add your vehicle information for better search.",
    optionsList: [
      {"option": "Every time I use the car", "isSelected": false},
      {"option": "Only sometimes", "isSelected": false},
      {"option": "It only happened once", "isSelected": false},
      {"option": "Not sure", "isSelected": false},
    ],
  ),
  FormStepData(
    question: "When does the problem typically happen?2222",
    subtitle: "When does the problem typically happen?",
    optionsList: [
      {
        "option": "When starting the car",
        "isSelected": false
      },
      {
        "option": "While driving (e.g., accelerating or turning)",
        "isSelected": false
      },
      {
        "option": "When slowing down or braking",
        "isSelected": false
      },
      {
        "option": "Randomly",
        "isSelected": false
      },
      {
        "option": "Not sure",
        "isSelected": false
      },

    ],
  ), FormStepData(
    question: "What is the main symptom or issue you're experiencing?3333",
    subtitle: "Add your vehicle information for better search.",
    optionsList: [
      {
        "option": "What is the main symptom or issue you're experiencing?",
        "isSelected": false
      },
      {
        "option": "The car makes strange noises (e.g., knocking, squealing)",
        "isSelected": false
      },
      {
        "option": "The car vibrates or shakes while driving",
        "isSelected": false
      },
      {
        "option": "A warning light is on (e.g., check engine, ABS)",
        "isSelected": false
      },
      {
        "option": "The car struggles to accelerate or loses power",
        "isSelected": false
      },
      {"option": "Other", "isSelected": false}
    ],
  ),
  FormStepData(
    question: "When did you first notice the issue?333",
    subtitle: "Add your vehicle information for better search.",
    optionsList: [
      {"option": "Today", "isSelected": false},
      {"option": "A few days ago", "isSelected": false},
      {"option": "A few weeks ago", "isSelected": false},
      {"option": "Over a month ago", "isSelected": false},
    ],
  ),
  FormStepData(
    question: " How often does the issue occur?3333",
    subtitle: "Add your vehicle information for better search.",
    optionsList: [
      {"option": "Every time I use the car", "isSelected": false},
      {"option": "Only sometimes", "isSelected": false},
      {"option": "It only happened once", "isSelected": false},
      {"option": "Not sure", "isSelected": false},
    ],
  ),
  FormStepData(
    question: "When does the problem typically happen?33333",
    subtitle: "When does the problem typically happen?",
    optionsList: [
      {
        "option": "When starting the car",
        "isSelected": false
      },
      {
        "option": "While driving (e.g., accelerating or turning)",
        "isSelected": false
      },
      {
        "option": "When slowing down or braking",
        "isSelected": false
      },
      {
        "option": "Randomly",
        "isSelected": false
      },
      {
        "option": "Not sure",
        "isSelected": false
      },

    ],
  ),
];
