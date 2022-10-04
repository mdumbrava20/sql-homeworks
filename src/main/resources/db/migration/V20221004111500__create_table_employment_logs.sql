CREATE SEQUENCE employment_log_id_seq MINVALUE 1 INCREMENT BY 1;

CREATE TABLE employment_logs
(
    employment_log_id NUMBER(3) DEFAULT employment_log_id_seq.nextval PRIMARY KEY,
    first_name  VARCHAR2(20)    NOT NULL ,
    last_name   VARCHAR2(25)    NOT NULL ,
    employment_action   VARCHAR2(5) NOT NULL ,
    employment_status_updtd_tmstmp  TIMESTAMP   NOT NULL ,
    CONSTRAINT action_check CHECK ( employment_action IN ('HIRED', 'FIRED'))
);

COMMENT ON TABLE employment_logs IS 'Employment logs table that observes inserting and deleting
on data from Employees table.';
COMMENT ON COLUMN employment_logs.employment_log_id IS 'Primary key with auto increment sequence';
COMMENT ON COLUMN employment_logs.first_name IS 'First Name of employee';
COMMENT ON COLUMN employment_logs.last_name IS 'Last Name of employee';
COMMENT ON COLUMN employment_logs.employment_action IS 'Status of employee can be only HIRED or FIRED';
COMMENT ON COLUMN employment_logs.employment_status_updtd_tmstmp IS 'Timestamp of changes made';