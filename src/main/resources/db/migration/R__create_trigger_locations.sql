CREATE OR REPLACE TRIGGER update_department_number
    AFTER INSERT OR DELETE
    ON DEPARTMENTS
    FOR EACH ROW
BEGIN

    IF INSERTING THEN
        UPDATE LOCATIONS
        SET LOCATIONS.department_amount = LOCATIONS.department_amount + 1
        WHERE LOCATION_ID = :NEW.location_Id;
    end if;
    IF DELETING THEN
        UPDATE LOCATIONS
        SET LOCATIONS.department_amount = LOCATIONS.department_amount - 1
        WHERE LOCATION_ID = :OLD.location_Id;
    end if;
END update_department_number;
