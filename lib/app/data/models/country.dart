class Country {
  final String name;
  final String dialCode;
  final String flag;
  final String code;

  const Country({
    required this.name,
    required this.dialCode,
    required this.flag,
    required this.code,
  });
}

// List of countries with their data
final List<Country> countries = [
  Country(
    name: 'Afghanistan',
    dialCode: '+93',
    flag: '🇦🇫',
    code: 'AF',
  ),
  Country(
    name: 'Îles Åland',
    dialCode: '+358',
    flag: '🇦🇽',
    code: 'AX',
  ),
  Country(
    name: 'Albanie',
    dialCode: '+355',
    flag: '🇦🇱',
    code: 'AL',
  ),
  Country(
    name: 'Algérie',
    dialCode: '+213',
    flag: '🇩🇿',
    code: 'DZ',
  ),
  Country(
    name: 'Cameroun',
    dialCode: '+237',
    flag: '🇨🇲',
    code: 'CM',
  ),
  // Add more countries as needed
];
