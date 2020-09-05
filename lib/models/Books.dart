class Books{

  final String bookId;
  final String bookTitle;
  final String uploaderName;
  final String uploaderId;
  final int rating;
  final int categoryId;
  final String bookPDF;
  final String bookCover;

  Books(this.bookId, this.bookTitle, this.uploaderName, this.uploaderId,
      this.rating, this.categoryId,this.bookPDF, this.bookCover);

  Map<String, Object> toJson(){
    return {
      "bookId":bookId,
      "bookTitle":bookTitle,
      "uploaderName":uploaderName,
      "uploaderId":uploaderId,
      "rating":rating,
      "categoryId":categoryId,
      "bookPDF":bookPDF,
      "bookCover":bookCover
    };
  }
}