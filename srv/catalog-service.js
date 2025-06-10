const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
  const { Books, BookCategories } = this.entities;

  // 📦 Action: Restock Book
  this.on('restockBook', async (req) => {
    const { bookID, quantity } = req.data;

    if (quantity <= 0) return req.error(400, 'Quantity must be a positive number');

    const book = await SELECT.one.from(Books).where({ ID: bookID });
    if (!book) return req.error(404, 'Book not found');

    const updatedStock = book.stock + quantity;
    await UPDATE(Books).set({ stock: updatedStock }).where({ ID: bookID });

    return `Stock updated to ${updatedStock}`;
  });

  // 📚 Function: Get Books by Category
  this.on('getBooksByCategory', async (req) => {
    const { categoryID } = req.data;

    const rows = await cds.run(`
      SELECT B.*
      FROM my_bookstore_Books AS B
      JOIN my_bookstore_BookCategories AS BC ON B.ID = BC.bookID
      WHERE BC.categoryID = '${categoryID}'
    `);

    return rows;
  });

  // ❌ Validation: Prevent negative stock or price
  this.before(['CREATE', 'UPDATE'], 'Books', (req) => {
    if (req.data.stock < 0) {
      req.error(400, 'Stock cannot be negative');
    }
    if (req.data.price < 0) {
      req.error(400, 'Price cannot be negative');
    }
  });

  // ❌ Validation: Prevent duplicate titles
  this.before('CREATE', 'Books', async (req) => {
    const exists = await SELECT.one.from(Books).where({ title: req.data.title });
    if (exists) {
      req.error(400, `Book titled "${req.data.title}" already exists.`);
    }
  });
});
