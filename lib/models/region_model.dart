class RegionModel {
  final String name;
  final String code;
  final String currency;

  const RegionModel({
    required this.name,
    required this.code,
    required this.currency,
  });
}

const List<RegionModel> regions = [
  RegionModel(
    name: "Nigeria",
    code: "en_NG",
    currency: "₦",
  ),

  RegionModel(
    name: "United States",
    code: "en_US",
    currency: "\$",
  ),

  RegionModel(
    name: "United Kingdom",
    code: "en_GB",
    currency: "£",
  ),

  RegionModel(
    name: "Canada",
    code: "en_CA",
    currency: "C\$",
  ),

  RegionModel(
    name: "India",
    code: "en_IN",
    currency: "₹",
  ),

  RegionModel(
    name: "South Africa",
    code: "en_ZA",
    currency: "R",
  ),

  RegionModel(
    name: "Ghana",
    code: "en_GH",
    currency: "₵",
  ),

  RegionModel(
    name: "Kenya",
    code: "en_KE",
    currency: "KSh",
  ),

  RegionModel(
    name: "Germany",
    code: "de_DE",
    currency: "€",
  ),

  RegionModel(
    name: "France",
    code: "fr_FR",
    currency: "€",
  ),
];