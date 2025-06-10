using my.bookstore as my from './data-model';

view TopSellingBooks as select from my.Sales as S
  inner join my.Books as B on S.book.ID = B.ID {
    key B.ID        as bookID,
        B.title     as title,
        sum(S.quantity) as totalSold
  }
  group by B.ID, B.title;
