# 🏋️ Fitness Tracking SQL

A PostgreSQL-based fitness tracking database project designed to help users log workouts, track exercises, and monitor weight progress over time.

---

## 📁 Project Structure

```
fitness-tracking-sql/
│
├── schema.sql          # Table definitions (CREATE TABLE)
├── inserts.sql         # Sample data (INSERT INTO)
├── analytics.sql       # Analytical queries
├── README.md
│
├── docs/
│   └── er_diagram.png  # ER Diagram
│
└── samples/
    └── sample_queries.sql
```

---

## 🗄️ Database Schema

The project consists of 5 tables:

### `users`
Stores registered users in the system.

| Column | Type | Description |
|---|---|---|
| user_id | serial PK | Unique user identifier |
| name | varchar(50) | Full name |
| age | int | Age |
| gender | varchar(50) | Gender |
| height_cm | int | Height in centimeters |
| weight_kg | int | Weight in kilograms |
| created_at | date | Registration date (default: today) |

### `exercises`
Defines the exercise types available in the system.

| Column | Type | Description |
|---|---|---|
| exercise_id | serial PK | Unique exercise identifier |
| name | varchar(100) | Exercise name |
| muscle_group | varchar(50) | Target muscle group |
| calories_burned_per_min | int | Estimated calories burned per minute |

### `workouts`
Records individual workout sessions performed by users.

| Column | Type | Description |
|---|---|---|
| workout_id | serial PK | Unique workout identifier |
| user_id | int FK | Reference to the user |
| workout_date | date | Date of the workout |
| duration_min | int | Total workout duration in minutes |

### `workout_exercises`
Tracks the exercises performed within a workout, including sets and reps. Acts as a junction table resolving the **M:N** relationship between `workouts` and `exercises`.

| Column | Type | Description |
|---|---|---|
| id | serial PK | Record identifier |
| workout_id | int FK | Reference to the workout |
| exercise_id | int FK | Reference to the exercise |
| sets | int | Number of sets |
| reps | int | Number of repetitions |

### `progress_logs`
Tracks a user's weight over time to monitor physical progress.

| Column | Type | Description |
|---|---|---|
| log_id | serial PK | Record identifier |
| user_id | int FK | Reference to the user |
| log_date | date | Date of the measurement |
| weight_kg | decimal | Recorded weight in kilograms |

---

## 🔗 Relationships

```
users ──< workouts ──< workout_exercises >── exercises
  └──────────────────< progress_logs
```

- A user can have many workout sessions (`1:N`)
- A workout can include many exercises, and an exercise can appear in many workouts (`M:N` → resolved via `workout_exercises`)
- A user can have many progress log entries (`1:N`)

---

## 📊 Analytics Queries

The following queries are included in `analytics.sql`:

| Query | Description |
|---|---|
| Most active user | Ranks users by total number of workouts |
| Total workout time | Total minutes spent working out per user |
| Most used muscle group | Frequency of muscle group targeting across all workouts |
| Most performed exercise | Exercise popularity based on workout history |
| Total calories burned | Estimated calories burned per user |
| Leaderboard (RANK) | Window function ranking by total workout duration |

---

## 🧪 Sample Data

`inserts.sql` populates the database with the following records:

- **7 users** — mix of ages and genders (e.g. Sena, Ahmet, Emre)
- **8 exercises** — Squat, Push-up, Plank, Jump Rope, Deadlift, and more
- **14 workout sessions** — spread across April 2026
- **20 workout-exercise entries** — sets and reps for each session
- **21 progress log entries** — 3 weigh-ins per user throughout April

---

## 🚀 Getting Started

1. Make sure PostgreSQL is installed and running.
2. Create a new database:
   ```sql
   CREATE DATABASE fitness_tracking;
   ```
3. Connect to the database and run the files in order:
   ```bash
   psql -d fitness_tracking -f schema.sql
   psql -d fitness_tracking -f inserts.sql
   psql -d fitness_tracking -f analytics.sql
   ```

---

## 🛠️ Tech Stack

- **Database**: PostgreSQL
- **Features used**: Serial primary keys, foreign key constraints, window functions (`RANK OVER`), aggregate functions (`SUM`, `COUNT`), multi-table `JOIN`s
