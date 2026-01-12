class SelfOrdering {
  final String orderId;
  final String terminalSeq;
  final String fawryRef;
  final String paymentOption;
  final String cardNumber;
  final bool isVoid;
  final bool isRefunded;

  SelfOrdering({
    required this.orderId,
    required this.terminalSeq,
    required this.fawryRef,
    required this.paymentOption,
    required this.cardNumber,
    required this.isVoid,
    required this.isRefunded,
  });

  factory SelfOrdering.fromJson(Map<String, dynamic> json) {
    return SelfOrdering(
      orderId: json['orderId']?.toString() ?? '',
      terminalSeq: json['clientTerminalSequenceID']?.toString() ?? '',
      fawryRef: json['fawryReference']?.toString() ?? '',
      paymentOption: json['paymentOption']?.toString() ?? '',
      cardNumber: json['cardNumber']?.toString() ?? '',
      isVoid: json['isVoid'] ?? false,
      isRefunded: json['isRefunded'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'clientTerminalSequenceID': terminalSeq,
      'fawryReference': fawryRef,
      'paymentOption': paymentOption,
      'cardNumber': cardNumber,
      'isVoid': isVoid,
      'isRefunded': isRefunded,
    };
  }

  static const List<String> fields = [
    'orderId',
    'clientTerminalSequenceID',
    'fawryReference',
    'paymentOption',
    'cardNumber',
    'isVoid',
    'isRefunded',
  ];
}
