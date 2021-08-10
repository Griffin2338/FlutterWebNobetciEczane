class Eczane {
  final int id;
  final String name;
  final String sehir;
  final String ilce;


  Eczane({
    required this.id,
    required this.name,
    required this.sehir,
    required this.ilce,

  });

  factory Eczane.fromJson(Map<String, dynamic> json) {
    return Eczane(
      id: json['ID'],
      name: json['dc_Eczane_Adi'],
      sehir: json['dc_Il'],
      ilce: json['dc_Ilce'],

    );
  }
}
