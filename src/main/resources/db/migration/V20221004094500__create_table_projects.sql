CREATE TABLE projects
(
    project_id          NUMBER(3) PRIMARY KEY ,
    project_description VARCHAR2(50) NOT NULL ,
    project_investments NUMBER(*, -3)   NOT NULL ,
    project_revenue     NUMBER(*)   NOT NULL,
    CONSTRAINT proj_length_proj_description CHECK ( LENGTH(project_description) > 10 ),
    CONSTRAINT proj_values_invest  CHECK ( project_investments > 0 ),
    CONSTRAINT proj_values_revenue  CHECK ( project_revenue > 0 )
);

COMMENT ON TABLE projects IS 'Projects table that is Many-To-Many relation with Employee table ';
COMMENT ON COLUMN projects.project_id IS 'Projects table Primary Key';
COMMENT ON COLUMN projects.project_description IS 'Project description. A not null column';
COMMENT ON COLUMN projects.project_investments IS 'Project investments. A not null column and greater than 10.
Values are only thousands with at least 3 zeroes';
COMMENT ON COLUMN projects.project_revenue IS 'Project revenue. A not null column and greater than 10';


