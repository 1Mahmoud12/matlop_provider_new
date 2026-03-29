// Main model class for the JSON response
class PredictionsModel {
  final List<Prediction> predictions;
  final String status;

  PredictionsModel({required this.predictions, required this.status});

  factory PredictionsModel.fromJson(Map<String, dynamic> json) {
    return PredictionsModel(
      predictions: json['predictions'] != null
          ? List<Prediction>.from(
              json['predictions'].map((x) => Prediction.fromJson(x)),
            )
          : [],
      status: json['status'] ?? '', 
    );
  }
}

// Prediction model class
class Prediction {
  final String description;
  final List<MatchedSubstring> matchedSubstrings;
  final String placeId;
  final String reference;
  final StructuredFormatting structuredFormatting;
  final List<Term> terms;
  final List<String> types;

  Prediction({
    required this.description,
    required this.matchedSubstrings,
    required this.placeId,
    required this.reference,
    required this.structuredFormatting,
    required this.terms,
    required this.types,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      description: json['description'] ?? '', // Default to empty string
      matchedSubstrings: json['matched_substrings'] != null
          ? List<MatchedSubstring>.from(
              json['matched_substrings'].map((x) => MatchedSubstring.fromJson(x)),
            )
          : [],
      placeId: json['place_id'] ?? '', // Default to empty string
      reference: json['reference'] ?? '', // Default to empty string
      structuredFormatting: json['structured_formatting'] != null
          ? StructuredFormatting.fromJson(json['structured_formatting'])
          : StructuredFormatting(
              mainText: '',
              mainTextMatchedSubstrings: [],
              secondaryText: '',
            ),
      terms: json['terms'] != null ? List<Term>.from(json['terms'].map((x) => Term.fromJson(x))) : [],
      types: json['types'] != null ? List<String>.from(json['types']) : [], // Default to an empty list
    );
  }
}

// MatchedSubstring model class
class MatchedSubstring {
  final int length;
  final int offset;

  MatchedSubstring({required this.length, required this.offset});

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) {
    return MatchedSubstring(
      length: json['length'] ?? -1, // Default to -1
      offset: json['offset'] ?? -1, // Default to -1
    );
  }
}

// StructuredFormatting model class
class StructuredFormatting {
  final String mainText;
  final List<MatchedSubstring> mainTextMatchedSubstrings;
  final String secondaryText;

  StructuredFormatting({
    required this.mainText,
    required this.mainTextMatchedSubstrings,
    required this.secondaryText,
  });

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) {
    return StructuredFormatting(
      mainText: json['main_text'] ?? '', // Default to empty string
      mainTextMatchedSubstrings: json['main_text_matched_substrings'] != null
          ? List<MatchedSubstring>.from(
              json['main_text_matched_substrings'].map((x) => MatchedSubstring.fromJson(x)),
            )
          : [],
      secondaryText: json['secondary_text'] ?? '', // Default to empty string
    );
  }
}

// Term model class
class Term {
  final int offset;
  final String value;

  Term({required this.offset, required this.value});

  factory Term.fromJson(Map<String, dynamic> json) {
    return Term(
      offset: json['offset'] ?? -1, // Default to -1
      value: json['value'] ?? '', // Default to empty string
    );
  }
}
