create table customer(cu_id NUMBER(10) primary key,cu_name varchar(10),cu_email varchar(10), cu_dob date,foreign key (cu_id) references customer_mn(cu_id));
create table customer_mn(cu_id number(10) primary key,cu_mn number(10));
create table second_hand_co(oc_id number(10) primary key,oc_name varchar(10),oc_email varchar(10),sc_id number(10),sh_id number(10),foreign key (sh_id) references showroom(sh_id),foreign key (sc_id) references secondhand_car(sc_id),foreign key (oc_id) references secondhand_mn(oc_id));
create table secondhand_car(sc_id number(10) primary key,oc_model varchar(10),oc_year number(10));
create table secondhand_mn(oc_id number(10) primary key, oc_mn number(10));
create table showroom(sh_id number(10) primary key,sh_company varchar(10),foreign key (sh_id) references showroom_location(sh_id),cu_id number(10),foreign key (cu_id) references customer (cu_id));
create table showroom_location(sh_id number(10) primary key,sh_state varchar(10),sh_city varchar(10),sh_pincode number(10));
create table car(c_id number(10) primary key,c_model varchar(10),c_year NUMBER(10),c_type varchar(10),sh_id number(10),foreign key (sh_id) references showroom(sh_id),cu_id number(10),foreign key (cu_id) references customer (cu_id));
create table salesperson(s_name varchar(10),s_id NUMBER(10) primary key,s_email varchar(10),sh_id number(10),cu_id number(10),foreign key (sh_id) references showroom(sh_id),foreign key (s_id) references salesperson_mn(s_id),foreign key (cu_id) references customer (cu_id));
create table salesperson_mn(s_id number(10) primary key,s_mn number(10));
create table receipt(bill_id NUMBER(10) primary key,bill_price number(10,2), bill_tax number(10,2),cu_id number(10),foreign key (cu_id) references customer (cu_id),sh_id number(10),foreign key (sh_id) references showroom(sh_id));
--CUSTOMER_MN SHOWROOM_LOCATION CUSTOMER SHOWROOM SECONDHAND_CAR SECONDHAND_MN SECOND_HAND_CO CAR salesperson_mn salesperson receipt

select * from customer;
select * from customer_mn;
select * from second_hand_co;
select * from secondhand_car;
select * from secondhand_mn;
select * from showroom;
select * from showroom_location;
select * from car;
select * from salesperson;
select * from salesperson_mn;
select * from receipt;
--ORIGINAL TABLE
create table customer(cu_id NUMBER(10) primary key,cu_name varchar(10),cu_email varchar(10), cu_dob date,s_id NUMBER(10),foreign key (s_id) references salesperson(s_id),c_id number(10),foreign key (c_id) references car(c_id),sh_id number(10),foreign key (sh_id) references showroom(sh_id));
create table receipt(bill_id NUMBER(10) primary key,bill_price number(10,2), bill_tax number(10,2),cu_id number(10),foreign key (cu_id) references customer (cu_id),sh_id number(10),foreign key (sh_id) references showroom(sh_id));
create table salesperson(s_name varchar(10),s_id NUMBER(10) primary key,s_email varchar(10), s_mn number(10),sh_id number(10),foreign key (sh_id) references showroom(sh_id));
create table car(c_id number(10) primary key,c_model varchar(10),c_year NUMBER(10),c_type varchar(10),sh_id number(10),foreign key (sh_id) references showroom(sh_id));
create table showroom(sh_id number(10) primary key,sh_state varchar(10),sh_city varchar(10),sh_pincode number(10),sh_company varchar(10));
create table second_hand_co(oc_name varchar(10),oc_model varchar(10),oc_year number(10),o_mn number(10),o_email varchar(10),sh_id number(10),foreign key (sh_id) references showroom(sh_id));

SELECT * From customer;
select * from showroom;
select * from receipt;
select * from car;
select * from second_hand_co;
select * from salesperson;

-- SHOWROOM CAR SALESPERSON CUSTOMER RECEIPT SECONDHAND
drop table customer;
DROP TABLE customer_mn;
drop table secondhand_car;
drop table  secondhand_mn;
drop table showroom;
drop table showroom_location;
drop table receipt;
select * from showroom;
describe showroom;
drop table salesperson;
drop table salesperson_mn;
drop table second_hand_co;
SELECT table_name FROM user_tables;
drop table car;

CREATE OR REPLACE PROCEDURE ADDCUSTOMER(cu_id IN NUMBER, cu_name IN VARCHAR, cu_email IN VARCHAR,cu_dob in date)
IS
BEGIN
    INSERT INTO customer VALUES(cu_id, cu_name, cu_email,cu_dob);
END ADDCUSTOMER;

DECLARE
    cus_id customer.cu_id%type;
    cus_name customer.cu_name%type;
    cus_email customer.cu_email%type;
    cus_dob customer.cu_dob%type;
BEGIN
    cus_id:=&cus_id;
    cus_name:='&cus_name';
    cus_email:='&cus_email';
    cus_dob:=&cus_dob;
    ADDCUSTOMER(cus_id,cus_name,cus_email,cus_dob);
END;

CREATE OR REPLACE PROCEDURE ADDsecond_hand_co(oc_id IN NUMBER, oc_name IN VARCHAR, oc_email IN VARCHAR,oc_mn in NUMBER, sc_id in NUMBER, sh_id in NUMBER)
IS
BEGIN
    INSERT INTO second_hand_co VALUES(oc_id,oc_name, oc_email,oc_mn,sc_id,sh_id);
END ADDsecond_hand_co;

DECLARE
    ocs_id second_hand_co.oc_id%type;
    ocs_name second_hand_co.oc_name%type;
    ocs_email second_hand_co.oc_email%type;
    ocs_mn second_hand_co.oc_mn%type;
    scs_id second_hand_co.sc_id%type;
    shs_id second_hand_co.sh_id%type;
BEGIN
    ocs_id:=&ocs_id;
    ocs_name:='&ocs_name';
    ocs_email:='&ocs_email';
    ocs_mn:=&ocs_mn;
    scs_id:=&scs_id;
    shs_id:=&shs_id;
    ADDsecond_hand_co(ocs_id,ocs_name,ocs_email,ocs_mn,scs_id,shs_id);
END;

CREATE OR REPLACE PROCEDURE ADDsecondhand_car(sc_id IN NUMBER, oc_model IN VARCHAR, oc_year IN NUMBER)
IS
BEGIN
    INSERT INTO secondhand_car VALUES(sc_id, oc_model, oc_year);
END ADDsecondhand_car;

DECLARE
    scs_id secondhand_car.sc_id%type;
    ocs_model secondhand_car.oc_model%type;
    ocs_year secondhand_car.oc_year%type;
BEGIN
    scs_id:=&scs_id;
    ocs_model:='&ocs_model';
    ocs_year:=&ocs_year;
    ADDsecondhand_car(scs_id,ocs_model,ocs_year);
END;

CREATE OR REPLACE PROCEDURE ADDsecondhand_mn(oc_id IN NUMBER, oc_mn IN NUMBER)
IS
BEGIN
    INSERT INTO secondhand_mn VALUES(oc_id, oc_mn);
END ADDsecondhand_mn;

DECLARE
    ocs_id secondhand_mn.oc_id%type;
    ocs_mn secondhand_mn.oc_mn%type;
BEGIN
    ocs_id:=&ocs_id;
    ocs_mn:='&ocs_mn';
    ADDsecondhand_mn(ocs_id,ocs_mn);
END;

REATE OR REPLACE PROCEDURE ADDSHOWROOM_LOCATION(sh_id IN NUMBER ,sh_state IN VARCHAR,sh_city IN VARCHAR,sh_pincode IN NUMBER)
IS
BEGIN
    INSERT INTO showroom_location VALUES(sh_id,sh_state,sh_city,sh_pincode);
END ADDSHOWROOM_LOCATION;

DECLARE
    show_id showroom_location.sh_id%type;
    show_state showroom_location.sh_state%type;
    show_city showroom_location.sh_city%type;
    show_pincode showroom_location.sh_pincode%type;
BEGIN
    show_id:=&show_id;
    show_state:='&show_state';
    show_city:='&show_city';
    show_pincode:=&show_pincode;
    ADDSHOWROOM_LOCATION(show_id,sh_state,sh_city,sh_pincode);
END;

CREATE OR REPLACE PROCEDURE ADDSHOWROOM(sh_id IN NUMBER, sh_company IN VARCHAR)
IS
BEGIN
    INSERT INTO showroom VALUES(sh_id,sh_company);
END ADDSHOWROOM;

DECLARE
    show_id showroom.sh_id%type;
    show_company showroom.sh_company%type;
BEGIN
    show_id:=&show_id;
    show_name:='&show_name';
    ADDSHOWROOM(show_id,sh_company);
END;

CREATE OR REPLACE PROCEDURE ADDCAR(c_id IN NUMBER,c_model IN VARCHAR,c_year IN NUMBER,c_type IN VARCHAR)
IS
BEGIN
    INSERT INTO car VALUES(c_id,c_model,c_year,c_type);
END ADDCAR;

DECLARE
    car_id car.c_id%type;
    car_model car.c_model%type;
    car_year car.c_year%type;
    car_type car.c_type%type;
BEGIN
    car_id:=&car_id;
    car_model:='&car_model';
    car_year:=&car_year;
    car_type:='&car_type'
    ADDCAR(car_id,car_model,car_year,car_type);
END;

CREATE OR REPLACE PROCEDURE ADDCUSTOMER_MN(cu_id IN NUMBER,cu_mn IN NUMBER)
IS
BEGIN
    INSERT INTO customer_mn VALUES(cu_id,cu_mn);
END ADDCUSTOMER_MN;

DECLARE
    cu_mn_id customer_mn.cu_id%type;
    cu_mn_mn customer_mn.cu_mn%type;
BEGIN
    cu_mn_id:=&cu_mn_id;
    cu_mn_mn:=&cu_mn_mn;
    ADDCUSTOMER_MN(cu_mn_id,cu_mn_mn);
END;

CREATE OR REPLACE PROCEDURE ADDsalesperson_mn(s_id IN NUMBER,s_mn IN NUMBER)
IS
BEGIN
    INSERT INTO salesperson_mn VALUES(s_id,s_mn);
END ADDsalesperson_mn;

DECLARE
    s_mn_id salesperson_mn.s_id%type;
    s_mn_mn salesperson_mn.s_mn%type;
BEGIN
    s_mn_id:=&s_mn_id;
    s_mn_mn:=&s_mn_mn;
    ADDsalesperson_mn(s_mn_id,s_mn_mn);
END;




CREATE OR REPLACE PROCEDURE ADDsalesperson(s_id IN NUMBER, s_name IN VARCHAR, s_email IN VARCHAR,cu_id in NUMBER, sh_id in NUMBER)
IS
BEGIN
    INSERT INTO salesperson VALUES(s_id,s_name, s_email,oc_mn,s_id,sh_id);
END ADDsalesperson;

DECLARE
    s_id salesperson.s_id%type;
    s_name salesperson.s_name%type;
    s_email salesperson.s_email%type;
    cu_id salesperson.cu_id%type;
    sh_id salesperson.sh_id%type;
BEGIN
    s_id:=&s_id;
    s_name:='&s_name';
    s_email:='&s_email';
    cu_id:=&cu_id;
    sh_id:=&sh_id;
    ADDsalesperson(s_id,s_name,s_email,cu_id,s_id);
END;



CREATE OR REPLACE PROCEDURE ADDreceipt(bill_id IN NUMBER, bill_price IN NUMBER, bill_tax IN NUMBER, cu_id IN NUMBER, sh_id IN NUMBER)
IS 
BEGIN 
	INSERT INTO receipt VALUES(bill_id, bill_price, bill_tax, cu_id, sh_id);
END ADDreceipt;

DECLARE
	bill_id receipt.bill_id%type;
	bll_price receipt.bill_price%type;
	bill_tax receipt.bill_tax%type;
	cu_id receipt.cu_id%type;
	sh_id receipt.sh_id%type;
Begin
	bill_id:=&bill_id;
	bll_price:=&bll_price;
	bill_tax:=&bill_tax;
	cu_id:=&cu_id;
	sh_id:=&sh_id;
	ADDreceipt(bill_id, bill_price, bill_tax, cu_id, sh_id);
END;
