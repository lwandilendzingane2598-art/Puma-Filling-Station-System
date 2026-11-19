# Puma Filling Station System

A web-based employee management, attendance clocking, and payroll system built with PHP, MySQL/MariaDB, and biometric verification

## Core Features

### 1. Authentication & Biometric Verification
* **Registration, Login & Logout:** Role-based access control separating standard employees from Human Resources (HR) personnel
* **Biometric Integration:** Utilizes pre-processed employee biometric profiles (`biometric_db/` `.pkl` models and `biometrics/` text records) alongside facial/image verification (`test_images/`) to authenticate employee identity during login and clocking

### 2. Employee Actions
* **Clocking In & Out:** Employees record shift start and end timestamps verified against their registered profile.
* **Profile Management:** View and update personal employee details and attendance status.

### 3. HR Actions (Admin / HR Only)
* **Payroll Management:** Generate and review employee pay records based on logged attendance and shift hours.
* **Data Calculations:** Restricted HR module for computing total hours worked, overtime, deductions, and net pay.
* **System Backup & Reset:** Create database/system backups and reset attendance or cycle records when starting a new pay period.

---

## Project Structure

* `index.php` — Main application entry point, routing, and core logic.
* `puma_db.sql` — Relational database schema and initial seed data.
* `biometric_db/` — Serialized biometric model files (e.g., `employee_john.pkl`).
* `biometrics/` — Individual employee biometric reference files (e.g., `Lwex.txt`, `Sbonelo.txt`).
* `test_images/` — Sample images used for testing login and biometric matching.
---

## Local Setup & Installation

1. **Database Setup:**
* Open **phpMyAdmin** (or your MySQL/MariaDB client) on `localhost` / `127.0.0.1`.
* Create a new database (e.g., `puma_db`) and import `puma_db.sql`
2. **Application Configuration:**
* Place the project folder inside your local server root directory (such as `htdocs` for XAMPP).
* Ensure the database host, username, password, and database name in `index.php` match your local server configuration.
3. **Run the System:**
* Start Apache and MySQL in your local server control panel.
* Navigate to `http://localhost/Puma-Filling-Station-System/` in your browser.

---

## Privacy & Data Notice
> **Note:** The files included in `biometric_db/`, `biometrics/`, and `test_images/` are sample/test artifacts intended solely for development and demonstration purposes. Do not upload real employee biometric records or production credentials to a public repository.
