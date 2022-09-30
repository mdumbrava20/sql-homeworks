-- Write a query to display: 
-- 1. the first name, last name, salary, AND job grade for all employees.
SELECT first_name, last_name, salary, job_title
FROM employees
         LEFT JOIN jobs USING (job_id);

-- 2. the first AND last name, department, city, AND state province for each employee.
SELECT first_name, last_name, department_name, city, state_province
FROM employees
         LEFT JOIN departments USING (department_id)
         INNER JOIN locations USING (location_id);

-- 3. the first name, last name, department number AND department name, for all employees for departments 80 OR 40.
SELECT first_name, last_name, department_id, department_name
FROM employees
         LEFT JOIN departments USING (department_id)
WHERE department_id IN (40, 80);

-- 4. those employees who contain a letter z to their first name AND also display their last name, department, city, AND state province.
SELECT first_name, last_name, department_name, city, state_province
FROM employees
         LEFT JOIN departments USING (department_id)
         INNER JOIN locations USING (location_id)
WHERE first_name LIKE ('%z%');

-- 5. the first AND last name AND salary for those employees who earn less than the employee earn whose number is 182.
SELECT employee1.FIRST_NAME, employee1.LasT_NAME, employee1.SALARY
FROM EMPLOYEES employee1
         INNER JOIN EMPLOYEES employee2
                    ON employee1.SALARY < employee2.SALARY AND employee2.EMPLOYEE_ID = 182;

-- 6. the first name of all employees including the first name of their manager.
SELECT employee.FIRST_NAME, manager.FIRST_NAME
FROM EMPLOYEES employee
         INNER JOIN EMPLOYEES manager
                    ON employee.MANAGER_ID = manager.EMPLOYEE_ID;

-- 7. the first name of all employees AND the first name of their manager including those who does not working under ANY manager.
SELECT employee.FIRST_NAME, manager.FIRST_NAME
FROM EMPLOYEES employee
         LEFT JOIN EMPLOYEES manager
                   ON employee.MANAGER_ID = manager.EMPLOYEE_ID;

-- 8. the details of employees who manage a department.
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL;

-- 9. the first name, last name, AND department number for those employees who works in the same department AS the employee who holds the last name AS Taylor.
SELECT employee1.FIRST_NAME, employee1.LasT_NAME, employee1.DEPARTMENT_ID
FROM EMPLOYEES employee1
         INNER JOIN EMPLOYEES employee2
                    ON employee2.LasT_NAME = 'Taylor' AND
                       employee1.DEPARTMENT_ID = employee2.DEPARTMENT_ID;

--10. the department name AND number of employees in each of the department.
SELECT department.DEPARTMENT_NAME, COUNT(*) AS Number_Of_Employees
FROM EMPLOYEES employee
         INNER JOIN DEPARTMENTS department
                    ON employee.DEPARTMENT_ID = department.DEPARTMENT_ID
GROUP BY department.DEPARTMENT_NAME;

--11. the name of the department, average salary AND number of employees working in that department who got commission.
SELECT department.DEPARTMENT_NAME, AVG(employee.SALARY), COUNT(*) AS Number_Of_Employees
FROM EMPLOYEES employee
         INNER JOIN DEPARTMENTS department
                    ON employee.DEPARTMENT_ID = department.DEPARTMENT_ID AND
                       employee.COMMISSION_PCT IS NOT NULL
GROUP BY department.DEPARTMENT_NAME;

--12. job title AND average salary of employees.
SELECT jobs.JOB_TITLE, AVG(employee.SALARY) AS Average_Salary
FROM EMPLOYEES employee
         INNER JOIN JOBS jobs
                    ON employee.JOB_ID = jobs.JOB_ID
GROUP BY jobs.JOB_TITLE;

--13. the country name, city, AND number of those departments WHERE at least 2 employees are working.
SELECT COUNTRY_NAME, CITY, DEPARTMENT_ID
FROM DEPARTMENTS departments
         right join LOCATIONS USING (LOCATION_ID)
         INNER JOIN COUNTRIES ON LOCATIONS.COUNTRY_ID = COUNTRIES.COUNTRY_ID
WHERE (SELECT COUNT(DEPARTMENT_ID)
       FROM EMPLOYEES employee
       WHERE employee.DEPARTMENT_ID = departments.DEPARTMENT_ID) >= 2;

--14. the employee ID, job name, number of days worked in for all those jobs in department 80.
SELECT EMPLOYEE_ID, JOB_TITLE, END_DATE - START_DATE AS Worked_Days
FROM JOB_HISTORY
         INNER JOIN JOBS USING (JOB_ID)
WHERE DEPARTMENT_ID = 80;

--15. the name ( first name AND last name ) for those employees who gets more salary than the employee whose ID is 163.
SELECT concat(employee1.FIRST_NAME||' ', employee1.LAST_NAME) NAME
FROM EMPLOYEES employee1
         INNER JOIN EMPLOYEES employee2
                    ON employee2.EMPLOYEE_ID = 163
                        AND employee1.SALARY > employee2.SALARY;

--16. the employee id, employee name (first name AND last name ) for all employees who earn more than the average salary.
SELECT EMPLOYEE_ID, concat(FIRST_NAME||' ', LAST_NAME) NAME
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

--17. the employee name ( first name AND last name ), employee id AND salary of all employees who report to Payam.
SELECT concat(employee.FIRST_NAME||' ', employee.LAST_NAME) NAME
FROM EMPLOYEES employee
         INNER JOIN EMPLOYEES report
                    ON employee.MANAGER_ID = report.EMPLOYEE_ID AND
                       report.FIRST_NAME = 'Payam';

--18. the department number, name ( first name AND last name ), job AND department name for all employees in the Finance department.
SELECT employee.DEPARTMENT_ID,
       concat(FIRST_NAME||' ', LAST_NAME) NAME,
       jobs.JOB_TITLE,
       department.DEPARTMENT_NAME
FROM EMPLOYEES employee
         INNER JOIN DEPARTMENTS department
                    ON employee.DEPARTMENT_ID = department.DEPARTMENT_ID AND
                       department.DEPARTMENT_NAME = 'Finance'
         INNER JOIN JOBS jobs
                    ON employee.JOB_ID = jobs.JOB_ID;

--19. all the information of an employee whose id is ANY of the number 134, 159 AND 183.
SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (134, 159, 183);

--20. all the information of the employees whose salary is within the range of smallest salary AND 2500.
SELECT *
FROM EMPLOYEES
WHERE SALARY BETWEEN (SELECT min(SALARY)
                      FROM EMPLOYEES) AND 2500;

--21. all the information of the employees who does not work in those departments WHERE some employees works whose id within the range 100 AND 200.
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID NOT IN (SELECT distinct DEPARTMENT_ID
                            FROM EMPLOYEES
                            WHERE EMPLOYEE_ID BETWEEN 100 AND 200
                              AND DEPARTMENT_ID IS NOT NULL);

--22. all the information for those employees whose id is ANY id who earn the second highest salary.
SELECT *
FROM EMPLOYEES
WHERE SALARY = (SELECT max(SALARY)
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID != (SELECT EMPLOYEE_ID
                                      FROM EMPLOYEES
                                      WHERE SALARY = (SELECT max(SALARY)
                                                      FROM EMPLOYEES)));

--23. the employee name( first name AND last name ) AND hiredate for all employees in the same department AS Clara. Exclude Clara.
SELECT concat(FIRST_NAME||' ', LAST_NAME) NAME, HIRE_DATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM EMPLOYEES
                       WHERE FIRST_NAME = 'Clara')
  AND FIRST_NAME != 'Clara';

--24. the employee number AND name( first name AND last name ) for all employees who work in a department with ANY employee whose name contains a T.
SELECT PHONE_NUMBER, concat(FIRST_NAME||' ', LAST_NAME) NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM EMPLOYEES
                        WHERE LasT_NAME LIKE ('%T%')
                           OR FIRST_NAME LIKE ('%T%'));

--25. full name(first AND last name), job title, starting AND ending date of last jobs for those employees with worked without a commission percentage.
SELECT distinct concat(FIRST_NAME||' ', LAST_NAME) NAME, JOB_TITLE, START_DATE, END_DATE
FROM EMPLOYEES employee
         INNER JOIN JOBS jobs
                    ON employee.JOB_ID = jobs.JOB_ID
         INNER JOIN JOB_HISTORY jobh
                   ON employee.EMPLOYEE_ID = jobh.EMPLOYEE_ID
WHERE COMMISSION_PCT IS NULL;

--26. the employee number, name( first name AND last name ), AND salary for all employees who earn more than the average salary AND who work in a department with ANY employee with a J in their name.
SELECT PHONE_NUMBER, concat(FIRST_NAME||' ', LAST_NAME) NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEES)
  AND DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM EMPLOYEES
                        WHERE FIRST_NAME LIKE ('%J%')
                           OR LasT_NAME LIKE ('%J%'));

--27. the employee number, name( first name AND last name ) AND job title for all employees whose salary is smaller than ANY salary of those employees whose job title is MK_MAN.
SELECT PHONE_NUMBER, concat(FIRST_NAME||' ', LAST_NAME) NAME, JOB_TITLE
FROM EMPLOYEES employee1
         INNER JOIN JOBS USING (JOB_ID)
WHERE SALARY < ANY (SELECT SALARY
                    FROM EMPLOYEES
                    WHERE JOB_ID = 'MK_MAN');

--28. the employee number, name( first name AND last name ) AND job title for all employees whose salary is smaller than ANY salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
SELECT PHONE_NUMBER, concat(FIRST_NAME||' ', LAST_NAME) NAME, JOB_TITLE
FROM EMPLOYEES employee1
         INNER JOIN JOBS USING (JOB_ID)
WHERE SALARY < ANY (SELECT SALARY
                    FROM EMPLOYEES
                    WHERE JOB_ID = 'MK_MAN')
  AND JOB_ID != 'MK_MAN';

--29. all the information of those employees who did not have ANY job in the past.
SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID NOT IN (SELECT distinct EMPLOYEE_ID
                          FROM JOB_HISTORY);

--30. the employee number, name( first name AND last name ) AND job title for all employees whose salary is more than ANY average salary of ANY department.
SELECT PHONE_NUMBER, concat(FIRST_NAME||' ', LAST_NAME) NAME, JOB_TITLE
FROM EMPLOYEES
         INNER JOIN JOBS USING (JOB_ID)
WHERE SALARY > ANY (SELECT AVG(SALARY)
                    FROM EMPLOYEES
                    GROUP BY DEPARTMENT_ID);

--31. the employee id, name ( first name AND last name ) AND the job id column with a
-- modified title SALESMAN for those employees whose job title is ST_MAN AND DEVELOPER for
-- whose job title is IT_PROG.
SELECT EMPLOYEE_ID, concat(FIRST_NAME||' ', LAST_NAME) NAME,
       DECODE(JOB_ID, 'ST_MAN', 'SALESMAN', 'IT_PROG', 'DEVELOPER', JOB_ID) JOB
FROM EMPLOYEES;

--32. the employee id, name ( first name AND last name ),
-- salary AND the SalaryStatus column with a title HIGH AND LOW respectively for those employees whose
-- salary is more than AND less than the average salary of all employees.
SELECT EMPLOYEE_ID, concat(FIRST_NAME||' ', LAST_NAME) Name, SALARY, CASE
    WHEN SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
        THEN 'HIGH' ELSE 'LOW' END SalaryStatus
FROM EMPLOYEES
GROUP BY EMPLOYEE_ID, concat(FIRST_NAME||' ', LAST_NAME) , SALARY;

--33. the employee id, name ( first name AND last name ), SalaryDrawn,
-- AvgCompare (salary - the average salary of all employees)
-- AND the SalaryStatus column with a title HIGH AND LOW respectively
-- for those employees whose salary is more than AND less than
-- the average salary of all employees.
SELECT EMPLOYEE_ID, concat(FIRST_NAME, LAST_NAME) NAME, SALARY,
       SALARY - (SELECT AVG(SALARY) FROM EMPLOYEES) AvgCompare,
       CASE WHEN SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
           THEN 'HIGH' ELSE 'LOW' END SalaryStatus
FROM EMPLOYEES;

--34. all the employees who earn more than the average AND who work in ANY of the IT departments.
SELECT *
FROM EMPLOYEES
         INNER JOIN DEPARTMENTS USING (DEPARTMENT_ID)
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
  AND DEPARTMENT_NAME LIKE ('%IT%');

--35. who earns more than Mr. Ozer.
SELECT *
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE LAST_NAME = 'Ozer');

--36. which employees have a manager who works for a department based in the US.
SELECT *
FROM EMPLOYEES employee
         INNER JOIN EMPLOYEES manager
                    ON employee.MANAGER_ID = manager.EMPLOYEE_ID
         INNER JOIN DEPARTMENTS department
                    ON manager.DEPARTMENT_ID = department.DEPARTMENT_ID
         INNER JOIN LOCATIONS location
                    ON department.LOCATION_ID = location.LOCATION_ID
WHERE location.COUNTRY_ID = 'US';

--37. the names of all employees whose salary is greater than 50% of their department’s total salary bill.
SELECT concat(FIRST_NAME||' ', LAST_NAME) NAME
FROM EMPLOYEES employee
WHERE SALARY > (SELECT SUM(SALARY)
                FROM EMPLOYEES bill
                WHERE bill.DEPARTMENT_ID = employee.DEPARTMENT_ID) / 2;

--38. the employee id, name ( first name AND last name ), salary, department name AND city for all
--the employees who gets the salary AS the salary earn by the employee which is maximum within the joining person January 1st, 2002 AND December 31st, 2003.
SELECT EMPLOYEE_ID, concat(FIRST_NAME||' ', LAST_NAME) NAME, SALARY, DEPARTMENT_NAME, CITY
FROM EMPLOYEES employee
         INNER JOIN DEPARTMENTS department
                    ON employee.DEPARTMENT_ID = department.DEPARTMENT_ID
         INNER JOIN LOCATIONS locations
                    ON department.LOCATION_ID = locations.LOCATION_ID
WHERE SALARY = ANY (SELECT SALARY
                    FROM EMPLOYEES
                    WHERE EMPLOYEES.HIRE_DATE BETWEEN TO_DATE('01/01/2002', 'MM/DD/YYYY') AND
                              TO_DATE('12/31/2003', 'MM/DD/YYYY'));

--39. the first AND last name, salary, AND department ID for all those employees who earn more than the average salary AND arrange the list in descending order ON salary.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
order by SALARY desc;

--40. the first AND last name, salary, AND department ID for those employees who earn more than the maximum salary of a department which ID is 40.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY > (SELECT max(SALARY)
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID = 40);

--41. the department name AND Id for all departments WHERE they located, that Id is equal to the Id for the location WHERE department number 30 is located.
SELECT DEPARTMENT_NAME, DEPARTMENT_ID
FROM DEPARTMENTS
WHERE LOCATION_ID = (SELECT LOCATION_ID
                     FROM DEPARTMENTS
                     WHERE DEPARTMENT_ID = 30);

--42. the first AND last name, salary, AND department ID for all those employees who work in that department WHERE the employee works who hold the ID 201.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM EMPLOYEES
                       WHERE EMPLOYEE_ID = 201);

--43. the first AND last name, salary, AND department ID for those employees whose salary is equal to the salary of the employee who works in that department which ID is 40.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY = ANY (SELECT SALARY
                    FROM EMPLOYEES
                    WHERE DEPARTMENT_ID = 40);

--44. the first AND last name, salary, AND department ID for those employees who earn more than the minimum salary of a department which ID is 40.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY > (SELECT min(SALARY)
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID = 40);

--45. the first AND last name, salary, AND department ID for those employees who earn less than the minimum salary of a department which ID is 70.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY < (SELECT min(SALARY)
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID = 70);

--46. the first AND last name, salary, AND department ID for those employees who earn less than the average salary, AND also work at the department WHERE the employee Laura is working AS a first name holder.
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES)
  AND DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM EMPLOYEES
                       WHERE FIRST_NAME = 'Laura');

--47. the full name (first AND last name) of manager who is supervising 4 OR more employees.
SELECT concat(FIRST_NAME||' ', LAST_NAME) NAME
FROM EMPLOYEES manager
WHERE (SELECT COUNT(MANAGER_ID)
       FROM EMPLOYEES
       WHERE EMPLOYEES.MANAGER_ID = manager.EMPLOYEE_ID) >= 4;

--48. the details of the current job for those employees who worked AS a Sales Representative in the past.
SELECT jobs.JOB_ID, jobs.JOB_TITLE, jobs.MIN_SALARY, jobs.MAX_SALARY
FROM JOB_HISTORY jobh
         INNER JOIN EMPLOYEES employee
                    ON jobh.EMPLOYEE_ID = employee.EMPLOYEE_ID
         INNER JOIN JOBS jobs
                    ON employee.JOB_ID = jobs.JOB_ID
         INNER JOIN JOBS old_job
                    ON old_job.JOB_ID = jobh.JOB_ID
WHERE old_job.JOB_TITLE = 'Sales Representative';

--49. all the infromation about those employees who earn second lowest salary of all the employees.
SELECT *
FROM EMPLOYEES
WHERE SALARY = (SELECT min(SALARY)
                FROM EMPLOYEES
                WHERE SALARY != (SELECT min(SALARY)
                                 FROM EMPLOYEES));

--50. the department ID, full name (first AND last name), salary for those employees who is highest salary drawar in a department.
SELECT DEPARTMENT_ID, FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES employee
WHERE SALARY = (SELECT max(SALARY)
                FROM EMPLOYEES drawer
                WHERE drawer.DEPARTMENT_ID = employee.DEPARTMENT_ID);
