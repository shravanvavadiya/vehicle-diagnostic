class VehicleInformationModel {
  Apiresponse? apiresponse;

  VehicleInformationModel({this.apiresponse});

  VehicleInformationModel.fromJson(Map<String, dynamic> json) {
    apiresponse = json['apiresponse'] != null
        ? new Apiresponse.fromJson(json['apiresponse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.apiresponse != null) {
      data['apiresponse'] = this.apiresponse!.toJson();
    }
    return data;
  }
}

class Apiresponse {
  Null? dataArray;
  List<QueData>? data;
  int? timestamp;

  Apiresponse({this.dataArray, this.data, this.timestamp});

  Apiresponse.fromJson(Map<String, dynamic> json) {
    dataArray = json['dataArray'];
    if (json['data'] != null) {
      data = <QueData>[];
      json['data'].forEach((v) {
        data!.add(new QueData.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataArray'] = this.dataArray;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class QueData {
  int? creationDate;
  int? lastModifiedDate;
  int? id;
  String? question;
  List<String>? answers;
  String? key;

  QueData(
      {this.creationDate,
        this.lastModifiedDate,
        this.id,
        this.question,
        this.answers,
        this.key});

  QueData.fromJson(Map<String, dynamic> json) {
    creationDate = json['creationDate'];
    lastModifiedDate = json['lastModifiedDate'];
    id = json['id'];
    question = json['question'];
    answers = json['answers'].cast<String>();
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['creationDate'] = this.creationDate;
    data['lastModifiedDate'] = this.lastModifiedDate;
    data['id'] = this.id;
    data['question'] = this.question;
    data['answers'] = this.answers;
    data['key'] = this.key;
    return data;
  }
}































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

/*final List<FormStepData> formStepsList = [
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
];*/
