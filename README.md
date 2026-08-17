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

The project runs with **Docker Compose** and includes **Adminer** as a web-based GUI for viewing tables, editing data, and running SQL queries.

---

## Technologies

- PostgreSQL 16
- Docker
- Docker Compose
- Adminer
- SQL
- Git / GitHub

---

## Architecture

The project uses two Docker containers:

```text
Browser
   |
   | localhost:8080
   v
Adminer
   |
   | Docker internal network
   | Server: db
   v
PostgreSQL
   |
   v
Metropolis Library Database
```

The PostgreSQL database is **not exposed directly to the host computer**.

Adminer communicates with PostgreSQL internally using the Docker Compose service name:

```text
db
```

This avoids conflicts with other PostgreSQL databases that may already use port `5432` on the host computer.

`schema.sql` creates the database structure.

`sample_data.sql` inserts example data.

The PostgreSQL image is built using the provided `Dockerfile`.

---

## Database Structure

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

The tables `book_authors` and `book_categories` are junction tables used for many-to-many relationships.

---

# How to Start the Project

## 1. Clone the repository

If GitHub SSH is configured:

```bash
git clone git@github.com:b-maystorov/metropolis-library-db.git
```

Enter the project folder:

```bash
cd metropolis-library-db
```

## 2. Start the containers

```bash
docker compose up -d --build
```

This starts:

- PostgreSQL
- Adminer

Check that both containers are running:

```bash
docker compose ps
```

---

# Adminer Login

Open in your browser:

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

Important:

```text
Server: db
```

Do **not** use `localhost` as the database server in Adminer.

`db` is the Docker Compose service name of the PostgreSQL container.

After logging in, the database tables should appear on the left side.

---

# Example SQL Queries

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

# Troubleshooting

## Adminer cannot connect

First check whether both containers are running:

```bash
docker compose ps
```

Make sure the Adminer login uses:

```text
Server: db
```

If a container is not running, check the logs:

```bash
docker compose logs
```

Database logs only:

```bash
docker compose logs db
```

Adminer logs only:

```bash
docker compose logs adminer
```

---

## Port 8080 is already in use

Adminer uses host port `8080`.

Check running Docker containers:

```bash
docker ps
```

If another container is already using port `8080`, stop it:

```bash
docker stop <container-name>
```

Then start the project again:

```bash
docker compose up -d
```

Alternatively, change the Adminer port in `docker-compose.yml`.

For example:

```yaml
ports:
  - "8081:8080"
```

Adminer would then be available at:

```text
http://localhost:8081
```

---

## PostgreSQL port 5432

The PostgreSQL container does **not** publish port `5432` to the host computer.

This is intentional.

Adminer connects directly to PostgreSQL through Docker's internal network:

```text
Adminer -> db:5432
```

Therefore, another PostgreSQL database using port `5432` on the host should not conflict with this project.

---

## Database tables are missing

Check the container status:

```bash
docker compose ps
```

Then check the database logs:

```bash
docker compose logs db
```

To recreate the project from the original SQL files:

```bash
docker compose down
docker compose up -d --build
```

This creates a fresh PostgreSQL container and runs:

```text
schema.sql
sample_data.sql
```

again.

---

# Stop and Start the Project

To temporarily stop the containers without deleting them:

```bash
docker compose stop
```

Start them again:

```bash
docker compose start
```

## Remove and recreate the project

```bash
docker compose down
docker compose up -d --build
```

### Important

The project currently does **not** use a PostgreSQL Docker volume.

This means that changes made only inside the running database or through Adminer can be lost when the database container is removed with:

```bash
docker compose down
```

The database will then be recreated from:

```text
schema.sql
sample_data.sql
```

Official changes to the database structure should therefore also be added to the SQL files in the repository.

---

# Getting Updates

If the repository has already been cloned and a newer version is available:

```bash
git pull
```

Then rebuild and start the updated project:

```bash
docker compose down
docker compose up -d --build
```

---

# Project Files

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
