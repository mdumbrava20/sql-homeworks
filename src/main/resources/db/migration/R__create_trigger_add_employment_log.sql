CREATE OR REPLACE TRIGGER add_employment_log
    AFTER INSERT OR DELETE
    ON EMPLOYEES
    FOR EACH ROW
BEGIN
    CASE
        WHEN INSERTING THEN insert_log(:NEW.FIRST_NAME, :NEW.LAST_NAME,
                                       'HIRED');
        WHEN DELETING THEN insert_log(:OLD.FIRST_NAME, :OLD.LAST_NAME,'FIRED');
        END CASE;
END;