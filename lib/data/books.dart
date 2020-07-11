// class Book {
//   final String bookAuthor, bookName, category, image;
//   final double bookRating, numRating;
//   Book({
//     this.image,
//     this.bookName,
//     this.bookAuthor,
//     this.bookRating,
//     this.category,
//     this.numRating,
//   });
// }

// Future<void> addRestaurant(Book book) {
//   final restaurants = Firestore.instance.collection('books');
//   return restaurants.add({
//     'image': book.bookAuthor,
//     'bookName': book.bookName,
//     'bookAuthor': book.bookAuthor,
//     'bookRating': book.bookRating,
//     'catergory': book.category,
//     'numRating': book.numRating,
//   });
// }

final books = [
  'Nepal',
  'India',
  'Corona',
  'PaniPuri',
  'Apple',
  'Dota',
  'Beta',
  'Earth',
  'Dog',
  'Game',
  'Flutter',
  'Tirthe ko Prem katha',
  'Blank kanda',
  'Cancer Pidit',
  'Haku ko jawani',
  'Sajish ko Invoker Sumiya bhanda babal'
];
