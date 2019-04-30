-- Generated by Oracle SQL Developer Data Modeler 18.4.0.339.1536
--   at:        2019-05-01 01:28:52 AEST
--   site:      Oracle Database 12c
--   type:      Oracle Database 12c
SET ECHO ON;
SPOOL mh_schema_output.txt;

DROP SEQUENCE bed_bed_number_seq;

DROP SEQUENCE doctor_doctor_id_seq;

DROP SEQUENCE e_item_item_code_seq;

DROP SEQUENCE nurse_nurse_id_seq;

DROP SEQUENCE pat_admission_adm_number_seq;

DROP SEQUENCE patient_patient_id_seq;

DROP SEQUENCE specialisation_specialisation_;

DROP SEQUENCE ward_ward_code_seq;

DROP TABLE b_assignment CASCADE CONSTRAINTS;

DROP TABLE bed CASCADE CONSTRAINTS;

DROP TABLE cost_centre CASCADE CONSTRAINTS;

DROP TABLE doc_spec CASCADE CONSTRAINTS;

DROP TABLE doctor CASCADE CONSTRAINTS;

DROP TABLE e_item CASCADE CONSTRAINTS;

DROP TABLE nurse CASCADE CONSTRAINTS;

DROP TABLE pat_admission CASCADE CONSTRAINTS;

DROP TABLE pat_eitem CASCADE CONSTRAINTS;

DROP TABLE pat_procedure CASCADE CONSTRAINTS;

DROP TABLE patient CASCADE CONSTRAINTS;

DROP TABLE procedure CASCADE CONSTRAINTS;

DROP TABLE specialisation CASCADE CONSTRAINTS;

DROP TABLE w_assignment CASCADE CONSTRAINTS;

DROP TABLE ward CASCADE CONSTRAINTS;

CREATE TABLE b_assignment (
    adm_number   NUMBER(6) NOT NULL,
    bed_number   NUMBER(3) NOT NULL,
    ward_code    NUMBER(3) NOT NULL
);

COMMENT ON COLUMN b_assignment.adm_number IS
    'adm_number: surrogate key added to entity';

COMMENT ON COLUMN b_assignment.bed_number IS
    'bed_number: bed number within a particular ward';

COMMENT ON COLUMN b_assignment.ward_code IS
    'ward_code: ward code';

ALTER TABLE b_assignment
    ADD CONSTRAINT bedassignment_pk PRIMARY KEY ( adm_number,
                                                  bed_number,
                                                  ward_code );

CREATE TABLE bed (
    bed_number     NUMBER(3) NOT NULL,
    ward_code      NUMBER(3) NOT NULL,
    bed_phone_no   CHAR(10),
    bed_type       CHAR(10) NOT NULL
);

ALTER TABLE bed
    ADD CONSTRAINT chk_bedtype CHECK ( bed_type IN (
        'adjustable',
        'fixed'
    ) );

COMMENT ON COLUMN bed.bed_number IS
    'bed_number: bed number within a particular ward';

COMMENT ON COLUMN bed.ward_code IS
    'ward_code: ward code';

COMMENT ON COLUMN bed.bed_phone_no IS
    'bed_phone_no: bedside telephone number';

COMMENT ON COLUMN bed.bed_type IS
    'bed_type: beds are classified as either fixed or adjustable';

ALTER TABLE bed ADD CONSTRAINT bed_pk PRIMARY KEY ( bed_number,
                                                    ward_code );

CREATE TABLE cost_centre (
    centre_code    NUMBER(5) NOT NULL,
    centre_title   VARCHAR2(50) NOT NULL,
    manager_name   VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN cost_centre.centre_code IS
    'centre_code: cost centre code';

COMMENT ON COLUMN cost_centre.centre_title IS
    'centre_title: cost centre title';

COMMENT ON COLUMN cost_centre.manager_name IS
    'manager_name: manager name';

ALTER TABLE cost_centre ADD CONSTRAINT cost_centre_pk PRIMARY KEY ( centre_code )
;

CREATE TABLE doc_spec (
    doctor_id           NUMBER(4) NOT NULL,
    specialisation_id   NUMBER(3) NOT NULL
);

COMMENT ON COLUMN doc_spec.doctor_id IS
    'doctor_id: doctor id';

COMMENT ON COLUMN doc_spec.specialisation_id IS
    'specialisation_id: doctor specialisation id';

ALTER TABLE doc_spec ADD CONSTRAINT "DOC-SPEC_PK" PRIMARY KEY ( doctor_id,
                                                                specialisation_id
                                                                );

CREATE TABLE doctor (
    doctor_id      NUMBER(4) NOT NULL,
    doctor_fname   VARCHAR2(50) NOT NULL,
    doctor_lname   VARCHAR2(50) NOT NULL,
    doctor_phone   CHAR(10) NOT NULL
);

COMMENT ON COLUMN doctor.doctor_id IS
    'doctor_id: doctor id';

COMMENT ON COLUMN doctor.doctor_fname IS
    'doctor_fname: doctor first name';

COMMENT ON COLUMN doctor.doctor_lname IS
    'doctor_lname: doctor last name';

COMMENT ON COLUMN doctor.doctor_phone IS
    'doctor_phone: doctor phone number';

ALTER TABLE doctor ADD CONSTRAINT doctor_pk PRIMARY KEY ( doctor_id );

CREATE TABLE e_item (
    item_code          CHAR(5) NOT NULL,
    item_description   VARCHAR2(50) NOT NULL,
    item_price         NUMBER(7, 2) NOT NULL,
    item_cstock        NUMBER(4) NOT NULL,
    centre_code        NUMBER(5) NOT NULL
);

ALTER TABLE e_item ADD CONSTRAINT itmprice_chk CHECK ( item_price > 0 );

COMMENT ON COLUMN e_item.item_code IS
    'item_code: item code for each extra item';

COMMENT ON COLUMN e_item.item_description IS
    'item_description: description of each extra item';

COMMENT ON COLUMN e_item.item_price IS
    'item_price: price of each extra item';

COMMENT ON COLUMN e_item.item_cstock IS
    'item_cstock: current stock of each item';

COMMENT ON COLUMN e_item.centre_code IS
    'centre_code: cost centre code';

ALTER TABLE e_item ADD CONSTRAINT extra_item_pk PRIMARY KEY ( item_code );

CREATE TABLE nurse (
    nurse_id            NUMBER(4) NOT NULL,
    nurse_fname         VARCHAR2(50) NOT NULL,
    nurse_lname         VARCHAR2(50) NOT NULL,
    nurse_phone         CHAR(10) NOT NULL,
    cert_for_children   CHAR(3) NOT NULL
);

ALTER TABLE nurse
    ADD CONSTRAINT cert_chk CHECK ( cert_for_children IN (
        'No',
        'Yes'
    ) );

COMMENT ON COLUMN nurse.nurse_id IS
    'nurse_id: unique nurse id';

COMMENT ON COLUMN nurse.nurse_fname IS
    'nurse_fname: nurse first name';

COMMENT ON COLUMN nurse.nurse_lname IS
    'nurse_lname: nurse last name';

COMMENT ON COLUMN nurse.nurse_phone IS
    'nurse_phone: nurse contact phone number';

COMMENT ON COLUMN nurse.cert_for_children IS
    'cert_for_children: nurse certified for work with children';

ALTER TABLE nurse ADD CONSTRAINT nurse_pk PRIMARY KEY ( nurse_id );

CREATE TABLE pat_admission (
    adm_number           NUMBER(6) NOT NULL, 
/*  discharge_datetime: date and time of discharge of a particular patient's*/
/*  admission*/
    discharge_datetime   DATE,
    patient_id           NUMBER(6) NOT NULL,
    adm_datetime         DATE NOT NULL,
    supvdoctor_id        NUMBER(4) NOT NULL
);

COMMENT ON COLUMN pat_admission.adm_number IS
    'adm_number: surrogate key added to entity';

COMMENT ON COLUMN pat_admission.discharge_datetime IS
    'discharge_datetime: date and time of discharge of a patient';

COMMENT ON COLUMN pat_admission.patient_id IS
    'patient_id: unique patient id';

COMMENT ON COLUMN pat_admission.adm_datetime IS
    'adm_datetime: admission date and time of a particular p atient';

COMMENT ON COLUMN pat_admission.supvdoctor_id IS
    'doctor_id: doctor id';

ALTER TABLE pat_admission ADD CONSTRAINT patient_admission_pk PRIMARY KEY ( adm_number
);

ALTER TABLE pat_admission ADD CONSTRAINT "PAT-ADMISSION_NK" UNIQUE ( patient_id,
                                                                     adm_datetime
                                                                     );

CREATE TABLE pat_eitem (
    adm_number       NUMBER(6) NOT NULL,
    carried_out_on   DATE NOT NULL,
    item_code        CHAR(5) NOT NULL
);

COMMENT ON COLUMN pat_eitem.adm_number IS
    'adm_number: surrogate key added to entity';

COMMENT ON COLUMN pat_eitem.carried_out_on IS
    'carried_out_on: procedure carried out on';

COMMENT ON COLUMN pat_eitem.item_code IS
    'item_code: item code for each extra item';

ALTER TABLE pat_eitem
    ADD CONSTRAINT "PAT-E-ITEM_PK" PRIMARY KEY ( adm_number,
                                                 carried_out_on,
                                                 item_code );

CREATE TABLE pat_procedure (
    carried_out_on        DATE NOT NULL,
    adm_number            NUMBER(6) NOT NULL,
    procedure_charge      NUMBER(7, 2),
    totalextras_charges   NUMBER(7, 2),
    reqdoctor_id          NUMBER(4),
    doccarried_id         NUMBER(4),
    procedure_code        NUMBER(5) NOT NULL
);

ALTER TABLE pat_procedure ADD CONSTRAINT prochrg_chk CHECK ( procedure_charge > 0

);

ALTER TABLE pat_procedure ADD CONSTRAINT texcharge_chk CHECK ( totalextras_charges

> 0 );

COMMENT ON COLUMN pat_procedure.carried_out_on IS
    'carried_out_on: procedure carried out on';

COMMENT ON COLUMN pat_procedure.adm_number IS
    'adm_number: surrogate key added to entity';

COMMENT ON COLUMN pat_procedure.procedure_charge IS
    'procedure_charge: procedure charge to patient';

COMMENT ON COLUMN pat_procedure.totalextras_charges IS
    'totalextras_charges: total extras charges to patient';

COMMENT ON COLUMN pat_procedure.reqdoctor_id IS
    'doctor_id: doctor id';

COMMENT ON COLUMN pat_procedure.doccarried_id IS
    'doctor_id: doctor id';

COMMENT ON COLUMN pat_procedure.procedure_code IS
    'procedure_code: procedure code';

ALTER TABLE pat_procedure ADD CONSTRAINT patient_procedure_pk PRIMARY KEY ( adm_number
,
                                                                            carried_out_on
                                                                            );

CREATE TABLE patient (
    patient_id        NUMBER(6) NOT NULL,
    patient_fname     VARCHAR2(50) NOT NULL,
    patient_lname     VARCHAR2(50) NOT NULL,
    patient_address   VARCHAR2(50) NOT NULL,
    patient_dob       DATE NOT NULL,
    patient_enumber   CHAR(10) NOT NULL
);

COMMENT ON COLUMN patient.patient_id IS
    'patient_id: unique patient id';

COMMENT ON COLUMN patient.patient_fname IS
    'patient_fname: patient first name';

COMMENT ON COLUMN patient.patient_lname IS
    'patient_lname: patient last name';

COMMENT ON COLUMN patient.patient_address IS
    'patient_address: patient address';

COMMENT ON COLUMN patient.patient_dob IS
    'patient_dob: patient date of birth';

COMMENT ON COLUMN patient.patient_enumber IS
    'patient_enumber: patient emergency contact number';

ALTER TABLE patient ADD CONSTRAINT patient_pk PRIMARY KEY ( patient_id );

CREATE TABLE procedure (
    procedure_code   NUMBER(5) NOT NULL,
    procedure_name   VARCHAR2(50) NOT NULL,
    procedure_desc   VARCHAR2(50) NOT NULL,
    proc_time_req    DATE NOT NULL,
    current_cost     NUMBER(7, 2) NOT NULL
);

ALTER TABLE procedure ADD CONSTRAINT ccost_chk CHECK ( current_cost > 0 );

COMMENT ON COLUMN procedure.procedure_code IS
    'procedure_code: procedure code';

COMMENT ON COLUMN procedure.procedure_name IS
    'procedure_name: name of the procedure';

COMMENT ON COLUMN procedure.procedure_desc IS
    'procedure_desc: procedure description of each procedure';

COMMENT ON COLUMN procedure.proc_time_req IS
    'proc_time_req: time required for each procedure';

COMMENT ON COLUMN procedure.current_cost IS
    'current_cost: current cost of each procedure';

ALTER TABLE procedure ADD CONSTRAINT procedure_pk PRIMARY KEY ( procedure_code );

CREATE TABLE specialisation (
    specialisation_id     NUMBER(3) NOT NULL,
    specialisation_name   CHAR(50) NOT NULL
);

COMMENT ON COLUMN specialisation.specialisation_id IS
    'specialisation_id: doctor specialisation id';

COMMENT ON COLUMN specialisation.specialisation_name IS
    'specialisation_name: doctor''s specialisation name';

ALTER TABLE specialisation ADD CONSTRAINT specialisation_pk PRIMARY KEY ( specialisation_id
);

ALTER TABLE specialisation ADD CONSTRAINT specialisation_nk UNIQUE ( specialisation_name

);

CREATE TABLE w_assignment (
    date_assigned    DATE NOT NULL,
    nurse_id         NUMBER(4) NOT NULL,
    date_completed   DATE,
    ward_code        NUMBER(3) NOT NULL
);

COMMENT ON COLUMN w_assignment.date_assigned IS
    'date_assigned:  initial date a nurse is assigned to work in a ward';

COMMENT ON COLUMN w_assignment.nurse_id IS
    'nurse_id: unique nurse id';

COMMENT ON COLUMN w_assignment.date_completed IS
    'date_completed: when a nurse finishes an allocaiton with a particular ward';

COMMENT ON COLUMN w_assignment.ward_code IS
    'ward_code: ward code';

ALTER TABLE w_assignment ADD CONSTRAINT wardassgnment_pk PRIMARY KEY ( date_assigned
,
                                                                       nurse_id )
                                                                       ;

CREATE TABLE ward (
    ward_code        NUMBER(3) NOT NULL,
    ward_name        VARCHAR2(50) NOT NULL,
    total_beds       NUMBER(3) NOT NULL,
    beds_available   NUMBER(3) NOT NULL
);

COMMENT ON COLUMN ward.ward_code IS
    'ward_code: ward code';

COMMENT ON COLUMN ward.ward_name IS
    'ward_name: name of the ward';

COMMENT ON COLUMN ward.total_beds IS
    'total_beds: total number of beds in each ward';

COMMENT ON COLUMN ward.beds_available IS
    'beds_available: number of currently available beds';

ALTER TABLE ward ADD CONSTRAINT ward_pk PRIMARY KEY ( ward_code );

ALTER TABLE b_assignment
    ADD CONSTRAINT bed_b_assignment FOREIGN KEY ( bed_number,
                                                  ward_code )
        REFERENCES bed ( bed_number,
                         ward_code );

ALTER TABLE e_item
    ADD CONSTRAINT cost_centre_eitem FOREIGN KEY ( centre_code )
        REFERENCES cost_centre ( centre_code );

ALTER TABLE doc_spec
    ADD CONSTRAINT doctor_doc_spec FOREIGN KEY ( doctor_id )
        REFERENCES doctor ( doctor_id );

ALTER TABLE pat_admission
    ADD CONSTRAINT doctor_pat_admission FOREIGN KEY ( supvdoctor_id )
        REFERENCES doctor ( doctor_id );

ALTER TABLE pat_procedure
    ADD CONSTRAINT doctor_pat_procedure FOREIGN KEY ( reqdoctor_id )
        REFERENCES doctor ( doctor_id );

ALTER TABLE pat_procedure
    ADD CONSTRAINT doctor_pat_procedurev2 FOREIGN KEY ( doccarried_id )
        REFERENCES doctor ( doctor_id );

ALTER TABLE pat_eitem
    ADD CONSTRAINT e_item_pat_eitem FOREIGN KEY ( item_code )
        REFERENCES e_item ( item_code );

ALTER TABLE w_assignment
    ADD CONSTRAINT nurse_w_assignment FOREIGN KEY ( nurse_id )
        REFERENCES nurse ( nurse_id );

ALTER TABLE b_assignment
    ADD CONSTRAINT pat_admission_b_assignment FOREIGN KEY ( adm_number )
        REFERENCES pat_admission ( adm_number );

ALTER TABLE pat_procedure
    ADD CONSTRAINT pat_admission_pat_procedure FOREIGN KEY ( adm_number )
        REFERENCES pat_admission ( adm_number );

ALTER TABLE pat_eitem
    ADD CONSTRAINT pat_procedure_pat_eitem FOREIGN KEY ( adm_number,
                                                         carried_out_on )
        REFERENCES pat_procedure ( adm_number,
                                   carried_out_on );

ALTER TABLE pat_admission
    ADD CONSTRAINT patient_pat_admission FOREIGN KEY ( patient_id )
        REFERENCES patient ( patient_id );

ALTER TABLE pat_procedure
    ADD CONSTRAINT procedure_pat_procedure FOREIGN KEY ( procedure_code )
        REFERENCES procedure ( procedure_code );

ALTER TABLE doc_spec
    ADD CONSTRAINT specialisation_doctor_spec FOREIGN KEY ( specialisation_id )
        REFERENCES specialisation ( specialisation_id );

ALTER TABLE bed
    ADD CONSTRAINT ward_bed FOREIGN KEY ( ward_code )
        REFERENCES ward ( ward_code );

ALTER TABLE w_assignment
    ADD CONSTRAINT ward_w_assignment FOREIGN KEY ( ward_code )
        REFERENCES ward ( ward_code );

CREATE SEQUENCE bed_bed_number_seq START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE doctor_doctor_id_seq START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE e_item_item_code_seq START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE nurse_nurse_id_seq START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE pat_admission_adm_number_seq START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE patient_patient_id_seq START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE specialisation_specialisation_ START WITH 1 NOCACHE ORDER;

CREATE SEQUENCE ward_ward_code_seq START WITH 1 NOCACHE ORDER;



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            15
-- CREATE INDEX                             0
-- ALTER TABLE                             39
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          8
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
SET ECHO OFF;