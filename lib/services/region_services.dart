class RegionServices {
  static String locale = 'en_NG';
  static String currencySymbol = '₦';

  static void updateRegion({
    required String newLocale,
    required String newCurrencySymbol,
  }) {
    locale = newLocale;
    currencySymbol = newCurrencySymbol;
  }
}
