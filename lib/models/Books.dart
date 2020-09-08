class Books{

  final String bookId;
  final String bookTitle;
  final String uploaderId;
  final int rating;
  final String categoryId;
  final String bookPDF;
  final String bookCover;
  final String bookDescription;


  Books(this.bookId, this.bookTitle, this.uploaderId,
      this.rating, this.categoryId,this.bookPDF, this.bookCover,this.bookDescription);

  static Books fromJson(map){
    return Books(
        map["bookId"],
        map["bookTitle"],
        map["uploaderId"],
        map["rating"],
        map["categoryId"],
        map["bookPDF"],
        map["bookCover"],
        map["bookDescription"]
    );
  }

  Map<String, Object> toJson(){
    return {
      "bookId":bookId,
      "bookTitle":bookTitle,
      "uploaderId":uploaderId,
      "rating":rating,
      "categoryId":categoryId,
      "bookPDF":bookPDF,
      "bookCover":bookCover,
      "bookDescription":bookDescription
    };
  }
}