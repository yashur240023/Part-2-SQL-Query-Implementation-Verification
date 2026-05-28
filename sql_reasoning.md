# SQL Reasoning and Explanations

# 1. Why LEFT JOIN Instead of INNER JOIN?

Query Used:

* Students and enrollments query

Reason:
A LEFT JOIN ensures all students appear even if they are not enrolled in any course.

If INNER JOIN were used:

* students without enrollments would disappear from results.

This is important because the task explicitly asks to include such students.

---

# 2. Why HAVING Instead of WHERE?

Query Used:

* Students with more than 10 submissions

Reason:
`HAVING` filters grouped aggregate results.

Example:

```sql
HAVING COUNT(submission_id) > 10
```

`WHERE` cannot directly filter aggregated counts after grouping.

---

# 3. Why Use a Subquery?

Query Used:

* Students whose average score is above overall average

Reason:
The overall average score must first be computed separately.

The subquery:

```sql
SELECT AVG(score)
FROM submission_results
```

provides a comparison value for each student’s average.

---

# 4. Duplicate Record Risk

Situation:
If duplicate submission rows exist, queries such as:

* top attempted problems
* submission counts
* average scores

may produce inflated values.

Example:
Duplicate submissions would increase attempt counts incorrectly.

Possible Solution:

* use DISTINCT
* clean staging tables before final insertion

---

# 5. Edge Case Considered

Query:

* Invalid email detection

Edge Case:
Some emails may contain spaces or partial formatting.

Example:

```text
abc@domain
```

This still fails basic validation because '.com' or domain extension is missing.

Another edge case:
NULL emails must also be detected separately.
