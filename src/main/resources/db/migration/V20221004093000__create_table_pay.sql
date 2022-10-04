CREATE TABLE pay
(
    cardNr         VARCHAR2(16) PRIMARY KEY,
    salary         NUMBER(8, 2),
    commission_pct NUMBER(2, 2)
);

COMMENT ON TABLE PAY IS 'Pay table which contains employees card number, salary, and commission';
COMMENT ON COLUMN pay.cardNr IS 'Primary key of pay table';
COMMENT ON COLUMN pay.salary IS 'Salary of employee';
COMMENT ON COLUMN pay.commission_pct IS 'Commission of employee';

ALTER TABLE EMPLOYEES
    ADD
        cardNr VARCHAR2(16)
            CONSTRAINT EMP_CARD_FK REFERENCES PAY (cardNr) UNIQUE;

UPDATE pay
SET pay.salary = (select SALARY
                  from EMPLOYEES e
                  where pay.cardNr = e.cardNr);