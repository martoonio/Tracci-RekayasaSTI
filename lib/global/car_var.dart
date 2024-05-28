class CarsList {
  final String key;
  final String platNomor;
  final String model;
  final String tipe;
  final String tahun;
  final String date;

  CarsList(
    {
      required this.tipe,
      required this.tahun,
      required this.key,
      required this.platNomor,
      required this.model,
      required this.date,
    }
  );

  factory CarsList.fromMap(Map<String, dynamic> data, String key) {
    return CarsList(
      key: key,
      platNomor: data['platNomor'] ?? '',
      model: data['model'] ?? '',
      tipe: data['tipe'] ?? '',
      tahun: data['tahun'] ?? '',
      date: data['date'] ?? '',
    );
  }
}
