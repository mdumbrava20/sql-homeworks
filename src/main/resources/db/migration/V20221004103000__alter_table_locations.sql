ALTER TABLE LOCATIONS
    ADD department_amount NUMBER(2) DEFAULT 0 NOT NULL;

COMMENT ON COLUMN LOCATIONS.department_amount IS 'Contains the amount of departments in the location';