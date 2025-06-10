using my.bookstore as my from '../db/data-model';

service CatalogService {
  entity Books           as projection on my.Books;
  entity Authors         as projection on my.Authors;
  entity Categories      as projection on my.Categories;
  entity BookAuthors     as projection on my.BookAuthors;
  entity BookCategories  as projection on my.BookCategories;
  entity Sales           as projection on my.Sales;
// action(change the data ) - name of the action - input parameter - input parameter - return string(output)
//  called via  POST /restockBook
// Body: { "bookID": "abc-123", "quantity": 10 }
// → Response: "Restocked 10 units"
  action restockBook(bookID: UUID, quantity: Integer) returns String;

// function = query , only reads the data 
// function - name of the func - input - a list of matching book records;
// called via GET /getBooksByCategory?categoryID=xyz-789
// → Response: [ list of books in that category ]
  function getBooksByCategory(categoryID: UUID) returns array of Books;
}
