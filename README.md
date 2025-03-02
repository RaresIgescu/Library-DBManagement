# PL/SQL Library Management System

This project consists of various PL/SQL procedures, functions, triggers, and packages designed to handle a library management system. The system includes functionalities like managing book loans, recommendations for books, and handling library database updates. The main operations include querying data from multiple tables and manipulating it based on certain criteria.

## Overview of Key Components

### 1. **Data Types and Tables**
- **`sala`**: A VARRAY type to hold up to 20 values of `VARCHAR2(50)`, representing rooms (sala) in the library.
- **`log1` Table**: Stores audit logs for table creation, alteration, or deletion events within the schema.

### 2. **Procedures**
- **`exercitiul_6`**: A procedure to display the events organized by a specific reader (`cititor`), along with the rooms and types of events.
- **`exercitiul_7`**: A procedure that displays authors and books from specific publishers (editura) where the books were published after 2000.
- **`exercitiul_8`**: A function that returns detailed information about the last borrowed book of a given reader (`nume_cititor`), including its title, authors, and publication year.
- **`exercitiul_9`**: A procedure that checks if a book has a sufficient number of available copies for loan, and displays detailed information about the book, its authors, location, and current availability status.
  
### 3. **Triggers**
- **`actualizare_autori`**: A trigger that updates the number of authors for a book when a new author is added to the `redacteaza` table.
- **`actualizare_stoc`**: A trigger that updates the stock of available copies when a book is borrowed or returned.

### 4. **Audit Trigger**
- **`exercitiul_12`**: A trigger that logs all actions such as creating, altering, or dropping tables in the schema. The audit logs include the timestamp, user, action type, object name, and object type.

### 5. **Package and Package Body for Recommendations**
- **`exercitiul_13`**: A package for generating book recommendations for a reader based on the genres they have borrowed before. It calculates the popularity of books and recommends the top 3 books for each genre. It also stores the recommendations in the `carti_recomandate` table.

#### Main Functions and Procedures in `exercitiul_13`:
- **`calc_popularitate`**: A function to calculate the popularity of a book based on how many times it has been borrowed.
- **`genuri_imprumutate`**: A function to get a list of genres that a specific reader has borrowed.
- **`commit_to_database`**: A procedure that saves the generated book recommendations to the database.
- **`de_recomandat`**: The main procedure that generates and commits book recommendations for a given reader.

### 6. **Example Queries**
- **Check if a book is available in the library**:
    ```sql
    select nr_disponibile from stoc where id_carte = 10;
    ```

- **Inserting a book loan**:
    ```sql
    insert into imprumut values (6, 10, to_date('2019-08-16', 'YYYY-MM-DD'), null);
    ```

- **Get book recommendations for a reader**:
    ```sql
    begin
        exercitiul_13.de_recomandat(3);
    end;
    ```

### 7. **Usage**
1. **Run the procedures**: Execute the procedures such as `exercitiul_6`, `exercitiul_7`, etc., to display data about books, readers, and events.
2. **Trigger Execution**: The triggers automatically handle updates to authors and book stock when actions occur (e.g., borrowing books).
3. **Audit Tracking**: The `exercitiul_12` trigger will track any changes made to the schema (table creation, modification, or deletion).
4. **Book Recommendations**: The `exercitiul_13` package will provide personalized book recommendations for a given reader based on their previous borrowing history.

## Setup Instructions

1. Execute the PL/SQL scripts to create the necessary types, procedures, triggers, and packages in your Oracle database environment.
2. Ensure that the necessary tables (`imprumut`, `carte`, `cititor`, `redacteaza`, `stoc`, etc.) are already created and populated with data before running the procedures.
3. Test the procedures and triggers by executing various SQL queries (such as book loans, event organization, etc.).

