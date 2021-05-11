extension StringExtension on String {
  String removeAccent() {
    return this
        .replaceAll('â', 'a')
        .replaceAll('ã', 'a')
        .replaceAll('à', 'a')
        .replaceAll('á', 'a')
        .replaceAll('Â', 'a')
        .replaceAll('Ã', 'a')
        .replaceAll('À', 'a')
        .replaceAll('Á', 'a')
        .replaceAll('ê', 'e')
        .replaceAll('é', 'e')
        .replaceAll('è', 'e')
        .replaceAll('Ê', 'e')
        .replaceAll('É', 'e')
        .replaceAll('È', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ì', 'i')
        .replaceAll('Í', 'i')
        .replaceAll('Ì', 'i')
        .replaceAll('ô', 'o')
        .replaceAll('õ', 'o')
        .replaceAll('ò', 'o')
        .replaceAll('ó', 'o')
        .replaceAll('Ô', 'o')
        .replaceAll('Õ', 'o')
        .replaceAll('Ò', 'o')
        .replaceAll('Ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ù', 'u')
        .replaceAll('Ú', 'u')
        .replaceAll('Ù', 'u')
        .toLowerCase();
  }
}