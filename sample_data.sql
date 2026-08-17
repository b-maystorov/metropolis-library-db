INSERT INTO books (isbn, title, publication_year)
VALUES
    ('9780451524935', '1984', 1949),
    ('9780451526342', 'Animal Farm', 1945),
    ('9780547928227', 'The Hobbit', 1937);

INSERT INTO authors (first_name, last_name, birth_year)
VALUES
    ('George', 'Orwell', 1903),
    ('J.R.R.', 'Tolkien', 1892);

INSERT INTO book_authors (book_id, author_id)
VALUES
    (1, 1),
    (2, 1),
    (3, 2);    

INSERT INTO categories (name, description)
VALUES
    ('Dystopian', 'Books about oppressive or controlled societies'),
    ('Political Fiction', 'Fiction focused on political systems and power'),
    ('Fantasy', 'Books with fictional worlds, magic, or mythical elements');    

INSERT INTO book_categories (book_id, category_id)
VALUES
    (1, 1),
    (1, 2),
    (2, 2),
    (3, 3);    

INSERT INTO members (first_name, last_name, email, join_date, status)
VALUES
    ('Anna', 'Schmidt', 'anna.schmidt@example.com', '2026-08-01', 'active'),
    ('David', 'Miller', 'david.miller@example.com', '2026-08-05', 'active'),
    ('Lisa', 'Brown', 'lisa.brown@example.com', '2026-08-10', 'blocked');    

INSERT INTO book_copies (book_id, inventory_number, status, location)
VALUES
    (1, 'INV-001', 'available', 'Shelf A1'),
    (1, 'INV-002', 'borrowed', 'Shelf A1'),
    (2, 'INV-003', 'available', 'Shelf B2'),
    (3, 'INV-004', 'available', 'Shelf C1');

INSERT INTO loans (member_id, copy_id, loan_date, due_date, return_date)
VALUES
    (1, 2, '2026-08-10', '2026-08-31', NULL),
    (2, 3, '2026-07-20', '2026-08-10', '2026-08-05');        