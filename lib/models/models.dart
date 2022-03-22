class BookModel{
  String bookName="";
  String bookAuthor="";
  String bookPage="";
  String bookCover="";
  String bookDescription = "";

  BookModel({required this.bookName, required this.bookAuthor, required this.bookPage, required this.bookCover, required this.bookDescription});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      bookName: json['items'][2]['volumeInfo']['title'],
      bookAuthor: json['items'][2]['volumeInfo']['authors'][0],
      bookPage: json['items'][2]['volumeInfo']['pageCount'].toString(),
      bookCover: json['items'][2]['volumeInfo']['imageLinks']['thumbnail'],
      bookDescription: json['items'][2]['volumeInfo']['description']
    );
  }
}