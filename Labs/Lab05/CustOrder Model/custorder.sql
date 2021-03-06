-- Generated by Oracle SQL Developer Data Modeler 18.4.0.339.1536
--   at:        2019-04-25 00:10:02 AEST
--   site:      Oracle Database 12c
--   type:      Oracle Database 12c

SET ECHO ON;
SPOOL customer_order_output.txt;

DROP SEQUENCE customer_custno_seq;

DROP TABLE customer CASCADE CONSTRAINTS;

DROP TABLE orderline CASCADE CONSTRAINTS;

DROP TABLE orders CASCADE CONSTRAINTS;

DROP TABLE product CASCADE CONSTRAINTS;

CREATE TABLE customer (
    custno        NUMBER(7) NOT NULL,
    custname      VARCHAR2(50) NOT NULL,
    custaddress   VARCHAR2(50) NOT NULL,
    custphone     CHAR(10)
);

COMMENT ON COLUMN customer.custno IS
    'custno: customer number';

COMMENT ON COLUMN customer.custname IS
    'custname: customer name';

COMMENT ON COLUMN customer.custaddress IS
    'custaddress: customer address';

COMMENT ON COLUMN customer.custphone IS
    'custhpone: customer phone';

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( custno );

CREATE TABLE orderline (
    orderno      NUMBER(7) NOT NULL,
    prodno       NUMBER(7) NOT NULL,
    qtyordered   NUMBER(3) NOT NULL,
    lineprice    NUMBER(8, 2) NOT NULL
);

ALTER TABLE orderline ADD CONSTRAINT chk_qtyordered CHECK ( qtyordered > 0 );

COMMENT ON COLUMN orderline.orderno IS
    'orderno: order number';

COMMENT ON COLUMN orderline.prodno IS
    'prodno: product number';

COMMENT ON COLUMN orderline.qtyordered IS
    'qtyordered: quantity ordered for each product';

COMMENT ON COLUMN orderline.lineprice IS
    'lineprice: total price for each product in an order';

ALTER TABLE orderline ADD CONSTRAINT orderline_pk PRIMARY KEY ( orderno,
                                                                prodno );

CREATE TABLE orders (
    orderno     NUMBER(7) NOT NULL,
    orderdate   DATE NOT NULL,
    custno      NUMBER(7) NOT NULL
);

COMMENT ON COLUMN orders.orderno IS
    'orderno: order number';

COMMENT ON COLUMN orders.orderdate IS
    'orderdate: order date';

COMMENT ON COLUMN orders.custno IS
    'custno: customer number';

ALTER TABLE orders ADD CONSTRAINT orders_pk PRIMARY KEY ( orderno );

CREATE TABLE product (
    prodno      NUMBER(7) NOT NULL,
    proddesc    VARCHAR2(50) NOT NULL,
    prodprice   NUMBER(7, 2) NOT NULL
);

COMMENT ON COLUMN product.prodno IS
    'prodno: product number';

COMMENT ON COLUMN product.proddesc IS
    'proddesc: product description';

COMMENT ON COLUMN product.prodprice IS
    'prodprice: product price';

ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY ( prodno );

ALTER TABLE orders
    ADD CONSTRAINT customer_orders FOREIGN KEY ( custno )
        REFERENCES customer ( custno );

ALTER TABLE orderline
    ADD CONSTRAINT orders_orderline FOREIGN KEY ( orderno )
        REFERENCES orders ( orderno );

ALTER TABLE orderline
    ADD CONSTRAINT product_orderline FOREIGN KEY ( prodno )
        REFERENCES product ( prodno );

CREATE SEQUENCE customer_custno_seq START WITH 1 NOCACHE ORDER;

SET ECHO OFF;

-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             0
-- ALTER TABLE                              8
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
-- CREATE SEQUENCE                          1
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
