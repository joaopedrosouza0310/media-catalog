String normalizeApiBaseUrl(String value) {
  return value.endsWith('/') ? value : '$value/';
}
