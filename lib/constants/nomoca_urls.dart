class NomocaUrls {
  static const contentsBaseUrl =
      String.fromEnvironment('NOMOCA_CONTENTS_BASE_URL');
  static const imageCDNBaseUrl =
      String.fromEnvironment('NOMOCA_IMAGE_CDN_BASE_URL');
  static const termsUrl = '$contentsBaseUrl/static/app/terms.html';
  static const privacyPolicyUrl = '$contentsBaseUrl/static/app/policy.html';
}
