class SubscriptionPack {
  // title: '1 Month - 4.99€',
  // saveText: 'Normal price',
  // monthlyPrice: '4.99€/Month',
  // productId: 'igshark_premium_4.99_month',

  String productId;
  String title;
  String description;
  String price;
  String monthlyPrice;
  String saveText;

  SubscriptionPack({
    required this.productId,
    required this.title,
    required this.description,
    required this.price,
    required this.monthlyPrice,
    required this.saveText,
  });
}
