class WalletParams {
  final num amount;
 final String accountName;
 final String iban;
 final String bankName;
  final int userId;
  final int transactionType;

  WalletParams(
      {required this.amount,
     required this.accountName,
     required this.transactionType,
     required this.iban,
      required this.bankName,
      required this.userId
      });

  Map<String, Object> toJson() => {
        'amount': amount,
       if (accountName != '') 'accountName': accountName,
       if (accountName != '') 'iban': iban,
        'userId': userId,
       if (accountName != '') 'bankName': bankName,
       'transactionType': transactionType,
      };
}
