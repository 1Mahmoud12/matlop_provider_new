enum OrderTypeEnum {
  other,
  Order,
  SpecialOrder,
}

enum SpecialOrderEnum {
  other,
  Emergency,
  Special,
}

enum SpecialOrderStatusEnum {
  other,
  Pending,
  Completed,
  Canceled,
}

enum MediaTypeEnum {
  other,
  Image,
  Video,
}

enum PackageTypeEnum { other, Daily, Monthly, Qurater, Biannual, Yearly, Weekly }

enum TechType {
  technical,
  cooperate,
}

enum TransactionTypeEnum {
  other,
  Deposit,
  Withdraw,
}

enum OrderStatusEnum { Pending, Paid, AssignedToProvider, InTheWay, TryingSolveProblem, Solved, ClientConfirmation }

enum DeviceTypeEnum {
  other,
  IOS,
  Android,
}

enum ApplicationTypeEnum {
  other,
  Technical,
  Client,
}

enum GenderEnum {
  male,
  female;

  int get id => index + 1; // male → 1, female → 2

  String get label => name; // 'male' / 'female'
}
