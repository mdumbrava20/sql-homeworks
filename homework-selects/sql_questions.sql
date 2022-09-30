-- Write a query to display: 
-- 1. the first name, last name, salary, and job grade for all employees.
SELECT first_name, last_name, salary, job_title
FROM employees
         LEFT JOIN jobs USING (job_id);

-- 2. the first and last name, department, city, and state province for each employee.
SELECT first_name, last_name, department_name, city, state_province
FROM employees
         LEFT JOIN departments USING (department_id)
         INNER JOIN locations USING (location_id);

-- 3. the first name, last name, department number and department name, for all employees for departments 80 or 40.
SELECT first_name, last_name, department_id, department_name
FROM employees
         LEFT JOIN departments USING (department_id)
WHERE department_id = 80
   OR department_id = 40;

-- 4. those employees who contain a letter z to their first name and also display their last name, department, city, and state province.
Select first_name, last_name, department_name, city, state_province
FROM employees
         LEFT JOIN departments USING (department_id)
         INNER JOIN locations USING (location_id)
WHERE first_name LIKE ('%z%');

-- 5. the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
Select employee1.FIRST_NAME, employee1.LAST_NAME, employee1.SALARY
FROM EMPLOYEES employee1
         INNER JOIN EMPLOYEES employee2
                    on employee1.SALARY < employee2.SALARY AND employee2.EMPLOYEE_ID = 182;

-- 6. the first name of all employees including the first name of their manager.
SELECT employee.FIRST_NAME, manager.FIRST_NAME
FROM EMPLOYEES employee
         INNER JOIN EMPLOYEES manager
                    on employee.MANAGER_ID = manager.EMPLOYEE_ID;

-- 7. the first name of all employees and the first name of their manager including those who does not working under any manager.
--TODO
SELECT employee.FIRST_NAME, manager.FIRST_NAME
FROM EMPLOYEES employee
         INNER JOIN EMPLOYEES manager
                    on employee.MANAGER_ID = manager.EMPLOYEE_ID OR
                       employee.MANAGER_ID IS NULL;

-- 8. the details of employees who manage a department.
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL;

-- 9. the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.
SELECT employee1.FIRST_NAME, employee1.LAST_NAME, employee1.DEPARTMENT_ID
FROM EMPLOYEES employee1
         INNER JOIN EMPLOYEES employee2
                    on employee2.LAST_NAME = 'Taylor' AND
                       employee1.DEPARTMENT_ID = employee2.DEPARTMENT_ID;

--10. the department name and number of employees in each of the department.
SELECT department.DEPARTMENT_NAME, COUNT(*) AS Number_Of_Employees
FROM EMPLOYEES employee
         INNER JOIN DEPARTMENTS department
                    on employee.DEPARTMENT_ID = department.DEPARTMENT_ID
group by department.DEPARTMENT_NAME;

--11. the name of the department, average salary and number of employees working in that department who got commission.
SELECT department.DEPARTMENT_NAME, AVG(employee.SALARY), COUNT(*) AS Number_Of_Employees
FROM EMPLOYEES employee
         INNER JOIN DEPARTMENTS department
                    on employee.DEPARTMENT_ID = department.DEPARTMENT_ID AND
                       employee.COMMISSION_PCT IS NOT NULL
group by department.DEPARTMENT_NAME;

--12. job title and average salary of employees.
SELECT jobs.JOB_TITLE, AVG(employee.SALARY) AS Average_Salary
FROM EMPLOYEES employee
         INNER JOIN JOBS jobs
                    on employee.JOB_ID = jobs.JOB_ID
group by jobs.JOB_TITLE;

--13. the country name, city, and number of those departments where at least 2 employees are working.

--14. the employee ID, job name, number of days worked in for all those jobs in department 80.
Select EMPLOYEE_ID, JOB_TITLE, END_DATE - START_DATE AS Worked_Days
FROM JOB_HISTORY
         INNER JOIN JOBS USING (JOB_ID)
WHERE DEPARTMENT_ID = 80;

--15. the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
SELECT employee1.FIRST_NAME, employee1.LAST_NAME
FROM EMPLOYEES employee1
         INNER JOIN EMPLOYEES employee2
                    on employee2.EMPLOYEE_ID = 163
                        AND employee1.SALARY > employee2.SALARY;

--16. the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.
--TODO
--17. the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.
SELECT employee.FIRST_NAME, employee.LAST_NAME
FROM EMPLOYEES employee
         INNER JOIN EMPLOYEES report
                    on employee.MANAGER_ID = report.EMPLOYEE_ID AND
                       report.FIRST_NAME = 'Payam';

--18. the department number, name ( first name and last name ), job and department name for all employees in the Finance department.
SELECT employee.DEPARTMENT_ID,
       employee.FIRST_NAME,
       employee.LAST_NAME,
       jobs.JOB_TITLE,
       department.DEPARTMENT_NAME
FROM EMPLOYEES employee
         INNER JOIN DEPARTMENTS department
                    on employee.DEPARTMENT_ID = department.DEPARTMENT_ID AND
                       department.DEPARTMENT_NAME = 'Finance'
         Inner JOIN JOBS jobs
                    on employee.JOB_ID = jobs.JOB_ID;

--19. all the information of an employee whose id is any of the number 134, 159 and 183.
SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID in (134, 159, 183);

--20. all the information of the employees whose salary is within the range of smallest salary and 2500.
SELECT *
FROM EMPLOYEES
WHERE SALARY between (SELECT min(SALARY) FROM EMPLOYEES) AND 2500;

--21. all the information of the employees who does not work in those departments where some employees works whose id within the range 100 and 200.
select *
from EMPLOYEES
where DEPARTMENT_ID not in (select distinct DEPARTMENT_ID
                            from EMPLOYEES
                            where EMPLOYEE_ID between 100 and 200
                              AND DEPARTMENT_ID is not null);

--22. all the information for those employees whose id is any id who earn the second highest salary.
select *
from EMPLOYEES
where SALARY = (select max(SALARY)
                from EMPLOYEES
                where EMPLOYEE_ID != (select EMPLOYEE_ID
                                      from EMPLOYEES
                                      where SALARY = (select max(SALARY) from EMPLOYEES)));

--23. the employee name( first name and last name ) and hiredate for all employees in the same department as Clara. Exclude Clara.
select FIRST_NAME, LAST_NAME, HIRE_DATE
from EMPLOYEES
where DEPARTMENT_ID = (select DEPARTMENT_ID
                       from EMPLOYEES
                       where FIRST_NAME = 'Clara')
  and FIRST_NAME != 'Clara';

--24. the employee number and name( first name and last name ) for all employees who work in a department with any employee whose name contains a T.
select PHONE_NUMBER, FIRST_NAME, LAST_NAME
from EMPLOYEES
where DEPARTMENT_ID in (select DEPARTMENT_ID
                        from EMPLOYEES
                        where LAST_NAME like ('%T%')
                           or FIRST_NAME like ('%T%'));

--25. full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.
select distinct employee.EMPLOYEE_ID, JOBS.JOB_ID, jobh.EMPLOYEE_ID
from EMPLOYEES employee
         inner join JOBS jobs
                    on employee.JOB_ID = jobs.JOB_ID
         left join JOB_HISTORY jobh
                   on employee.EMPLOYEE_ID = jobh.EMPLOYEE_ID
where COMMISSION_PCT is null;

--26. the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.
select PHONE_NUMBER, FIRST_NAME, LAST_NAME, SALARY
from EMPLOYEES
where SALARY > (select avg(SALARY) from EMPLOYEES)
  AND DEPARTMENT_ID in (select DEPARTMENT_ID
                        from EMPLOYEES
                        where FIRST_NAME like ('%J%')
                           or LAST_NAME like ('%J%'));

--27. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.
select PHONE_NUMBER, FIRST_NAME, LAST_NAME, JOB_TITLE
from EMPLOYEES employee1
    inner join JOBS using (JOB_ID)
where SALARY < any (select SALARY
                from EMPLOYEES
                where JOB_ID = 'MK_MAN');

--28. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
--TODO SAME CONDITION ?

--29. all the information of those employees who did not have any job in the past.
select *
from EMPLOYEES
where EMPLOYEE_ID not in (select distinct EMPLOYEE_ID from JOB_HISTORY);

--30. the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.
select PHONE_NUMBER, FIRST_NAME, LAST_NAME, JOB_TITLE
from EMPLOYEES
    inner join JOBS using (JOB_ID)
where SALARY > any (select avg(SALARY)
                    from EMPLOYEES
                    group by DEPARTMENT_ID);

--31. the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.
--32. the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
--33. the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees)
-- and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than
-- the average salary of all employees.
--34. all the employees who earn more than the average and who work in any of the IT departments.
--35. who earns more than Mr. Ozer.

--36. which employees have a manager who works for a department based in the US.
--37. the names of all employees whose salary is greater than 50% of their department’s total salary bill.
--38. the employee id, name ( first name and last name ), salary, department name and city for all
--the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.  
--39. the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list in descending order on salary.
--40. the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.
--41. the department name and Id for all departments where they located, that Id is equal to the Id for the location where department number 30 is located.
--42. the first and last name, salary, and department ID for all those employees who work in that department where the employee works who hold the ID 201.
--43. the first and last name, salary, and department ID for those employees whose salary is equal to the salary of the employee who works in that department which ID is 40.
--44. the first and last name, salary, and department ID for those employees who earn more than the minimum salary of a department which ID is 40.
--45. the first and last name, salary, and department ID for those employees who earn less than the minimum salary of a department which ID is 70.
--46. the first and last name, salary, and department ID for those employees who earn less than the average salary, and also work at the department where the employee Laura is working as a first name holder.
--47. the full name (first and last name) of manager who is supervising 4 or more employees.
--48. the details of the current job for those employees who worked as a Sales Representative in the past.
--49. all the infromation about those employees who earn second lowest salary of all the employees.
--50. the department ID, full name (first and last name), salary for those employees who is highest salary drawar in a department.
