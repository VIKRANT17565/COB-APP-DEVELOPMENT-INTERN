import 'package:http/http.dart' as http;

// rapidapi.com

/////////////////////////////////// Books ///////////////////////////////////

// Search Books by Name
Future<http.Response> searchBooksByName(String name) async {
  final response = await http.get(
    Uri.parse('https://book-search.p.rapidapi.com/search/$name'),
    headers: {
      'x-rapidapi-key': 'aa46436ad3msh6c3a50f4bbf69fep122893jsn73e1b45ae524',
      'x-rapidapi-host': 'book-search.p.rapidapi.com',
    },
  );
  return response;
}

// Get the Top 15 most popular books in a Month of an Year**
Future<http.Response> getTop15BooksInMonthOfYear(
    String month, String year) async {
  final response = await http.get(
    Uri.parse('https://book-search.p.rapidapi.com/books?month=$month&year=$year'),
    headers: {
      'x-rapidapi-key': 'aa46436ad3msh6c3a50f4bbf69fep122893jsn73e1b45ae524',
      'x-rapidapi-host': 'book-search.p.rapidapi.com',
    },
  );
  return response;
}

// List of Nominated Books for a Genre in a Year
Future<http.Response> getNominatedBooksForGenreInYear(
    String genre, String year) async {
  final response = await http.get(
    Uri.parse('https://book-search.p.rapidapi.com/nominations?genre=$genre&year=$year'),
    headers: {
      'x-rapidapi-key': 'aa46436ad3msh6c3a50f4bbf69fep122893jsn73e1b45ae524',
      'x-rapidapi-host': 'book-search.p.rapidapi.com',
    },
  );
  return response;
}


// Get the Awarded Books of a Year
Future<http.Response> getAwardedBooksOfYear(String year) async {
  final response = await http.get(
    Uri.parse('https://book-search.p.rapidapi.com/awards?year=$year'),
    headers: {
      'x-rapidapi-key': 'aa46436ad3msh6c3a50f4bbf69fep122893jsn73e1b45ae524',
      'x-rapidapi-host': 'book-search.p.rapidapi.com',
    },
  );
  return response;
}


// Get Weekly Popular Books by Genre**
Future<http.Response> getWeeklyPopularBooksByGenre(String genre, {int itemCount = 10}) async {
  final response = await http.get(
    Uri.parse('https://hapi-books.p.rapidapi.com/week/$genre/$itemCount'),
    headers: {
      'x-rapidapi-key': 'aa46436ad3msh6c3a50f4bbf69fep122893jsn73e1b45ae524',
      'x-rapidapi-host': 'book-search.p.rapidapi.com',
    },
  );
  return response;
}


// Get Book Information by Book Id
Future<http.Response> getBookInformationByBookId(String bookId) async {
  final response = await http.get(
    Uri.parse('https://book-search.p.rapidapi.com/book?id=$bookId'),
    headers: {
      'x-rapidapi-key': 'aa46436ad3msh6c3a50f4bbf69fep122893jsn73e1b45ae524',
      'x-rapidapi-host': 'book-search.p.rapidapi.com',
    },
  );
  return response;
}


/////////////////////////////////// Authors ///////////////////////////////////

// Get the Most Popular Authors
Future<http.Response> getMostPopularAuthors() async {
  final response = await http.get(
    Uri.parse('https://book-search.p.rapidapi.com/authors'),
    headers: {
      'x-rapidapi-key': 'aa46436ad3msh6c3a50f4bbf69fep122893jsn73e1b45ae524',
      'x-rapidapi-host': 'book-search.p.rapidapi.com',
    },
  );
  return response;
}


// Get Author Information by Id
Future<http.Response> getAuthorInformationById(String authorId) async {
  final response = await http.get(
    Uri.parse('https://book-search.p.rapidapi.com/author?id=$authorId'),
    headers: {
      'x-rapidapi-key': 'aa46436ad3msh6c3a50f4bbf69fep122893jsn73e1b45ae524',
      'x-rapidapi-host': 'book-search.p.rapidapi.com',
    },
  );
  return response;
}