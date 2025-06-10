namespace my.bookstore;

entity Authors {
  key ID: UUID;
  name : String;
  bio  : String;

  books : Association to many BookAuthors on books.author = $self;
}

entity Categories {
  key ID : UUID;
  name   : String;

  books : Association to many BookCategories on books.category = $self;
}

entity Books {
  key ID        : UUID;
  title         : String;
  stock         : Integer;
  price         : Decimal(10,2);
  publishedOn   : Date;

  authors : Association to many BookAuthors on authors.book = $self;
  categories : Association to many BookCategories on categories.book = $self;
}

entity BookAuthors {
  key bookID   : UUID;
  key authorID : UUID;

  book   : Association to Books    on book.ID = bookID;
  author : Association to Authors  on author.ID = authorID;
}

entity BookCategories {
  key bookID     : UUID;
  key categoryID : UUID;

  book     : Association to Books      on book.ID = bookID;
  category : Association to Categories on category.ID = categoryID;
}

entity Sales {
  key ID      : UUID;
  book        : Association to Books;
  quantity    : Integer;
  soldOn      : Date;
}
