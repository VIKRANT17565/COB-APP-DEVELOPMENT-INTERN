List<String> genres = [
  'Fiction',
  'Literary Fiction',
  'Historical Fiction',
  'Science Fiction',
  'Fantasy',
  'Mystery',
  'Autobiography',
  'Biography',
  'Philosophy',
  'History',
  'Science',
  'Poetry',
  'Drama',
  'Tragedy',
  'Young Adult',
  'Romance',
];

int getCurrentYear() {
  return DateTime.now().year;
}

int getCurrentMonth() {
  return DateTime.now().month;
}

// RapidAPI Key

Map<String, String> rapidAPIKeyByUser = {
  'vikrant': 'aa46436ad3msh6c3a50f4bbf69fep122893jsn73e1b45ae524',
  'laughingFox': '4c090535d0msh9ee9c313d0d28fdp194d6cjsnec2b605ad380',
  'vikrantClg': '241d0bcd57msh393bfb6bc1fa67ep1bc350jsnae9bb910f0cc',
};

String rapidAPIKey = rapidAPIKeyByUser['laughingFox']!;

Map<String, dynamic> searchedBookInfoById = {};
