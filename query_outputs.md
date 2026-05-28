# Query Outputs and Validation

# 1. Active Students

## Purpose

Retrieve all currently active students.

## Sample Output

| student_id | student_name | email                                     |
| ---------- | ------------ | ----------------------------------------- |
| 101        | Amit Shah    | [amit@gmail.com](mailto:amit@gmail.com)   |
| 102        | Priya Singh  | [priya@gmail.com](mailto:priya@gmail.com) |

## Validation Note

Only students with `is_active = TRUE` appear in the output.

---

# 2. Invalid Emails

## Purpose

Identify missing or malformed emails.

## Sample Output

| student_id | email        |
| ---------- | ------------ |
| 204        | NULL         |
| 315        | abcgmail.com |

## Validation Note

Emails without '@' are treated as invalid.

---

# 3. Easy and Medium Problems

## Result Summary

Returned only problems whose difficulty is Easy or Medium.

## Validation Note

Hard problems were excluded correctly.

---

# 4. Latest 20 Submissions

## Result Summary

Rows are sorted by newest submission timestamp first.

## Validation Note

The timestamps decrease sequentially.

---

# 5. Unsuccessful Submissions

## Result Summary

Shows submissions with statuses such as:

* Wrong Answer
* Runtime Error
* Time Limit Exceeded

## Validation Note

Accepted submissions are excluded.

---

# 6. Submission Details Join

## Result Summary

Displays:

* student name
* problem title
* language
* score
* submission time

## Validation Note

Every submission correctly maps to a valid student and problem.

---

# 7. Students and Enrollments

## Result Summary

Some students show NULL course names.

## Validation Note

LEFT JOIN correctly preserves students without enrollments.

---

# 8. Courses with Student Count

## Sample Output

| course_name | total_students |
| ----------- | -------------- |
| DSA         | 120            |
| DBMS        | 95             |

## Validation Note

Counts match enrollment records.

---

# 9. Testcase Results

## Result Summary

Each testcase result maps to:

* student
* problem
* testcase

## Validation Note

Foreign key relationships work correctly.

---

# 10. Enrolled but No Submission

## Result Summary

Students appear only if enrolled and never submitted.

## Validation Note

LEFT JOIN with NULL filtering correctly identifies missing submissions.

---

# 11. Submission Count by Status

## Sample Output

| status       | total_submissions |
| ------------ | ----------------- |
| Accepted     | 520               |
| Wrong Answer | 180               |

## Validation Note

Total counts equal total submission rows.

---

# 12. Average Score Per Problem

## Validation Note

Average values remain within expected scoring range.

---

# 13. Students with More Than 10 Submissions

## Validation Note

HAVING filters grouped results after aggregation.

---

# 14. Problems Below 40% Success Rate

## Validation Note

Problems with many failed attempts appear in results.

---

# 15. Top Attempted Problems

## Validation Note

Rows are sorted by highest attempt count.

---

# 16. Above Average Students

## Validation Note

Student averages exceed global average score.

---

# 17. Never Attempted Problems

## Validation Note

Problem IDs do not exist in submissions table.

---

# 18. Enrolled but Never Submitted

## Validation Note

Students appear in enrollments but not in submissions.

---

# 19. Python and Java Users

## Validation Note

Only students using both languages appear.

---

# 20. Second Highest Score

## Validation Note

Maximum score is excluded before selecting next highest value.
