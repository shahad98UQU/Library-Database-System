# Library Database Management System (SQL Implementation)

## Project Overview
This project delivers a robust relational database schema designed to streamline library administration, tracking transactions across employees, customers, and book loan registries.

## Core Features & SQL Implementations
* **Data Definition & Schema Design:** Constructed foundational structures including automated tracking arrays such as `Blacklist` and `RequestedBooks` logs.
* **Relational Analytics (Joins):** Built complex multi-table `JOIN` statements to correlate transaction histories bridging employee and customer interaction matrices.
* **Advanced Database Views:** Developed optimization views (`BestRentedBooks` and `info`) using analytic functions like `DATEDIFF` and `COUNT` to synthesize high-level management metrics.
* **Data Integrity Enforcement (Triggers):** Programmed procedural database triggers (`BEFORE UPDATE` / `BEFORE DELETE`) using custom state assertions (`SIGNAL SQLSTATE '45000'`) to eliminate dirty data writes and prevent incomplete record deletion.

## Technologies Used
* SQL / MySQL Dialect
* Relational Database Management Systems (RDBMS)
