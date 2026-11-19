# Puma Filling Station System

A web-based employee management, attendance clocking, and payroll system built with PHP, MySQL/MariaDB, and biometric verification[span_4](start_span)[span_4](end_span)[span_5](start_span)[span_5](end_span)[span_6](start_span)[span_6](end_span).

## Core Features

### 1. Authentication & Biometric Verification
* **Registration, Login & Logout:** Role-based access control separating standard employees from Human Resources (HR) personnel[span_7](start_span)[span_7](end_span).
* **Biometric Integration:** Utilizes pre-processed employee biometric profiles (`biometric_db/` `.pkl` models and `biometrics/` text records) alongside facial/image verification (`test_images/`) to authenticate employee identity during login and clocking[span_8](start_span)[span_8](end_span)[span_9](start_span)[span_9](end_span)[span_10](start_span)[span_10](end_span).

### 2. Employee Actions
* **Clocking In & Out:** Employees record shift start and end timestamps verified against their registered profile[span_11](start_span)[span_11](end_span)[span_12](start_span)[span_12](end_span).
* **Profile Management:** View and update personal employee details and attendance status[span_13](start_span)[span_13](end_span).

### 3. HR Actions (Admin / HR Only)
* **Payroll Management:** Generate and review employee pay records based on logged attendance and shift hours[span_14](start_span)[span_14](end_span).
* **Data Calculations:** Restricted HR module for computing total hours worked, overtime, deductions, and net pay[span_15](start_span)[span_15](end_span).
* **System Backup & Reset:** Create database/system backups and reset attendance or cycle records when starting a new pay period[span_16](start_span)[span_16](end_span).

---

## Project Structure

* `index.php` — Main application entry point, routing, and core logic[span_17](start_span)[span_17](end_span)[span_18](start_span)[span_18](end_span).
* `puma_db.sql` — Relational database schema and initial seed data[span_19](start_span)[span_19](end_span)[span_20](start_span)[span_20](end_span).
* `biometric_db/` — Serialized biometric model files (e.g., `employee_john.pkl`)[span_21](start_span)[span_21](end_span)[span_22](start_span)[span_22](end_span).
* `biometrics/` — Individual employee biometric reference files (e.g., `Lwex.txt`, `Sbonelo.txt`)[span_23](start_span)[span_23](end_span)[span_24](start_span)[span_24](end_span).
* `test_images/` — Sample images used for testing login and biometric matching[span_25](start_span)[span_25](end_span)[span_26](start_span)[span_26](end_span).

---

## Local Setup & Installation

1. **Database Setup:**
* Open **phpMyAdmin** (or your MySQL/MariaDB client) on `localhost` / `127.0.0.1`[span_27](start_span)[span_27](end_span).
* Create a new database (e.g., `puma_db`) and import `puma_db.sql`[span_28](start_span)[span_28](end_span)[span_29](start_span)[span_29](end_span).
2. **Application Configuration:**
* Place the project folder inside your local server root directory (such as `htdocs` for XAMPP).
* Ensure the database host, username, password, and database name in `index.php` match your local server configuration[span_30](start_span)[span_30](end_span).
3. **Run the System:**
* Start Apache and MySQL in your local server control panel.
* Navigate to `http://localhost/Puma-Filling-Station-System/` in your browser[span_31](start_span)[span_31](end_span).

---

## Privacy & Data Notice
> **Note:** The files included in `biometric_db/`, `biometrics/`, and `test_images/` are sample/test artifacts intended solely for development and demonstration purposes[span_32](start_span)[span_32](end_span)[span_33](start_span)[span_33](end_span). Do not upload real employee biometric records or production credentials to a public repository.
