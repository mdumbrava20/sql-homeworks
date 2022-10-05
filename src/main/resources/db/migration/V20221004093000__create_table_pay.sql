CREATE SEQUENCE auto_increment_PK MINVALUE 1 INCREMENT BY 1;

CREATE TABLE pay
(
    cardNr         VARCHAR2(16) DEFAULT auto_increment_PK.nextval PRIMARY KEY,
    salary         NUMBER(8, 2),
    commission_pct NUMBER(2, 2),
    employee_id    NUMBER(6)    NOT NULL
    CONSTRAINT employee_id REFERENCES EMPLOYEES (employee_id)
);

COMMENT ON TABLE PAY IS 'Pay table which contains employees card number, salary, and commission';
COMMENT ON COLUMN pay.cardNr IS 'Primary key of pay table';
COMMENT ON COLUMN pay.salary IS 'Salary of employee';
COMMENT ON COLUMN pay.commission_pct IS 'Commission of employee';


INSERT INTO pay (salary, commission_pct, employee_id)
SELECT salary, commission_pct, employee_id
FROM employees;