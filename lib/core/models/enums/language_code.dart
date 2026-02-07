
enum LanguageCode {
  ar(label: "arabic"),
  en(label: "english");

  final String label;

  const LanguageCode({required this.label});

  factory LanguageCode.fromCode(String code) {
    return LanguageCode.values.firstWhere(
          (e) => e.name == code,
      orElse: () => LanguageCode.en,
    );
  }
}
