CLASS zcl_generate_bookingsfl_atq DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_generate_bookingsfl_atq IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA:it_bookings TYPE TABLE OF ztbookingfl_atq.

*    read current timestamp
    GET TIME STAMP FIELD DATA(zv_tsl).
*   fill internal table (itab)
    it_bookings = VALUE #(
        ( booking  = '1' customername = 'Buchholm' numberofpassengers = '3' emailaddress = 'tester1@flight.example.com'
          country = 'Germany' dateofbooking ='20180213125959' dateoftravel ='20180213125959' cost = '546' currencycode = 'EUR' lastchangedat = zv_tsl )
        ( booking  = '2' customername = 'Jeremias' numberofpassengers = '1' emailaddress = 'tester2@flight.example.com'
          country = 'USA' dateofbooking ='20180313125959' dateoftravel ='20180313125959' cost = '1373' currencycode = 'USD' lastchangedat = zv_tsl )
     ).

*   Delete the possible entries in the database table - in case it was already filled
    DELETE FROM ztbookingfl_atq.
*   insert the new table entries
    INSERT ztbookingfl_atq FROM TABLE @it_bookings.

*   check the result
    SELECT * FROM ztbookingfl_atq INTO TABLE @it_bookings.
    out->write( sy-dbcnt ).
    out->write( 'data inserted successfully!').

  ENDMETHOD.

ENDCLASS.

