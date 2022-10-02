-- Write a query to display: 
-- 1. the first name, last name, salary, and job grade for all employees.
select first_name, last_name, salary, job_title
from employees
         left join jobs using (job_id);

-- 2. the first and last name, department, city, and state province for each employee.
select first_name, last_name, department_name, city, state_province
from employees
         left join departments using (department_id)
         inner join locations using (location_id);

-- 3. the first name, last name, department number and department name, for all employees for departments 80 or 40.
select first_name, last_name, department_id, department_name
from employees
         left join departments using (department_id)
where department_id = 80
   OR department_id = 40;

-- 4. those employees who contain a letter z to their first name and also display their last name, department, city, and state province.
select first_name, last_name, department_name, city, state_province
from employees
         left join departments using (department_id)
         inner join locations using (location_id)
where first_name like ('%z%');

-- 5. the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
select employee1.FIRST_NAME, employee1.LasT_NAME, employee1.SALARY
from EMPLOYEES employee1
         inner join EMPLOYEES employee2
                    on employee1.SALARY < employee2.SALARY and employee2.EMPLOYEE_ID = 182;

-- 6. the first name of all employees including the first name of their manager.
select employee.FIRST_NAME, manager.FIRST_NAME
from EMPLOYEES employee
         inner join EMPLOYEES manager
                    on employee.MANAGER_ID = manager.EMPLOYEE_ID;

-- 7. the first name of all employees and the first name of their manager including those who does not working under any manager.
select employee.FIRST_NAME, manager.FIRST_NAME
from EMPLOYEES employee
         left join EMPLOYEES manager
                   on employee.MANAGER_ID = manager.EMPLOYEE_ID;

-- 8. the details of employees who manage a department.
select *
from EMPLOYEES
where DEPARTMENT_ID is not null;

-- 9. the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.
select employee1.FIRST_NAME, employee1.LasT_NAME, employee1.DEPARTMENT_ID
from EMPLOYEES employee1
         inner join EMPLOYEES employee2
                    on employee2.LasT_NAME = 'Taylor' and
                       employee1.DEPARTMENT_ID = employee2.DEPARTMENT_ID;

--10. the department name and number of employees in each of the department.
select department.DEPARTMENT_NAME, COUNT(*) as Number_Of_Employees
from EMPLOYEES employee
         inner join DEPARTMENTS department
                    on employee.DEPARTMENT_ID = department.DEPARTMENT_ID
group by department.DEPARTMENT_NAME;

--11. the name of the department, average salary and number of employees working in that department who got commission.
select department.DEPARTMENT_NAME, AVG(employee.SALARY), COUNT(*) as Number_Of_Employees
from EMPLOYEES employee
         inner join DEPARTMENTS department
                    on employee.DEPARTMENT_ID = department.DEPARTMENT_ID and
                       employee.COMMISSION_PCT is not null
group by department.DEPARTMENT_NAME;

--12. job title and average salary of employees.
select jobs.JOB_TITLE, AVG(employee.SALARY) as Average_Salary
from EMPLOYEES employee
         inner join JOBS jobs
                    on employee.JOB_ID = jobs.JOB_ID
group by jobs.JOB_TITLE;

--13. the country name, city, and number of those departments where at least 2 employees are working.
select COUNTRY_NAME, CITY, DEPARTMENT_ID
from DEPARTMENTS departments
         right join LOCATIONS using (LOCATION_ID)
         inner join COUNTRIES on LOCATIONS.COUNTRY_ID = COUNTRIES.COUNTRY_ID
where (select count(DEPARTMENT_ID)
       from EMPLOYEES employee
       where employee.DEPARTMENT_ID = departments.DEPARTMENT_ID) >= 2;

--14. the employee ID, job name, number of days worked in for all those jobs in department 80.
select EMPLOYEE_ID, JOB_TITLE, END_DATE - START_DATE as Worked_Days
from JOB_HISTORY
         inner join JOBS using (JOB_ID)
where DEPARTMENT_ID = 80;

--15. the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
select employee1.FIRST_NAME, employee1.LasT_NAME
from EMPLOYEES employee1
         inner join EMPLOYEES employee2
                    on employee2.EMPLOYEE_ID = 163
                        and employee1.SALARY > employee2.SALARY;

--16. the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME
from EMPLOYEES
where SALARY > (select avg(SALARY) from EMPLOYEES);

--17. the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.
select employee.FIRST_NAME, employee.LasT_NAME
from EMPLOYEES employee
         inner join EMPLOYEES report
                    on employee.MANAGER_ID = report.EMPLOYEE_ID and
                       report.FIRST_NAME = 'Payam';

--18. the department number, name ( first name and last name ), job and department name for all employees in the Finance department.
select employee.DEPARTMENT_ID,
       employee.FIRST_NAME,
       employee.LasT_NAME,
       jobs.JOB_TITLE,
       department.DEPARTMENT_NAME
from EMPLOYEES employee
         inner join DEPARTMENTS department
                    on employee.DEPARTMENT_ID = department.DEPARTMENT_ID and
                       department.DEPARTMENT_NAME = 'Finance'
         inner join JOBS jobs
                    on employee.JOB_ID = jobs.JOB_ID;

--19. all the information of an employee whose id is any of the number 134, 159 and 183.
select *
from EMPLOYEES
where EMPLOYEE_ID in (134, 159, 183);

--20. all the information of the employees whose salary is within the range of smallest salary and 2500.
select *
from EMPLOYEES
where SALARY between (select min(SALARY)
                      from EMPLOYEES) and 2500;

--21. all the information of the employees who does not work in those departments where some employees works whose id within the range 100 and 200.
select *
from EMPLOYEES
where DEPARTMENT_ID not in (select distinct DEPARTMENT_ID
                            from EMPLOYEES
                            where EMPLOYEE_ID between 100 and 200
                              and DEPARTMENT_ID is not null);

--22. all the information for those employees whose id is any id who earn the second highest salary.
select *
from EMPLOYEES
where SALARY = (select max(SALARY)
                from EMPLOYEES
                where EMPLOYEE_ID != (select EMPLOYEE_ID
                                      from EMPLOYEES
                                      where SALARY = (select max(SALARY)
                                                      from EMPLOYEES)));

--23. the employee name( first name and last name ) and hiredate for all employees in the same department as Clara. Exclude Clara.
select FIRST_NAME, LasT_NAME, HIRE_DATE
from EMPLOYEES
where DEPARTMENT_ID = (select DEPARTMENT_ID
                       from EMPLOYEES
                       where FIRST_NAME = 'Clara')
  and FIRST_NAME != 'Clara';

--24. the employee number and name( first name and last name ) for all employees who work in a department with any employee whose name contains a T.
select PHONE_NUMBER, FIRST_NAME, LasT_NAME
from EMPLOYEES
where DEPARTMENT_ID in (select DEPARTMENT_ID
                        from EMPLOYEES
                        where LasT_NAME like ('%T%')
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
select PHONE_NUMBER, FIRST_NAME, LasT_NAME, SALARY
from EMPLOYEES
where SALARY > (select avg(SALARY)
                from EMPLOYEES)
  and DEPARTMENT_ID in (select DEPARTMENT_ID
                        from EMPLOYEES
                        where FIRST_NAME like ('%J%')
                           or LasT_NAME like ('%J%'));

--27. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.
select PHONE_NUMBER, FIRST_NAME, LasT_NAME, JOB_TITLE
from EMPLOYEES employee1
         inner join JOBS using (JOB_ID)
where SALARY < any (select SALARY
                    from EMPLOYEES
                    where JOB_ID = 'MK_MAN');

--28. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
select PHONE_NUMBER, FIRST_NAME, LasT_NAME, JOB_TITLE
from EMPLOYEES employee1
         inner join JOBS using (JOB_ID)
where SALARY < any (select SALARY
                    from EMPLOYEES
                    where JOB_ID = 'MK_MAN')
  and JOB_ID != 'MK_MAN';

--29. all the information of those employees who did not have any job in the past.
select *
from EMPLOYEES
where EMPLOYEE_ID not in (select distinct EMPLOYEE_ID
                          from JOB_HISTORY);

--30. the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.
select PHONE_NUMBER, FIRST_NAME, LasT_NAME, JOB_TITLE
from EMPLOYEES
         inner join JOBS using (JOB_ID)
where SALARY > any (select avg(SALARY)
                    from EMPLOYEES
                    group by DEPARTMENT_ID);

--31. the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.
--TODO ?
--32. the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
--TODO ?
--33. the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees)
-- and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than
-- the average salary of all employees.
--TODO ?
--34. all the employees who earn more than the average and who work in any of the IT departments.
select *
from EMPLOYEES
         inner join DEPARTMENTS using (DEPARTMENT_ID)
where SALARY > (select avg(SALARY) from EMPLOYEES)
  and DEPARTMENT_NAME like ('%IT%');

--35. who earns more than Mr. Ozer.
select *
from EMPLOYEES
where SALARY > (select SALARY from EMPLOYEES where LAST_NAME = 'Ozer');

--36. which employees have a manager who works for a department based in the US.
select *
from EMPLOYEES employee
         inner join EMPLOYEES manager
                    on employee.MANAGER_ID = manager.EMPLOYEE_ID
         inner join DEPARTMENTS department
                    on manager.DEPARTMENT_ID = department.DEPARTMENT_ID
         inner join LOCATIONS location
                    on department.LOCATION_ID = location.LOCATION_ID
where location.COUNTRY_ID = 'US';

--37. the names of all employees whose salary is greater than 50% of their department’s total salary bill.
select FIRST_NAME, LAST_NAME
from EMPLOYEES employee
where SALARY > (select sum(SALARY)
                from EMPLOYEES bill
                where bill.DEPARTMENT_ID = employee.DEPARTMENT_ID) / 2;

--38. the employee id, name ( first name and last name ), salary, department name and city for all
--the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_NAME, CITY
from EMPLOYEES employee
         inner join DEPARTMENTS department
                    on employee.DEPARTMENT_ID = department.DEPARTMENT_ID
         inner join LOCATIONS locations
                    on department.LOCATION_ID = locations.LOCATION_ID
where SALARY = any (select SALARY
                    from EMPLOYEES
                    where EMPLOYEES.HIRE_DATE between to_date('01/01/2002', 'MM/DD/YYYY') and
                              to_date('12/31/2003', 'MM/DD/YYYY'));

--39. the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list in descending order on salary.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES
where SALARY > (select avg(SALARY) from EMPLOYEES)
order by SALARY desc;

--40. the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES
where SALARY > (select max(SALARY)
                from EMPLOYEES
                where DEPARTMENT_ID = 40);

--41. the department name and Id for all departments where they located, that Id is equal to the Id for the location where department number 30 is located.
select DEPARTMENT_NAME, DEPARTMENT_ID
from DEPARTMENTS
where LOCATION_ID = (select LOCATION_ID
                     from DEPARTMENTS
                     where DEPARTMENT_ID = 30);

--42. the first and last name, salary, and department ID for all those employees who work in that department where the employee works who hold the ID 201.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES
where DEPARTMENT_ID = (select DEPARTMENT_ID
                       from EMPLOYEES
                       where EMPLOYEE_ID = 201);

--43. the first and last name, salary, and department ID for those employees whose salary is equal to the salary of the employee who works in that department which ID is 40.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES
where SALARY = any (select SALARY
                    from EMPLOYEES
                    where DEPARTMENT_ID = 40);

--44. the first and last name, salary, and department ID for those employees who earn more than the minimum salary of a department which ID is 40.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES
where SALARY > (select min(SALARY)
                from EMPLOYEES
                where DEPARTMENT_ID = 40);

--45. the first and last name, salary, and department ID for those employees who earn less than the minimum salary of a department which ID is 70.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES
where SALARY < (select min(SALARY)
                from EMPLOYEES
                where DEPARTMENT_ID = 70);

--46. the first and last name, salary, and department ID for those employees who earn less than the average salary, and also work at the department where the employee Laura is working as a first name holder.
select FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES
where SALARY < (select avg(SALARY) from EMPLOYEES)
  and DEPARTMENT_ID = (select DEPARTMENT_ID
                       from EMPLOYEES
                       where FIRST_NAME = 'Laura');

--47. the full name (first and last name) of manager who is supervising 4 or more employees.
select FIRST_NAME, LAST_NAME
from EMPLOYEES manager
where (select count(MANAGER_ID)
       from EMPLOYEES
       where EMPLOYEES.MANAGER_ID = manager.EMPLOYEE_ID) >= 4;

--48. the details of the current job for those employees who worked as a Sales Representative in the past.
select jobs.JOB_ID, jobs.JOB_TITLE, jobs.MIN_SALARY, jobs.MAX_SALARY
from JOB_HISTORY jobh
         inner join EMPLOYEES employee
                    on jobh.EMPLOYEE_ID = employee.EMPLOYEE_ID
         inner join JOBS jobs
                    on employee.JOB_ID = jobs.JOB_ID
         inner join JOBS old_job
                    on old_job.JOB_ID = jobh.JOB_ID
where old_job.JOB_TITLE = 'Sales Representative';

--49. all the infromation about those employees who earn second lowest salary of all the employees.
select *
from EMPLOYEES
where SALARY = (select min(SALARY)
                from EMPLOYEES
                where SALARY != (select min(SALARY)
                                 from EMPLOYEES));

--50. the department ID, full name (first and last name), salary for those employees who is highest salary drawar in a department.
select DEPARTMENT_ID, FIRST_NAME, LAST_NAME, SALARY
from EMPLOYEES employee
where SALARY = (select max(SALARY)
                from EMPLOYEES drawer
                where drawer.DEPARTMENT_ID = employee.DEPARTMENT_ID);
