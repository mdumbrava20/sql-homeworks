CREATE OR REPLACE PROCEDURE insert_log(
    first_name_log EMPLOYEES.first_name%TYPE,
    last_name_log EMPLOYEES.last_name%TYPE,
    action  EMPLOYMENT_LOGS.employment_action%TYPE
)
    IS
BEGIN
    INSERT INTO employment_logs (first_name, last_name,
                                 employment_action, employment_status_updtd_tmstmp)
    VALUES (first_name_log, last_name_log, action, CURRENT_TIMESTAMP);
END;