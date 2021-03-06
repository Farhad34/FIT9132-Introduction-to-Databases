SET ECHO ON

SPOOL week10solution.txt

/*1.*/

SELECT
    MAX(mark)
FROM
    uni.enrolment
WHERE
    unitcode = 'FIT1004'
    AND semester = 1
    AND TO_CHAR(ofyear, 'YYYY') = '2013';

/* 2.*/

SELECT
    round(AVG(mark), 1) /* in question if asked about the rounded do this */
FROM
    uni.enrolment
WHERE
    unitcode = 'FIT1040'
    AND semester = 2
    AND EXTRACT(YEAR FROM ofyear) = 2013;/* another way to do and search*/
    
/* 3.*/

SELECT
    TO_CHAR(ofyear, 'YYYY') AS year,
    semester,
    AVG(mark)
FROM
    uni.enrolment
WHERE
    unitcode = 'FIT1040'
GROUP BY
    year,
    semester
ORDER BY
    ofyear,
    semester;

/*4 */

SELECT
    *
FROM
    uni.enrolment
WHERE
    unitcode IN (
        'FIT5132',
        'FIT5136'
    ) /* add condition heere  to make condition*/
ORDER BY
    unitcode,
    ofyear,
    semester;
    
    
    
    
/*4Find the number of students enrolled in the unit FIT1040 in the year 2013, under the following conditions:*/

/*○ Repeat students are counted each time*/

SELECT
    COUNT(studid) AS student_count
FROM
    uni.enrolment
WHERE
    unitcode = 'FIT1040'
    AND TO_CHAR(ofyear, 'YYYY') = '2013';

/*○ Repeat students are only counted once*/

SELECT
    COUNT(DISTINCT studid) AS student_count
FROM
    uni.enrolment
WHERE
    unitcode = 'FIT1040'
    AND TO_CHAR(ofyear, 'YYYY') = '2013';
    
    
    
    
/*5. Find the total number of enrolment per semester for each unit in the year 2013. The list should include the unitcode, semester and year. Order the list in increasing order of enrolment numbers.*/

SELECT
    unitcode,
    TO_CHAR(ofyear, 'YYYY') AS "Year of offer",
    semester
FROM
    uni.enrolment
WHERE
    TO_CHAR(ofyear, 'YYYY') = '2013'
GROUP BY
    unitcode,
    ofyear,
    semester
ORDER BY
    total;

/*6. Find the total number of prerequisite units for FIT2077.*/

SELECT
    count() AS no_prereqs
FROM
    uni.prereq
WHERE
    unitcode = 'FIT2077';

/*7. Find the total number of prerequisite units for each unit. In the list, include the unitcode for which the count is applicable.*/

SELECT
    unitcode,
    COUNT(has_prereq_of) AS no_prereq /* we need double quote oif number is there--- exam e avabei rakhbo javabe ami korsi like - no_prerw*/
FROM
    uni.prereq
GROUP BY
    unitcode
ORDER BY
    unitcode;

/*8. For each pre-requisite unit, calculate how many times it has been used as prerequisite. Include the name of the prerequisite unit in the listing .*/

SELECT
    has_rprereq_of AS unitcode,
    u.unitname,
    COUNT(u.unitcode) AS no_times(used from uni.prereq p 
    join ui,.unit u on u.unitcode = has_prereq_of group by order by;

/*9. Find the unit with the highest number of enrolments in a given offering in the year 2013.*/
SELECT
    unitcode,
    semester,
    TO_CHAR(ofyear, 'YYYY') AS year12,
    MAX(COUNT(studentid))
FROM
    uni.enrolment
WHERE
    TO_CHAR(ofyear, 'YYYY') = '2013'
GROUP BY
    unitcode,
    semester,
    ofyear
HAVING
    COUNT(studid) = 7.........;; /* to write group by we simple copy from here,, everything in select has to be in group by but group by te onno kichu thakte pare*/

/*10. Who is the oldest student in FIT1004? Display the student full name and the date of birth.*/

/*11. Find all students enrolled in FIT1004 in semester 1, 2013 who have scored more than the average mark of FIT1004 in the same offering? Display the students' name and the mark. Sort the list in the order of the mark from the highest to the lowest.*/

/*Use the Uni database from the previous exercises to complete the following queries.*/

/*1. Find the maximum mark for FIT1004 in semester 1, 2013. */
SELECT
    MAX(mark)
FROM
    uni.enrolment
WHERE
    unitcode = 'FIT1004'
    AND semester = '1'
        AND TO_CHAR(ofyear, 'YYYY') = 2013;

/*2. Find the average mark of FIT1040 in semester 2, 2013.*/

SELECT
    round(AVG(mark), 2)
FROM
    uni.enrolment
WHERE
    unitcode = 'FIT1040'
    AND semester = '2'
        AND TO_CHAR(ofyear, 'yyyy') = '2013';

/*3. List the average mark for each offering of FIT1040. In the listing, */
/*you need to include the year and semester number. Sort the result according to the year.*/

SELECT
    TO_CHAR(ofyear, 'YYYY') AS "offer year",
    semester,
    AVG(mark) AS avg_mark
FROM
    uni.enrolment
WHERE
    unitcode = 'FIT1040'
GROUP BY
    ofyear,
    semester
ORDER BY
    ofyear,
    semester;

/*4. Find the number of students enrolled in the unit FIT1040 in the year 2013, 
--under the following conditions:*/
/*○ Repeat students are counted each time*/
/*○ Repeat students are only counted once*/

SELECT
    COUNT(studid)
FROM
    uni.enrolment
WHERE
    unitcode = 'FIT1040'
    AND TO_CHAR(ofyear, 'YYYY') = '2013';


/*5. Find the total number of enrolment per semester for each unit in the year 2013.
--The list should include the unitcode, semester and year. 
--Order the list in increasing order of enrolment numbers.*/

SELECT
    unitcode,
    semester,
    ofyear,
    COUNT(studid) AS total
FROM
    uni.enrolment
WHERE
    TO_CHAR(ofyear, 'YYYY') = '2013'
GROUP BY
    semester,
    ofyear,
    unitcode;


/*6. Find the total number of prerequisite units for FIT2077.*/

SELECT
    COUNT(*)
FROM
    uni.prereq
WHERE
    unitcode = 'FIT2077';


/*7. Find the total number of prerequisite units for each unit. 
--In the list, include the unitcode for which the count is applicable.*/

SELECT
    unitcode,
    COUNT(unitcode)
FROM
    uni.prereq
GROUP BY
    unitcode
ORDER BY
    unitcode;



/*8. For each pre-requisite unit, calculate how many times it has been used as prerequisite. 
--Include the name of the prerequisite unit in the listing .*/

SELECT
    has_prereq_of,
    u.unitname,
    COUNT(u.unitcode)
FROM
    uni.prereq   p
    JOIN uni.unit     u
    ON p.has_prereq_of = u.unitcode
GROUP BY
    has_prereq_of,
    u.unitname;
    

/*9. Find the unit with the highest number of enrolments in a given offering in the year 2013.*/

SELECT
    *
FROM
    uni.enrolment
WHERE
    TO_CHAR(ofyear, 'yyyy') = '2013';

/*unit with highest number of enrollment*/

SELECT
    MAX(COUNT(studid))
FROM
    uni.enrolment
GROUP BY
    unitcode,
    semester,
    ofyear
HAVING
    TO_CHAR(ofyear, 'yyyy') = '2013';

SELECT
    ofyear,
    unitcode,
    semester,
    COUNT(studid)
FROM
    uni.enrolment
GROUP BY
    ofyear,
    semester,
    unitcode;


/*10. Who is the oldest student in FIT1004? Display the student full name and the date of birth.*/

SELECT
    unitcode
FROM
    uni.enrolment
GROUP BY
    unitcode;

SELECT
    *
FROM
    uni.enrolment   e
    JOIN uni.student     s
    ON e.studid = s.studid
WHERE
    unitcode = 'FIT1004'
    AND studdob = (
        SELECT
            MIN(studdob)
        FROM
            uni.student     s
            JOIN uni.enrolment   e
            ON s.studid = e.studid
        WHERE
            unitcode = 'FIT1004'
    );



/*11. Find all students enrolled in FIT1004 in semester 1, 2013 who have scored more than the 
average mark of FIT1004 
in the same offering? Display the students' name and the mark. Sort the list in 
the order of the mark from the highest to the lowest.*/

SELECT
    s.studfname
    || ' '
       || s.studlname AS studentname,
    e.mark
FROM
    uni.enrolment   e
    JOIN uni.student     s
    ON e.studid = s.studid
WHERE
    unitcode = 'FIT1004'
    AND semester = '1'
        AND TO_CHAR(ofyear, 'YYYY') = '2013'
            AND mark > (
        SELECT
            AVG(mark)
        FROM
            uni.enrolment
        WHERE
            unitcode = 'FIT1004'
            AND semester = '1'
                AND TO_CHAR(ofyear, 'YYYY') = '2013'
    )order by mark desc;
    
    
    
    

SET ECHO OFF

SPOOL OFF