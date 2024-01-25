class Pagination {
  int currentPage = 1;
  int perPage = 5;
  int totalItems = 0;

  int get totalPages => (totalItems + perPage - 1) ~/ perPage;
}