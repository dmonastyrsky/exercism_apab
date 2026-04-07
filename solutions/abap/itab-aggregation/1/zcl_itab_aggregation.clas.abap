CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_itab_aggregation IMPLEMENTATION.
  METHOD perform_aggregation.

    DATA: ls_result LIKE LINE OF aggregated_data.

    DATA(lt_data) = initial_numbers.
    SORT lt_data BY group.

    " Використовуємо INTO, щоб бачити значення полів всередині AT NEW
    LOOP AT lt_data INTO DATA(ls_row).
      
      AT NEW group.
        CLEAR ls_result.
        ls_result-group = ls_row-group.
        ls_result-min   = ls_row-number.
        ls_result-max   = ls_row-number.
      ENDAT.

      ls_result-count = ls_result-count + 1.
      ls_result-sum   = ls_result-sum + ls_row-number.

      IF ls_row-number < ls_result-min.
        ls_result-min = ls_row-number.
      ENDIF.
      
      IF ls_row-number > ls_result-max.
        ls_result-max = ls_row-number.
      ENDIF.

      AT END OF group.
        " Важливо: ділимо суму на кількість для середнього
        ls_result-average = ls_result-sum / ls_result-count.
        APPEND ls_result TO aggregated_data.
      ENDAT.

    ENDLOOP.

    
  ENDMETHOD.

ENDCLASS.
