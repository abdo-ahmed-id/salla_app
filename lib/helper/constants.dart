class Constants {
  static List<K> cars = [
    K(brand: 'MG', model: ['3', '5', '6', 'RX5', 's350', 'Zs']),
    K(brand: 'BYD', model: [
      'F3',
      'F0',
      'L3',
    ]),
    K(
      brand: 'BMW',
      model: [
        '316l-E46',
        '316i-E90',
        '316i-F30',
        '318l-E46',
        '318i-E90',
        '318i-F30',
        '320l-E46',
        '320i-E90',
        '320i-F30',
        '325l-E46',
        '325i-E90',
        '328i-F30',
        '330i-E46',
        '330i-E90',
        '330i-F30',
        '330i-E46',
        '330i-E90',
        '330i-F30',
      ],
    ),
    K(brand: 'DFSK', model: []),
    K(brand: '', model: []),
    K(brand: '', model: []),
    K(brand: '', model: []),
    K(brand: '', model: []),
    K(brand: '', model: []),
    K(brand: '', model: []),
    K(brand: '', model: []),
  ];

  static List<String> categoryCars = ['ملاكي'];
  static List<String> brandCars = [
    'MG',
    'BYD',
    'BMW',
    'DFSK',
    'اسبرانزا',
    'البينا',
    'الفاروميو',
    'اوبل',
    'اودي',
    'بروتون',
    'بريليانس',
    'بيجو',
    'تشانجان',
    'تويوتا',
    'جاك',
    'جريتوول',
    'جلوري',
    'جيب',
    'جيلي',
    'دايهاتسو',
    'دايو',
    'سكودا',
    'سوزوكي',
    'سيات',
    'شيفروليه',
    'فيات',
    'لادا',
    'مرسيدس',
    'ميني',
    'نيسان',
  ];
  static List<String> mGModelCars = ['3', '5', '6', 'RX5', 's350', 'Zs'];
  static List<String> bYDModelCars = [
    'F3',
    'F0',
    'L3',
  ];
}

class K {
  final String brand;
  final List<String> model;

  K({this.brand, this.model});
}
