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
    // 'BMW',
    'DFSK',
    'اسبرانزا',
    'البينا',
    'الفاروميو',
    'اوبل',
    'اوداي',
    'بروتون',
    'بريليانس',
    'بيجو',
    'تشانجان',
    'تويوتا',
    'جاك',
    'جريتوول',
    'جلوري',
    'جيب',
    // 'جيلي',
    // 'دايهاتسو',
    // 'دايو',
    // 'سكودا',
    // 'سوزوكي',
    // 'سيات',
    // 'شيفروليه',
    // 'فيات',
    // 'لادا',
    'مرسيدس',
    // 'ميني',
    // 'نيسان',
  ];
  static List<String> odayModelCars = [
    '80',
    'A1',
    'A3',
    'A4',
    'A5',
    'A6',
    'Q3',
    'Q5',
    'Q7',
    'S4'
  ];
  static List<String> protonModelCars = [
    'اكسورا',
    'بريفي',
    'بيرسونا',
    'جين2',
    'ساجا',
    'واجا',
    'ويرا'
  ];
  static List<String> brelyansModelCars = [
    'جالينا',
    'سبلندور',
    'كروس',
    'FRV',
    'FSV',
    'SVR',
    'V5',
    'V6'
  ];
  static List<String> bigoModelCars = [
    '2008',
    '206',
    '207',
    '208',
    '3008',
    '301',
    '307',
    '308',
    '405',
    '406',
    '407',
    '408',
    '5008',
    '504',
    '508',
    '806',
    'بارتنر'
  ];
  static List<String> tshanganModelCars = [
    'مينيبيني',
    'V7',
    'CS35',
  ];
  static List<String> toyotaModelCars = [
    'افانزا',
    'افينسيس',
    'اوريس',
    'ايكو',
    'برادو',
    'تركي',
    'جنوب افريقي',
    'خليجي',
    'ياريس',
    'كامري',
  ];
  static List<String> jakModelCars = [
    'A13',
    'J3',
    'S2',
    'S3',
    'S7',
  ];
  static List<String> gretoolModelCars = ['C30'];
  static List<String> gloaryModelCars = ['جلوري'];
  static List<String> geepModelCars = [
    'جراند شيروكي',
    'رانجلر',
    'رينجيد',
    'شيركي',
    'كومباس',
    'ليبرتي',
    'KK',
    'XJ',
  ];
  static List<String> marsedesModelCars = [
    '200C',
    '200E',
    '280S',
    'A150',
    'A160',
    'B150',
    'B180',
    'C180',
    'C200',
    'C240',
    'C250',
    'C280',
    'C300',
    'CL5000',
    'CLA180',
    'CLA200',
    'CLK2000',
    'E180',
    'E200',
    'E230',
  ];
  static List<String> mGModelCars = ['3', '5', '6', 'RX5', 's350', 'Zs'];
  static List<String> bYDModelCars = ['F3', 'F0', 'L3'];
  static List<String> ispranzaModelCars = ['A11', 'A113', 'L3'];
  static List<String> albenaModelCars = ['B5', 'B6', 'B7', 'B8'];
  static List<String> appleModelCars = [
    'استرا',
    'انسيجنا',
    'تيجرا',
    "كسكادا",
    'جراند لاند'
  ];
  static List<String> alfaromioModelCars = [
    '156',
    '6اسبايدر',
    'جوليتا',
    'ميتو'
  ];
  static List<String> dFSKModelCars = ['EAGLE580'];
}

class K {
  final String brand;
  final List<String> model;

  K({this.brand, this.model});
}
