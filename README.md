# CodeJudge SQL Query Implementation — Part 2

## Objective

This part focuses on implementing SQL queries on the normalized CodeJudge relational database created in Part 1.

The assignment demonstrates:

* SQL retrieval queries
* filtering
* joins
* aggregation
* HAVING clauses
* subqueries
* validation of outputs

---

# Repository Structure

```text
├── README.md
├── queries.sql
├── query_outputs.md
└── sql_reasoning.md
```

---

# Topics Covered

## Basic Retrieval and Filtering

* active students
* invalid emails
* easy and medium problems
* latest submissions
* failed submissions

## Joins

* submission details
* enrollments
* course-wise counts
* testcase results
* students without submissions

## Aggregation

* submission counts
* average scores
* top attempted problems
* low success-rate problems

## Subqueries

* above-average students
* unattempted problems
* students with no submissions
* multi-language submissions
* second-highest scores

---

# Validation Approach

For every query:

* query purpose is explained
* expected output is described
* validation note confirms logical correctness

---

# Assumptions

* `status = 'Accepted'` means successful submission
* scores are stored in `submission_results`
* `is_active = TRUE` exists in students table
* emails should contain '@'
* timestamps are stored using SQL TIMESTAMP datatype
