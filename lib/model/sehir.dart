class Sehir {

  final String il;
  final String ilce;

  Sehir({
    required this.il,
    required this.ilce,
  });

  factory Sehir.fromJson(Map<String, dynamic> json) {
    return Sehir(
      il: json['dc_Il'],
      ilce: json['dc_Ilce'],
    );
  }
}
