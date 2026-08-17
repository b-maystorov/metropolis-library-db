# Metropolis Library Database

## Project Overview

This project contains a PostgreSQL database for the fictional **Metropolis Library**.

The database manages:

- books
- physical book copies
- authors
- categories
- members
- loans

The database runs inside Docker and includes **Adminer** as a web-based GUI for viewing tables and running SQL queries.

## Technologies

- PostgreSQL 16
- Docker
- Docker Compose
- Adminer
- SQL
- Git / GitHub

## Architecture

The project uses two containers:

```text
Browser
   |
   v
Adminer
   |
   v
PostgreSQL
   |
   v
Metropolis Library Database
```

`schema.sql` creates the database structure.

`sample_data.sql` inserts example data.

The Docker image is built using the provided `Dockerfile`.

## Database Structure

The database contains the following tables:

| Table             | Purpose                                                |
| ----------------- | ------------------------------------------------------ |
| `books`           | Stores general book information such as title and ISBN |
| `book_copies`     | Stores each physical copy owned by the library         |
| `authors`         | Stores author information                              |
| `book_authors`    | Connects books and authors                             |
| `categories`      | Stores book categories                                 |
| `book_categories` | Connects books and categories                          |
| `members`         | Stores library member information                      |
| `loans`           | Stores borrowing and return information                |

The connection tables `book_authors` and `book_categories` are used for many-to-many relationships.

---

## How to Start the Project

### 1. Clone the repository

```bash
git clone git@github.com:b-maystorov/metropolis-library-db.git
```

Enter the project folder:

```bash
cd metropolis-library-db
```

### 2. Start the containers

```bash
docker compose up -d --build
```

This starts:

- PostgreSQL
- Adminer

Check if both containers are running:

```bash
docker compose ps
```

---

## Adminer Login

Open:

```text
http://localhost:8080
```

Use:

```text
System: PostgreSQL
Server: db
Username: postgres
Password: library123
Database: library
```

After logging in, the library tables should appear on the left side.

You can now view the data or execute SQL queries directly through Adminer.

## Example SQL Queries

Show all books:

```sql
SELECT * FROM books;
```

Show all members:

```sql
SELECT * FROM members;
```

Show books together with their authors:

```sql
SELECT
    books.title,
    authors.first_name,
    authors.last_name
FROM books
JOIN book_authors
    ON books.book_id = book_authors.book_id
JOIN authors
    ON book_authors.author_id = authors.author_id;
```

Show all active loans:

```sql
SELECT *
FROM loans
WHERE return_date IS NULL;
```

---

## Troubleshooting

### Port 5432 is already in use

Check running containers:

```bash
docker ps
```

Stop the container using PostgreSQL:

```bash
docker stop <container-name>
```

Then start the project again:

```bash
docker compose up -d
```

### Port 8080 is already in use

Check which container is using the port:

```bash
docker ps
```

Stop the conflicting container or change the Adminer port in `docker-compose.yml`.

### Adminer cannot connect

Make sure the login uses:

```text
Server: db
```

Do not use `localhost` as the database server inside Adminer.

Check the containers:

```bash
docker compose ps
```

View errors:

```bash
docker compose logs
```

### Database tables are missing

Rebuild the project:

```bash
docker compose down
docker compose up -d --build
```

---

## Stop the Project

```bash
docker compose down
```

Start it again:

```bash
docker compose up -d
```

---

## Project Files

```text
metropolis-library-db/
├── Dockerfile
├── docker-compose.yml
├── schema.sql
├── sample_data.sql
└── README.md
```

- `schema.sql` – creates the database tables
- `sample_data.sql` – inserts example data
- `Dockerfile` – builds the PostgreSQL image
- `docker-compose.yml` – starts PostgreSQL and Adminer
- `README.md` – project documentation
