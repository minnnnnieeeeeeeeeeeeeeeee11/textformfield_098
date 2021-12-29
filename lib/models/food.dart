class Food {
  String? thName;
  String? enName;
  String? foodvalue;
  int? Price;

// constucktor
  Food(this.enName, this.thName, this.foodvalue, this.Price);

  static List<Food> getFood() {
    return [
      Food('Pizza', 'พิซซ่า', 'pizza', 59),
      Food('Steak', 'สเต็ก', 'steak', 239),
      Food('Salad', 'สลัด', 'salad', 79),
      Food('Shabu', 'ชาบู', 'shabu', 399),
    ];
  }
}
