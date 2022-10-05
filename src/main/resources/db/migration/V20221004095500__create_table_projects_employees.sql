CREATE TABLE projects_employees
(
    employee_id     NUMBER(6)   NOT NULL ,
    project_id      NUMBER(3)   NOT NULL ,
    worked_hours    NUMBER(3)   NOT NULL,
    CONSTRAINT  PROJEMP_EMP_FK  FOREIGN KEY (employee_id)
        REFERENCES EMPLOYEES (EMPLOYEE_ID),
    CONSTRAINT PROJEMP_PROJ_FK  FOREIGN KEY (project_id)
        REFERENCES PROJECTS (PROJECT_ID)
);