-- =====================================================
-- BASIC RETRIEVAL AND FILTERING
-- =====================================================

-- 1. List all active students
SELECT
    student_id,
    student_name,
    email,
    batch_id,
    admission_date
FROM students
WHERE is_active = TRUE;

--------------------------------------------------------

-- 2. Find students with missing or invalid email
SELECT
    student_id,
    student_name,
    email
FROM students
WHERE email IS NULL
   OR email NOT LIKE '%@%.%';

--------------------------------------------------------

-- 3. List Easy or Medium problems
SELECT
    problem_id,
    title,
    difficulty
FROM problems
WHERE difficulty IN ('Easy', 'Medium');

--------------------------------------------------------

-- 4. Latest 20 submissions
SELECT
    submission_id,
    student_id,
    problem_id,
    status,
    submission_time
FROM submissions
ORDER BY submission_time DESC
LIMIT 20;

--------------------------------------------------------

-- 5. Find unsuccessful submissions
SELECT
    submission_id,
    student_id,
    problem_id,
    status
FROM submissions
WHERE status <> 'Accepted';



-- =====================================================
-- JOINS
-- =====================================================

-- 6. Submission details with student and problem info
SELECT
    s.submission_id,
    st.student_name,
    p.title AS problem_title,
    s.language,
    s.status,
    sr.score,
    s.submission_time
FROM submissions s
JOIN students st
    ON s.student_id = st.student_id
JOIN problems p
    ON s.problem_id = p.problem_id
LEFT JOIN submission_results sr
    ON s.submission_id = sr.submission_id;

--------------------------------------------------------

-- 7. All students and their enrollments
SELECT
    st.student_id,
    st.student_name,
    c.course_name
FROM students st
LEFT JOIN enrollments e
    ON st.student_id = e.student_id
LEFT JOIN courses c
    ON e.course_id = c.course_id;

--------------------------------------------------------

-- 8. Courses with number of enrolled students
SELECT
    c.course_id,
    c.course_name,
    COUNT(e.student_id) AS total_students
FROM courses c
LEFT JOIN enrollments e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

--------------------------------------------------------

-- 9. Testcase results with problem and student details
SELECT
    sr.result_id,
    st.student_name,
    p.title AS problem_title,
    tc.testcase_id,
    sr.verdict
FROM submission_results sr
JOIN submissions s
    ON sr.submission_id = s.submission_id
JOIN students st
    ON s.student_id = st.student_id
JOIN problems p
    ON s.problem_id = p.problem_id
JOIN test_cases tc
    ON sr.testcase_id = tc.testcase_id;

--------------------------------------------------------

-- 10. Students enrolled but no submissions
SELECT DISTINCT
    st.student_id,
    st.student_name
FROM students st
JOIN enrollments e
    ON st.student_id = e.student_id
LEFT JOIN submissions s
    ON st.student_id = s.student_id
WHERE s.submission_id IS NULL;



-- =====================================================
-- AGGREGATION AND HAVING
-- =====================================================

-- 11. Count submissions by status
SELECT
    status,
    COUNT(*) AS total_submissions
FROM submissions
GROUP BY status;

--------------------------------------------------------

-- 12. Average score per problem
SELECT
    p.problem_id,
    p.title,
    AVG(sr.score) AS average_score
FROM problems p
JOIN submissions s
    ON p.problem_id = s.problem_id
JOIN submission_results sr
    ON s.submission_id = sr.submission_id
GROUP BY p.problem_id, p.title;

--------------------------------------------------------

-- 13. Students with more than 10 submissions
SELECT
    st.student_id,
    st.student_name,
    COUNT(s.submission_id) AS total_submissions
FROM students st
JOIN submissions s
    ON st.student_id = s.student_id
GROUP BY st.student_id, st.student_name
HAVING COUNT(s.submission_id) > 10;

--------------------------------------------------------

-- 14. Problems with success rate below 40%
SELECT
    p.problem_id,
    p.title,
    (
        SUM(CASE WHEN s.status = 'Accepted' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
    ) AS success_rate
FROM problems p
JOIN submissions s
    ON p.problem_id = s.problem_id
GROUP BY p.problem_id, p.title
HAVING (
        SUM(CASE WHEN s.status = 'Accepted' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
       ) < 40;

--------------------------------------------------------

-- 15. Top 10 most attempted problems
SELECT
    p.problem_id,
    p.title,
    COUNT(s.submission_id) AS attempts
FROM problems p
JOIN submissions s
    ON p.problem_id = s.problem_id
GROUP BY p.problem_id, p.title
ORDER BY attempts DESC
LIMIT 10;



-- =====================================================
-- SUBQUERIES / SET LOGIC
-- =====================================================

-- 16. Students with above-average scores
SELECT
    st.student_id,
    st.student_name,
    AVG(sr.score) AS avg_score
FROM students st
JOIN submissions s
    ON st.student_id = s.student_id
JOIN submission_results sr
    ON s.submission_id = sr.submission_id
GROUP BY st.student_id, st.student_name
HAVING AVG(sr.score) >
(
    SELECT AVG(score)
    FROM submission_results
);

--------------------------------------------------------

-- 17. Problems never attempted
SELECT
    p.problem_id,
    p.title
FROM problems p
WHERE p.problem_id NOT IN
(
    SELECT DISTINCT problem_id
    FROM submissions
);

--------------------------------------------------------

-- 18. Students enrolled but never submitted
SELECT
    st.student_id,
    st.student_name
FROM students st
WHERE st.student_id IN
(
    SELECT student_id
    FROM enrollments
)
AND st.student_id NOT IN
(
    SELECT DISTINCT student_id
    FROM submissions
);

--------------------------------------------------------

-- 19. Students who used both Python and Java
SELECT
    st.student_id,
    st.student_name
FROM students st
JOIN submissions s
    ON st.student_id = s.student_id
GROUP BY st.student_id, st.student_name
HAVING
    SUM(CASE WHEN s.language = 'Python' THEN 1 ELSE 0 END) > 0
AND
    SUM(CASE WHEN s.language = 'Java' THEN 1 ELSE 0 END) > 0;

--------------------------------------------------------

-- 20. Second-highest score for a problem
SELECT DISTINCT score
FROM submission_results
WHERE score <
(
    SELECT MAX(score)
    FROM submission_results
)
ORDER BY score DESC
LIMIT 1;
