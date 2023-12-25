bool hasError(int statusCode) {
  return statusCode < 200 || statusCode >= 300;
}
